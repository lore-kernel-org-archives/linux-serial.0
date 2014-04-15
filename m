From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: 8250_dw DMA issue with BYT ?
Date: Tue, 15 Apr 2014 10:25:59 +0300
Message-ID: <1397546759.11914.151.camel@smile.fi.intel.com>
References: <50C3158CF44D924791C15F1437EF2EC65D9BE7@HASMSX104.ger.corp.intel.com>
	 <20140415065606.GA3368@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23111 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752371AbaDOH0D (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Apr 2014 03:26:03 -0400
In-Reply-To: <20140415065606.GA3368@xps8300>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Poulain, Loic" <loic.poulain@intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Jin, Yao" <yao.jin@intel.com>

On Tue, 2014-04-15 at 09:56 +0300, Heikki Krogerus wrote:
> On Mon, Apr 14, 2014 at 03:54:31PM +0000, Poulain, Loic wrote:

...

> > This problem seems due to the DMA usage. Indeed, when I disable
> > the DMA manually in 8250_dw.c (up->dma = NULL), problem does not
> > occur anymore, all baudrates are stable.
> 
> I think this is the same issue Jin Yao (CC'd) already spotted. He made
> a bug for it:
> https://bugzilla.kernel.org/show_bug.cgi?id=73071
> 
> > Do you think a specific 8250 DMA configuration could apply for the byt
> > case ?
> > How/Where can I debug to know if the 8250 DMA works as expected ?
> 
> Adding Andy. He maintains the Designware DMA Engine driver that is
> used on BYT. He should be the best person to tell how to debug the
> DMA.

In case you have DYNAMIC_DEBUG enabled in the kernel configuration you
may apply following addon to the kernel command line (considering that
you have DW_DMAC_CORE=y and DW_DMAC=y):
dw_dmac_core.dyndbg dw_dmac.dyndbg

It enables the debug messages from the dw_dmac driver.

P.S. in case you need deep debugging I have a custom patch which enables
it for all IO communication done with the hardware (this apparently
doesn't include dumps of data transfered).

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

