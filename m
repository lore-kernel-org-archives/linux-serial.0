From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: 8250_dw DMA issue with BYT ?
Date: Thu, 17 Apr 2014 13:21:01 +0300
Message-ID: <20140417102101.GA17611@xps8300>
References: <50C3158CF44D924791C15F1437EF2EC65D9BE7@HASMSX104.ger.corp.intel.com>
 <20140415065606.GA3368@xps8300>
 <0C6A3B2997299B4EAD81D386F36CD8C210C8AB23@shsmsx102.ccr.corp.intel.com>
 <50C3158CF44D924791C15F1437EF2EC65DA634@HASMSX104.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54223 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227AbaDQKVH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Apr 2014 06:21:07 -0400
Content-Disposition: inline
In-Reply-To: <50C3158CF44D924791C15F1437EF2EC65DA634@HASMSX104.ger.corp.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Poulain, Loic" <loic.poulain@intel.com>
Cc: "Jin, Yao" <yao.jin@intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hi Loic,

On Wed, Apr 16, 2014 at 04:34:58PM +0000, Poulain, Loic wrote:
> After analysis, here is my status:
> 
> The Bluetooth chip generates hardware errors due to unexpected
> data. These unexpected data are caused by 8250 concurrent TX.
> 
> - Concurrent DMA TX (8250_dma.c):
> 
> After each DMA transfer, __dma_tx_complete() is called.
> This function updates the circular buffer tail and calls
> serial8250_tx_dma() if data remains.
> 
> However these operations are not protected against concurrent
> call of serial8250_tx_dma() (via uart start_tx). So, this concurrent 
> call may use non-updated tail index and may be called in parallel 
> of an other serial8250_tx_dma().
> 
> 
> - Concurrent Chars TX (8250_corec.c):
> 
> In the serial8250_handle_irq(), serial8250_tx_chars is called if
> UART_LSR_THRE. However we should not call this function
> if we are using the DMA. Moreover, for the same reason as above,
> serial8250_tx_chars could be called with bad tail index or in parallel
> of a serial8250_tx_dma.

Nice job! Thanks a lot for the analysis!

> I think two fixes are necessary:
> 
> to avoid tx chars usage:

<snip>

> The last one fixes TX issues but causes random freeze of my
> platform (when uploading file via bluetooth). It seems to be a deadlock.
> I have no kernel trace in my console, system is stuck.
> 
> To temporally workaround this, I simply moved "tx_running=0" after updating
> tail index (in __dma_tx_complete) so that no dma_tx can happen before 
> this update.
> 
> 	xmit->tail += dma->tx_size;
> 	xmit->tail &= UART_XMIT_SIZE - 1;
> 	p->port.icount.tx += dma->tx_size;
> 
> 	dma->tx_running = 0;

As a side note. Since you are in any case playing with the tx_running
flag, could you check if it's possible to drop it and just rely on the
status from the dma engine (with dmaengine_tx_status())?


Thanks,

-- 
heikki
