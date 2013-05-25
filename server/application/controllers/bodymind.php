<?php

class Bodymind_Controller extends Base_Controller {

	public $restful = true;

    public function get_index()
    {
		
		
		$volume = Volume::order_by('updated_at', 'desc')->first();

		if ( null != $volume ) {
			$output = array();
			$output[0] = $volume->intensita;
			return Response::make( json_encode($output), 200 )->header( 'Access-Control-Allow-Origin', "*" );
		} else {
			return Response::make( "NO DATA", 200 )->header( 'Access-Control-Allow-Origin', "*" );
		}
    }

    public function post_index()
    {
    	
    	$data = Input::json();
    	
    	if ( is_array($data) ){

    		$volume = new Volume();
    		$volume->intensita = $data[0];
			$volume->save();
			return Response::make( "", 204 )->header( 'Access-Control-Allow-Origin', "*" );

    	}

        return Response::make( "NO DATA", 404 )->header( 'Access-Control-Allow-Origin', "*" );
    }

}