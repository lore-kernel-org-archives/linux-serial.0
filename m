From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] of/fdt: fix error checking for earlycon address
Date: Wed, 28 Oct 2015 23:07:38 -0500
Message-ID: <CAL_JsqKGOw-Mk=87Fsw+NsbaKR2TDFoJZE-DeVfyxDPRN45o5g@mail.gmail.com>
References: <1445600840-26749-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445600840-26749-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Frank Rowand <frowand.list@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Oct 23, 2015 at 6:47 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> fdt_translate_address() returns OF_BAD_ADDR on error.  It is defined as
> a u64 value, so the variable "addr" should be defined as u64 as well.
>
> Fixes: fb11ffe74c79 ("of/fdt: add FDT serial scanning for earlycon")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied, thanks.

Rob

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
>                 return -ENODEV;
>
>         while (match->compatible[0]) {
> -               unsigned long addr;
> +               u64 addr;
> +
>                 if (fdt_node_check_compatible(fdt, offset, match->compatible)) {
>                         match++;
>                         continue;
>                 }
>
>                 addr = fdt_translate_address(fdt, offset);
> -               if (!addr)
> +               if (addr == OF_BAD_ADDR)
>                         return -ENXIO;
>
>                 of_setup_earlycon(addr, match->data);
> --
> 1.9.1
>
