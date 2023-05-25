Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53D0C77B7A
	for <linux-serial@archiver.kernel.org>; Thu, 25 May 2023 11:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbjEYLUB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 May 2023 07:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240799AbjEYLUA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 May 2023 07:20:00 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380B813A
        for <linux-serial@vger.kernel.org>; Thu, 25 May 2023 04:19:55 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 1186f88a-faee-11ed-abf4-005056bdd08f;
        Thu, 25 May 2023 14:19:52 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Thu, 25 May 2023 14:19:52 +0300
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 08/11] serial: sc16is7xx: fix regression with GPIO
 configuration
Message-ID: <ZG9EWEwb077qyBIi@surfacebook>
References: <20230525040324.3773741-1-hugo@hugovil.com>
 <20230525040324.3773741-9-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525040324.3773741-9-hugo@hugovil.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Thu, May 25, 2023 at 12:03:22AM -0400, Hugo Villeneuve kirjoitti:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
> and commit 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> changed the function of the GPIOs pins to act as modem control
> lines without any possibility of selecting GPIO function.
> 
> As a consequence, applications that depends on GPIO lines configured
> by default as GPIO pins no longer work as expected.
> 
> Also, the change to select modem control lines function was done only
> for channel A of dual UART variants (752/762). This was not documented
> in the log message.

> This new patch allows to specify GPIO or modem control line function
> in the device tree, and for each of the ports (A or B).

Imperative mood as stated in documentation, please.
Like "Allow to specify...".

> This is done by using the new device-tree property named
> "modem-control-line-ports" (property added in separate patch).
> 
> We also now reduce the number of exported GPIOs according to the
> modem-status-line-port DT property.
> 
> Boards that need to have GPIOS configured as modem control lines
> should add that property to their device tree. Here is a list of
> boards using the sc16is7xx driver in their device tree and that may
> need to be modified:
>     arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
>     mips/boot/dts/ingenic/cu1830-neo.dts
>     mips/boot/dts/ingenic/cu1000-neo.dts

...

> +#ifdef CONFIG_GPIOLIB

I'm wondering if we can avoid adding new ifdefferies...

> +	s->gpio_configured = devtype->nr_gpio;

The name of the variable is a bit vague WRT its content.
Shouldn't be as simple as the rvalue, i.e. s->nr_gpio?

> +#endif /* CONFIG_GPIOLIB */

...

> +		of_property_for_each_u32(dev->of_node, "nxp,modem-control-line-ports",
> +					 prop, p, u)

The driver so far is agnostic to property provider. Please keep it that way,
i.e. no of_ APIs.

> +			if (u < devtype->nr_uart) {

Hmm... What other can it be?

> +				/* Use GPIO lines as modem control lines */
> +				if (u == 0)
> +					val |= SC16IS7XX_IOCONTROL_MODEM_A_BIT;
> +				else if (u == 1)
> +					val |= SC16IS7XX_IOCONTROL_MODEM_B_BIT;
> +
> +#ifdef CONFIG_GPIOLIB
> +				if (s->gpio_configured >=
> +				    SC16IS7XX_GPIOS_PER_BANK)

On one line it will be better to read. Esp. taking into account the above remark.

> +					s->gpio_configured -=
> +						SC16IS7XX_GPIOS_PER_BANK;

Ditto.

> +#endif /* CONFIG_GPIOLIB */
> +			}

-- 
With Best Regards,
Andy Shevchenko


