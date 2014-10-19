From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 2/3] tty: serial: bcm63xx: Update the Kconfig help text
Date: Sun, 19 Oct 2014 11:06:32 -0700
Message-ID: <CAGVrzcYA8FWUTuDg1uksiOwMcJHwUcscbhEDkiv9PE02p9E1sw@mail.gmail.com>
References: <1413685818-32265-1-git-send-email-cernekee@gmail.com> <1413685818-32265-2-git-send-email-cernekee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:56950 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbaJSSHO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 19 Oct 2014 14:07:14 -0400
Received: by mail-ie0-f181.google.com with SMTP id at20so3426001iec.40
        for <linux-serial@vger.kernel.org>; Sun, 19 Oct 2014 11:07:13 -0700 (PDT)
In-Reply-To: <1413685818-32265-2-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.cz, mbizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux-MIPS <linux-mips@linux-mips.org>, linux-serial@vger.kernel.org

2014-10-18 19:30 GMT-07:00 Kevin Cernekee <cernekee@gmail.com>:
> Remove incorrect "bcm963xx_uart" module name; add a list of known users;
> tweak grammar/indentation/capitalization.
>
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/tty/serial/Kconfig | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 4a5c0c8..815b652 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1281,22 +1281,24 @@ config SERIAL_TIMBERDALE
>         Add support for UART controller on timberdale.
>
>  config SERIAL_BCM63XX
> -       tristate "bcm63xx serial port support"
> +       tristate "Broadcom BCM63xx/BCM33xx UART support"
>         select SERIAL_CORE
>         depends on MIPS || ARM || COMPILE_TEST
>         help
> -         If you have a bcm63xx CPU, you can enable its onboard
> -         serial port by enabling this options.
> +         This enables the driver for the onchip UART core found on
> +         the following chipsets:
>
> -          To compile this driver as a module, choose M here: the
> -          module will be called bcm963xx_uart.
> +           BCM33xx (cable modem)
> +           BCM63xx/BCM63xxx (DSL)
> +           BCM68xx (PON)
> +           BCM7xxx (STB) - DOCSIS console
>
>  config SERIAL_BCM63XX_CONSOLE
> -       bool "Console on bcm63xx serial port"
> +       bool "Console on BCM63xx serial port"
>         depends on SERIAL_BCM63XX=y
>         select SERIAL_CORE_CONSOLE
>         help
> -         If you have enabled the serial port on the bcm63xx CPU
> +         If you have enabled the serial port on the BCM63xx CPU
>           you can make it the console by answering Y to this option.
>
>  config SERIAL_GRLIB_GAISLER_APBUART
> --
> 2.1.1
>



-- 
Florian
