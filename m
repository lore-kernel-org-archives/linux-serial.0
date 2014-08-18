From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 07/15] tty: serial: 8250_dma: enqueue RX dma again on
 completion.
Date: Mon, 18 Aug 2014 11:52:49 +0100
Message-ID: <20140818115249.537b3e42@alan.etchedpixels.co.uk>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
	<1408124563-31541-8-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1408124563-31541-8-git-send-email-bigeasy@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org


>  		if (!up->dma || dma_err)
>  			status = serial8250_rx_chars(up, status);
> +
> +		if (dma_err && port->type == PORT_OMAP_16750)
> +			serial8250_rx_dma(up, 0);

Can we stick to a 'has dma' flag and port->rx_dma() type usages so that
we don't have to rewrite it again to add them the next slightly odd DMA
user we add 8)

