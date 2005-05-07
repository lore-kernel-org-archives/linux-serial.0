From: Gerald Emig <gme@emig-software.de>
Subject: Re: tcdrain / TCSBRK / wait_until_sent delay
Date: Sat, 7 May 2005 12:32:20 +0200
Message-ID: <20050507123220.56bba950@emig4.heisch.inka.de>
References: <200505051650.38471.andyparkins@gmail.com>
	<Pine.LNX.4.58.0505051023210.21399@deadrat.localdomain>
	<200505060901.10692.andyparkins@gmail.com>
	<Pine.LNX.4.58.0505061137590.21399@deadrat.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:62206 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262954AbVEGKcg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 7 May 2005 06:32:36 -0400
In-Reply-To: <Pine.LNX.4.58.0505061137590.21399@deadrat.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rich+ml@lclogic.com
Cc: Andy Parkins <andyparkins@gmail.com>, linux-serial@vger.kernel.org

On Fri, 6 May 2005 12:14:51 -0700 (PDT)
rich+ml@lclogic.com wrote:

> On Fri, 6 May 2005, Andy Parkins wrote:
> 
> > I'm not sure what the HZ/50 is for.
> Undoes some fudge factor added on when first calculated.
> 
> > These times will all be significantly smaller than 1ms; if the value
> > of HZ where going to affect this then why has the author bothered to
> > calculate these times at all? 1ms would drown these other timeouts
> > out.
> It only kicks in for sub-1200 baud.
> 
> In any case linux is not an RTOS, it does not guarantee maximum
> latency, so no matter what you are going to be intermittent at best.


That is the key: because switching the handshake lines is commonly done
by software, it usually can not be reliable if you need a correct
switching of RTS.
You should instead purchase a dedicated RS485 board that does the
switching by hardhare.


> 
> Have you tried hardware flow control, "stty crtscts < /dev/ttyX"?. 
> With CTS strapped high, RTS should follow THRE||TE.

Probably with a delay depending on the current system load, I suppose !




Gerald

