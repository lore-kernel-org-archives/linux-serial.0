From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [2.6.23-rc3 possible regression] 8250 claims nonexisting device blocking IO port
Date: Sun, 19 Aug 2007 21:47:47 -0600
Message-ID: <200708192147.47433.bjorn.helgaas@hp.com>
References: <200708181107.56087.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759107AbXHTDsN@vger.kernel.org>
In-Reply-To: <200708181107.56087.arvidjaar@mail.ru>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-serial@vger.kernel.org, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Saturday 18 August 2007 01:07:55 am Andrey Borzenkov wrote:
> This is related to thread "2.6.22-rc: regression: no irda0 interface (2.6.21 
> was OK), smsc does not find chip" but it is already way too overloaded.
> 
> In 2.6.23 smsc-ircc2 fails to initialize IrDA controller. Apparently because 
> it by default is using the same IO port as ttyS3 and this is now claimed by 
> 8250.

8250 should have claimed ttyS3 in 2.6.21 and earlier.  So from
the 8250 point of view, 2.6.21 and 2.6.23 should behave the same.

>From the smsc-ircc2 point of view, 2.6.21 and 2.6.23 should work
the same except for the additional quirk_smc_enable().  If
2.6.23 is worse than 2.6.21, please try removing the body of
quirk_smc_enable() and see whether that makes 2.6.23 as good
as 2.6.21.

For smsc-ircc2, 2.6.23 is definitely a regression from 2.6.22,
because 8250 stayed out of the way in 2.6.22.  But we had to
revert 8250 back to the 2.6.21 behavior because the change
swapped ttyS0 and ttyS1 on some machines, so we just have to
live with that 8250/smsc-ircc2 conflict for the time being.

Bjorn
