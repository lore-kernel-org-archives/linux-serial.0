From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: EXT: Re: [PATCH RFC 1/4] dma: imx-sdma - reduce transfer latency
 for DMA cyclic clients
Date: Sat, 2 Jul 2016 22:57:05 +0530
Message-ID: <20160702172704.GV14945@localhost>
References: <cover.1465456639.git.nandor.han@ge.com>
 <0ed1e0027f135e9c88d7ac094ca807c7dc8f6713.1465456639.git.nandor.han@ge.com>
 <20160628143426.GB14945@localhost>
 <57768552.6060407@ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57768552.6060407@ge.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nandor Han <nandor.han@ge.com>
Cc: =Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Jul 01, 2016 at 05:59:30PM +0300, Nandor Han wrote:
> 
> 
> On 28/06/16 17:34, Vinod Koul wrote:
> >On Thu, Jun 09, 2016 at 03:16:30PM +0300, Nandor Han wrote:
> >>Having the SDMA driver use a tasklet for running the clients
> >>callback introduce some issues:
> >>   - probability to have desynchronized data because of the
> >>     race condition created since the DMA transaction status
> >>     is retrieved only when the callback is executed, leaving
> >>     plenty of time for transaction status to get altered.
> >>   - inter-transfer latency which can leave channels idle.
> >>
> >>Move the callback execution, for cyclic channels, to SDMA
> >>interrupt (as advised in `Documentation/dmaengine/provider.txt`)
> >>to (a)reduce the inter-transfer latency and (b) eliminate the
> >>race condition possibility where DMA transaction status might
> >>be changed by the time is read.
> >>
> >>The responsibility of the SDMA interrupt latency
> >>is moved to the SDMA clients which case by case should defer
> >>the work to bottom-halves when needed.
> >
> >Both of these look fine. Please change the patch titles to dmaengine: xxxx
> >
> >Are these going to be merged thru dmaengine tree or serial one?
> >
> 
> I will send soon a V2 where I will fix the titles. If you are OK
> with all the patchset it can be merged to dmaengine tree, otherwise
> probably goes to serial one.

Sure I can merge all.. provided ACKs on other patches.


-- 
~Vinod
