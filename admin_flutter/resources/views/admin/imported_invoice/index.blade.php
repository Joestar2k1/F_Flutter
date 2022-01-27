@extends('admin.app')
@section('title') Admin - Imported Invoice @endsection
@section('content')
    <div class="page-breadcrumb bg-white">
        <div class="row align-items-center">
            <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                <span class="page-title">Hóa đơn nhập<a href="{{ route('admin.imported_invoice.createView') }}"
                        class="btn btn-success">Create new</a></span>
            </div>
        </div>
        <!-- /.col-lg-12 -->
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <table class="table table-hover table-bordered" id="sampleTable">
                        <thead>
                            <tr>
                                <th>Inventory receiving voucher ID</th>
                                <th>Provider ID</th>
                                <th>Employee ID</th>
                                <th>Quantity Total</th>
                                <th>Status</th>
                                <th>Detail</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Donna Snider</td>
                                <td>Customer Support</td>
                                <td>New York</td>
                                <td>27</td>
                                <td>
                                    <div style="background-color: rgb(85, 221, 85)">OK</div>
                                </td>
                                <td>
                                    <a href=""> <i class="fa fa-arrow-right" aria-hidden="true"></i> </a>
                                </td>

                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

@endsection
