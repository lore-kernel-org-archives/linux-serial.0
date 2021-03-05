Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE697C433DB
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 11:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A7C765021
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 11:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhCELDz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 5 Mar 2021 06:03:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51168 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhCELDX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 5 Mar 2021 06:03:23 -0500
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lI8Er-0001eJ-Ts
        for linux-serial@vger.kernel.org; Fri, 05 Mar 2021 11:03:22 +0000
Received: by mail-wm1-f70.google.com with SMTP id u15so630048wmj.2
        for <linux-serial@vger.kernel.org>; Fri, 05 Mar 2021 03:03:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eplRf97wsAW/dlILq0xIA0M8/hRdFRbfndY572sUQ3w=;
        b=ewNoZ3v7y3ZtnU6Zk53A1G1+WEm56xJMoTW368b0ySqJY/E5xuOYirkh/cECMFrcpW
         PCsUp9Z75ZhgT3oV1sIoHglIrmRr6FHEIFOKqvRgRQap5EDtkB+E3xNeVZHZ4EqBctSV
         mFubljagU+ODa8PiBroGJd0hLlSUJK7WkeS4TxISWGxd1C6n0U4l75VFIHPs4QUoAZQd
         Xzfq9DI1YmYX/lsOwDLwFI4u5Y3eDmUaTHN841K3YzjcZU3ggMp0pCmTWsqriHao9C1e
         rQ/wpSWbYil2R2jw1kwDQMMPB+RhN97dbBacSc9r5u+34LdUr/B++s+pOFZUCNLEU/Ad
         av5A==
X-Gm-Message-State: AOAM530QGnAOnZvqrkVey5dZjiSUz39vg/+E5bcrOdBOlnj94h6tUSor
        ZaC0Zlls9zRAfkqnetOQKh+5ldQTAWcqDJIBY2AmcGrDWCp2fRUoW6gBmDvScfTo2ZljVY5C1o8
        CXNQwBwFeDPfVc9ViDp4Jdq82ofczIkYmpssBxGimXw==
X-Received: by 2002:a5d:658d:: with SMTP id q13mr8756111wru.388.1614942201437;
        Fri, 05 Mar 2021 03:03:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnftLtCGeuBhGnFb1pHZJs39fFWG0ruOT9/IIDb0iq2tGSJ/FRqtMfWfVPM8GomI6b040CLQ==
X-Received: by 2002:a5d:658d:: with SMTP id q13mr8756098wru.388.1614942201250;
        Fri, 05 Mar 2021 03:03:21 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id 9sm2163207wmf.13.2021.03.05.03.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 03:03:20 -0800 (PST)
Subject: Re: [RFT PATCH v3 27/27] arm64: apple: Add initial Apple Mac mini
 (M1, 2020) devicetree
To:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-28-marcan@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <e45c15ae-ee81-139c-5da1-a6759e39fd71@canonical.com>
Date:   Fri, 5 Mar 2021 12:03:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210304213902.83903-28-marcan@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 04/03/2021 22:39, Hector Martin wrote:
> This currently supports:
> 
> * SMP (via spin-tables)
> * AIC IRQs
> * Serial (with earlycon)
> * Framebuffer
> 
> A number of properties are dynamic, and based on system firmware
> decisions that vary from version to version. These are expected
> to be filled in by the loader.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  MAINTAINERS                              |   1 +
>  arch/arm64/boot/dts/Makefile             |   1 +
>  arch/arm64/boot/dts/apple/Makefile       |   2 +
>  arch/arm64/boot/dts/apple/t8103-j274.dts |  45 ++++++++
>  arch/arm64/boot/dts/apple/t8103.dtsi     | 135 +++++++++++++++++++++++
>  5 files changed, 184 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/apple/Makefile
>  create mode 100644 arch/arm64/boot/dts/apple/t8103-j274.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t8103.dtsi
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 28bd46f4f7a7..d5e4d93a536a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1647,6 +1647,7 @@ C:	irc://chat.freenode.net/asahi-dev
>  T:	git https://github.com/AsahiLinux/linux.git
>  F:	Documentation/devicetree/bindings/arm/apple.yaml
>  F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> +F:	arch/arm64/boot/dts/apple/
>  F:	arch/arm64/include/asm/sysreg_apple.h
>  F:	drivers/irqchip/irq-apple-aic.c
>  F:	include/dt-bindings/interrupt-controller/apple-aic.h
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index f1173cd93594..639e01a4d855 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -6,6 +6,7 @@ subdir-y += amazon
>  subdir-y += amd
>  subdir-y += amlogic
>  subdir-y += apm
> +subdir-y += apple
>  subdir-y += arm
>  subdir-y += bitmain
>  subdir-y += broadcom
> diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
> new file mode 100644
> index 000000000000..cbbd701ebf05
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_APPLE) += t8103-j274.dtb
> diff --git a/arch/arm64/boot/dts/apple/t8103-j274.dts b/arch/arm64/boot/dts/apple/t8103-j274.dts
> new file mode 100644
> index 000000000000..8afc2ed70361
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t8103-j274.dts
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Apple Mac mini (M1, 2020)
> + *
> + * target-type: J174
> + *
> + * Copyright The Asahi Linux Contributors
> + */
> +
> +/dts-v1/;
> +
> +#include "t8103.dtsi"
> +
> +/ {
> +	compatible = "apple,j274", "apple,t8103", "apple,arm-platform";
> +	model = "Apple Mac mini (M1, 2020)";
> +
> +	aliases {
> +		serial0 = &serial0;
> +	};
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		stdout-path = "serial0";
> +
> +		framebuffer0: framebuffer@0 {
> +			compatible = "apple,simple-framebuffer", "simple-framebuffer";
> +			reg = <0 0 0 0>; /* To be filled by loader */
> +			/* Format properties will be added by loader */
> +			status = "disabled";
> +		};
> +	};
> +
> +	memory@800000000 {
> +		device_type = "memory";
> +		reg = <0x8 0 0x2 0>; /* To be filled by loader */

Shouldn't this be 0x800000000 with ~0x80000000 length (or whatever is
more common)? Or did I miss some ranges?

Best regards,
Krzysztof
