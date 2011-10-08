From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] TTY: serial_core: Fix crash if agetty() run on
 non-console serial port
Date: Sat, 8 Oct 2011 08:55:32 -0700
Message-ID: <CAD=FV=U2H08ohbgmDxWNPkh8bm8uBPt-2_H2B4cSb9LvEFWdHA@mail.gmail.com>
References: <1318024753-15336-1-git-send-email-dianders@chromium.org>
	<4E900E9E.2070604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:39414 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924Ab1JHPzf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 8 Oct 2011 11:55:35 -0400
Received: from wpaz17.hot.corp.google.com (wpaz17.hot.corp.google.com [172.24.198.81])
	by smtp-out.google.com with ESMTP id p98FtYDT031838
	for <linux-serial@vger.kernel.org>; Sat, 8 Oct 2011 08:55:34 -0700
Received: from bkbzu5 (bkbzu5.prod.google.com [10.205.80.133])
	by wpaz17.hot.corp.google.com with ESMTP id p98FsoqJ023822
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Sat, 8 Oct 2011 08:55:33 -0700
Received: by bkbzu5 with SMTP id zu5so2789060bkb.6
        for <linux-serial@vger.kernel.org>; Sat, 08 Oct 2011 08:55:33 -0700 (PDT)
In-Reply-To: <4E900E9E.2070604@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Oct 8, 2011 at 1:49 AM, Jiri Slaby <jirislaby@gmail.com> wrote:
> I cannot reproduce this. What uart driver is this with? And where does
> it call uart_suspend_port from? Basically, it would mean that it calls
> uart_suspend_port while userspace is still running? Or who HUPs the port
> (the second point in your list)?

Thank you for testing!  I am working with the 8250 driver controlling
the onboard UART on an nVidia Tegra T25 (ARM).

You raise very good questions, and I'm happy to keep tracking down to
continue to look for a deeper root cause.  I continued to do some more
testing of this patch (with the help of a few others) after posting
the list.  We tried the same setup on an x86-based board and the HUP
doesn't show up.  ...so my patch wasn't needed on that board (although
my patch didn't hurt).  ...that means, as you already pointed out,
that the HUP must _not_ be coming from userspace.

Probably the true bug in my system is that a spurious HUP is being
generated as a result of the suspend.  That is probably platform
dependent and would explain why this hasn't been a bigger problem for
others.


...however, even though my patch shouldn't be needed for any hardware
that doesn't generate the spurious HUP, it might still be worthwhile
to consider including it?  ...or perhaps changing it to a BUG_ON or
WARN_ON to at least detect the case of running the shutdown code after
the suspend code?  Definitely the case that I ran into (shutdown after
suspend) will definitely cause a crash during resume.


I will spend time on Monday digging into the source of the HUP and
will post a followup.

-Doug
