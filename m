From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v1 1/2] dmaengine: slave means at least one of DMA_SLAVE,
 DMA_CYCLIC
Date: Tue, 10 May 2016 21:43:57 +0530
Message-ID: <20160510161356.GJ2274@localhost>
References: <1462390180-82368-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1462390180-82368-2-git-send-email-andriy.shevchenko@linux.intel.com>
 <20160510155637.GG2274@localhost>
 <1462896063.17131.306.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462896063.17131.306.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, May 10, 2016 at 07:01:03PM +0300, Andy Shevchenko wrote:
> On Tue, 2016-05-10 at 21:26 +0530, Vinod Koul wrote:
> > On Wed, May 04, 2016 at 10:29:39PM +0300, Andy Shevchenko wrote:
> > > 
> > > When check for capabilities recognize slave support by eother
> > > DMA_SLAVE or
> > 							^^^^^^^
> > typo
> 
> Indeed, thanks.
> Do I need to resend this one?

Yes please.

Also instead of OR, AND will do the same, but your approach works too, so
either way am fine..

And I do not get correlation with fix on patch 1. This should be independent
change..


-- 
~Vinod
