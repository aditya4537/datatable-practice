<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>Product List</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
        <style>
            /* CSS */
            ::selection {
                background-color: #326174;
                color: #ffffff;
            }

            /* Center table content */
            .dataTables_wrapper table,
            .dataTables_wrapper thead th,
            .dataTables_wrapper tbody td,
            .dataTables_wrapper tfoot th {
                text-align: center;
            }

            /* Custom style for search bar */
            .dataTables_filter input {
                border: 2px solid #e0e0e0;
                border-radius: 2px;
                padding: 5px;
            }

            .dataTables_filter input:hover {
                border: 2px solid #5c5a5a;
                border-radius: 2px;
                padding: 5px;
            }

            /* Custom style for length menu */
            .dataTables_length select {
                border: 2px solid #ccc;
                border-radius: 5px;
                padding: 5px;
            }

            /* Style pagination buttons */
            .dataTables_wrapper .dataTables_paginate .paginate_button {
                padding: 0.5rem 0.75rem;
                margin-left: 2px;
                border-radius: 0.25rem;
                border: 1px solid #8b98a0;
                background-color: #67909c;
                color: #f3f9ff;
            }

            /* Style active pagination button */
            .dataTables_wrapper .dataTables_paginate .paginate_button.current {
                background-color: #007bff;
                color: #ffffff;
                border-color: #007bff;
            }

            /* Style hover state of pagination buttons */
            .dataTables_wrapper .dataTables_paginate .paginate_button:hover {
                background-color: #93b7db;
                color: #ffffff;
                border-color: #dee2e6;
            }
        </style>
    </head>

    <body>

        <div class="container">
            <h1>Products</h1>
            <div id="bg-container" style="background-color: #d3f1ff;">
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addProductModal">Add
                    Product</button>
                <label for="color-picker">Pick the Color</label>
                <input type="color" name="color-picker" id="color-picker">
                <br><br> <!-- Add spacing between button and table -->
                <table id="productTable" class="display" style="background-color: #92aeb9;">
                    <thead style="background-color: #324d5f; color:white;">
                        <tr>
                            <th>Id</th>
                            <th>Product</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>

                    </tbody>
                    <tfoot>
                        <tr>
                            <th colspan="3" style="text-align:right">Total:</th>
                            <th></th>
                            <th></th>
                        </tr>
                    </tfoot>

                </table>
            </div>
        </div>

        <!-- View Product Modal -->
        <div class="modal fade" id="viewProductModal" tabindex="-1" aria-labelledby="viewProductModalLabel"
            aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="viewProductModalLabel">Product Details</h5>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Name:</label>
                            <span id="viewProductName"></span>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Category:</label>
                            <span id="viewProductCategory"></span>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Price:</label>
                            <span id="viewProductPrice"></span>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="closeViewModal" class="btn btn-secondary"
                            data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>



        <!-- Edit Product Modal -->
        <div class="modal fade" id="editProductModal" tabindex="-1" role="dialog"
            aria-labelledby="editProductModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="editProductModalLabel">Edit Product</h4>
                    </div>
                    <div class="modal-body">
                        <form id="editProductForm">
                            <div class="form-group">
                                <input type="hidden" class="form-control" id="editProductId" name="editProductId"
                                    required>
                            </div>
                            <div class="form-group">
                                <label for="editProductName">Product Name</label>
                                <input type="text" class="form-control" id="editProductName" name="editProductName"
                                    required>
                            </div>
                            <div class="form-group">
                                <label for="editProductCategory">Category</label>
                                <input type="text" class="form-control" id="editProductCategory"
                                    name="editProductCategory" required>
                            </div>
                            <div class="form-group">
                                <label for="editProductPrice">Price</label>
                                <input type="number" class="form-control" id="editProductPrice" name="editProductPrice"
                                    required>
                            </div>
                            <input type="hidden" id="editProductId" name="editProductId">
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" id="saveEditProduct">Save changes</button>
                    </div>
                </div>
            </div>
        </div>


        <!-- Add Product Modal -->
        <div class="modal fade" id="addProductModal" tabindex="-1" role="dialog" aria-labelledby="addProductModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="addProductModalLabel">Add Product</h4>
                    </div>
                    <div class="modal-body">
                        <form id="addProductForm">
                            <div class="form-group">
                                <label for="addProductName">Product Name</label>
                                <input type="text" class="form-control" id="addProductName" name="addProductName"
                                    required>
                            </div>
                            <div class="form-group">
                                <label for="addProductCategory">Category</label>
                                <input type="text" class="form-control" id="addProductCategory"
                                    name="addProductCategory" required>
                            </div>
                            <div class="form-group">
                                <label for="addProductPrice">Price ₹</label>
                                <input type="number" class="form-control" id="addProductPrice" name="addProductPrice"
                                    required>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" id="saveAddProduct">Add Product</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>

            //Handle edit button click
            function editProd(id) {
                $.ajax({
                    type: 'GET',
                    url: '/product/' + id,
                    success: function (product) {
                        // Populate the form fields with product details
                        $('#editProductId').val(product.id);
                        $('#editProductName').val(product.name);
                        $('#editProductCategory').val(product.category);
                        $('#editProductPrice').val(product.price);
                    },
                    error: function (xhr, status, error) {
                        console.error(error);
                    }
                });
                $('#editProductModal .modal-content');
                $('#editProductModal').modal('show');
            }

            function areAllFieldsNotNull(obj) {
                for (let key in obj) {
                    if (obj[key] === null || obj[key] == '') {
                        return false;
                    }
                }
                return true;
            }

            const Toast = Swal.mixin({
                toast: true,
                position: "top-end",
                showConfirmButton: false,
                timer: 3000,
                timerProgressBar: true,
                didOpen: (toast) => {
                    toast.onmouseenter = Swal.stopTimer;
                    toast.onmouseleave = Swal.resumeTimer;
                }
            });


            $(document).ready(function () {
                var table = $('#productTable').DataTable({
                    responsive: true,
                    ajax: {
                        url: "/products",
                        dataSrc: ""
                    },
                    lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
                    order: [[0, "asc"]],
                    columns: [
                        { data: "id" },
                        { data: "name" },
                        { data: "category" },
                        { data: "price" },
                        {
                            data: null,
                            render: function (data, type, row) {
                                return (
                                    '<div class="dropdown">' +
                                    '<button class="btn btn-light dropdown-toggle" type="button" id="actionDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">' +
                                    '<i class="fas fa-ellipsis-v"></i>' +
                                    "</button>" +
                                    '<div class="dropdown-menu dropdown-menu-right" aria-labelledby="actionDropdown">' +
                                    '<button type="button" class="btn btn-primary btn-edit" style="border-radius: 50%; margin:0px 18px;margin-right:3px; border-style: none; " onclick="editProd(' +
                                    data.id +
                                    ')"><i class="fas fa-pencil-alt"></i></button>' +
                                    '<button type="button" class="btn btn-danger btn-delete" style="border-radius: 50%; margin-right:3px; border-style: none;"  data-id="' +
                                    data.id +
                                    '"><i class="fas fa-trash-alt"></i></button>' +
                                    '<button type="button" class="btn btn-info btn-view" style="border-radius: 50%; margin-right:3px; border-style: none;" data-id="' +
                                    data.id +
                                    '"><i class="fas fa-eye"></i></button>' +
                                    "</div>" +
                                    "</div>"
                                );
                            }
                        }

                    ],
                    footerCallback: function (row, data, start, end, display) {
                        var api = this.api();

                        // Calculate the total price
                        var totalPrice = api
                            .column(3, { page: 'current' })
                            .data()
                            .reduce(function (acc, val) {
                                return acc + parseFloat(val);
                            }, 0);

                        // Update the footer
                        $(api.column(3).footer()).html(totalPrice.toFixed(2));
                    }
                });

                $('#color-picker').change(function () {
                    var color = $(this).val();
                    $('#bg-container').css("background-color", color);
                })

                //Handle View close button click
                $('#closeViewModal').click(function () {
                    $('#viewProductModal').modal('hide');
                })

                // Handle view button click
                $('#productTable').on('click', '.btn-view', function () {
                    var productId = $(this).data('id');

                    // Fetch product details by ID
                    $.ajax({
                        type: 'GET',
                        url: '/product/' + productId,
                        success: function (product) {
                            // Populate the modal with product details
                            $('#viewProductName').text(product.name);
                            $('#viewProductCategory').text(product.category);
                            $('#viewProductPrice').text(product.price);

                            // Show the modal
                            $('#viewProductModal').modal('show');
                        },
                        error: function (xhr, status, error) {
                            console.error(error);
                        }
                    });
                });


                // Handle delete button click
                // Handle delete product confirmation                
                $('#productTable').on('click', '.btn-delete', function () {
                    var productId = $(this).attr("data-id");

                    const swalWithBootstrapButtons = Swal.mixin({
                        customClass: {
                            confirmButton: 'btn btn-success',
                            cancelButton: 'btn btn-danger'
                        },
                        buttonsStyling: false
                    })

                    swalWithBootstrapButtons.fire({
                        title: 'Are you sure?',
                        text: "You won't be able to revert this!",
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonText: 'Delete',
                        cancelButtonText: 'Cancel',
                        reverseButtons: true
                    }).then((result) => {
                        if (result.isConfirmed) {
                            $.ajax({
                                type: "DELETE",
                                url: "/deleteProduct/" + productId,
                                success: function (response) {
                                    swalWithBootstrapButtons.fire(
                                        'Deleted!',
                                        'Your product has been deleted.',
                                        'success'
                                    ).then(() => {
                                        table.ajax.reload();
                                    });
                                },
                                error: function (error) {
                                    console.error("error", error);
                                    swalWithBootstrapButtons.fire(
                                        'Not deleted',
                                        'Something went wrong.',
                                        'error'
                                    ).then(() => {
                                        table.ajax.reload();
                                    });
                                }
                            });
                        } else if (result.dismiss === Swal.DismissReason.cancel) {
                            swalWithBootstrapButtons.fire(
                                'Cancelled',
                                'Your product is safe :)',
                                'error'
                            );
                        }
                    });

                });


                // Handle add product form submission
                $('#saveAddProduct').click(function () {
                    var productName = $('#addProductName').val();
                    var productCategory = $('#addProductCategory').val();
                    var productPrice = $('#addProductPrice').val();
                    var productData = { "name": productName, "category": productCategory, "price": productPrice };

                    if (areAllFieldsNotNull(productData)) {
                        $.ajax({
                            type: 'POST',
                            url: '/products/add',
                            contentType: 'application/json',
                            data: JSON.stringify(productData),
                            success: function (response) {
                                $('#addProductModal').modal('hide');
                                $('#addProductName').val('');
                                $('#addProductCategory').val('');
                                $('#addProductPrice').val('');

                                Toast.fire({
                                    icon: "success",
                                    title: "Product Added Successfully!"
                                });
                                table.ajax.reload();
                            },
                            error: function (xhr, status, error) {
                                console.error(error);
                            }
                        });
                    } else {
                        Toast.fire({
                            icon: "error",
                            title: "Fields must not be empty!"
                        });
                    }
                });

                // Handle edit product form submission
                $('#saveEditProduct').click(function () {
                    var productId = $('#editProductId').val();
                    var productName = $('#editProductName').val();
                    var productCategory = $('#editProductCategory').val();
                    var productPrice = $('#editProductPrice').val();
                    var productData = { "id": productId, "name": productName, "category": productCategory, "price": productPrice };

                    $.ajax({
                        type: 'PUT',
                        url: '/editProduct/' + productId,
                        contentType: 'application/json',
                        data: JSON.stringify(productData),
                        success: function (response) {
                            $('#editProductModal').modal('hide');
                            Toast.fire({
                                icon: "success",
                                title: "Product Updated Successfully!"
                            });
                            table.ajax.reload();
                        },
                        error: function (xhr, status, error) {
                            console.error(error);
                        }
                    });
                });

            });
        </script>
    </body>

    </html>