From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: n_tty_write() going into schedule but NOT coming out
Date: Sat, 6 Apr 2013 15:02:02 +0530
Message-ID: <515FEB92.9060707@synopsys.com>
References: <5156DC21.20901@synopsys.com> <5159925B.5050806@synopsys.com>  <1364829008.3617.21.camel@thor.lan> <515ADC96.7090908@synopsys.com> <1365191567.3585.10.camel@thor.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from us02smtp2.synopsys.com ([198.182.60.77]:48110 "EHLO
	alvesta.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163221Ab3DFJcQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 6 Apr 2013 05:32:16 -0400
In-Reply-To: <1365191567.3585.10.camel@thor.lan>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On 04/06/2013 01:22 AM, Peter Hurley wrote:
> I'll see if I can reproduce this over the weekend on an old single-core laptop I
> still have.

TIA for doing this.

> There were some race conditions in the N_TTY line discipline which I
> recently fixed. Those changes are in linux-next. Can you test if this is
> reproducible on linux-next?

I tried today's -next and I see the same issue :-(

> Assuming I don't reproduce this on the laptop, the only other
> explanation I can think of right now is that ARCLinux is not properly
> handling signal-driven i/o (assuming the BusyBox /bin/sh uses SIGIO). Do
> you know if there is anything special about the way ARCLinux handle
> signals?

No, it's pretty standard stuff - we are uClibc based though - as opposed to glibc
so there might be some subtleties - but we do run LTP open posix regularly. Also
the test setup is a slowish 80MHz FPGA so this is not something many people have
in their regular test setups.

I'll start reading the relevant code myself - and will be willing to take any
debug/test patches which help with troubleshooting of this issue.

Just to re-iterate, my test setup has a minimal busybox based rootfs, 3 telnet
sessions, each running a
while true; do find / -name "*" ; done

I'm running out of ramfs, no external disk/nfs mounts to reduce the peripheral I/O
slowing down the find (although NFS stuff will be caches anyways after first fetch).

Also please make sure you have CONFIG_PREEMPT_COUNT otherwise there's a
possibility (atleast on ARC builds) that a stale register causes timer list to be
corrupted in mod_timer().

Thx,
-Vineet
