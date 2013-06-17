From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 10/10] ARM: Exynos: extend soft-reset support for Exynos5420
Date: Mon, 17 Jun 2013 14:21:49 +0200
Message-ID: <3807303.re8cJcYGJh@wuerfel>
References: <1371466836-4111-1-git-send-email-chander.kashyap@linaro.org> <1371466836-4111-11-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:57285 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932693Ab3FQMVM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Jun 2013 08:21:12 -0400
In-Reply-To: <1371466836-4111-11-git-send-email-chander.kashyap@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Chander Kashyap <chander.kashyap@linaro.org>, mark.rutland@arm.com, kgene.kim@samsung.com, linux-serial@vger.kernel.org, t.figa@samsung.com, linux-samsung-soc@vger.kernel.org, thomas.ab@samsung.com, s.nawrocki@samsung.com

On Monday 17 June 2013 16:30:35 Chander Kashyap wrote:
> @@ -330,10 +330,10 @@ void exynos5_restart(char mode, const char *cmd)
>         u32 val;
>         void __iomem *addr;
>  
> -       if (of_machine_is_compatible("samsung,exynos5250")) {
> -               val = 0x1;
> -               addr = EXYNOS_SWRESET;
> -       } else if (of_machine_is_compatible("samsung,exynos5440")) {
> +       val = 0x1;
> +       addr = EXYNOS_SWRESET;
> +
> +       if (of_machine_is_compatible("samsung,exynos5440")) {
>                 u32 status;
>                 np = of_find_compatible_node(NULL, NULL, "samsung,exynos5440-clock");
>  

Please try to avoid adding further uses of hardcoded MMIO addresses.

Can you change that to use the same logic that exynos5440 has?

	Arnd
