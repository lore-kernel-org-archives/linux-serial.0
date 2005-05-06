From: rich+ml@lclogic.com
Subject: Re: tcdrain / TCSBRK / wait_until_sent delay
Date: Fri, 6 May 2005 12:14:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505061137590.21399@deadrat.localdomain>
References: <200505051650.38471.andyparkins@gmail.com>
 <Pine.LNX.4.58.0505051023210.21399@deadrat.localdomain>
 <200505060901.10692.andyparkins@gmail.com>
Reply-To: rich+ml@lclogic.com
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from adsl-64-164-130-2.dsl.snfc21.pacbell.net ([64.164.130.2]:10245
	"EHLO mail.lclogic.com") by vger.kernel.org with ESMTP
	id S261275AbVEFTOy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 May 2005 15:14:54 -0400
In-Reply-To: <200505060901.10692.andyparkins@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
Cc: linux-serial@vger.kernel.org

On Fri, 6 May 2005, Andy Parkins wrote:

> I'm not sure what the HZ/50 is for.
Undoes some fudge factor added on when first calculated.

> These times will all be significantly smaller than 1ms; if the value of HZ
> where going to affect this then why has the author bothered to calculate
> these times at all? 1ms would drown these other timeouts out.
It only kicks in for sub-1200 baud.

In any case linux is not an RTOS, it does not guarantee maximum latency,
so no matter what you are going to be intermittent at best.

Have you tried hardware flow control, "stty crtscts < /dev/ttyX"?.  With
CTS strapped high, RTS should follow THRE||TE.

== Rich
