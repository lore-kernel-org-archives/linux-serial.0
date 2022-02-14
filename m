Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3BDC433EF
	for <linux-serial@archiver.kernel.org>; Mon, 14 Feb 2022 15:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355992AbiBNPx3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Feb 2022 10:53:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355985AbiBNPx3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Feb 2022 10:53:29 -0500
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC74C49261;
        Mon, 14 Feb 2022 07:53:20 -0800 (PST)
Received: from relay1-d.mail.gandi.net (unknown [217.70.183.193])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 7FC07CEE4A;
        Mon, 14 Feb 2022 15:46:31 +0000 (UTC)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F3629240006;
        Mon, 14 Feb 2022 15:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644853586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ywu1zL9TscboOTL+KoPo7dZ6f2fEaqerWdTVr9qxik=;
        b=A4CnLIzQ5f3D5+0+ZyuCP8fGLUGNr3eCLcIRf21jidFewb//SlR/zb7Lyd0/MOE8NLVvVa
        sTDqJpZchwZd8AC4M1eDjlR6E+X1I3Ie61VNE7VW9RZ5MlcWLIVVen8yJ0zQfddAxaWfLK
        iuymkZZEOra8qtl/QUyEza2pc6mlD4S/GXvcQSDlyL2BrswAzLeo5z7S8Tblj26PDs7rkI
        LWtXjgHLPPM10VL5MzpMBm3JZXErjsRlw5JylQQn3HMir4dQNXgjzXd1nd9pVP4W7jxeor
        kw2AG71XY9qOvX9sMqZub7Vgo8zNVBxEz0yWWA/XseLaufRAmKk6r6fkOv/krA==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        Pali =?utf-8?Q?Roh?= =?utf-8?Q?=C3=A1r?= <pali@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>
Subject: Re: [PATCH v8 5/6] arm64: dts: marvell: armada-37xx: add device
 node for UART clock and use it
In-Reply-To: <20220211191238.2142-6-kabel@kernel.org>
References: <20220211191238.2142-1-kabel@kernel.org>
 <20220211191238.2142-6-kabel@kernel.org>
Date:   Mon, 14 Feb 2022 16:46:25 +0100
Message-ID: <87leydjvse.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Marek and Pali,

> From: Pali Roh=C3=A1r <pali@kernel.org>
>
> Define DT node for UART clock "marvell,armada-3700-uart-clock" and use
> this UART clock as a base clock for all UART devices.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
> Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>

Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

However for keeping bisectability we have to ensure that this patch will
be applied after the drivers changes.

Thanks,

Gregory


> ---
> Changes since v7:
> - changed commit message ("This change defines" -> "Define")
> - added Marek's Reviewed-by tag
> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/bo=
ot/dts/marvell/armada-37xx.dtsi
> index 673f4906eef9..4cf6c8aa0ac2 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -132,10 +132,20 @@ avs: avs@11500 {
>  				reg =3D <0x11500 0x40>;
>  			};
>=20=20
> +			uartclk: clock-controller@12010 {
> +				compatible =3D "marvell,armada-3700-uart-clock";
> +				reg =3D <0x12010 0x4>, <0x12210 0x4>;
> +				clocks =3D <&tbg 0>, <&tbg 1>, <&tbg 2>,
> +					 <&tbg 3>, <&xtalclk>;
> +				clock-names =3D "TBG-A-P", "TBG-B-P", "TBG-A-S",
> +					      "TBG-B-S", "xtal";
> +				#clock-cells =3D <1>;
> +			};
> +
>  			uart0: serial@12000 {
>  				compatible =3D "marvell,armada-3700-uart";
>  				reg =3D <0x12000 0x18>;
> -				clocks =3D <&xtalclk>;
> +				clocks =3D <&uartclk 0>;
>  				interrupts =3D
>  				<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
>  				<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> @@ -147,7 +157,7 @@ uart0: serial@12000 {
>  			uart1: serial@12200 {
>  				compatible =3D "marvell,armada-3700-uart-ext";
>  				reg =3D <0x12200 0x30>;
> -				clocks =3D <&xtalclk>;
> +				clocks =3D <&uartclk 1>;
>  				interrupts =3D
>  				<GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
>  				<GIC_SPI 31 IRQ_TYPE_EDGE_RISING>;
> --=20
> 2.34.1
>

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
