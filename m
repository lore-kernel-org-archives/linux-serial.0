From: "Jongsung Kim" <neidhard.kim@lge.com>
Subject: RE: [PATCH] ARM: bcm2835: override the HW UART periphid
Date: Tue, 21 May 2013 15:07:34 +0900
Message-ID: <008d01ce55e9$7c479510$74d6bf30$@lge.com>
References: <519AD82A.6090809@wwwdotorg.org> <1369116149-2361-1-git-send-email-neidhard.kim@lge.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:50572 "EHLO
	LGEMRELSE6Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979Ab3EUGHg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 May 2013 02:07:36 -0400
In-Reply-To: <1369116149-2361-1-git-send-email-neidhard.kim@lge.com>
Content-Language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: swarren@wwwdotorg.org, linux@arm.linux.org.uk, gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: linux-serial@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Jongsung Kim <neidhard.kim@lge.com> :
> diff --git a/arch/arm/boot/dts/bcm2835.dtsi
b/arch/arm/boot/dts/bcm2835.dtsi
> index f0052dc..1e12aef 100644
> --- a/arch/arm/boot/dts/bcm2835.dtsi
> +++ b/arch/arm/boot/dts/bcm2835.dtsi
> @@ -44,6 +44,7 @@
>  			reg = <0x7e201000 0x1000>;
>  			interrupts = <2 25>;
>  			clock-frequency = <3000000>;
> +			arm,primecell-periphid = <0x00241011>;
>  		};
>  
>  		gpio: gpio {

Stephen, how do you think about this kind of approach instead?

