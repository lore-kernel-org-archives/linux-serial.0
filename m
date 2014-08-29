From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 07/15] tty: serial: 8250_dma: enqueue RX dma again on
 completion.
Date: Fri, 29 Aug 2014 17:52:53 +0200
Message-ID: <5400A1D5.705@linutronix.de>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>	<1408124563-31541-8-git-send-email-bigeasy@linutronix.de> <20140818115249.537b3e42@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47736 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbaH2PxY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 29 Aug 2014 11:53:24 -0400
In-Reply-To: <20140818115249.537b3e42@alan.etchedpixels.co.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On 08/18/2014 12:52 PM, One Thousand Gnomes wrote:
> 
>>  		if (!up->dma || dma_err)
>>  			status = serial8250_rx_chars(up, status);
>> +
>> +		if (dma_err && port->type == PORT_OMAP_16750)
>> +			serial8250_rx_dma(up, 0);
> 
> Can we stick to a 'has dma' flag and port->rx_dma() type usages so that
> we don't have to rewrite it again to add them the next slightly odd DMA
> user we add 8)

I hide this behind a bug flag, something like UART_NEEDS_DMA_RX_PENDING.

Sebastian
