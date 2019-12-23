<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage1.Master" AutoEventWireup="true" CodeBehind="boardList_m.aspx.cs" Inherits="proj3.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        h1 {
            text-align: center;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            border-top: 1px solid gray;
            border-bottom: 1px solid gray;
        }

            table > tbody > tr > td, table > thead > tr > th {
                padding: 10px;
                border-bottom: 1px solid gray;
                text-align: center;
            }

        a {
            text-decoration: none;
            color: black;
        }

            a:hover {
                text-decoration: underline;
                color: black;
            }

        #Button2 {
            float: right;
        }

        .sortBtn {
            background-color: white;
            border: none;
            font-size: 17px;
        }
    </style>

    <div style="width: 80%; margin: auto;">
        <h2 style="text-align: center;">리스트 페이지</h2>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:Button ID="login" runat="server" OnClick="login_Click" />&nbsp;&nbsp;&nbsp;
         <%if (Session["logcheck"] != null && (int)Session["logcheck"] == 1)
             { %>
                <%=Session["logid"] %> 로그인중
        <%} %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:HiddenField ID="sorting" runat="server" />
                <br />
                <br />
                <table>
                    <thead>
                        <tr>
                            <th></th>   
                            <th>
                                <asp:Button class="sortBtn" ID="subjectSort" runat="server" Text="제목" OnClick="subjectSort_Click" /></th>
                            <th>
                                <asp:Button class="sortBtn" ID="idSort" runat="server" Text="작성자" OnClick="idSort_Click" /></th>
                            <th>
                                <asp:Button class="sortBtn" ID="dateSort" runat="server" Text="작성일" OnClick="dateSort_Click" /></th>
                            <th>조회수</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="RepBoardList" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("num")  %></td>
                                    <%if (sorting.Value == null || sorting.Value == "")
                                        { %>
                                    <td style="text-align: left;"><a href="boardConfirm_m.aspx?number=<%#Eval("num")  %>">
                                        <%# (int)Eval("depth") >0 ? String.Concat(Enumerable.Repeat("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",(int)Eval("depth")))+"ㄴ" : ""%>
                                        <%# Eval("subject")  %> </a><%# (int)Eval("repctn") > 0 ? "["+Eval("repctn")+"]" : ""%></td>
                                    <%}
                                        else
                                        { %>
                                     <td style="text-align: left;"><a href="boardConfirm_m.aspx?number=<%#Eval("num")  %>">
                                        <%# Eval("subject")  %></a><%# (int)Eval("repctn") > 0 ? "["+Eval("repctn")+"]" : ""%> </td>
                                    <%} %>
                                    <td><%# Eval("id")  %> </td>
                                    <td><%# Eval("date")  %> </td>
                                    <td><%# Eval("hits")  %> </td>
                                </tr>

                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
                <br />
                <div style="margin: auto; width: 600px;">
                    <div style="width: 150px; float: left; height: 30px;">
                        <%if (num > 1 && pagenum > 1)
                            { %>
                        <a href="boardList_m.aspx?num=1&searchtype=<%=searchtype %>&search=<%=search %>">&lt&lt 처음</a>&nbsp;
                     <a href="boardList_m.aspx?num=<%= PreviousNum()%>&searchtype=<%=searchtype %>&search=<%=search %>">&lt 이전</a>
                        <%
                            } %>
                    </div>

                    <div style="width: 300px; float: left; height: 30px; text-align: center;">
                        <%for (int i = 0; i < 10; i++)
                            {
                                if (((pagenum - 1) * 10) + i + 1 <= maxpage)
                                {
                        %> <a class="pnum" href="boardList_m.aspx?num=<%= PageNumber(i)%>&searchtype=<%=searchtype %>&search=<%=search %>"><%=PageNumber(i)%></a>
                        <%
                                }
                            }%>
                    </div>

                    <div style="width: 150px; float: left; height: 30px;">
                        <%if (num < maxpage)
                            { %>
                        <a href="boardList_m.aspx?num=<%= NextNum()%>&searchtype=<%=searchtype %>&search=<%=search %>">다음 &gt</a>
                        &nbsp;<a href="boardList_m.aspx?num=<%=maxpage%>&searchtype=<%=searchtype %>&search=<%=search %>">끝 &gt&gt</a>
                        <%} %>
                    </div>

                </div>
                <br />
                <div style="width: 30%; margin: auto;">
                    <asp:DropDownList ID="Serselect" runat="server">
                        <asp:ListItem>제목</asp:ListItem>
                        <asp:ListItem>내용</asp:ListItem>
                        <asp:ListItem>작성자</asp:ListItem>
                    </asp:DropDownList>
                    <asp:TextBox ID="SerInput" runat="server"></asp:TextBox>
                    <asp:Button ID="SerBtn" runat="server" Text="검색" OnClick="SerBtn_Click" />
                </div>
                <br />
                <%if (Session["logcheck"] != null && (int)Session["logcheck"] == 1)
                    { %>
                <asp:Button ID="Button1" runat="server" Text="글쓰기" OnClick="Button1_Click" />
                <%} %>
                <asp:Button ID="Button2" runat="server" Text="XML테스트" OnClick="Button2_Click" />
                <asp:Button ID="Button3" runat="server" Text="나모에디터" OnClick="Button3_Click" />
            </ContentTemplate>
        </asp:UpdatePanel>

    </div>
</asp:Content>
