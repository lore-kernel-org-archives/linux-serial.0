From: "Chen, Jun D" <jun.d.chen@intel.com>
Subject: RE: [PATCH] serial: ifx6x60: ifx_spi_write don't need to do
 mrdy_assert when fifo is not empty.
Date: Sun, 18 Nov 2012 03:14:28 +0000
Message-ID: <9E44E06DBBA23A489DED933DBC291A850FD7A645@SHSMSX102.ccr.corp.intel.com>
References: <1353064117.24092.4.camel@chenjun-workstation>
 <20121116123834.GA9327@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1193 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752527Ab2KRDOc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 17 Nov 2012 22:14:32 -0500
In-Reply-To: <20121116123834.GA9327@kroah.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, "Bi, Chao" <chao.bi@intel.com>, serial <linux-serial@vger.kernel.org>, "Gorby, Russ" <russ.gorby@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wu, Fengguang" <fengguang.wu@intel.com>

Hi,
   I make this patch on your tty-next tree,  Do I need to make it on the branch 3.7-rc6 against?

-----Original Message-----
From: Greg KH [mailto:gregkh@linuxfoundation.org] 
Sent: Friday, November 16, 2012 8:39 PM
To: Chen, Jun D
Cc: Alan Cox; Bi, Chao; serial; Gorby, Russ; linux-kernel@vger.kernel.org; Wu, Fengguang
Subject: Re: [PATCH] serial: ifx6x60: ifx_spi_write don't need to do mrdy_assert when fifo is not empty.

On Fri, Nov 16, 2012 at 06:08:37AM -0500, Jun Chen wrote:
> 
> This patch check whether the fifo lenth is empty before writing new 
> data to fifo.If condition is true,ifx_spi_write need to trigger one 
> mrdy_assert. If condition is false,the mrdy_assert will be trigger by the next ifx_spi_io.
> 
> Cc: Bi Chao <chao.bi@intel.com>
> Signed-off-by: Chen Jun <jun.d.chen@intel.com>
> ---
>  drivers/tty/serial/ifx6x60.c |   14 +++++++++++---
>  1 files changed, 11 insertions(+), 3 deletions(-)

What tree did you make this against?  It doesn't apply to my tty-next tree at all :(

greg k-h
