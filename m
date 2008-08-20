From: Jeff DeFouw <jeffd@i2k.com>
Subject: Re: 8250 misses interrupt, stalls
Date: Wed, 20 Aug 2008 11:29:38 -0400
Message-ID: <20080820152938.GA10530@blorp.plorb.com>
References: <20080808052727.GB23330@blorp.plorb.com> <BD6105C44DDDF84AB07C23F6A35AE54E01E99F6D@dhrseasvxb03.messaging.danaherad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from qmta05.emeryville.ca.mail.comcast.net ([76.96.30.48]:49685 "EHLO
	QMTA05.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752956AbYHTP3l (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Aug 2008 11:29:41 -0400
Content-Disposition: inline
In-Reply-To: <BD6105C44DDDF84AB07C23F6A35AE54E01E99F6D@dhrseasvxb03.messaging.danaherad.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Kohne, Mike" <mike.kohne@gilbarco.com>
Cc: linux-serial@vger.kernel.org

On Fri, Aug 08, 2008 at 05:36:58AM -0700, Kohne, Mike wrote:
> I have a system (single core CPU, Winbond 83627HF, but with extra serial
> ports provided by a SCH3116 - another superio chip). In my box, the
> extra serial ports refuse to work (I never see interrupts) when I use
> SMP kernels. If I rebuild the kernel without SMP, my serial ports work
> fine. I've never gotten a sufficient explaination as to why turning on
> an SMP kernel would screw up these serial ports. We don't have the heavy
> (continuous) use that you do, so we would never have noticed the kind of
> errors you see.
> 
> Now obviously there's a wide difference between my behavior (they never
> work) and yours (they work for a while), but you might want to try
> building a non-SMP kernel (I took the distributed kernel config as my
> starting point, and just turned off SMP using make menuconfig). 
> 
> I'd be interested to know if this had any effect on your problem. 

I tried a stripped down UP kernel, but it didn't fix the problem.  It 
took about an hour to fail, compared to the usual under 10 minutes.  I 
also tried adding counters all over the interrupt paths and couldn't 
find any interrupts getting lost in the kernel.  It's looking like 
hardware for me.  I'll have to do some sort of workaround with timers.

-- 
Jeff DeFouw <jeffd@i2k.com>
