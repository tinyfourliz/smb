<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.file.FileUpload"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.general.*" %>
<%@ page import="com.dch.HttpUrlService" %>
<%
	request.setCharacterEncoding("UTF-8");
	FileUpload fu4 = new FileUpload(request);
	String it_code1 = Util.null2String((String) fu4.getParameter("itcode"));
    String address = Util.null2String((String) fu4.getParameter("address"));
    String mnemonic = Util.null2String((String) fu4.getParameter("mnemonic"));
    String mnePassword = Util.null2String((String) fu4.getParameter("mnePassword"));
 %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="author" content="Weaver E-Mobile Dev Group" />
        <meta name="description" content="Weaver E-mobile" />
        <meta name="keywords" content="weaver,e-mobile" />
        <meta name="viewport" content="width=device-width,minimum-scale=1.0, maximum-scale=1.0" />
        <title>测试标签页面</title>
        <link rel="stylesheet" href="../css/trav.css"/>
        <link rel="stylesheet" href="../css/bootstrap.min.css" type="text/css" />
        <script src="../js/jquery-1.11.3.min.js" type="text/javascript"></script>
        <script src="../js/bootstrap.min.js" type="text/javascript"></script>
        <link rel="stylesheet" href="../css/weui.min.css" />
        <link rel="stylesheet" href="../css/jquery-weui.min.css" />
        <link rel="stylesheet" href="../css/icon.css" />
        <link rel="stylesheet" href="../css/task.css" />
        <link rel="stylesheet" href="../css/bootstrapValidator.min.css" />
        <script type='text/javascript' src='../js/jquery.textarea.autoheight.js'></script>
        <script type='text/javascript' src='../js/jquery.form.js'></script>
        <script type='text/javascript' src="../js/jquery-weui.js"></script>
        <script type='text/javascript' src='../js/fastclick.min.js'></script>
        <script type='text/javascript' src='../js/web3.min.js'></script>
        <script type='text/javascript' src='../js/bignumber.js'></script>
        <script type='text/javascript' src='../js/bootstrapValidator.min.js'></script>

        <script type="text/javascript">
            $(function() {
                var address = '<%=address %>';
                var itcode = '<%=it_code1 %>';
                var mnemonic = '<%=mnemonic %>';
                var mnePassword = '<%=mnePassword %>';

                $('#defaultForm').bootstrapValidator({
                    message: 'This value is not valid',
                    feedbackIcons: {
                        valid: 'glyphicon glyphicon-ok',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                     },
                     fields: {
                         alias: {
                             message: '账户名无效',
                             validators: {
                                 notEmpty: {
                                     message: '账户名不能为空'
                                 },
                                 stringLength: {
                                     min: 2,
                                     max: 20,
                                     message: '账户名长度必须在2到20之间'
                                 },
                                 regexp: {
                                     regexp: /^[a-zA-Z0-9_\.]+$/,
                                     message: '用户名由字母、数字、下划线和点组成，区分大小写'
                                }
                            }
                        },
                         password: {
                             message:'密码无效',
                             validators: {
                                 notEmpty: {
                                     message: '密码不能为空'
                                 },
                                 stringLength: {
                                     min: 6,
                                     max: 30,
                                     message: '密码长度必须在6到30之间'
                                 },
                                 identical: {
                                     field: 'password',
                                     message: '两次密码不一致'
                                 },
                                 different: {
                                     field: 'alias',
                                     message: '不能和用户名相同'
                                 },
                                 regexp: {
                                     regexp: /^[a-zA-Z0-9_\.]+$/,
                                     message: '密码由字母、数字、下划线和点组成，区分大小写'
                                 }
                             }
                         },
                         repassword: {
                             message: '密码无效',
                             validators: {
                                 notEmpty: {
                                     message: '确认密码不能为空'
                                 },
                                 stringLength: {
                                     min: 6,
                                     max: 30,
                                     message: '确认密码长度必须在6到30之间'
                                 },
                                 identical: {
                                     field: 'password',
                                     message: '两次密码不一致'
                                 },
                                 different: {
                                     field: 'alias',
                                     message: '不能和用户名相同'
                                 },
                                 regexp: {
                                     regexp: /^[a-zA-Z0-9_\.]+$/,
                                     message: '密码由字母、数字、下划线和点组成，区分大小写'
                                 }
                             }
                         }
                    }
                });

                $("#txtAccount").val(address);

                $("#btnOk").on("click", function() {
                    $("#btnOk").attr("disabled", "true");
                    var bootstrapValidator = $("#defaultForm").data('bootstrapValidator');
                    bootstrapValidator.validate();
                    if(bootstrapValidator.isValid()) {
                        if(confirm("请保存好您的密码，我们不会为您保存，一旦丢失资产将无法恢复") == true){
                            var alias = $("#txtName").val();
                            var traPassword = $("#txtPassword").val();

                            $.ajax({
                                type: "GET",
                                url: "/mobile/plugin/dch/smb/test/getCheckUp.jsp",
                                data: {"jsonStr":JSON.stringify({
                                    "alias": alias,
                                    "itcode": itcode
                                })},
                                dataType: "json",
                                success: function(data) {
                                    if (data.valid) {
                                        $.ajax({
                                            type: "GET",
                                            url: "/mobile/plugin/dch/smb/test/getRegisiter.jsp",
                                            data: {"jsonStr":JSON.stringify({
                                                "alias": alias,
                                                "traPassword": traPassword,
                                                "mnemonic": mnemonic,
                                                "mnePassword": mnePassword
                                            })},
                                            dataType: "json",
                                            success: function(data) {
                                                if (data.success) {
                                                    alert("新账户创建成功");
                                                } else {
                                                    alert(JSON.stringify(data));
                                                    alert("注册失败，请稍后再试");
                                                }
                                                window.location.href = "/mobile/plugin/dch/smb/test/accManager.jsp?itcode="+itcode;
                                            }
                                        });
                                    } else {
                                        alert("账户名已存在");
                                    }
                                }
                            });
                        }
                    }
                });
            });
    </script>
</head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-md-12" align="center">
                    <form id="defaultForm" role="form">
                        <h4 class="form-title" style="float: left;">账户：</h4>
                        <div id="divName" class="form-group">
                            <input id="txtAccount" class="form-control required" readonly="readonly"/>
                        </div><br>
                        <h4 class="form-title" style="float: left;">账户名：</h4>
                        <div id="divName" class="form-group">
                            <input id="txtName" class="form-control required" placeholder="为您的新账户起一个名字" name="alias"/>
                        </div><br>
                        <h4 class="form-title" style="float: left;">密码：</h4>
                        <div id="divPassword" class="form-group">
                            <input id="txtPassword" class="form-control required" type="password" placeholder="请输入密码" name="password"/>
                        </div>
                        <div id="divPassword" class="form-group">
                            <input id="txtRepeat" class="form-control required" type="password" placeholder="请确认密码" name="repassword"/>
                        </div>
                        <div id="divPassword" class="form-group">
                            <button id="btnOk" type="button" class="btn btn-info btn-lg btn-block">
                            创建</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>  
    </body>
</html>