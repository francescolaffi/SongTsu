function SetValue(action)
{
	dhcp_on = document.getElementById("DHCPCL_ON");
	dhcp_off = document.getElementById("DHCPCL_OFF");
	
	ipaddr = document.getElementById("IPADDR");
	subnet = document.getElementById("SUBNET");
	gateway = document.getElementById("GATEWAY");
	dns1 = document.getElementById("DNS1");
	dns2 = document.getElementById("DNS2");
	
	ssid = document.getElementById("SSID");
	sectype = document.getElementById("SECTYPE");
	
	wep40 = document.getElementById("WEP40");
	wep104 = document.getElementById("WEP104");
	wpa = document.getElementById("WPA");
	wpa2 = document.getElementById("WPA2");
	
	wpapass = document.getElementById("WPAPASS");
	wpakey = document.getElementById("WPAKEY");
	wpa2pass = document.getElementById("WPA2PASS");
	wpa2key = document.getElementById("WPA2KEY");
	
	wifi_menu = document.getElementById("wifi_menu");
	wifi_content = document.getElementById("wifi_content");
	
	switch(action)
	{
		case "infrastructure":
			dhcp_on.disabled = false;

			wifi_menu.style.height = "120px";
			wifi_content.style.height = "120px";
			
			wep40.style.display = "none";
			wep104.style.display = "none";
			wpa.style.display = "none";
			wpa2.style.display = "none";
			
			while (sectype.options.length)
				sectype.options[0] = null;
			
			sectype.options[0] = new Option("Open", "OPEN");
			sectype.options[1] = new Option("WEP 40 bit", "WEP40");
			sectype.options[2] = new Option("WEP 104 bit", "WEP104");
			sectype.options[3] = new Option("WPA", "WPA");
			sectype.options[4] = new Option("WPA2", "WPA2");
			break;
		
		case "adhoc":
			dhcp_on.disabled = true;
			dhcp_off.checked = true;
			
			ipaddr.disabled = false;
			subnet.disabled = false;
			gateway.disabled = false;
			dns1.disabled = false;
			dns2.disabled = false;
			
			wep40.style.display = "none";
			wep104.style.display = "none";
			wpa.style.display = "none";
			wpa2.style.display = "none";
			
			while (sectype.options.length)
				sectype.options[0] = null;
			
			sectype.options[0] = new Option("Open", "OPEN");
			sectype.options[1] = new Option("WEP 40 bit", "WEP40");
			sectype.options[2] = new Option("WEP 104 bit", "WEP104");
			break;
		
		case "dhcpon":
			ipaddr.disabled = true;
			subnet.disabled = true;
			gateway.disabled = true;
			dns1.disabled = true;
			dns2.disabled = true;
			break;
		
		case "dhcpoff":
			ipaddr.disabled = false;
			subnet.disabled = false;
			gateway.disabled = false;
			dns1.disabled = false;
			dns2.disabled = false;
			break;
		
		case "sectype":
			wep40.style.display = "none";
			wep104.style.display = "none";
			wpa.style.display = "none";
			wpa2.style.display = "none";
			
			switch(sectype.value)
			{
				case "OPEN":
					wifi_menu.style.height = "120px";
					wifi_content.style.height = "120px";
					break;
				
				case "WEP40":
					wifi_menu.style.height = "260px";
					wifi_content.style.height = "260px";
					wep40.style.display = "block";
					break;
				
				case "WEP104":
					wifi_menu.style.height = "140px";
					wifi_content.style.height = "140px";
					wep104.style.display = "block";
					break;
				
				case "WPA":
					wifi_menu.style.height = "200px";
					wifi_content.style.height = "200px";
					wpa.style.display = "block";
					break;
				
				case "WPA2":
					wifi_menu.style.height = "200px";
					wifi_content.style.height = "200px";
					wpa2.style.display = "block";
					break;
			}
			break;
		
		case "wpapass":
			wpapass.disabled = false;
			wpakey.disabled = true;
			break;
		
		case "wpakey":
			wpapass.disabled = true;
			wpakey.disabled = false;
			break;
		
		case "wpa2pass":
			wpa2pass.disabled = false;
			wpa2key.disabled = true;
			break;
		
		case "wpa2key":
			wpa2pass.disabled = true;
			wpa2key.disabled = false;
			break;
	}
}

// ------------------------------------------------

function CheckIP(ip)
{
	pattern = ip.match(/^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/);
	
	if(pattern == null)
		return false;
	var i = 1;
	for (i = 1; i < 5; i++) 
	{
		if(pattern[i] > 255)
			return false;
	}
	
	return true;
}

function CheckHEX(hex)
{
	hex_char = "0123456789ABCDEF";
	hex = hex.toUpperCase();
	var i;

	for(i = 0; i < hex.length; i++)
	{
		if(hex_char.indexOf(hex.charAt(i)) < 0)
			return false;
	}
	
	return true;
}


function CheckSend()
{
	frm = document.getElementById("configuration");
	
	if(document.getElementById("DHCPCL_OFF").checked)
	{
		if(!CheckIP(frm.IPADDR.value))
		{
			alert("Error: not valid IP address!");
			frm.IPADDR.style.backgroundColor = "#f99";
			return false;
		}
		else
			frm.IPADDR.style.backgroundColor = "#fff";
		
		if(!CheckIP(frm.SUBNET.value))
		{
			alert("Error: not valid subnet mask!");
			frm.SUBNET.style.backgroundColor = "#f99";
			return false;
		}
		else
			frm.SUBNET.style.backgroundColor = "#fff";
		
		if(!CheckIP(frm.GATEWAY.value))
		{
			alert("Error: not valid gateway!");
			frm.GATEWAY.style.backgroundColor = "#f99";
			return false;
		}
		else
			frm.GATEWAY.style.backgroundColor = "#fff";
		
	}
	
	if(frm.SSID.value.length < 1)
	{
		alert("Error: valid SSID required!");
		frm.SSID.style.backgroundColor = "#f99";
		return false;
	}
	else
		frm.SSID.style.backgroundColor = "#fff";

	if(frm.SECTYPE.value == "WEP40")
	{
		error = false;
		
		if((frm.WEP40KEY1.value.length < 10)||(frm.WEP40KEY2.value.length < 10)||
		   (frm.WEP40KEY3.value.length < 10)||(frm.WEP40KEY1.value.length < 10))
		{
			alert("Error: wep 40 bit passkey incomplete!");
			error = true;
		}
		
		if((!CheckHEX(frm.WEP40KEY1.value))||(!CheckHEX(frm.WEP40KEY2.value))||
		   (!CheckHEX(frm.WEP40KEY3.value))||(!CheckHEX(frm.WEP40KEY4.value)))
		{
			alert("Error: only hex values are allowed for the wep 40 bit passkey!");
			error = true;
		}
		
		if(error)
		{
			frm.WEP40KEY1.style.backgroundColor = "#f99";
			frm.WEP40KEY2.style.backgroundColor = "#f99";
			frm.WEP40KEY3.style.backgroundColor = "#f99";
			frm.WEP40KEY4.style.backgroundColor = "#f99";
			return false;
		}
		else
		{
			frm.WEP40KEY1.style.backgroundColor = "#fff";
			frm.WEP40KEY2.style.backgroundColor = "#fff";
			frm.WEP40KEY3.style.backgroundColor = "#fff";
			frm.WEP40KEY4.style.backgroundColor = "#fff";
			var j = 0;
			var strdummy = "";
			var strdummy2 = "";

			frm.WEP40KEY4.value = frm.WEP40KEY1.value + frm.WEP40KEY2.value + frm.WEP40KEY3.value + frm.WEP40KEY4.value;
		}
	}
	
	if(frm.SECTYPE.value == "WEP104")
	{
		error = false;
		
		if(frm.WEP104KEY.value.length < 26)
		{
			alert("Error: wep 104 bit passkey incomplete!");
			error = true;
		}
		
		if(!CheckHEX(frm.WEP104KEY.value))
		{
			alert("Error: only hex values are allowed for the wep 104 bit passkey!");
			error = true;
		}
		
		if(error)
		{
			frm.WEP104KEY.style.backgroundColor = "#f99";
			return false;
		}
		else
			frm.WEP140KEY.style.backgroundColor = "#fff";
	}
	
	if(frm.SECTYPE.value == "WPA")
	{
		error = false;
		
		if(document.getElementById("WPASECPASS").checked)
		{
			if(frm.WPAPASS.value.length < 8)
			{
				alert("Error: WPA passphrase incomplete!");
				frm.WPAPASS.style.backgroundColor = "#f99";
				error = true;
			}
		}
		else
		{
			if(frm.WPAKEY.value.length < 64)
			{
				alert("Error: wpa passkey incomplete!");
				frm.WPAKEY.style.backgroundColor = "#f99";
				error = true;
			}
			
			if(!CheckHEX(frm.WPAKEY.value))
			{
				alert("Error: only hex values are allowed for the wpa passkey!");
				frm.WPAKEY.style.backgroundColor = "#f99";
				error = true;
			}
		}
		
		if(error)
		{
			return false;
		}
		else
		{
			frm.WPAPASS.style.backgroundColor = "#fff";
			frm.WPAKEY.style.backgroundColor = "#fff";
		}
	}
	
	if(frm.SECTYPE.value == "WPA2")
	{
		error = false;
		
		if(document.getElementById("WPA2SECPASS").checked)
		{
			if(frm.WPA2PASS.value.length < 8)
			{
				alert("Error: WPA2 passphrase incomplete!");
				frm.WPA2PASS.style.backgroundColor = "#f99";
				error = true;
			}
		}
		else
		{
			if(frm.WPA2KEY.value.length < 64)
			{
				alert("Error: wpa2 passkey incomplete!");
				frm.WPA2KEY.style.backgroundColor = "#f99";
				error = true;
			}
			
			if(!CheckHEX(frm.WPA2KEY.value))
			{
				alert("Error: only hex values are allowed for the wpa2 passkey!");
				frm.WPA2KEY.style.backgroundColor = "#f99";
				error = true;
			}
		}
		
				
		if(error)
		{
			return false;
		}
		else
		{
			frm.WPA2PASS.style.backgroundColor = "#fff";
			frm.WPA2KEY.style.backgroundColor = "#fff";
		}
	}
	
	return true;
}
