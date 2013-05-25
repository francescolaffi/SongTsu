<?php

class Bodymind_Controller extends Base_Controller {

	public $restful = true;

    public function get_index()
    {
		$volume = Volume::order_by('updated_at', 'desc')->first();

		if ( null != $volume ) {
			$output = array();
			$output[0] = (int)$volume->intensita; //volume
			
			$datetime = date('Y-m-d H:i:s', strtotime("-10 second")); //2013-05-25 14:12:19

			$backs = Back::where('updated_at', '>', $datetime)->take(10)->get();

			$frequenza_pressione = count($backs);

			$rigaAttiva = 0;
			foreach ($backs as $back) {
				
				$valore = 0;
				for ($i=0; $i < 4; $i++) { 
					for ($j=0; $j < 4; $j++) { 
						$campo = "cell$i$j";
						$valore += $back->$campo;
					}
					if ( $valore > 1 ) $rigaAttiva += 1;
					$valore = 0;
				}
			}

			if ( $rigaAttiva > 1) {
				$frequenza_pressione = $frequenza_pressione - $frequenza_pressione / 2;
			}

			$mood[0]="Relax";
			$mood[1]="calm";
			$mood[2]="peaceful";
			$mood[3]="chillout";
			$mood[4]="cool";
			$mood[5]="groovy";
			$mood[6]="ethnic";
			$mood[7]="funky";
			$mood[8]="energetic";
			$mood[9]="aggressive";

			if ( $frequenza_pressione == 0 ) {
				$output[1] = $mood[0];		 //mood
			}
			else {
				$output[1] = $mood[$frequenza_pressione-1];		 //mood
			}

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