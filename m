From: Peter Astrand <peter@cendio.se>
Subject: Re: Serial port redirection
Date: Mon, 8 Dec 2003 10:49:47 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0312081047190.10908-100000@maggie.lkpg.cendio.se>
References: <3FD0F44B.8080906@acm.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1;
	FORMAT=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.cendio.se ([193.12.253.66]:253 "EHLO mail.cendio.se")
	by vger.kernel.org with ESMTP id S265361AbTLHJtt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Dec 2003 04:49:49 -0500
In-Reply-To: <3FD0F44B.8080906@acm.org>
Content-ID: <Pine.LNX.4.44.0312081047192.10908@maggie.lkpg.cendio.se>
List-Id: linux-serial@vger.kernel.org
To: Corey Minyard <minyard@acm.org>
Cc: linux-serial@vger.kernel.org


> Here's another patch, relative to 2.0 of ser2net.  Hopefully it fixes=
=20
> this problem.

I've tried the latest CVS now. It works better: cyclades-ser-cli now=20
initializes correctly. However, I'm not able to sync with pilot-xfer:=20
pilot-xfer does not detect when I'm pressing the sync button. With=20
sredird, this works (but the communication stops after listing four=20
databases.)


--=20
Peter =C5strand		www.thinlinc.com
Cendio			www.cendio.se
Teknikringen 3		Phone: +46-13-21 46 00
583 30 Link=F6ping

-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
