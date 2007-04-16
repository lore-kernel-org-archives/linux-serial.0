From: pradeep pradeep <asnvpradeep@yahoo.com>
Subject: Setting Different Hardware modes
Date: Mon, 16 Apr 2007 04:55:31 -0700 (PDT)
Message-ID: <157040.4082.qm@web51807.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1043040557-1176724531=:4082"
Return-path: <kernelnewbies-bounce@nl.linux.org>
Sender: kernelnewbies-bounce@nl.linux.org
Errors-to: kernelnewbies-bounce@nl.linux.org
List-help: <mailto:ecartis@nl.linux.org?Subject=help>
List-unsubscribe: <mailto:kernelnewbies-request@nl.linux.org?Subject=unsubscribe>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:kernelnewbies-request@nl.linux.org?Subject=subscribe>
List-owner: <mailto:ecartis-owner@nl.linux.org>
List-post: <mailto:kernelnewbies@nl.linux.org>
List-archive: <http://mail.nl.linux.org/kernelnewbies/>
To: linux-serial@vger.kernel.org, kernelnewbies@nl.linux.org, linux-newbie@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

--0-1043040557-1176724531=:4082
Content-Type: text/plain; charset=ascii

Hi,
 
    I am writing a serial driver for my coustom serial hardware which supports different modes.
    like 550,550ex,750,850 and 950 mode. How can i set the hardware to different modes at run time.
    In 8250 the driver identifies the type of the hardware and initialises it in the respective mode.
    But I want to do the hardware setting based upon the users requirement.
    Is there is a property sheet(windows) equivalent.

Pradeep Annavarapu
Hyderabad

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1043040557-1176724531=:4082
Content-Type: text/html; charset=ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman, new york, times, serif;font-size:12pt"><DIV></DIV>
<DIV><FONT face=Arial size=2>Hi,</FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>&nbsp;&nbsp;&nbsp; I am writing a serial driver for my coustom serial hardware which supports different modes.</FONT></DIV>
<DIV><FONT face=Arial size=2>&nbsp;&nbsp;&nbsp; like 550,550ex,750,850 and 950 mode. How can i set the hardware to different modes at run time.</FONT></DIV>
<DIV><FONT face=Arial size=2>&nbsp;&nbsp;&nbsp; In 8250 the driver identifies the type of the hardware and initialises it in the respective mode.</FONT></DIV>
<DIV>&nbsp;&nbsp;&nbsp; But I want to do the hardware setting based upon the users requirement.</DIV>
<DIV><FONT face=Arial size=2>&nbsp;&nbsp;&nbsp; Is&nbsp;there is a property sheet(windows) equivalent.</FONT></DIV>
<DIV>
<DIV>&nbsp;</DIV>
<DIV>Pradeep Annavarapu<BR>Hyderabad</DIV></DIV>
<DIV></DIV></div><br>



      <hr size=1>Ahhh...imagining that irresistible "new car" smell?<br> Check out
<a href="http://us.rd.yahoo.com/evt=48245/*http://autos.yahoo.com/new_cars.html;_ylc=X3oDMTE1YW1jcXJ2BF9TAzk3MTA3MDc2BHNlYwNtYWlsdGFncwRzbGsDbmV3LWNhcnM-">new cars at Yahoo! Autos.</a>
</body></html>
--0-1043040557-1176724531=:4082--

--
To unsubscribe from this list: send an email with
"unsubscribe kernelnewbies" to ecartis@nl.linux.org
Please read the FAQ at http://kernelnewbies.org/FAQ
