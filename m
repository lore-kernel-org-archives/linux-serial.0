Return-Path: <SRS0=s89U=ID=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55B3C433E0
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 18:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76C60650A4
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 18:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhCESx5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 5 Mar 2021 13:53:57 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:39766 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhCESxv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 5 Mar 2021 13:53:51 -0500
Received: by mail-ot1-f53.google.com with SMTP id h22so2782597otr.6;
        Fri, 05 Mar 2021 10:53:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fneTq2063McDFfTPtwQtaMOm7W8A1xMYIqx5C0mAJsk=;
        b=LHFk0fOiOzO4eQl17wFViJkzaZtB4b4EDWnB9cTpSrZ2hT9g7MpQ72nhmGJ8TlDmj8
         8Mfqd/9WuI4m516rHg/HpBT4FwDkfTwPiyBP/IZkbgfzCnLEKSonY7JJNQoeu8KxQea5
         1igol/OwEDO53xhzcSxoVogY4KORblYMOzzc8p+7sK2X/yCH2LWSmSAlybyTBuV+G6zy
         8YbaeK2mLi6w0RNIxyAi7i+Gu4jhftKUSLoMvNLFele5tIa6OO3VRlgmjrCb662iif5P
         mDjzOdGrSdDGWFwvlEWsGdUEJnBYrmwbJ+l+ufTMwWD852HBzWkxxLD7iIqRHGEDJRKw
         mMpA==
X-Gm-Message-State: AOAM531TqLvtb0mH9lFIDHqZq7Nvp364ClyzJ+qqgTy4Q8KICCPiM81p
        6OV5MDucqQURkqlVsnpjH/0LLvq7ag==
X-Google-Smtp-Source: ABdhPJx2eP3/GWFcePScRRMJu4lNsYmW8oQimLQi+5KHkY5RbcmejQsXuc9T1SCDS/k9iNKR7cLyrA==
X-Received: by 2002:a9d:73ce:: with SMTP id m14mr8673721otk.57.1614970430386;
        Fri, 05 Mar 2021 10:53:50 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h20sm765795otr.2.2021.03.05.10.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 10:53:49 -0800 (PST)
Received: (nullmailer pid 468180 invoked by uid 1000);
        Fri, 05 Mar 2021 18:53:47 -0000
Date:   Fri, 5 Mar 2021 12:53:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Valentin Caron <valentin.caron@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: stm32: add examples
Message-ID: <20210305185347.GA466473@robh.at.kernel.org>
References: <20210209095948.15889-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209095948.15889-1-valentin.caron@foss.st.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Feb 09, 2021 at 10:59:48AM +0100, Valentin Caron wrote:
> From: Valentin Caron <valentin.caron@st.com>
> 
> Add examples to show more use cases :
>  - uart2 with hardware flow control
>  - uart4 without flow control

Why do I need these? I can go read your dts files if I need more 
examples.

> 
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
> ---
>  .../bindings/serial/st,stm32-uart.yaml        | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> index 06d5f251ec88..3a4aab5d1862 100644
> --- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> @@ -82,6 +82,26 @@ additionalProperties: false
>  examples:
>    - |
>      #include <dt-bindings/clock/stm32mp1-clks.h>
> +
> +    usart4: serial@40004c00 {
> +      compatible = "st,stm32-uart";
> +      reg = <0x40004c00 0x400>;
> +      interrupts = <52>;
> +      clocks = <&clk_pclk1>;
> +      pinctrl-names = "default";
> +      pinctrl-0 = <&pinctrl_usart4>;
> +    };
> +
> +    usart2: serial@40004400 {
> +      compatible = "st,stm32-uart";
> +      reg = <0x40004400 0x400>;
> +      interrupts = <38>;
> +      clocks = <&clk_pclk1>;
> +      st,hw-flow-ctrl;
> +      pinctrl-names = "default";
> +      pinctrl-0 = <&pinctrl_usart2 &pinctrl_usart2_rtscts>;
> +    };
> +
>      usart1: serial@40011000 {
>        compatible = "st,stm32-uart";
>        reg = <0x40011000 0x400>;
> -- 
> 2.17.1
> 
