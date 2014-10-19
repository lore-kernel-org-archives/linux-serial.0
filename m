From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 1/3] tty: serial: bcm63xx: Allow bcm63xx_uart to be built
 on other platforms
Date: Sun, 19 Oct 2014 11:06:03 -0700
Message-ID: <CAGVrzca5gOs1mCeVokC0NHJCf7P7CL5BLtR8dXiPwpL5nWnU9g@mail.gmail.com>
References: <1413685818-32265-1-git-send-email-cernekee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:64270 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbaJSSGo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 19 Oct 2014 14:06:44 -0400
Received: by mail-ig0-f172.google.com with SMTP id r2so4124177igi.11
        for <linux-serial@vger.kernel.org>; Sun, 19 Oct 2014 11:06:43 -0700 (PDT)
In-Reply-To: <1413685818-32265-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.cz, mbizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux-MIPS <linux-mips@linux-mips.org>, linux-serial@vger.kernel.org

2014-10-18 19:30 GMT-07:00 Kevin Cernekee <cernekee@gmail.com>:
> This device was originally supported on bcm63xx only, but it shows up on
> a wide variety of MIPS and ARM chipsets spanning multiple product lines.
> Now that the driver has eliminated dependencies on bcm63xx-specific
> header files, we can build it on any non-bcm63xx kernel.
>
> Compile-tested on x86, both statically and as a module.  Tested for
> functionality on bcm3384 (a new MIPS platform under active development).
>
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/tty/serial/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 649b784..4a5c0c8 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1283,7 +1283,7 @@ config SERIAL_TIMBERDALE
>  config SERIAL_BCM63XX
>         tristate "bcm63xx serial port support"
>         select SERIAL_CORE
> -       depends on BCM63XX
> +       depends on MIPS || ARM || COMPILE_TEST
>         help
>           If you have a bcm63xx CPU, you can enable its onboard
>           serial port by enabling this options.
> --
> 2.1.1
>



-- 
Florian
