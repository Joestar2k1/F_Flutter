<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
class Review extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('reviews')->insert([
            [             
                'userID' => 'KH202201252',               
                'productID' => 'ff20220118pr8',
                'content' => 'Giao hàng rất nhanh, Hàng rất tốt. Shop xứng đáng 10đ',           
                'quantity' => 4,           
                'postedDate' => Date('Y-m-d H:i:s'),           
                'status' => 1,           
            ],
            [             
                'userID' => 'KH202201252',               
                'productID' => 'ff20220118pr8',
                'content' => 'Chúc shop năm mới vui vẻ nhé.',           
                'quantity' => 4,           
                'postedDate' => Date('Y-m-d H:i:s'),           
                'status' => 1,           
            ],
            [             
                'userID' => 'KH202201252',               
                'productID' => 'ff20220118pr9',
                'content' => 'Sản phẩm tốt quá. Mình rất thích chất lượng như thế này.',           
                'quantity' => 5,           
                'postedDate' => Date('Y-m-d H:i:s'),           
                'status' => 1,           
            ],
            [             
                'userID' => 'KH202201255',               
                'productID' => 'fm20220118pr6',
                'content' => 'Thịt cũng rất tươi và chất lượng. Nhưng khâu giao hàng tệ quá.',           
                'quantity' => 3,           
                'postedDate' => Date('Y-m-d H:i:s'),           
                'status' => 1,           
            ],
        ]);
    }
}
