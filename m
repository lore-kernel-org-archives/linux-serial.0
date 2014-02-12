From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: sirf: update copyright years to 2014
Date: Wed, 12 Feb 2014 06:19:31 -0800
Message-ID: <20140212141931.GA7688@kroah.com>
References: <1392214124-3427-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:48381 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948AbaBLORX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Feb 2014 09:17:23 -0500
Content-Disposition: inline
In-Reply-To: <1392214124-3427-1-git-send-email-21cnbao@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-serial@vger.kernel.org, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>

On Wed, Feb 12, 2014 at 10:08:44PM +0800, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  drivers/tty/serial/sirfsoc_uart.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
> index 49a2ffd..7079b5c 100644
> --- a/drivers/tty/serial/sirfsoc_uart.c
> +++ b/drivers/tty/serial/sirfsoc_uart.c
> @@ -1,7 +1,8 @@
>  /*
>   * Driver for CSR SiRFprimaII onboard UARTs.
>   *
> - * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
> + * Copyright (c) 2011 - 2014 Cambridge Silicon Radio Limited, a CSR plc group
> + * company.

I do not see contributions from csr for all of these years, so no, this
is not allowed.  Please go talk with your corporate lawyer if you have
questions about how/when to update the copyright of your files, as I
don't think they would agree that this change is correct.

greg k-h
