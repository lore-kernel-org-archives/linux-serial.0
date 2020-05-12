Return-Path: <SRS0=eb60=62=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F817C54E4A
	for <linux-serial@archiver.kernel.org>; Tue, 12 May 2020 14:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52085206F5
	for <linux-serial@archiver.kernel.org>; Tue, 12 May 2020 14:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgELOJD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 May 2020 10:09:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:41344 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgELOJC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 May 2020 10:09:02 -0400
IronPort-SDR: Xwksx/rEKETJDmeFMvRF3q36i+BTxgZYdj5Tnqhbti7CK/Y9krrctBYuW5G2oZFwWztkNb8Tvd
 C53kdGQXoFgA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 07:09:02 -0700
IronPort-SDR: YTAiltqx0cQMeD/JF+mgLuk9Yr9klWVR59iMYXgLhpfi1OUZqMPr5xz0IOVyyiRCBjnsdnBoh1
 l65wW3Gy96hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,384,1583222400"; 
   d="scan'208";a="262132988"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 12 May 2020 07:08:59 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jYVag-006Daj-Nj; Tue, 12 May 2020 17:09:02 +0300
Date:   Tue, 12 May 2020 17:09:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 4/4] serial: 8250: Support rs485 bus termination GPIO
Message-ID: <20200512140902.GB185537@smile.fi.intel.com>
References: <cover.1589285873.git.lukas@wunner.de>
 <dafe8ecb9897efdbe530667657377ba96c43b8c7.1589285874.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dafe8ecb9897efdbe530667657377ba96c43b8c7.1589285874.git.lukas@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 12, 2020 at 02:40:04PM +0200, Lukas Wunner wrote:
> Commit e8759ad17d41 ("serial: uapi: Add support for bus termination")
> introduced the ability to enable rs485 bus termination from user space.
> So far the feature is only used by a single driver, 8250_exar.c, using a
> hardcoded GPIO pin specific to Siemens IOT2040 products.

Perhaps you need to Cc this to Jan Kiszka.

> Provide for a more generic solution by allowing specification of an
> rs485 bus termination GPIO pin in the device tree:  Amend the serial
> core to retrieve the GPIO from the device tree (or ACPI table) and amend
> the default ->rs485_config() callback for 8250 drivers to change the
> GPIO on request from user space.

Perhaps the followup can be turning 8250_exar to request those GPIOs it
provides (as hogs or regular ones, I don't know).

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
> Changes v1 -> v2:
> * Drop unnecessary devm_gpiod_put(). (Andy)
> * Use GPIOD_OUT_LOW macro for brevity. (Andy)
> * Document the rationale for disabling termination by default.
> * Drop nonsensical read of GPIO after setting its direction to out.
> 
>  drivers/tty/serial/8250/8250_port.c |  4 ++++
>  drivers/tty/serial/serial_core.c    | 16 ++++++++++++++++
>  include/linux/serial_core.h         |  2 ++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index f77bf820b7a3..b5b630d02110 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -681,6 +681,10 @@ int serial8250_em485_config(struct uart_port *port, struct serial_rs485 *rs485)
>  	memset(rs485->padding, 0, sizeof(rs485->padding));
>  	port->rs485 = *rs485;
>  
> +	if (port->rs485_term_gpio)
> +		gpiod_set_value(port->rs485_term_gpio,
> +				rs485->flags & SER_RS485_TERMINATE_BUS);
> +
>  	/*
>  	 * Both serial8250_em485_init() and serial8250_em485_destroy()
>  	 * are idempotent.
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 43b6682877d5..57840cf90388 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3317,6 +3317,7 @@ int uart_get_rs485_mode(struct uart_port *port)
>  	 * to get to a defined state with the following properties:
>  	 */
>  	rs485conf->flags &= ~(SER_RS485_RX_DURING_TX | SER_RS485_ENABLED |
> +			      SER_RS485_TERMINATE_BUS |
>  			      SER_RS485_RTS_AFTER_SEND);
>  	rs485conf->flags |= SER_RS485_RTS_ON_SEND;
>  
> @@ -3331,6 +3332,21 @@ int uart_get_rs485_mode(struct uart_port *port)
>  		rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
>  	}
>  
> +	/*
> +	 * Disabling termination by default is the safe choice:  Else if many
> +	 * bus participants enable it, no communication is possible at all.
> +	 * Works fine for short cables and users may enable for longer cables.
> +	 */
> +	port->rs485_term_gpio = devm_gpiod_get_optional(dev, "rs485-term",
> +							GPIOD_OUT_LOW);
> +	if (IS_ERR(port->rs485_term_gpio)) {
> +		ret = PTR_ERR(port->rs485_term_gpio);
> +		port->rs485_term_gpio = NULL;
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Cannot get rs485-term-gpios\n");
> +		return ret;
> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(uart_get_rs485_mode);
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index b649a2b894e7..9fd550e7946a 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -10,6 +10,7 @@
>  #include <linux/bitops.h>
>  #include <linux/compiler.h>
>  #include <linux/console.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/circ_buf.h>
>  #include <linux/spinlock.h>
> @@ -251,6 +252,7 @@ struct uart_port {
>  	struct attribute_group	*attr_group;		/* port specific attributes */
>  	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
>  	struct serial_rs485     rs485;
> +	struct gpio_desc	*rs485_term_gpio;	/* enable RS485 bus termination */
>  	struct serial_iso7816   iso7816;
>  	void			*private_data;		/* generic platform data pointer */
>  };
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


