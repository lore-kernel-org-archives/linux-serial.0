From: rich+ml@lclogic.com
Subject: Re: tcdrain / TCSBRK / wait_until_sent delay
Date: Sat, 7 May 2005 11:09:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505071011510.21399@deadrat.localdomain>
References: <200505051650.38471.andyparkins@gmail.com>
 <200505060901.10692.andyparkins@gmail.com> <Pine.LNX.4.58.0505061137590.21399@deadrat.localdomain>
 <200505071035.55508.andyparkins@gmail.com>
Reply-To: rich+ml@lclogic.com
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from adsl-64-164-130-2.dsl.snfc21.pacbell.net ([64.164.130.2]:35846
	"EHLO mail.lclogic.com") by vger.kernel.org with ESMTP
	id S262737AbVEGSJW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 7 May 2005 14:09:22 -0400
In-Reply-To: <200505071035.55508.andyparkins@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
Cc: linux-serial@vger.kernel.org

> > Have you tried hardware flow control, "stty crtscts < /dev/ttyX"?.  With
> > CTS strapped high, RTS should follow THRE||TE.
>
> That's an interesting idea - CTS is currently set by the RS485 converter to
> indicate when it has successfully turned the buffer around.  So it goes, RTS
> set high, wait for CTS, send...  Is what you're suggesting that I cut this
> wire and hold CTS high externally?

Oh no, in that case you don't need to do anything. The transaction you
described is exactly what happens automatically when crtscts is enabled.

However if your uart doesn't actually support AFE then it will be done
by the driver and have the timing characteristics you see already.

Hook up your scope, "stty crtscts < /dev/ttyX; echo test > /dev/ttyX" and
see what happens.

== Rich
