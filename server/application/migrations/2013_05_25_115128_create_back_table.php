<?php

class Create_Back_Table {

	/**
	 * Make changes to the database.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('back', function($table)
	    {
	        $table->increments('id');
	        //$table->string('')->unique();
	        $table->string('cell00');
			$table->string('cell01');
			$table->string('cell02');
			$table->string('cell03');
			$table->string('cell10');
			$table->string('cell11');
			$table->string('cell12');
			$table->string('cell13');
			$table->string('cell20');
			$table->string('cell21');
			$table->string('cell22');
			$table->string('cell23');
			$table->string('cell30');
			$table->string('cell31');
			$table->string('cell32');
			$table->string('cell33');
	        $table->timestamps();
	    });
	}

	/**
	 * Revert the changes to the database.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::drop('back');
	}

}