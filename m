From: "Bi, Chao" <chao.bi@intel.com>
Subject: RE: [PATCH] serial:ifx6x60:different SPI word width configure
 requires different swap process
Date: Thu, 25 Oct 2012 00:40:43 +0000
Message-ID: <253F3AA5ECB4EC43A2CA0147545F67F2102A4EC2@SHSMSX102.ccr.corp.intel.com>
References: <1351061328.18855.95.camel@bichao>
 <20121024133129.1155cc2e@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29299 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752068Ab2JYFNB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Oct 2012 01:13:01 -0400
In-Reply-To: <20121024133129.1155cc2e@pyramind.ukuu.org.uk>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "alan@linux.intel.com" <alan@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Gorby, Russ" <russ.gorby@intel.com>, "Liu, Chuansheng" <chuansheng.liu@intel.com>, "Chen, Jun D" <jun.d.chen@intel.com>

> Minor question - is that not just (len + 3) >> 2 ?
Yes, I'll update it in another mail. Thanks.

Chao

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
Sent: Wednesday, October 24, 2012 8:31 PM
To: Bi, Chao
Cc: alan@linux.intel.com; linux-serial@vger.kernel.org; Gorby, Russ; Liu, Chuansheng; Chen, Jun D
Subject: Re: [PATCH] serial:ifx6x60:different SPI word width configure requires different swap process

On Wed, 24 Oct 2012 14:48:48 +0800
chao bi <chao.bi@intel.com> wrote:

> 
> SPI protocol driver only provide one function (swap_buf()) to swap SPI 
> data into big endian format, which is only available when SPI 
> controller's word width is 16 bits. But word width could be configured 
> as 8/16/32 bits, different word width configure should be mapped to 
> different swap methods.This patch is to make SPI protocol driver 
> choose the right swap function corresponding to SPI word width configuration.
> 
> cc: liu chuansheng <chuansheng.liu@intel.com>
> cc: Chen Jun <jun.d.chen@intel.com>
> Signed-off-by: channing <chao.bi@intel.com>

> +	len = (0 == (len&0x03)) ? (len >> 2) : ((len >> 2) + 1);

Minor question - is that not just (len + 3) >> 2 ?

The SPI swapping stuff at runtime looks right so.

Acked-by: Alan Cox <alan@linux.intel.com>
