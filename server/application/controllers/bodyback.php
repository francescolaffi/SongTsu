<?php

class Bodyback_Controller extends Base_Controller {

	/*
	public function action_index()
	{
		return "bodyback";
	}
	*/

	public $restful = true;

    public function get_index()
    {
/*		
		//
		// DA RIMUOVERE
		//
		$a = new Back();
		$cella = rand( 0 , 3 );
		$riga = rand( 0 , 3);
		$campo = "cell$riga$cella";
    	$a->$campo = rand(0,255);
		$a->save();
		//
		// END
		//
*/

		$datetime = date('Y-m-d H:i:s', strtotime("-2 second")); //2013-05-25 14:12:19

		$backs = Back::where('updated_at', '>', $datetime)->take(10)->get();
		$output = array();
		
		if (  count ($backs) >  0 ) {
			
			$back = $backs[0];
			
			for ($i=0; $i < 4; $i++) { 
				for ($j=0; $j < 4; $j++) { 
					$campo = "cell$i$j";
					$output[] = $back->$campo;
				}
			}
			
			return Response::make( json_encode($output), 200 )->header( 'Access-Control-Allow-Origin', "*" );
		} else {
			return Response::make( json_encode($output), 200 )->header( 'Access-Control-Allow-Origin', "*" );
		}
    }

    public function post_index()
    {
    	
		$dataAll = Input::all();

    	//$data = Input::json();

    	$data = $dataAll['c'];
    	
    	$data = explode(" ", $data);

    	$enable = false;

    	if ( is_array($data) ){

    		$back = new Back();
    		for ($i=0; $i < 4; $i++) { 
				for ($j=0; $j < 4; $j++) { 
					$campo = "cell$i$j";

					$valore = $data[$i*4 + $j];
					if ( $valore > 500 ) {
						$enable = true;
						$back->$campo = $valore;
					} 
				}
			}
			if ( $enable ) {
				$back->save();
				return Response::make( "", 204 )->header( 'Access-Control-Allow-Origin', "*" );
			}
    	}
		
		return Response::make( "NO DATA", 404 )->header( 'Access-Control-Allow-Origin', "*" );
    }

}