<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class User extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('users')->insert([
            [
                'id' => 'KH202201255',
                'username' => 'chuongzano',
                'password' => Hash::make('hoaichuongaA'),
                'email' => 'russian2311@gmail.com',
                'fullName' => 'Nguyễn Hoài Chương',
                'phone' => '0917439160',
                 'avatar' => 'a.png',
                'status' => 0,
            ],
            [
                'id' => 'KH202201252',
                'username' => 'Kim Loan',
                'password' => Hash::make('kimloan123'),
                'email' => 'kimloanvn@gmail.com',
                'fullName' => 'Tran Thi Kim Loan',
                'phone' => '0917439160',
                 'avatar' => 'b.png',
                'status' => 0,
            ],
        ]);
    }
}