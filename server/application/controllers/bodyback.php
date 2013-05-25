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


		$back = Back::order_by('updated_at', 'desc')->first();

		if ( null != $back ) {
			$output = array();
			
			for ($i=0; $i < 4; $i++) { 
				for ($j=0; $j < 4; $j++) { 
					$campo = "cell$i$j";
					$output[] = $back->$campo;
				}
			}
			
			return Response::make( json_encode($output), 200 )->header( 'Access-Control-Allow-Origin', "*" );
		} else {
			return Response::make( "NO DATA", 200 )->header( 'Access-Control-Allow-Origin', "*" );
		}
    }

    public function post_index()
    {

    	//$cell00 = Input::get('cell00');
    	
    	$data = Input::json();
    	
    	if ( is_array($data) ){

    		$back = new Back();
    		for ($i=0; $i < 4; $i++) { 
				for ($j=0; $j < 4; $j++) { 
					$campo = "cell$i$j";
					$back->$campo = $data[$i*4 + $j];
				}
			}
			$back->save();

    	}

		return Response::make( "NO DATA", 404 )->header( 'Access-Control-Allow-Origin', "*" );
    }

}