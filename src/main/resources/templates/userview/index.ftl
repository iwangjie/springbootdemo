<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8"/>
    <title>用户列表</title>
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- 可选的 Bootstrap 主题文件（一般不用引入） -->
    <!--<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">-->
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"
            integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
            crossorigin="anonymous"></script>

    <style type="text/css">
        body {
            margin: auto;
            width: 80%;
        }

        .title{
            position: absolute;
            margin-left: 35%;
        }

        .main {
            width: 80%;
            position: relative;
            left: 10%;
        }

        .fenye {
            margin: auto;
            text-align: center;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            //选中当前页面分页


        });

        //添加用户页面
        function addView() {
            $('#newView').modal({
                show: true
            })
        }


        //编辑用户
        function editUser(id) {
            //发送ajax查询该用户信息
            $.post("/user/" + id, function (user) {
                $("#edituserid").val(user.id);
                $("#editusername").val(user.name);
            });

            $('#editView').modal({
                show: true
            })


        }

        /**
         * 删除用户
         * @param id
         */
        function deleteUser(id) {
            $.post("/user/del/" + id, function (user) {
                alert("删除成功！")
                window.location = "/user"
            });
        }
    </script>
</head>

<body>

<div class="main">
    <h1 class="title">SpringBoot-----增删改查</h1>
    <!-- 新建用户模态框 -->
    <button onclick="addView()" type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
        新建用户
    </button>

    <!-- Modal -->
    <div class="modal fade" id="newView" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">新建用户</h4>
                </div>
                <div class="modal-body">
                    <form action="/user/add" method="post">
                        <input type="hidden" class="form-control" id="adduserid" name="id">
                        <div class="form-group">
                            <label for="exampleInputEmail1">用户名：</label>
                            <input type="text" class="form-control" id="addusername" name="name">
                        </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">新增</button>
                </div>
                </form>
            </div>

        </div>
    </div>


    <!-- 编辑用户模态框 -->
    <div class="modal fade" id="editView" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">编辑用户</h4>
                </div>
                <div class="modal-body">
                    <form action="/user/update" method="post">
                        <input type="hidden" class="form-control" id="edituserid" name="id">
                        <div class="form-group">
                            <label for="exampleInputEmail1">用户名：</label>
                            <input type="text" class="form-control" id="editusername" name="name">
                        </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">更新</button>
                </div>
                </form>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">用户列表</div>
        <div class="panel-body">
            <p>展示所有用户、提供CRUD操作</p>
        </div>
        <!-- Table -->
        <table class="table table-hover">
            <thead>
            <tr>
                <th>用户编号</th>
                <th>用户名称</th>
                <th>用户创建时间</th>
                <th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;操作</th>
            </tr>
            </thead>
            <tbody>
            <#list page.list as user>
            <tr>
                <td>${user.id}</td>
                <td>${user.name}</td>
                <td>${user.createTime}</td>
                <td>
                    <input onclick="editUser(${user.id})" class="btn btn-default" type="button" value="编辑">
                    <button onclick="deleteUser(${user.id})" type="button" class="btn btn-danger">删除</button>
                </td>
            </tr>
            </#list>

            </tbody>
        </table>
        <div class="fenye">
            <nav aria-label="Page navigation">
                <ul class="pagination pagination-lg">

                <#--存在上一页-->
                <#if (page.pageCurrent > 1)>
                    <li>
                        <a href="/user?page=${page.pageCurrent-1}" aria-label="Previous">
                            <span aria-hidden="true">上一页</span>
                        </a>
                    </li>
                </#if>
                <#--不存在上一页-->
                <#if (page.pageCurrent == 1)>
                    <li class="previous disabled">
                        <a aria-label="Previous">
                            <span aria-hidden="true">上一页</span>
                        </a>
                    </li>
                </#if>

                <#--循环分页-->
                <#list 1..page.totalPage as i>
                <#--当前页-->
                    <#if page.pageCurrent == i>
                        <li class="active"><span href="#">${i}</span></li>
                    </#if>
                <#--非当前页-->
                    <#if page.pageCurrent != i>
                        <li><a href="/user?page=${i}">${i}</a></li>
                    </#if>
                </#list>

                <#--存在下一页-->
                <#if (page.pageCurrent != page.totalPage)>
                    <li>
                        <a href="/user?page=${page.pageCurrent+1}" aria-label="Next">
                            <span aria-hidden="true">下一页</span>
                        </a>
                    </li>
                </#if>
                <#--不存在下一页-->
                <#if (page.pageCurrent == page.totalPage)>
                    <li class="next disabled">
                        <a aria-label="Next">
                            <span aria-hidden="true">下一页</span>
                        </a>
                    </li>
                </#if>

                </ul>
            </nav>
        </div>

    </div>
</body>

</html>