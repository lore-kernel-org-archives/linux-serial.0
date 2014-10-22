From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V3 09/10] tty: serial: of-serial: Allow OF earlycon to
 default to "on"
Date: Wed, 22 Oct 2014 17:27:49 +0800
Message-ID: <CAL_Jsq+AuqTOU7UFdYi28YGjL1QorY=3zOSccN43Vb1a=q6SHw@mail.gmail.com>
References: <1413930186-23168-1-git-send-email-cernekee@gmail.com> <1413930186-23168-10-git-send-email-cernekee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:55369 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932361AbaJVJ2L (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 Oct 2014 05:28:11 -0400
In-Reply-To: <1413930186-23168-10-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Florian Fainelli <f.fainelli@gmail.com>, mbizon@freebox.fr, Jonas Gorski <jogo@openwrt.org>, Linux-MIPS <linux-mips@linux-mips.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Wed, Oct 22, 2014 at 6:23 AM, Kevin Cernekee <cernekee@gmail.com> wrote:
> On many development systems it is very common to see failures during the
> early stages of the boot process, e.g. SMP boot or PCIe initialization.
> This is one likely reason why some existing earlyprintk implementations,
> such as arch/mips/kernel/early_printk.c, are enabled unconditionally
> at compile time.
>
> Now that earlycon's operating parameters can be passed into the kernel
> via DT, it is helpful to be able to configure the kernel to turn it on
> automatically.  Introduce a new CONFIG_SERIAL_EARLYCON_FORCE option for
> this purpose.

You can already force this using the CMDLINE_EXTEND option. I'm not
sure we need more options.

>
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  drivers/of/fdt.c           |  5 +++++
>  drivers/tty/serial/Kconfig | 11 +++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 20193cc..3e2ea1e 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1013,6 +1013,11 @@ bool __init early_init_dt_verify(void *params)
>
>  void __init early_init_dt_scan_nodes(void)
>  {
> +#ifdef CONFIG_SERIAL_EARLYCON_FORCE
> +       if (early_init_dt_scan_chosen_serial() < 0)
> +               pr_warn("Unable to set up earlycon from stdout-path\n");
> +#endif

Doesn't this make the earlycon get scanned and setup twice? Hopefully
that is safe...

This also introduces the scanning at another point in time during boot
which may not work depending on the arch.

Rob

> +
>         /* Retrieve various information from the /chosen node */
>         of_scan_flat_dt(early_init_dt_scan_chosen, boot_command_line);
>
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index fdd851e..bc4ebcc 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -14,6 +14,17 @@ config SERIAL_EARLYCON
>           the console before standard serial driver is probed. The console is
>           enabled when early_param is processed.
>
> +config SERIAL_EARLYCON_FORCE
> +       bool "Always enable early console"
> +       depends on SERIAL_EARLYCON
> +       help
> +         Traditionally, enabling the early console has required passing in
> +         the "earlycon" parameter on the kernel command line.  On systems
> +         under development it may be desirable to enable earlycon
> +         unconditionally rather than to force the user to manually add it
> +         to the boot argument string, as boot failures often occur before
> +         the standard serial driver is probed.
> +
>  source "drivers/tty/serial/8250/Kconfig"
>
>  comment "Non-8250 serial port support"
> --
> 2.1.1
>
