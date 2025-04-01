function formatTimeDiff(diff){
    var time_split = [];
    time_split.push(diff % 60);
    diff = Math.floor(diff / 60);
    time_split.push(diff % 60);
    diff = Math.floor(diff / 60);
    time_split.push(diff % 24);
    diff = Math.floor(diff / 24);
    time_split.push(diff);
    time_split.reverse();
    var suffixes = ["days", "hours", "minutes", "seconds"];
    for (var i=0; i<suffixes.length; i++){
        suffixes[i] = time_split[i] + " " + suffixes[i];
    }
    return suffixes.join(", ");
}

function updateTimers(){
    var now = parseInt(+new Date() / 1000);
    var untilEventEnd = 1744369200 - now;
    if (untilEventEnd > 0){
        $('#countdown').html(formatTimeDiff(untilEventEnd) + " until the end of the event.");
    } else {
        $('#countdown').html("The event has ended. Thanks for participating!");
    }
}

function apiHit(data, fsucc, ffail) {
    $.post("https://bepis.fools2025.store/api.php", {"d": JSON.stringify(data)}).done(fsucc).fail(ffail);
}

function entities(s){
    return $('<div>').text(s).html();
}

function getSmolLeaderboard() {
    apiHit({
        "r": "leaderboard"
    }, function(r) {
        if (r['error']) {
            alert(r['msg']);
            return;
        }
        if (r['data'].length == 0) {
            $("#leaderboard").html("<table><tr><td>You're so early, there's no one here yet!</td></tr></table>");
            return;
        }
        var tbl = [
            "<tr>",
            "<th style='width:60px'>#</th>",
            "<th>Username</th>",
            "<th>Score</th>",
            "<th colspan='25' style='width:250px'>Entries</th>",
            "</tr>"
        ];
        for (var i=0; i<r['data'].length; i++) {
            var ent = r['data'][i];
            tbl.push("<tr><td>#" + (i+1) + "</td><td><b>" + entities(ent['username']) + "</b></td>");
            tbl.push("<td>" + parseInt(ent['score']) + "</td>");
            for (var j=0; j<25; j++) {
                if (ent['achievement'][j] == 'A') tbl.push("<td class='y'>✓</td>");
                else tbl.push("<td class='n'>✘</td>");
            }
            tbl.push("</tr>");
        }
        $("#leaderboard").html("<table>" + tbl.join('') + "</table>");
    }, function() {
        $("#leaderboard").html("Unable to connect to the server. <a href='index.html'>Retry?</a>");
    });
}

