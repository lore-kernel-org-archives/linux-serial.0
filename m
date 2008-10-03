From: "johnny" <johnny@pan-tone.com.sg>
Subject: Help:Serial / Parallel Port Control Under Linux
Date: Fri, 3 Oct 2008 13:10:00 +0800
Message-ID: <709406A39EA948FCB5AE537FF0873FAD@johnny>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from netsmtp-a.singnet.com.sg ([165.21.1.25]:38709 "EHLO
	netsmtp-a.singnet.com.sg" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbYJCFKK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 3 Oct 2008 01:10:10 -0400
Received: from ovscan56.singnet.com.sg (ovscan56.singnet.com.sg [165.21.101.73])
	by netsmtp-a.singnet.com.sg (8.14.2/8.13.5) with ESMTP id m935A1RQ005023
	for <linux-serial@vger.kernel.org>; Fri, 3 Oct 2008 13:10:07 +0800
Received: from netsmtp-c.singnet.com.sg (netsmtp-c.singnet.com.sg [165.21.1.26])
	by ovscan56.singnet.com.sg (8.13.6/8.13.6) with ESMTP id m935A1sZ016113
	for <linux-serial@vger.kernel.org>; Fri, 3 Oct 2008 13:10:01 +0800
Received: from singnet.com.sg (bizw22.singnet.com.sg [165.21.111.36])
	by netsmtp-c.singnet.com.sg (8.14.2/8.13.5) with SMTP id m935A1LE021599
	for <linux-serial@vger.kernel.org>; Fri, 3 Oct 2008 13:10:01 +0800
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,=20

Right Now I need to write a simple C code to control the serial / paral=
lel
port under linux working like this:
Detect there is an input signal / voltage change and send some output s=
ignal
/ voltage accordingly, eg: if DSR is detected to be high, I want to set=
 RTS
to be high as well; if RI is detected to be high, I want DTR set to be =
low
etc.

I have read the Serial-How to and Serial programming-How to, however I =
am
still not so clear regarding to this simple programming.

Could anyone direct me some useful references / codes regarding to this
project?

Thanks & Best Regards,
=A0
Johnny Xing


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
