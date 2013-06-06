From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 03/13] ARM: dts: fork out common Exynos5 nodes
Date: Thu, 6 Jun 2013 16:44:46 +0530
Message-ID: <CAK9yfHxv7EG_1rtgpOwo3HDN7TdfjnK3wH4bAG=RKQJDeW+hHw@mail.gmail.com>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
	<1370516488-25860-3-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:47499 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932391Ab3FFLOq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Jun 2013 07:14:46 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd20so4427499obb.19
        for <linux-serial@vger.kernel.org>; Thu, 06 Jun 2013 04:14:46 -0700 (PDT)
In-Reply-To: <1370516488-25860-3-git-send-email-chander.kashyap@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, s.nawrocki@samsung.com, thomas.ab@samsung.com

On 6 June 2013 16:31, Chander Kashyap <chander.kashyap@linaro.org> wrote:
> In preparation of adding support for Exynos5420, which has many peripherals
> similar to Exynos5250, a new common Exynos5 device tree source file is
> created out of the existing Exynos5250 device tree source file. Only the
> common nodes required for basic boot up on Exynos5420 based boards are moved
> into this new file and the rest of the common nodes would be moved subsequently.
>
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> ---
>  arch/arm/boot/dts/exynos5.dtsi    |  121 +++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5250.dtsi |   74 +----------------------
>  2 files changed, 122 insertions(+), 73 deletions(-)
>  create mode 100644 arch/arm/boot/dts/exynos5.dtsi
>
> diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
> new file mode 100644
> index 0000000..ab56608
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos5.dtsi
> @@ -0,0 +1,121 @@
> +/*
> + * Samsung's Exynos5 SoC series common device tree source
> + *
> + * Copyright (c) 2012-2013 Samsung Electronics Co., Ltd.
> + *             http://www.samsung.com
> + *
> + * Samsung's Exynos5 SoC series device nodes are listed in this file. Particular
> + * SoCs from Exynos5 series can include this file and provide values for SoCs
> + * specfic bindings.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/include/ "skeleton.dtsi"

Perhaps you could use #include here and rest of the places in this patch?

-- 
With warm regards,
Sachin
