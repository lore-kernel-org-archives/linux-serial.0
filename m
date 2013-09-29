From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Subject: Re: tty loop-back device
Date: Sun, 29 Sep 2013 11:09:58 +0400
Message-ID: <l28jnt$j67$1@ger.gmane.org>
References: <l26jrq$48d$1@ger.gmane.org> <l26uk7$id2$2@ger.gmane.org> <l2736h$db0$1@ger.gmane.org> <l27esn$cn6$1@ger.gmane.org> <l286bm$239$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:48155 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342Ab3I2HKN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 29 Sep 2013 03:10:13 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1VQB8u-0008KP-EV
	for linux-serial@vger.kernel.org; Sun, 29 Sep 2013 09:10:12 +0200
Received: from 92.243.181.209 ([92.243.181.209])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Sun, 29 Sep 2013 09:10:12 +0200
Received: from matwey.kornilov by 92.243.181.209 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Sun, 29 Sep 2013 09:10:12 +0200
In-Reply-To: <l286bm$239$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

29.09.2013 07:21, Grant Edwards =EF=E8=F8=E5=F2:
> I was thinking about initially just creating a blocking ioctl() call
> that the master can use to wait for either a termios configuration
> change or a modem control line change.  I admit that's not as elegent=
:
> it would mean a master would need multiple threads in most cases (one
> for data and one for config and modem status).  But, it may be a less
> intrusive change [I haven't looked at the poll implementation in any
> detail, so perhaps the poll change isn't as bad as I fear.]

The simplier way is to use master in 'packet mode' (see TIOCPKT). Then=20
we can distinguish stream data from termios notification for every=20
master's read. It either starts with '\0' and the following is the data=
=20
to transmit or with control symbol and then master have to use ioctl to=
=20
read new tty->termios.

> Having to use multiple threads in a master sounds ugly at first, but
> it's still orders of magnitude easier than implementing a serial
> driver in kernel space that uses network I/O to communicate with the
> physical UART.

=46or sure.

We need way more ioctls. Since every new slave pty is enumerated almost=
=20
randomly (depends on how many sessions is opened, opening order, etc),=20
we have to mark somehow the pty when the daemon creates it, then udev=20
should be able to create appropriate symbolic link for client user-spac=
e=20
application. Then user-space client may be configured to work with=20
/dev/tty/by-name/uniqname for instance.

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
