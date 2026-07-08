Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D16B3BBA0E
	for <linux-serial@vger.kernel.org>; Wed,  8 Jul 2026 06:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783491735; cv=pass; b=MLNYdsFqC4qGAsLnzZBoJxuMGZHzF6h4/Ksuht7a/RmwZK9P8zAplHFZyULJG70gnZMsVhwUuRF4dqGWF8ITA9UdVepWFLkggpF4ZHqxVgxFRZvwzxI4Clehob5yPbERt2TehMX4oP8O/fUnw596c8uUU9UaH69YwTyEQ5Z32Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783491735; c=relaxed/simple;
	bh=Q+fJSBCJJKaFA5XtTf5qMvXQ35XMD3uNkGCHwK1jljw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ud77Szo1vHVlxFbhz/HwO1ZwO7TKkB034wHp4iVQ4zYQDmth33zaJI3bJx2f60Nwf0nDim0EivkK8S6fFbQ5pIdMCqXA5VbqLjVwdXspMq2aCXPu4IUpLt5BefJaJaP/KTR1XOkuT7+NfsE3cF7EZVe/ScUxoeD/AAcZ3H4w5Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SOMpkoxX; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SOMpkoxX"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66766d649fdso403581d50.1
        for <linux-serial@vger.kernel.org>; Tue, 07 Jul 2026 23:22:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783491732; cv=none;
        d=google.com; s=arc-20260327;
        b=qWjzOvboDQRICY9pGprWGA2jCU2HIkLeKUBQDTQLJzSIvB8rUiC09mggODZyObvCQn
         gNYCgyFi2DJs95fhoZMGkydvNWPrbgoFhWa+Gqcsw8U3NdBKnWtyjUjNBaZ1Oloayh/7
         YbOGIMoi/kENs9NTPsTak/Y606Yu/J3yAZ59bmc/+klPLDArDeuUNTqT+JMW/Y5wv3As
         txWIfsdgy/zDzKHzNA2sePF/mo1vV2kiYfKgCxzbAvvtLqJAVcwFsUCxiVCZfRi0YWKB
         mIwT3j0CFegbtc6WbziRZeLBtIT7rmjsIKtEqRARaEtwLsrGT+fsLRdgMc0I5TYjaMeb
         wxEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nyXdoI7KZnNpfNaLYiInRne3qbmZfDvP+wR+FbUBMps=;
        fh=PHFzSUX7xWb4peHCj4hWkeghPEHqZ/9+smgG1uEBVGI=;
        b=Ag/9jANER2oh332/mWfemzDPgxg8ge4p3nUWCcK8CzypvRJY5DqVrL6TO8fHIWvRtA
         N4booczYunapVUPnXJnRB0kaLEx5rOKCHlt/QaROF9REaQL/dhAoU+8bgqsJAYRreg9c
         3hN4fIJp6rgMXSVSf/mwFgx5ltwmrdBFvP1cXyZicw8mk9pl1ScaIae755I8RrUM+tW5
         PppDeSKmo/D65Qa3tpKqeWhfzKqdMvNV4eytIzJnCoblSX2ZzIOySI9lGlH6cJYErEtg
         D65ZrIy3/zfGorx0LSFTIBWXn8qFhJVGY55ug8AQdm/P9SNrETFweYHu2inMz9h1nwTe
         VdiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783491732; x=1784096532; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nyXdoI7KZnNpfNaLYiInRne3qbmZfDvP+wR+FbUBMps=;
        b=SOMpkoxXAYU0ha8zZXa3DkE9A+bHOU39O9Ki47900Ryaq5LoxhQ65H6WJKg5Z0B+Fn
         WlUqW3DVU748xZbcVS4TBX7Q8/w7WOV6kmqt60Xjf7vkmJnsmIbQTFIQqDwLDd7w9DsV
         3012VAd3OX7dNpmKfWf57X1BLlcXYtzqbFZUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783491732; x=1784096532;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nyXdoI7KZnNpfNaLYiInRne3qbmZfDvP+wR+FbUBMps=;
        b=naTVoUxYzSwrhmG8NbnAAVwNkUytY4u+bD53315pgZpjOqFYOUktuwL56QMy6cpKRb
         qHsbSpBMNIqvBtX/4oaIawb8FU1WSEkcOECGEax45RMHks7a/34eYeOgyQ68MTQl/lTP
         MySFNOdp7xV6DVx9HxaS/zuKJCBakTk7rax3GZ4T8afKfpKMiLy7suUlOE9ZIPcDrWt3
         RZ/Q6lxaLr2MGMhXnPmVquxjUGg7y26+/3ya5Hnfjj6Esm5L3ANlr9HEI2wBEUxqhY1x
         4RntkBhzHZQWEoVZgK+I+lz6qpbsSoGEXbXMl+lq0EfAgRY5mYeNzF8DU6T0eY3DO9WG
         r5ig==
X-Forwarded-Encrypted: i=1; AHgh+Rpxd/CzwXi9fp/8hi30Mmgkc2Njlf2HbD1gM0+mA9EUs8zc3lNcBHjF8n+rN41XPAlbRK2GkbiIu7plNV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywVknZE50KIWoiuCmYVwVVRs1w7r7mIyAlYn/hALwJJRQ1ERsu
	X2jqHABEudbO1fFj8jXneylP5i9CFKW7TzqF/QqGPfJqTgB/2mZI3xH6TffzkmpmRiW9Nc2unQJ
	J37+T82niYFo3W8dDfLJBm8yXu6KNRFR5EEPQmEpS
X-Gm-Gg: AfdE7cnUJY00KlWGuUw3XAOt6uHArfdebq/uPMAF/v0Lbw91WJPivlN/LHmGo4pLAVH
	MP70RInyLV5oJoHFd4+GXmJSzgH7EkXeEKfKCfhbAk8gwXok174K3VmfhmRcFl55QosXOs2BRwV
	+YYaZhSfdvNJtz/DyrHIu8on4MBPcP8B3DMowS2MG643YrGpjfIsBwMh3o76FECHa0rpqecwE8z
	mHvkBZx4+POEo8n7MfEwh4BUbJlfHSVbMKN3BK6ctEpXlhb31uDTI0I6fSkjgMVA6aLdYToC//J
	S6lY3tcjV7Q/4rFLHydiHd7WKRw=
X-Received: by 2002:a05:690e:4841:b0:666:2480:2b0a with SMTP id
 956f58d0204a3-6679f201176mr697881d50.50.1783491732443; Tue, 07 Jul 2026
 23:22:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701-add-mediatek-genio-520-720-evk-v2-0-19d5da4ef984@collabora.com>
 <20260701-add-mediatek-genio-520-720-evk-v2-3-19d5da4ef984@collabora.com>
In-Reply-To: <20260701-add-mediatek-genio-520-720-evk-v2-3-19d5da4ef984@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 8 Jul 2026 14:22:01 +0800
X-Gm-Features: AVVi8CeA6CFM4kR5Bt4fLtWwaGoE3MK5l8ZS1mrdHaGZI7ndDG_5d5ZiXOKEMvU
Message-ID: <CAGXv+5F9RPzKWTH1heDEUmWgE2k9mnvdj_uLO9MS5aKqN+3cDw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] arm64: dts: mediatek: add Genio 720-EVK board
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Sean Wang <sean.wang@mediatek.com>, kernel@collabora.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 12:36=E2=80=AFAM Louis-Alexis Eyraud
<louisalexis.eyraud@collabora.com> wrote:
>
> Add support for MediaTek MT8189 SoC and its variants, and a devicetree
> for the basic hardware enablement of the Genio 720-EVK board, based on
> MT8391 SoC.
>
> MT8391 SoC is a variant of MT8189 SoC with a difference for the Arm
> Cortex-A78 CPU core maximum frequency (2.6 Ghz for MT8391, 3 Ghz for
> MT8189). MT8391 hardware register maps are identical to MT8189.
>
> The Genio 720-EVK board has following features:
>   - MT8391 SoC
>   - MT6365 PMIC
>   - MT6319 Buck IC
>   - MT6375 Charger IC
>   - 8GB LPDDR5 RAM
>   - 64GB eMMC 5.1
>   - 128GB UFS
>   - 20V DC Jack
>   - USB Type-C Power Adapter
>   - Micro SD card slot
>   - Push Button x 4 (Power, Reset, Download and Home Key)
>   - LED x 3 (System Power, Reset, DC-IN Power)
>   - USB Type-C Connector (USB 3.2) x 2
>   - USB Type-C Connector (USB 2.0) x 1
>   - 3.5mm Earphone Jack x 1 (with Microphone Input)
>   - 3.5mm Line Out Audio Jack x 1
>   - Analog Microphone x 1
>   - Digital Microphone x 2
>   - Gigabit Ethernet with RJ45 connector
>   - DP x 1 (Mode over USB Type-C)
>   - LVDS port x 1
>   - eDP port x 1
>   - UART x2 with serial-to-usb converters and USB Type-C connectors
>   - UART Port x 2 on Pin Header
>   - M.2 Slot x 2
>   - I2C Capacitive Touch Pad
>   - 4-Lane DSI x 1
>   - 4-Data Lane CSI x 2
>   - I2S Pin header
>   - 40-Pin 2.54mm Pin Header x 1
>   - CAN Bus x 1 (RS232 Connector)
>
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile              |   1 +
>  arch/arm64/boot/dts/mediatek/mt8189.dtsi           | 920 +++++++++++++++=
++++++
>  .../boot/dts/mediatek/mt8391-genio-720-evk.dts     |  27 +
>  .../boot/dts/mediatek/mt8391-genio-common.dtsi     | 673 +++++++++++++++
>  4 files changed, 1621 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/=
mediatek/Makefile
> index a86fb313b1a9..5c75ea1ef09a 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -173,6 +173,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8395-genio-1200-ev=
k-ufs.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8390-genio-700-evk.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8390-grinn-genio-700-sbc.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8390-tungsten-smarc.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8391-genio-720-evk.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8395-kontron-3-5-sbc-i1200.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8395-radxa-nio-12l.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8395-radxa-nio-12l-8-hd-panel.dtbo
> diff --git a/arch/arm64/boot/dts/mediatek/mt8189.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8189.dtsi
> new file mode 100644
> index 000000000000..272b1b34c953
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8189.dtsi
> @@ -0,0 +1,920 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + *
> + * Copyright (c) 2025 Collabora Ltd.
> + * Author: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> + */
> +
> +#include <dt-bindings/clock/mediatek,mt8189-clk.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/power/mediatek,mt8189-power.h>
> +#include <dt-bindings/phy/phy.h>
> +
> +/ {

[...]

> +       soc {
> +               compatible =3D "simple-bus";
> +               #address-cells =3D <2>;
> +               #size-cells =3D <2>;
> +               ranges;
> +               dma-ranges =3D <0x0 0x0 0x0 0x0 0x10 0x0>;
> +
> +               performance: performance-controller@108d78 {
> +                       compatible =3D "mediatek,cpufreq-hw";
> +                       reg =3D <0 0x00108d78 0 0x120>, <0 0x00108e98 0 0=
x120>;
> +                       #performance-domain-cells =3D <1>;
> +               };
> +
> +               gic: interrupt-controller@c000000 {
> +                       compatible =3D "arm,gic-v3";
> +                       reg =3D <0 0xc000000 0 0x40000>, /* distributor *=
/
> +                             <0 0xc040000 0 0x200000>; /* redistributor =
*/
> +                       interrupt-parent =3D <&gic>;
> +                       interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       interrupt-controller;
> +                       #interrupt-cells =3D <4>;
> +                       #redistributor-regions =3D <1>;
> +
> +                       ppi-partitions {
> +                               ppi_cluster0: interrupt-partition-0 {
> +                                       affinity =3D <&cpu0 &cpu1 &cpu2 &=
cpu3 &cpu4 &cpu5>;
> +                               };
> +
> +                               ppi_cluster1: interrupt-partition-1 {
> +                                       affinity =3D <&cpu6 &cpu7>;
> +                               };
> +                       };
> +               };
> +
> +               apdma: dma-controller@11300b00 {
> +                       compatible =3D "mediatek,mt8189-uart-dma", "media=
tek,mt6985-uart-dma";
> +                       reg =3D <0 0x11300b00 0 0x80>,
> +                             <0 0x11300b80 0 0x80>,
> +                             <0 0x11300c00 0 0x80>,
> +                             <0 0x11300c80 0 0x80>,
> +                             <0 0x11300d00 0 0x80>,
> +                             <0 0x11300d80 0 0x80>,
> +                             <0 0x11300e00 0 0x80>,
> +                             <0 0x11300e80 0 0x80>;
> +                       interrupts =3D <GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH 0=
>,
> +                                    <GIC_SPI 433 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <GIC_SPI 437 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       clocks =3D <&peri_ao CLK_PERAO_DMA_B>;
> +                       clock-names =3D "apdma";
> +                       dma-requests =3D <8>;
> +                       #dma-cells =3D <1>;
> +               };
> +
> +               auxadc: adc@11019000 {

The .dtsi file's device nodes should be sorted by base address.
This file's device node order is inconsistent.


ChenYu
