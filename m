From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: 8250_dw: support high baudrates if possible
Date: Sat, 28 Jun 2014 16:36:08 +0100
Message-ID: <20140628163608.0c5536a9@alan.etchedpixels.co.uk>
References: <1403889920-1127-1-git-send-email-elder@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:54054 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224AbaF1Pgd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 28 Jun 2014 11:36:33 -0400
In-Reply-To: <1403889920-1127-1-git-send-email-elder@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alex Elder <elder@linaro.org>
Cc: gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com, david.daney@cavium.com, loic.poulain@intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 27 Jun 2014 12:25:20 -0500
> +		rate = 16 * max(115200U, (unsigned int)baud);
> +

This assumes an arbitarily configurable clock, which is not I think the
usual case. 
> +		/*
> +		 * Request a different clock rate if necessary, and
> +		 * record it if successful.
> +		 */
> +		if (rate != p->uartclk) {
> +			BUG_ON(!data->clk);
> +			if (!clk_set_rate(data->clk, (unsigned long)rate))
> +				p->uartclk = rate;
> +		}


