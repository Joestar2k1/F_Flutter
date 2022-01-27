@extends('admin.app')
@section('title') Admin - Imported Invoice - Create Detail @endsection
@section('content')
    <div class="container-lg">
        <div class="table-responsive">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-8">
                            <h2>Tạo chi tiết hóa đơn nhập <b>Details</b></h2>
                        </div>
                        <div class="col-sm-4">
                            <button type="button" class="btn btn-info add-new-imported-invoice-detail"><i
                                    class="fa fa-plus"></i> Add
                                New</button>
                        </div>
                    </div>
                </div>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Mã CTHDN</th>
                            <th>Mã sản phẩm</th>
                            <th>Tên sản phẩm</th>
                            <th>Số lượng nhập</th>
                            <th>Đơn giá/Kg</th>
                            <th>Đơn vị (Kg)</th>

                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>CTHDN 001</td>
                            <td>DH56424</td>
                            <td>Dưa hấu</td>
                            <td>100</td>
                            <td>25.000</td>
                            <td>Kg</td>

                            <td>
                                <a class="add" title="Add" data-toggle="tooltip"><i
                                        class="material-icons">&#xE03B;</i></a>
                                <a class="edit" title="Edit" data-toggle="tooltip"><i
                                        class="material-icons">&#xE254;</i></a>
                                <a class="delete" title="Delete" data-toggle="tooltip"><i
                                        class="material-icons">&#xE872;</i></a>
                            </td>
                        </tr>

                        <tr>
                            <td>CTHDN 001</td>
                            <td>DH56424</td>
                            <td>Dưa hấu</td>
                            <td>100</td>
                            <td>25.000</td>
                            <td>Kg</td>

                            <td>
                                <a class="add" title="Add" data-toggle="tooltip"><i
                                        class="material-icons">&#xE03B;</i></a>
                                <a class="edit" title="Edit" data-toggle="tooltip"><i
                                        class="material-icons">&#xE254;</i></a>
                                <a class="delete" title="Delete" data-toggle="tooltip"><i
                                        class="material-icons">&#xE872;</i></a>
                            </td>
                        </tr>
                        <tr>
                            <td>CTHDN 001</td>
                            <td>DH56424</td>
                            <td>Dưa hấu</td>
                            <td>100</td>
                            <td>25.000</td>
                            <td>Kg</td>

                            <td>
                                <a class="add" title="Add" data-toggle="tooltip"><i
                                        class="material-icons">&#xE03B;</i></a>
                                <a class="edit" title="Edit" data-toggle="tooltip"><i
                                        class="material-icons">&#xE254;</i></a>
                                <a class="delete" title="Delete" data-toggle="tooltip"><i
                                        class="material-icons">&#xE872;</i></a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
@endsection
