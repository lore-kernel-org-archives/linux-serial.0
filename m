From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: Warning about not setting tty->port: what to set it to?
Date: Mon, 14 Jan 2013 16:51:25 +0000 (UTC)
Message-ID: <kd1d2d$dfs$1@ger.gmane.org>
References: <kcpt0f$ott$1@ger.gmane.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:40381 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756521Ab3ANQvm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Jan 2013 11:51:42 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1TunGN-0003Ca-Cd
	for linux-serial@vger.kernel.org; Mon, 14 Jan 2013 17:51:55 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Mon, 14 Jan 2013 17:51:55 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Mon, 14 Jan 2013 17:51:55 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2013-01-11, Grant Edwards <grant.b.edwards@gmail.com> wrote:

> I maintain a serial card driver which, starting with kernel 3.7,
> produces this warning when a port is opened:
>
>  tty_init_dev: ttyXYZ driver does not set tty->port. This will crash the kernel later. Fix the driver!

I've been looking at 3.7.2 in-kernel tty drivers to try to figure out
what to do about this, and I don't understand how the in-kernel
drivers are avoiding the same problem I'm seeing.

I've looked at three other tty drivers: amiserial.c, rocket.c,
cyclades.c:

Based on some examination/experimentation, it seems the check for
tty->port is done during driver "installation" and occurs _before_ a
tty driver's open() function is called().

But, amiserial.c doesn't set tty->port until the open() function is
called.  How does the amiserial driver avoid the warning and stack
trace?

AFAICT, the rocket.c and cyclades.c drivers don't set tty->port at
all.

What am I missing?

-- 
Grant Edwards               grant.b.edwards        Yow! When this load is
                                  at               DONE I think I'll wash it
                              gmail.com            AGAIN ...

