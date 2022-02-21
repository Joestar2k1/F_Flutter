<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
class Address extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('addresses')->insert([
            [
                'id' => 1,
                'userID' => 'KH202201255',
                'name' => '12 Hồ Thành Biên, Quận 8, TP.HCM',           
            ],
            [
                'id' => 2,
                'userID' => 'KH202201255',
                'name' => 'Quận Gò Vấp, TP.HCM',           
            ],
        ]);
    }
}
