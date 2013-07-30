unit ColorConversion;

interface

uses Math;

type
  TRGBColor=record
    Red,
    Green,
    Blue:integer;
  end;

  THSVColor=record
    Hue,
    Saturnation,
    Value:integer;
  end;

  function RGBToHSV(rgb:TRGBColor):THSVColor;
  function HSVtoRGB(hsv:THSVColor):TRGBColor;

implementation

function HSVtoRGB (hsv:THSVCOlor):TRGBColor;   {h IN 0..359; s,v IN 0..255}
    CONST
      divisor:  INTEGER = 255*60;
    VAR
      f    :  INTEGER;
      hTemp:  INTEGER;
      p,q,t:  INTEGER;
  BEGIN
    IF   hsv.Saturnation = 0
    THEN BEGIN
      result.Red := hsv.Value;      {Achromatic:  Shades of gray}
      result.Green := hsv.Value;
      result.Blue := hsv.Value
    END
    ELSE BEGIN
      IF   hsv.Hue = 360
      THEN hTemp := 0
      ELSE hTemp := hsv.Hue;

      f := hTemp MOD 60;
      hTemp := hTemp DIV 60;   {h is now IN [0,6)}

      p := hsv.Value - hsv.Value*hsv.Saturnation DIV 255;
      q := hsv.Value - (hsv.Value*hsv.Saturnation*f) DIV divisor;
      t := hsv.Value - (hsv.Value*hsv.Saturnation*(60 - f)) DIV divisor;

      CASE hTemp OF
        0:  BEGIN  result.Red := hsv.Value;   result.Green := t;   result.Blue := p  END;
        1:  BEGIN  result.Red := q;   result.Green := hsv.Value;   result.Blue := p  END;
        2:  BEGIN  result.Red := p;   result.Green := hsv.Value;   result.Blue := t  END;
        3:  BEGIN  result.Red := p;   result.Green := q;   result.Blue := hsv.Value  END;
        4:  BEGIN  result.Red := t;   result.Green := p;   result.Blue := hsv.Value  END;
        5:  BEGIN  result.Red := hsv.Value;   result.Green := p;   result.Blue := q  END;
      END

    END


  END {HSVtoRGB};



  {RGB, each 0 to 255, to HSV.
   H = 0 to 359 (corresponding to 0..359 degrees around hexcone)
   S = 0 (shade of gray) to 255 (pure color)
   V = 0 (black) to 255 {white)

   Based on C Code in "Computer Graphics -- Principles and Practice,"
   Foley et al, 1996, p. 592.  Floating point fractions, 0..1, replaced
with
   integer values, 0..255.
  }

function RGBtoHSV (rgb:TRGBColor):THSVColor;   {0..255}
    VAR
      Delta   :  INTEGER;
      MinValue:  INTEGER;
  BEGIN
    MinValue:=min(min(rgb.Red,rgb.Green),rgb.Blue);
    result.Value:=max(max(rgb.Red,rgb.Green),rgb.Blue);
    Delta := result.Value - MinValue;

    {Calculate saturation:  saturation is 0 if r, g and b are all 0}
    IF   result.Value = 0
    THEN result.Saturnation := 0
    ELSE result.Saturnation := (255 * Delta) DIV result.Value;

    IF   result.Saturnation = 0
    THEN result.Hue := 0   {Achromatic:  When s = 0, h is undefined but assigned the
value 0}
    ELSE BEGIN    {Chromatic}

      IF   rgb.Red = result.Value
      THEN result.Hue := (60*(rgb.Green-rgb.Blue)) DIV Delta             {degrees -- between yellow
and magenta}
      ELSE
        IF   rgb.Green = result.Value
        THEN result.Hue := 120 + (60*(rgb.Blue-rgb.Red)) DIV Delta     {degrees -- between cyan
and yellow}
        ELSE
          IF  rgb.Blue = result.Value
          THEN result.Hue := 240 + (60*(rgb.Red-rgb.Green)) DIV Delta;  {degrees -- between
magenta and cyan}

      IF   result.Hue < 0
      THEN result.Hue := result.Hue + 360;

    END
  END {RGBtoHSV};

end.

