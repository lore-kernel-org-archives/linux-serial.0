From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] tty: atmel_serial: include <mach/hardware.h> explicitly
Date: Wed, 27 Nov 2013 10:48:19 +0100
Message-ID: <5295BFE3.5070700@atmel.com>
References: <1385545111-1256-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:46846 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab3K0Js1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Nov 2013 04:48:27 -0500
In-Reply-To: <1385545111-1256-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Andrew Victor <linux@maxim.org.za>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

On 27/11/2013 10:38, Uwe Kleine-K=C3=B6nig :
> When compiled for at91rm9200 (i.e. ARM) the driver needs among others
> the symbol AT91RM9200_BASE_US0 which is defined in
> arch/arm/mach-at91/include/mach/at91rm9200.h. This file is included
> implicitly via several steps. As ARM's <asm/timex.h> will stop includ=
ing
> <mach/hardware.h> later in this series explicitly include
> <mach/hardware.h>
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Uwe, this AT91RM9200_BASE_US0 value is supposed to disappear in 3.14=20
tanks to a patch from Linus W. ([PATCH v4] ARM/serial: at91: switch=20
atmel serial to use gpiolib) (not in linux-next yet).

So I think that this patch is not needed for 3.14.

Bye,

> ---
>
> Notes:
>      Hello,
>
>      I want to send this patch as part of a series dropping <mach/tim=
ex.h>
>      altogether. So please don't take this patch but only give your A=
ck if
>      you're OK with me sending this patch via arm-soc.
>
>      Thanks
>      Uwe
>
>   drivers/tty/serial/atmel_serial.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/a=
tmel_serial.c
> index c7d99af..de51964 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -47,6 +47,7 @@
>
>   #ifdef CONFIG_ARM
>   #include <mach/cpu.h>
> +#include <mach/hardware.h>
>   #include <asm/gpio.h>
>   #endif
>
>


--=20
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
