<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
    $(document).ready(function () {
        // show the alert
        setTimeout(function () {
            $(".alert").alert('close');
        }, 2000);
    });
</script>

<c:if test="${pageContext.request.userPrincipal.name != null}">
    <script>
        $("#search_data").autocomplete({
            source: "/users/search",
            minLength: 1,
            select: function (event, ui) {
                $("#search").val(ui.item.label);
                return true;
            }
        });
        $("#search_data").data("ui-autocomplete")._renderItem = function (ul, item) {
            return $('<li/>', {'data-value': item.label})
                .append($('<a/>', {href: item.label, class: 'list-group-item list-group-item-action p-2'})
                    .append($('<img/>', {
                        src: '/images/' + item.propic,
                        alt: item.label,
                        class: 'rounded-circle align-middle float-left mr-2',
                        width: 32,
                        height: 32,
                    }))
                    .append('<b>' + item.label + '</b>')
                    .append($('<br>'))
                    .append(item.fullName))
                .appendTo(ul).addClass("list-group small list-group-flush");
        };
    </script>
</c:if>
<noscript>
    $(document).ready(function(){

    $('#search_data').autocomplete({
    source: "/user/search",
    minLength: 1,
    select: function(event, ui)
    {
    $('#search_data').val(ui.item.value);
    }
    }).data('ui-autocomplete')._renderItem = function(ul, item){
    return $("
    <li class='ui-autocomplete-row'></li>
    ")
    .data("item.autocomplete", item)
    .append(item.label)
    .appendTo(ul);
    };

    });
</noscript>


</body>
</html>