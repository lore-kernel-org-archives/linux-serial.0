Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057976;
	b=lmtHxefxfZ7AfrHkFbnEHZNiNmntauj4+EWKCmC3+dzHwJDUlW2DgRARkJEP+yZ3lx6z
	 tr41++vxrLm7oICtbLdZMTUkS3RW7CZrH6s5y+ixQEtXIsxgY6YoHLGGg3ytBwWF4pNWb
	 vJK10klO5X/PvOgAYeSOQVOrSv4gsiAaroAQ63suhbDM8WjnH4hvrxzqOdwJMUvjGZFiw
	 KSYHckSnQXgUo76SlWwzSdGwK3uS/VX/g+mYFgbtSDJfEKZkUHzJ5/sde4dIO7TR/lHZW
	 K4jncOqgdSNTq7wAyLWtdgg/fCqNkWIhuDQ1Q9YvElkvYjbmiC3MYTmxWAjFQCiVB8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057976;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=w/RdA1rSr8ljWy2SisaHpv0mqfzAzdPn/dHrxjJoI+Y=;
	b=WLC7FinCvBQMCoMKDRRBTkY+4XtvTE/uHKSGCawMu8v1ffqWoXje2z+8R24AVr/Rsztv
	 dXLwovoT9duyadJ8RqCSM3Vw2O0nKhQ3J0zEmV1c8znR8Rby3rzkGIIyWA8eKZ9KS/2eA
	 5AWgX2k9REBUkm8ncdR53j8cBzYWRB1DokzxgpOC6p68c7DjMTawpjY52GLb3O7H8DHym
	 IGrUlKm3FLZwf58CTqR6+DThPESjIGG4bZrC0U8S3sgrFNxlNiW4O+uDfh2mLH7wtUY5h
	 JVVnbtwLAt1GH3ovuEDvrtzy/CadhKJGni3SvgjVwc9/wLsRLt8k/VurUF8nR4WeiIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=Y8DWwUWc;
	arc=none smtp.remote-ip=79.135.106.120
Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch [79.135.106.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A438606A32C;
	Sat,  7 Nov 2026 13:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A438606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=Y8DWwUWc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1794057971; x=1794317171;
	bh=w/RdA1rSr8ljWy2SisaHpv0mqfzAzdPn/dHrxjJoI+Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Y8DWwUWcLzDJA8th58OdrPyldokIroba+TMQbsU+lBbtDrJUW6ma7TwLMuowqApf/
	 VbZzOCMUlrXMUfPj6J0GSFsvL1FdGqCb4Fk10PqRCwiD7fFg/nDIsrm8GyVFuo4J8Z
	 UoHIPEXQmDVs8nGfBJb2n199QvySGdjtVyltJsdh2OZ7kMwT/GZkI9Au87pWTpNNw3
	 q6VACuNR/ZsfrmTjVcu7MzibDwOHry3dU6y6jhz/I7vC+froYTfiS/plvLNFG8ws27
	 z+vPlsFLARkI8I5yVjlQchb9rA4H2VrubN2iNseU/2i4PH3icxiixHdnuobq9sjzDV
	 eyB6OLdNjo+nQ==
Date: Sat, 07 Nov 2026 13:26:04 +0000
To: i@udp0.com
From: Roman Vivchar <rva333@protonmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@mediatek.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-watchdog@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: mediatek: Add MT6833 and the Xiaomi Redmi Note 13 5G
Message-ID: <FmgvoyT_AgANJAPnjEgEdlKRY0s2nXWF2Wm88KAM2KNKgiWpC0VzBcAukgMmYb_8H67s9wIRvgqcDgWO79Yc-PjdNoBiUS1KejZMWptvLhM=@protonmail.com>
In-Reply-To: <20261107-mt6833-base-v1-4-bda21083e9f3@udp0.com>
References: <20261107-mt6833-base-v1-0-bda21083e9f3@udp0.com> <20261107-mt6833-base-v1-4-bda21083e9f3@udp0.com>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: 6c6b17e26323889f84a277a4c51ad887a1e9c5d0
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Saturday, November 7th, 2026 at 2:22 PM, Rui Cao via B4 Relay <devnull+i=
.udp0.com@kernel.org> wrote:

> From: Rui Cao <i@udp0.com>
>=20
> Add a device tree for MediaTek's MT6833 (Dimensity 700): its eight
> cores, six Cortex-A55 and two Cortex-A76 in one DynamIQ cluster, with
> their caches and PMUs, PSCI, the architected timer, the GICv3, the
> watchdog and the first UART.
>=20
> Add the Xiaomi Redmi Note 13 5G (gold) on it, with its memory, the
> regions its bootloader reserves for the firmware it starts, and the
> framebuffer the bootloader leaves the panel scanning out.
>=20
> The cache sizes are the ones the cores report in CCSIDR_EL1. The
> bootloader programs CNTFRQ_EL0 (13 MHz), so the timer has no
> clock-frequency.
>=20
> Signed-off-by: Rui Cao <i@udp0.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile              |   1 +
>  .../arm64/boot/dts/mediatek/mt6833-xiaomi-gold.dts | 205 +++++++++++++
>  arch/arm64/boot/dts/mediatek/mt6833.dtsi           | 341 +++++++++++++++=
++++++
>  3 files changed, 547 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/=
mediatek/Makefile
> index a86fb313b1a..b8466d4a3d6 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -6,6 +6,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6795-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6795-sony-xperia-m5.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6797-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6797-x20-dev.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6833-xiaomi-gold.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7622-rfb1.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7622-bananapi-bpi-r64.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7981b-cudy-wr3000-v1.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt6833-xiaomi-gold.dts b/arch/a=
rm64/boot/dts/mediatek/mt6833-xiaomi-gold.dts
> new file mode 100644
> index 00000000000..6bdcf407fb6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6833-xiaomi-gold.dts
> @@ -0,0 +1,205 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> +/*
> + * Xiaomi Redmi Note 13 5G (gold)
> + *
> + * Copyright (C) 2026 Rui Cao <i@udp0.com>
> + */
> +
> +/dts-v1/;
> +#include "mt6833.dtsi"
> +
> +/ {
> +=09model =3D "Xiaomi Redmi Note 13 5G";
> +=09compatible =3D "xiaomi,gold", "mediatek,mt6833";
> +=09chassis-type =3D "handset";
> +
> +=09chosen {
> +=09=09#address-cells =3D <2>;
> +=09=09#size-cells =3D <2>;
> +=09=09ranges;
> +
> +=09=09/* The bootloader leaves the panel lit, scanning out this buffer *=
/
> +=09=09framebuffer@73c10000 {
> +=09=09=09compatible =3D "simple-framebuffer";
> +=09=09=09reg =3D <0 0x73c10000 0 (4352 * 2400)>;
> +=09=09=09width =3D <1080>;
> +=09=09=09height =3D <2400>;
> +=09=09=09stride =3D <4352>;
> +=09=09=09format =3D "a8r8g8b8";
> +=09=09};
> +=09};
> +
> +=09memory@40000000 {
> +=09=09device_type =3D "memory";
> +=09=09reg =3D <0 0x40000000 1 0x80000000>;
> +=09};
> +
> +=09/*
> +=09 * The regions the bootloader reserves for the firmware it starts (AT=
F,
> +=09 * TEE, GenieZone, the SSPM, MCUPM and SCP coprocessors, the modem) a=
nd
> +=09 * for itself, as it reports them.
> +=09 */

Shouldn't the boot shim populate /memory and the dynamic /reserved-memory
nodes from the vendor FDT instead of hardcoding them here? There are
multiple phone variants, which may have different reserved memory addresses=
.

> +=09reserved-memory {
> +=09=09#address-cells =3D <2>;
> +=09=09#size-cells =3D <2>;
> +=09=09ranges;
> +
> +=09=09aee-debug-kinfo@48080000 {
> +=09=09=09reg =3D <0 0x48080000 0 0x10000>;
> +=09=09=09no-map;
> +=09=09};

...

> diff --git a/arch/arm64/boot/dts/mediatek/mt6833.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt6833.dtsi
> new file mode 100644
> index 00000000000..4c5f1381ca6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6833.dtsi

...

> +=09=09watchdog: watchdog@10007000 {
> +=09=09=09compatible =3D "mediatek,mt6833-wdt", "mediatek,mt6589-wdt";
> +=09=09=09reg =3D <0 0x10007000 0 0x100>;
> +=09=09};
> +

No interrupts?

Best regards,
Roman
