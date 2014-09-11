From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 8/9] ARM: meson: dts: add basic Meson/Meson6/Meson6-atv1200 DTSI/DTS
Date: Thu, 11 Sep 2014 23:03:36 +0200
Message-ID: <3167715.dUiYojznL5@wuerfel>
References: <1410466300-19168-1-git-send-email-carlo@caione.org> <1410466300-19168-9-git-send-email-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:52075 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729AbaIKVE1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Sep 2014 17:04:27 -0400
In-Reply-To: <1410466300-19168-9-git-send-email-carlo@caione.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux@arm.linux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, daniel.lezcano@linaro.org, tglx@linutronix.de, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, b.galvani@gmail.com, maxime.ripard@free-electrons.com, afaerber@suse.de, matthias.bgg@gmail.com

On Thursday 11 September 2014 22:11:39 Carlo Caione wrote:
> diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
> new file mode 100644
> index 0000000..ace5db8
> --- /dev/null
> +++ b/arch/arm/boot/dts/meson.dtsi
> @@ -0,0 +1,74 @@
> +/*
> + * Copyright 2014 Carlo Caione <carlo@caione.org>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + */

We recently had a discussion about licensing of dts files. Please make
these dual-licensed GPL+BSD or similar, so they can be included in
other operating systems as well.

> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +
> +	aliases {
> +		serial0 = &uart_AO;
> +		serial1 = &uart_A;
> +		serial2 = &uart_B;
> +		serial3 = &uart_C;
> +	};

I think it would be best to move these aliases into the per-board
file and only list the present ones.

	Arnd
