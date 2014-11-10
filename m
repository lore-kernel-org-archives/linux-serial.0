From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] of: Fix crash if an earlycon driver is not found
Date: Mon, 10 Nov 2014 08:14:01 -0600
Message-ID: <CAL_Jsq+iVfFGYEF575spQ5MaYPzo1QSfLUZP1M=TpH0+HdGS6A@mail.gmail.com>
References: <1415523348-4631-1-git-send-email-cernekee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:34035 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbaKJOOX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Nov 2014 09:14:23 -0500
In-Reply-To: <1415523348-4631-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Grant Likely <grant.likely@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Maxime Bizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux-MIPS <linux-mips@linux-mips.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, stable@vger.kernel.org

On Sun, Nov 9, 2014 at 2:55 AM, Kevin Cernekee <cernekee@gmail.com> wrote:
> __earlycon_of_table_sentinel.compatible is a char[128], not a pointer, so
> it will never be NULL.  Checking it against NULL causes the match loop to
> run past the end of the array, and eventually match a bogus entry, under
> the following conditions:
>
>  - Kernel command line specifies "earlycon" with no parameters
>  - DT has a stdout-path pointing to a UART node
>  - The UART driver doesn't use OF_EARLYCON_DECLARE (or maybe the console
>    driver is compiled out)
>
> Fix this by checking to see if match->compatible is a non-empty string.
>
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> Cc: <stable@vger.kernel.org> # 3.16+

Thanks. I'll queue this up.

BTW, you should not add stable CC when submitting for review, but
rather add a note for the maintainer to apply to stable. Only if a
commit is in mainline already and not flagged for stable, then you
send the patch with the stable tag to get the commit added to stable.
It's a bit confusing...

Rob

> ---
>  drivers/of/fdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index d1ffca8..30e97bc 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -773,7 +773,7 @@ int __init early_init_dt_scan_chosen_serial(void)
>         if (offset < 0)
>                 return -ENODEV;
>
> -       while (match->compatible) {
> +       while (match->compatible[0]) {
>                 unsigned long addr;
>                 if (fdt_node_check_compatible(fdt, offset, match->compatible)) {
>                         match++;
> --
> 2.1.1
>
