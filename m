From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Subject: [PATCH] serial:ifx6x60:add swap_buf_32 function in
 case SPI word width is 32 bits
Date: Tue, 23 Oct 2012 10:39:20 +0100
Message-ID: <20121023103920.3bcb9159@pyramind.ukuu.org.uk>
References: <1350981170.18855.83.camel@bichao>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:49891 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932768Ab2JWJeW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Oct 2012 05:34:22 -0400
In-Reply-To: <1350981170.18855.83.camel@bichao>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: chao bi <chao.bi@intel.com>
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, richardx.r.gorby@intel.com, jun.d.chen@intel.com, chuansheng.liu@intel.com

> is 16 bits. But per our experiment and validation on medfield platform, 16 bit
> word width cannot cover all scenarioes, 32 bits word width is a better choice
> to avoid SPI FIFO overrun. Therefore, SPI controller is likely to configure its
> word width as either 16 bits or 32 bits. This patch is to implement 2 functions
> (swap_buf_16() and swap_buf_32()) to adapt the two configurations.

And how will you get both to work with the same kernel, which is the way
Linux wants to work (and avoids the nasty mess some other embedded
platforms have gotten themselves into).

What you probably want to do is is put a 16/32bit flag into the platform
data and then in ifx_spi_spi_probe() just do


	if (pl_data->spi_32)
		ifx_dev->swap = swap_buf_32;
	else
		ifx_dev->swap = swap_buf;


then call

	ifx_dev->swap_buf()

Alan
