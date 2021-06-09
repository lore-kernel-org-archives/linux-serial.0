Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5251C48BCF
	for <linux-serial@archiver.kernel.org>; Wed,  9 Jun 2021 12:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CDDB6128A
	for <linux-serial@archiver.kernel.org>; Wed,  9 Jun 2021 12:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbhFIMnh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Jun 2021 08:43:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232663AbhFIMng (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Jun 2021 08:43:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 325606128A;
        Wed,  9 Jun 2021 12:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623242501;
        bh=Xbsc3bY6YJ0pnoKPD9UgbsyV3ALnbDq7EDI/CjmvsZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2sb+2we58p3qKSNv2yBAgyV29ezdYBJ09mOUVmW2U4W4CzbJo5ZcOGHRdJvz1enPp
         8tT84Q6cwvzAxuwKADtTqFvM7LDk81N/QiXLzW0rKIeDvI6SS0C81ht/QWv6dX3W2X
         o1sTgvIgp/Q6PjFYR0eL6AGaaEsQ0sezRr6ZEPd0=
Date:   Wed, 9 Jun 2021 14:41:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 2/3] serial: 8250_exar: Extract exar_get_platform()
 helper
Message-ID: <YMC3AhYbxA0Nbp8q@kroah.com>
References: <20210608144239.12697-1-andriy.shevchenko@linux.intel.com>
 <20210608144239.12697-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608144239.12697-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 08, 2021 at 05:42:38PM +0300, Andy Shevchenko wrote:
> We would like to use DMI matching in other functions as well.
> Hence, extract it as exar_get_platform() helper function.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_exar.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index bd4e9f6ac29c..3ffeedc29c83 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -501,23 +501,27 @@ static const struct dmi_system_id exar_platforms[] = {
>  	{}
>  };
>  
> +static const struct exar8250_platform *exar_get_platform(void)
> +{
> +	const struct dmi_system_id *dmi_match;
> +
> +	dmi_match = dmi_first_match(exar_platforms);
> +	if (dmi_match)
> +		return dmi_match->driver_data;
> +
> +	return &exar8250_default_platform;
> +}
> +
>  static int
>  pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
>  		   struct uart_8250_port *port, int idx)
>  {
> -	const struct exar8250_platform *platform;
> -	const struct dmi_system_id *dmi_match;
> +	const struct exar8250_platform *platform = exar_get_platform();
>  	unsigned int offset = idx * 0x400;
>  	unsigned int baud = 7812500;
>  	u8 __iomem *p;
>  	int ret;
>  
> -	dmi_match = dmi_first_match(exar_platforms);
> -	if (dmi_match)
> -		platform = dmi_match->driver_data;
> -	else
> -		platform = &exar8250_default_platform;
> -
>  	port->port.uartclk = baud * 16;
>  	port->port.rs485_config = platform->rs485_config;
>  
> -- 
> 2.30.2
> 

Do not mix "fixes with features" in a single series, as I now have to
pick it apart and apply it to different branches by hand :(

Please do different series for the two different things if at all
possible.

thanks,

greg k-h
