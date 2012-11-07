From: "Chen, Jun D" <jun.d.chen@intel.com>
Subject: RE: [PATCH] serial: ifx6x60: ifx_spi_write don't need to do
 mrdy_assert when fifo is not empty.
Date: Wed, 7 Nov 2012 09:09:54 +0000
Message-ID: <9E44E06DBBA23A489DED933DBC291A850FD7058C@SHSMSX102.ccr.corp.intel.com>
References: <1352194134.4332.47.camel@chenjun-workstation>
 <20121106094728.7ed9d586@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34037 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753132Ab2KGJJ5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Nov 2012 04:09:57 -0500
In-Reply-To: <20121106094728.7ed9d586@pyramind.ukuu.org.uk>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@linux.intel.com>, serial <linux-serial@vger.kernel.org>, "Gorby, Russ" <russ.gorby@intel.com>, "Bi, Chao" <chao.bi@intel.com>

Hi,Alan
	Thank for your question, I will update this patch in other email. 
 
-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
Sent: Tuesday, November 06, 2012 5:47 PM
To: Chen, Jun D
Cc: Alan Cox; serial; Gorby, Russ; Bi, Chao
Subject: Re: [PATCH] serial: ifx6x60: ifx_spi_write don't need to do mrdy_assert when fifo is not empty.

On Tue, 06 Nov 2012 04:28:54 -0500
Jun Chen <jun.d.chen@intel.com> wrote:

> 
> This patch check whether the kfifo lenth equal to the count of write 
> data.If condition is true,ifx_spi_write need to trigger one 
> mrdy_assert. If condition is false,the mrdy_assert will be triggered by the next ifx_spi_io.
> Cc: Bi Chao <chao.bi@intel.com>
> Signed-off-by: Chen Jun <jun.d.chen@intel.com>
> ---
>  drivers/tty/serial/ifx6x60.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/tty/serial/ifx6x60.c 
> b/drivers/tty/serial/ifx6x60.c index ac718e1..b52ef8d 100644
> --- a/drivers/tty/serial/ifx6x60.c
> +++ b/drivers/tty/serial/ifx6x60.c
> @@ -522,7 +522,8 @@ static int ifx_spi_write(struct tty_struct *tty, const unsigned char *buf,
>  	unsigned char *tmp_buf = (unsigned char *)buf;
>  	int tx_count = kfifo_in_locked(&ifx_dev->tx_fifo, tmp_buf, count,
>  				   &ifx_dev->fifo_lock);
> -	mrdy_assert(ifx_dev);
> +	if (kfifo_len(&ifx_dev->tx_fifo) == count)
> +		mrdy_assert(ifx_dev);
>  	return tx_count;

I'm not convinced this is safe. What stops the sending task from emptying data out of the fifo between the kfifo_in_locked and the kfifo_len check ?

Can't you just check tx_count ?

Alan
