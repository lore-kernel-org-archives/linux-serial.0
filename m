From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Subject: Re: tty loop-back device
Date: Sat, 28 Sep 2013 21:21:29 +0400
Message-ID: <l2736h$db0$1@ger.gmane.org>
References: <l26jrq$48d$1@ger.gmane.org> <l26uk7$id2$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33870 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754394Ab3I1RVm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 28 Sep 2013 13:21:42 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1VPyD7-00042B-9i
	for linux-serial@vger.kernel.org; Sat, 28 Sep 2013 19:21:41 +0200
Received: from 92.243.181.209 ([92.243.181.209])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Sat, 28 Sep 2013 19:21:41 +0200
Received: from matwey.kornilov by 92.243.181.209 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Sat, 28 Sep 2013 19:21:41 +0200
In-Reply-To: <l26uk7$id2$2@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

28.09.2013 20:03, Grant Edwards =EF=E8=F8=E5=F2:
> What you're talking about is pretty much the existing pty device.
>
> Unfortunately, Linux pty's only support a subset of the serial port
> API, so they can't be used for applications like network-connected
> serial ports.  So people like me have to write kernel-mode drivers fo=
r
> such devices.

Yep, pty_set_termios looks like a mock or dummy, when it is critical=20
part to applications like network serial port devices. One needs to set=
=20
baudrate, parity, etc.

> I've suggested extending the Linux pty so that it _does_ support the
> rest of the serial port API.  I even offered to work on it if the
> results would likely be accepted into the kernel tree, but my
> questions/offers have never gotten any response.

It seems that BSD and Unix98 pty's may coexist in pty.c. So, there is a=
=20
chance that it is possible to add support of Extended pty not breaking=20
existing things. One need to be a brave to change something in pty.c, I=
t=20
is quite critical part.

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
