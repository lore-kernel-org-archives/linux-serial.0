From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] of/fdt: fix error checking for earlycon address
Date: Fri, 23 Oct 2015 09:15:22 -0400
Message-ID: <562A32EA.20808@hurleysoftware.com>
References: <1445600840-26749-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445600840-26749-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, linux-serial@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Ley Foon Tan <lftan@altera.com>
List-Id: linux-serial@vger.kernel.org

Hi Masahiro,

On 10/23/2015 07:47 AM, Masahiro Yamada wrote:
> fdt_translate_address() returns OF_BAD_ADDR on error.  It is defined as
> a u64 value, so the variable "addr" should be defined as u64 as well.

Good catch.

I would prefer if fdt_translate_address() returned resource_size_t (which
is the proper type for handling addresses as integers) and that type
was propagated through early_init_dt_scan_chosen_serial => of_setup_earlycon.

Regards,
Peter Hurley


PS - It seems that there is a new user of fdt_translate_address() in the
nios arch:

commit e8bf5bc776edef44777b13b2eb4461d653519bae
Author: Ley Foon Tan <lftan@altera.com>
Date:   Tue Feb 10 23:21:08 2015 +0800

    nios2: add early printk support
    
    Signed-off-by: Ley Foon Tan <lftan@altera.com>

I've copied the author as that should have been an earlycon in the
altera uart driver(s) rather than early_printk. Oh well.


> Fixes: fb11ffe74c79 ("of/fdt: add FDT serial scanning for earlycon")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/of/fdt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 9fc3568..196e449 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -822,14 +822,15 @@ static int __init early_init_dt_scan_chosen_serial(void)
>  		return -ENODEV;
>  
>  	while (match->compatible[0]) {
> -		unsigned long addr;
> +		u64 addr;
> +
>  		if (fdt_node_check_compatible(fdt, offset, match->compatible)) {
>  			match++;
>  			continue;
>  		}
>  
>  		addr = fdt_translate_address(fdt, offset);
> -		if (!addr)
> +		if (addr == OF_BAD_ADDR)
>  			return -ENXIO;
>  
>  		of_setup_earlycon(addr, match->data);
> 
