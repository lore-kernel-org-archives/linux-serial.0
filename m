From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH 1/2] of: Fix crash if an earlycon driver is not found
Date: Wed, 12 Nov 2014 17:11:10 +0000
Message-ID: <20141112171110.49BE5C41C69@trevor.secretlab.ca>
References: <1415523348-4631-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:51564 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404AbaKLVUr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 16:20:47 -0500
Received: by mail-wi0-f181.google.com with SMTP id n3so6282161wiv.2
        for <linux-serial@vger.kernel.org>; Wed, 12 Nov 2014 13:20:46 -0800 (PST)
In-Reply-To: <1415523348-4631-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>, gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc: f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, stable@vger.kernel.org

On Sun,  9 Nov 2014 00:55:47 -0800
, Kevin Cernekee <cernekee@gmail.com>
 wrote:
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

Applied, thanks. Although a more robust fix would probably to be
checking for the end address of the section. This is a safe fix though,
so I'm picking it up.

g.

> ---
>  drivers/of/fdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index d1ffca8..30e97bc 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -773,7 +773,7 @@ int __init early_init_dt_scan_chosen_serial(void)
>  	if (offset < 0)
>  		return -ENODEV;
>  
> -	while (match->compatible) {
> +	while (match->compatible[0]) {
>  		unsigned long addr;
>  		if (fdt_node_check_compatible(fdt, offset, match->compatible)) {
>  			match++;
> -- 
> 2.1.1
> 

