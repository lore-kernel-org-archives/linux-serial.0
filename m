From: "Bi, Chao" <chao.bi@intel.com>
Subject: RE: Subject: [PATCH] serial:ifx6x60:add swap_buf_32 function in
 case SPI word width is 32 bits
Date: Wed, 24 Oct 2012 06:43:33 +0000
Message-ID: <253F3AA5ECB4EC43A2CA0147545F67F2102A4D15@SHSMSX102.ccr.corp.intel.com>
References: <1350981170.18855.83.camel@bichao>
 <20121023103920.3bcb9159@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:3599 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933331Ab2JXGni convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Oct 2012 02:43:38 -0400
In-Reply-To: <20121023103920.3bcb9159@pyramind.ukuu.org.uk>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "alan@linux.intel.com" <alan@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Gorby, Russ" <russ.gorby@intel.com>, "Chen, Jun D" <jun.d.chen@intel.com>, "Liu, Chuansheng" <chuansheng.liu@intel.com>

Hi Alan,

Yes, you're right.
SPI word width is configured by Protocol driver in ifx_spi_spi_probe(), it could be 8/16/32 bits, so Protocol driver should choose diff swap method according to the configuration.
I've update the patch as your suggestion, please check another PATCH mail.
Thanks!

Chao


-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
Sent: Tuesday, October 23, 2012 5:39 PM
To: Bi, Chao
Cc: alan@linux.intel.com; linux-serial@vger.kernel.org; Gorby, Russ; Chen, Jun D; Liu, Chuansheng
Subject: Re: Subject: [PATCH] serial:ifx6x60:add swap_buf_32 function in case SPI word width is 32 bits

> is 16 bits. But per our experiment and validation on medfield 
> platform, 16 bit word width cannot cover all scenarioes, 32 bits word 
> width is a better choice to avoid SPI FIFO overrun. Therefore, SPI 
> controller is likely to configure its word width as either 16 bits or 
> 32 bits. This patch is to implement 2 functions
> (swap_buf_16() and swap_buf_32()) to adapt the two configurations.

And how will you get both to work with the same kernel, which is the way Linux wants to work (and avoids the nasty mess some other embedded platforms have gotten themselves into).

What you probably want to do is is put a 16/32bit flag into the platform data and then in ifx_spi_spi_probe() just do


	if (pl_data->spi_32)
		ifx_dev->swap = swap_buf_32;
	else
		ifx_dev->swap = swap_buf;


then call

	ifx_dev->swap_buf()

Alan
