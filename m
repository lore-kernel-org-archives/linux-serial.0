From: Beniamino Galvani <b.galvani@gmail.com>
Subject: Re: [PATCH 5/7] ARM: meson: dts: add basic
 Meson/Meson6/Meson6-atv1200 DTSI/DTS
Date: Sun, 17 Aug 2014 16:42:01 +0200
Message-ID: <20140817144201.GB29963@gmail.com>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
 <1408272594-10814-6-git-send-email-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:58366 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbaHQOmT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 17 Aug 2014 10:42:19 -0400
Content-Disposition: inline
In-Reply-To: <1408272594-10814-6-git-send-email-carlo@caione.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Carlo Caione <carlo@caione.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux@arm.linux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, daniel.lezcano@linaro.org, tglx@linutronix.de, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org

Hi,

On Sun, Aug 17, 2014 at 12:49:52PM +0200, Carlo Caione wrote:
> The Meson6 SoC is produced by Amlogic inc. and it is based on 2 Cortex A9
> and an ARM Mali-400 GPU.
> This patch adds two basic DTSI for the preliminary support of Meson and
> Meson6 SoCs. Another DTS is also added for supporting the atv1200 board,
> produced by Geniatech inc.
> index 0000000..d62add4
(...)
> --- /dev/null
> +++ b/arch/arm/boot/dts/meson6.dtsi
> @@ -0,0 +1,44 @@
> +/*
> + * Copyright 2014 Carlo Caione <carlo@caione.org>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + */
> +
> +/include/ "meson.dtsi"
> +
> +/ {
> +	model = "Amlogic Meson6 SoC";
> +	compatible = "amlogic,meson6", "amlogic,8726_mx";
> +
> +	interrupt-parent = <&gic>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {

The address after the @ should match the value of the 'reg' property.

> +			device_type = "cpu";
> +			compatible = "arm,cortex-a9";
> +			reg = <0x200>;
> +		};
> +
> +		cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a9";
> +			reg = <0x1>;

According to Documentation/devicetree/bindings/arm/cpus.txt, this
should be set to bits [23:0] of the CPU MPIDR register, in this case
0x201.

Beniamino

> +		};
> +	};
> +
> +	clocks {
> +		#address-cells = <1>;
> +
> +		clk81: clk@0 {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <200000000>;
> +		};
> +	};
> +}; /* end of / */
> -- 
> 1.9.1
> 
