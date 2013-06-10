From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 13/13] ARM: Exynos: extend soft-reset support for Exynos5420
Date: Mon, 10 Jun 2013 17:54:59 +0900
Message-ID: <0ea501ce65b8$3046d7a0$90d486e0$%kim@samsung.com>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
 <1370516488-25860-13-git-send-email-chander.kashyap@linaro.org>
 <51B07631.2010802@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:10961 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388Ab3FJIzB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Jun 2013 04:55:01 -0400
In-reply-to: <51B07631.2010802@linaro.org>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Tushar Behera' <tushar.behera@linaro.org>, 'Chander Kashyap' <chander.kashyap@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, t.figa@samsung.com, s.nawrocki@samsung.com, thomas.ab@samsung.com

Tushar Behera wrote:
> 
> On 06/06/2013 04:31 PM, Chander Kashyap wrote:
> > Extend the soft reset support for Exynos5420 SoC.
> >
> > Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> > ---
> >  arch/arm/mach-exynos/common.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
> > index fbe1aa7..dc7c134 100644
> > --- a/arch/arm/mach-exynos/common.c
> > +++ b/arch/arm/mach-exynos/common.c
> > @@ -321,7 +321,8 @@ void exynos5_restart(char mode, const char *cmd)
> >  	u32 val;
> >  	void __iomem *addr;
> >
> > -	if (of_machine_is_compatible("samsung,exynos5250")) {
> > +	if (of_machine_is_compatible("samsung,exynos5250") ||
> > +		(of_machine_is_compatible("samsung,exynos5420"))) {
> >  		val = 0x1;
> >  		addr = EXYNOS_SWRESET;
> >  	} else if (of_machine_is_compatible("samsung,exynos5440")) {
> >
> 
> How about making 0x1 and EXYNOS_SWRESET as default values of val and
> addr. That way we can remove this check for exynos5250 and exynos5420.
> Also we can remove the trailing else statement as there are no non-DT
> boards for EXYNOS5.
> 
>  void exynos5_restart(char mode, const char *cmd)
>  {
>         struct device_node *np;
> -       u32 val;
> -       void __iomem *addr;
> +       u32 val = 0x1;
> +       void __iomem *addr = EXYNOS_SWRESET;
> 
> -       if (of_machine_is_compatible("samsung,exynos5250")) {
> -               val = 0x1;
> -               addr = EXYNOS_SWRESET;
> -       } else if (of_machine_is_compatible("samsung,exynos5440")) {
> +       if (of_machine_is_compatible("samsung,exynos5440")) {
>                 u32 status;
>                 np = of_find_compatible_node(NULL, NULL,
> "samsung,exynos5440-clock");
> 
> @@ -336,9 +333,6 @@ void exynos5_restart(char mode, const char *cmd)
>                 val = __raw_readl(addr);
> 
>                 val = (val & 0xffff0000) | (status & 0xffff);
> -       } else {
> -               pr_err("%s: cannot support non-DT\n", __func__);
> -               return;
>         }
> 
> --

Yeah, looks better.

- Kukjin

