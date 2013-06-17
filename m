From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 07/10] ARM: dts: Add initial device tree support for
 Exynos5420
Date: Mon, 17 Jun 2013 09:46:48 +0100
Message-ID: <20130617084648.GA6809@e106331-lin.cambridge.arm.com>
References: <1370516488-25860-10-git-send-email-chander.kashyap@linaro.org>
 <1371218572-8993-1-git-send-email-chander.kashyap@linaro.org>
 <1371218572-8993-8-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:35395 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756074Ab3FQIrW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Jun 2013 04:47:22 -0400
Content-Disposition: inline
In-Reply-To: <1371218572-8993-8-git-send-email-chander.kashyap@linaro.org>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "t.figa@samsung.com" <t.figa@samsung.com>, "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>

Hi,

> diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> new file mode 100644
> index 0000000..43f0eb8
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> @@ -0,0 +1,40 @@
> +/*
> + * SAMSUNG SMDK5420 board device tree source
> + *
> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +/dts-v1/;
> +#include "exynos5420.dtsi"
> +
> +/ {
> +	model = "Samsung SMDK5420 board based on EXYNOS5420";
> +	compatible = "samsung,smdk5420", "samsung,exynos5420";
> +
> +	memory {
> +		reg =	<0x20000000 0x10000000
> +			 0x30000000 0x10000000
> +			 0x40000000 0x10000000
> +			 0x50000000 0x10000000
> +			 0x60000000 0x10000000
> +			 0x70000000 0x10000000
> +			 0x80000000 0x10000000
> +			 0x90000000 0x10000000>;
> +	};

As splitting these into 256MB banks is a workaround for an implementation
issue, there should at least be a comment to that effect.

It would be far nicer if this were described as one bank and the kernel could
split it up as necessary when using sparsemem.

Thanks,
Mark.
