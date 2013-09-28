From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Subject: Re: tty loop-back device
Date: Sun, 29 Sep 2013 00:41:04 +0400
Message-ID: <l27esn$cn6$1@ger.gmane.org>
References: <l26jrq$48d$1@ger.gmane.org> <l26uk7$id2$2@ger.gmane.org> <l2736h$db0$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43104 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754733Ab3I1UlP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 28 Sep 2013 16:41:15 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1VQ1KE-0006EO-SH
	for linux-serial@vger.kernel.org; Sat, 28 Sep 2013 22:41:14 +0200
Received: from 92.243.181.209 ([92.243.181.209])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Sat, 28 Sep 2013 22:41:14 +0200
Received: from matwey.kornilov by 92.243.181.209 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Sat, 28 Sep 2013 22:41:14 +0200
In-Reply-To: <l2736h$db0$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

28.09.2013 21:21, Matwey V. Kornilov =EF=E8=F8=E5=F2:
> It seems that BSD and Unix98 pty's may coexist in pty.c. So, there is=
 a
> chance that it is possible to add support of Extended pty not breakin=
g
> existing things. One need to be a brave to change something in pty.c,=
 It
> is quite critical part.

It seems that we need new line discipline to allow async notification o=
f=20
master tty when the client changes tty->termios. poll() has to be=20
reimplemented to generate POLLPRI, when tty->termios handling required=20
on the master side, then master may use special ioctl to read=20
tty->termios requested.


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
