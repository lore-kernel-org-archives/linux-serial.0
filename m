From: "Alex Moen" <alexm@ndtel.com>
Subject: Saving data from the serial port
Date: Thu, 17 Apr 2003 13:44:24 -0500
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <007201c30511$6143ebd0$443d24c0@S0029770574>
Reply-To: <alexm@ndtel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ndtc.ndtel.com ([66.163.128.13]:10078 "EHLO ndtc.ndtel.com")
	by vger.kernel.org with ESMTP id S261883AbTDQScl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Apr 2003 14:32:41 -0400
Received: from S0029770574 (nos.gondtc.com [66.163.129.66])
	by ndtc.ndtel.com (8.12.6/8.12.6) with ESMTP id h3HIiZgh023406
	for <linux-serial@vger.kernel.org>; Thu, 17 Apr 2003 13:44:36 -0500
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hey all,

I am willing to bet that:
  a) this is so simple that I am overlooking it, or
  b) it has been covered a MILLION times already.

If b, please let me know where to find the answer, because I can't find it.
If a, tell me how blockheaded I am, laugh a little, and then tell me the
solution....

I want to take the data from a serial port from our PBX and log it to a
file.  Sounds simple, right?  I can (Winblows) hyperterm to the port and
gather the data.  I can connect the port to a serial printer and get the
data.  But, when I connect my linux box to the serial port, I am only
getting PART of the data.  For instance, I am only getting the first 14-16
characters of each line, with really no line breaks.  I also notice with
statserial that I am getting an overrun (wth is that???).  I have the port
settings in the software set at what Windows and the printer are set at
(9600-8-N-1).

I have read through the serial howto, tried a few programs that are
suggested (two that look promising but are giving the above results are
linbar and logserial), and am stumped.

I'd hate to have to set up a Win98 box running hyperterm logging to a file,
and then manually rotate that each day....


Thanks, and don't laugh too hard...

Alex

