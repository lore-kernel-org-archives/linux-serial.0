Return-Path: <SRS0=CtGi=5G=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74DDC4332B
	for <linux-serial@archiver.kernel.org>; Sat, 21 Mar 2020 11:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D56820776
	for <linux-serial@archiver.kernel.org>; Sat, 21 Mar 2020 11:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgCULVg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 21 Mar 2020 07:21:36 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:42252 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgCULVf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 21 Mar 2020 07:21:35 -0400
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Mar 2020 07:21:35 EDT
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 9E2B015605; Sat, 21 Mar 2020 11:11:41 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 07/10] ARM: dts: tango4: Make /serial compatible with ns16550a
References: <20200320174107.29406-1-lkundrak@v3.sk>
        <20200320174107.29406-8-lkundrak@v3.sk>
Date:   Sat, 21 Mar 2020 11:11:41 +0000
In-Reply-To: <20200320174107.29406-8-lkundrak@v3.sk> (Lubomir Rintel's message
        of "Fri, 20 Mar 2020 18:41:04 +0100")
Message-ID: <yw1xd096hsia.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Lubomir Rintel <lkundrak@v3.sk> writes:

> ralink,rt2880-uart is compatible with ns16550a and all other
> instances of RT2880 UART nodes include it in the compatible property.
> Add it also here, to make the binding schema simpler.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Mans Rullgard <mans@mansr.com>

> ---
>  arch/arm/boot/dts/tango4-common.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/tango4-common.dtsi b/arch/arm/boot/dts/tango4-common.dtsi
> index ff72a8efb73d0..54fd522badfc9 100644
> --- a/arch/arm/boot/dts/tango4-common.dtsi
> +++ b/arch/arm/boot/dts/tango4-common.dtsi
> @@ -85,7 +85,7 @@ tick-counter@10048 {
>  		};
>
>  		uart: serial@10700 {
> -			compatible = "ralink,rt2880-uart";
> +			compatible = "ralink,rt2880-uart", "ns16550a";
>  			reg = <0x10700 0x30>;
>  			interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-frequency = <7372800>;
> -- 
> 2.25.1
>

-- 
Måns Rullgård
