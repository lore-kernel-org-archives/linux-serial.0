From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial:ifx6x60:different SPI word width configure
 requires different swap process
Date: Wed, 24 Oct 2012 13:31:29 +0100
Message-ID: <20121024133129.1155cc2e@pyramind.ukuu.org.uk>
References: <1351061328.18855.95.camel@bichao>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:51933 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758041Ab2JXM00 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Oct 2012 08:26:26 -0400
In-Reply-To: <1351061328.18855.95.camel@bichao>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: chao bi <chao.bi@intel.com>
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, richardx.r.gorby@intel.com, chuansheng.liu@intel.com, jun.d.chen@intel.com

On Wed, 24 Oct 2012 14:48:48 +0800
chao bi <chao.bi@intel.com> wrote:

> 
> SPI protocol driver only provide one function (swap_buf()) to swap SPI data
> into big endian format, which is only available when SPI controller's word width
> is 16 bits. But word width could be configured as 8/16/32 bits, different word
> width configure should be mapped to different swap methods.This patch is to make
> SPI protocol driver choose the right swap function corresponding to SPI word
> width configuration.
> 
> cc: liu chuansheng <chuansheng.liu@intel.com>
> cc: Chen Jun <jun.d.chen@intel.com>
> Signed-off-by: channing <chao.bi@intel.com>

> +	len = (0 == (len&0x03)) ? (len >> 2) : ((len >> 2) + 1);

Minor question - is that not just (len + 3) >> 2 ?

The SPI swapping stuff at runtime looks right so.

Acked-by: Alan Cox <alan@linux.intel.com>
