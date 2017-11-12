<!DOCTYPE html>
<html>
<head lang="en">
    <title>Spring Boot Demo - FreeMarker</title>

    <link href="/css/index.css" rel="stylesheet"/>
    <style>

        li {
            background-color: #ddffff !important;
            padding: 14px 20px;
            border-left: 6px solid #ccc !important;
            border-color: #2196F3 !important;
            margin-bottom: 15px;
        }

        ul {
            /*去除小点*/
            list-style-type: none;

        }

        .delte {
            background-color: cadetblue;
            font-family: "Bookshelf Symbol 7";
            color: antiquewhite;
        }


        span {
            padding-bottom: 15px;
            /*字段独占一行*/
            display: block
        }

        .adduser{
            height: 50px;
            width: 200px;
            color: #2196F3;
            font-size: 30px;
            font-family: Consolas;
        }


    </style>
</head>
<body>
<div class="main">
    <h1>用户新建</h1>
    <form action="/user/add" method="post">
        用户名：<input type="input" name="username"/>
        <input type="submit">
    </form>
</div>

<script type="text/javascript" src="/webjars/jquery/2.1.4/jquery.min.js"></script>

<script>

</script>
</body>
</html>