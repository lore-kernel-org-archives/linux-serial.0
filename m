From: "Bi, Chao" <chao.bi@intel.com>
Subject: RE: [PATCH] serial:ifx6x60:Keep word size accordance with SPI
 controller
Date: Wed, 16 Jan 2013 04:57:40 +0000
Message-ID: <253F3AA5ECB4EC43A2CA0147545F67F2102CE29F@SHSMSX102.ccr.corp.intel.com>
References: <1355288826.30354.237.camel@bichao>
 <20130116025028.GA29056@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:30227 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757526Ab3APE6L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Jan 2013 23:58:11 -0500
In-Reply-To: <20130116025028.GA29056@kroah.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, "Gorby, Russ" <russ.gorby@intel.com>, "Chen, Jun D" <jun.d.chen@intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Sorry for that, please check my resubmitted patch right now.

Thanks,
Chao

-----Original Message-----
From: Greg KH [mailto:gregkh@linuxfoundation.org] 
Sent: Wednesday, January 16, 2013 10:50 AM
To: Bi, Chao
Cc: Alan Cox; Gorby, Russ; Chen, Jun D; linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial:ifx6x60:Keep word size accordance with SPI controller

On Wed, Dec 12, 2012 at 01:07:06PM +0800, chao bi wrote:
> 
> As protocol driver, IFX SPI driver initiate to setup SPI master with 
> default SPI word size as 16 bit/word, however, SPI master may not 
> adopt this default value due to SPI controller's capability, it might 
> choose an available value by itself and set it to 
> spi_device.bits_per_word. In order to keep align with Controller, IFX 
> driver should make use of this value during SPI transfer, but the default one.
> 
> Signed-off-by: Chen Jun <jun.d.chen@intel.com>
> Signed-off-by: channing <chao.bi@intel.com>
> ---
>  drivers/tty/serial/ifx6x60.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/tty/serial/ifx6x60.c 
> b/drivers/tty/serial/ifx6x60.c index 675d94a..5919992 100644
> --- a/drivers/tty/serial/ifx6x60.c
> +++ b/drivers/tty/serial/ifx6x60.c
> @@ -810,7 +810,8 @@ static void ifx_spi_io(unsigned long data)
>  		ifx_dev->spi_xfer.cs_change = 0;
>  		ifx_dev->spi_xfer.speed_hz = ifx_dev->spi_dev->max_speed_hz;
>  		/* ifx_dev->spi_xfer.speed_hz = 390625; */
> -		ifx_dev->spi_xfer.bits_per_word = spi_bpw;
> +		ifx_dev->spi_xfer.bits_per_word =
> +		ifx_dev->spi_dev->bits_per_word;

Please follow the proper coding style (hint, this isn't it.)

thanks,

greg k-h
