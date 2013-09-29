From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: tty loop-back device
Date: Sun, 29 Sep 2013 03:21:26 +0000 (UTC)
Message-ID: <l286bm$239$1@ger.gmane.org>
References: <l26jrq$48d$1@ger.gmane.org> <l26uk7$id2$2@ger.gmane.org>
 <l2736h$db0$1@ger.gmane.org> <l27esn$cn6$1@ger.gmane.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44609 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753466Ab3I2DVt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 28 Sep 2013 23:21:49 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1VQ7Zr-0002U7-HA
	for linux-serial@vger.kernel.org; Sun, 29 Sep 2013 05:21:47 +0200
Received: from c-24-118-110-103.hsd1.mn.comcast.net ([24.118.110.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Sun, 29 Sep 2013 05:21:47 +0200
Received: from grant.b.edwards by c-24-118-110-103.hsd1.mn.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Sun, 29 Sep 2013 05:21:47 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2013-09-28, Matwey V. Kornilov <matwey.kornilov@gmail.com> wrote:
> 28.09.2013 21:21, Matwey V. Kornilov ?????:
>> It seems that BSD and Unix98 pty's may coexist in pty.c. So, there is a
>> chance that it is possible to add support of Extended pty not breaking
>> existing things. One need to be a brave to change something in pty.c, It
>> is quite critical part.
>
> It seems that we need new line discipline to allow async notification of 
> master tty when the client changes tty->termios. poll() has to be 
> reimplemented to generate POLLPRI, when tty->termios handling required 
> on the master side, then master may use special ioctl to read 
> tty->termios requested.

I was thinking about initially just creating a blocking ioctl() call
that the master can use to wait for either a termios configuration
change or a modem control line change.  I admit that's not as elegent:
it would mean a master would need multiple threads in most cases (one
for data and one for config and modem status).  But, it may be a less
intrusive change [I haven't looked at the poll implementation in any
detail, so perhaps the poll change isn't as bad as I fear.]

Having to use multiple threads in a master sounds ugly at first, but
it's still orders of magnitude easier than implementing a serial
driver in kernel space that uses network I/O to communicate with the
physical UART.

-- 
Grant

