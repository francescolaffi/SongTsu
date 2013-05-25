<?php

class Create_Volume_Table {

	/**
	 * Make changes to the database.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('volume', function($table)
	    {
	        $table->increments('id');
	        $table->integer('intensita');
	        $table->timestamps();
	    });

		/*
	    DB::table('users')->insert(array(
            'username'  => 'admin',
            'password'  => Hash::make('password'),
            'name'  => 'Admin'
        ));
        */
	}

	/**
	 * Revert the changes to the database.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::drop('volume');
	}

}