Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D52C433E0
	for <linux-serial@archiver.kernel.org>; Fri, 19 Mar 2021 04:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9302364F1C
	for <linux-serial@archiver.kernel.org>; Fri, 19 Mar 2021 04:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbhCSE3K (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Mar 2021 00:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbhCSE3C (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Mar 2021 00:29:02 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A965C06174A;
        Thu, 18 Mar 2021 21:29:02 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id j26so4733812iog.13;
        Thu, 18 Mar 2021 21:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=77EAi3x6RSk+HaqpjBCCrupeL7eTqd2Gni0r4hhnRTY=;
        b=Av0mvs/1QDNsl+ACn3AMio1ANWZxSy27ALnryooHEksD+19Qjf1YH873gIgKT99kIb
         umXkWRr5r8O+xEzYgmuhITER3BJepmJlpA49kvYCaBQ0Gs3oUJ0Y0P+rtgD7zkoec2DS
         hPo5IAu9a11vAAoLycxXhWTXB2Myk4UweaEO/kiQzrb9LBtWrNlmMNjJ2EPBA7SP96iX
         6qqU41cvUsGy72fAtVyC7WHqCogQWkeBsvf2XGp/Bn0jwPJObqyaqS8jST8ZmaWYX5OW
         N6UU5ESDSvkgWo9gtQAFuI9kSIGJmH5t7VDFz991crSSjgdCFfPX91OpQSeegc41+mvw
         drGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=77EAi3x6RSk+HaqpjBCCrupeL7eTqd2Gni0r4hhnRTY=;
        b=hjodJPgdkvH2A1CjLgDOdq+cHQmfCgmAamUS3RCLFu/CpZE3SOmMq+ed9zvvzbZrdS
         Pkx9iqxsCVePpVcp5umxWbrqMXxQ/HmAY9eV6MmRBwM8vPjnBYMQMBhdHWGyjsmy0uB5
         wEYINP/Vqtz1nHa8gWFMjMQDMB9Z88swK0g0nTZI7zO1+v6G8qW2auXa+kP03AnGmt9S
         y+I0p/SYqTWN3dg0hL5eC2U7QhM2p4FYYfsZjOZ0tMv1XU7AYAbv9KCtf/kOR/+z1JrW
         qbQ/awVwVkp8b3NKxQcyDfCQWpYQGtB2bRHmC3vLT+AQ09uaew+I4Nbg4RdUen4nfBT1
         d3ww==
X-Gm-Message-State: AOAM532FP3ERksoN4g/e9lplcq8g0RiwBMorDmOmPwDsBPLBelQKJ/tN
        d8v004MmQ8p+IYWAzKNAROdhxB1zyu/PSwDCO5E=
X-Google-Smtp-Source: ABdhPJymXjj1dWzAvDvLcfggYqYjavGJzkjtuYIsSBDQSfVLN0qs2L4pO18/cvZe8ong+1rygx+Dn1HaTmH7Mj00ipA=
X-Received: by 2002:a05:6638:d47:: with SMTP id d7mr9834886jak.2.1616128142127;
 Thu, 18 Mar 2021 21:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <1615801436-3016-1-git-send-email-dillon.minfei@gmail.com> <1615801436-3016-10-git-send-email-dillon.minfei@gmail.com>
In-Reply-To: <1615801436-3016-10-git-send-email-dillon.minfei@gmail.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Fri, 19 Mar 2021 12:28:26 +0800
Message-ID: <CAL9mu0Lfj+n4uk2rT8QnDtRveHn2gLx4ut6fLCByt0w9e08vwQ@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] dt-bindings: serial: stm32: add phandle
 'bluetooth' to fix dtbs_check warrning
To:     Rob Herring <robh+dt@kernel.org>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux@armlinux.org.uk, Vladimir Murzin <vladimir.murzin@arm.com>,
        afzal.mohd.ma@gmail.com, gregkh@linuxfoundation.org,
        erwan.leray@st.com, erwan.leray@foss.st.com,
        linux-serial@vger.kernel.org, lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

No changes, Just loop lkp in.


Hi lkp,

Sorry for the late reply, thanks for your report.
This patch is to fix the build warning message.

Thanks.
Regards

On Mon, Mar 15, 2021 at 5:45 PM <dillon.minfei@gmail.com> wrote:
>
> From: dillon min <dillon.minfei@gmail.com>
>
> when run make dtbs_check with 'bluetoothi brcm,bcm43438-bt'
> dts enabled on stm32h7, there is a warrning popup:
>
> >> arch/arm/boot/dts/stm32h750i-art-pi.dt.yaml: serial@40004800: 'bluetooth'
>    does not match any of the regexes: 'pinctrl-[0-9]+'
>
> to make dtbs_check happy, so add a phandle bluetooth
>
> Fixes: 500cdb23d608 ("ARM: dts: stm32: Add STM32H743 MCU and STM32H743i-EVAL board")
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  Documentation/devicetree/bindings/serial/st,stm32-uart.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> index 8631678283f9..5e674840e62d 100644
> --- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> @@ -50,6 +50,11 @@ properties:
>      minItems: 1
>      maxItems: 2
>
> +  bluetooth:
> +    type: object
> +    description: |
> +      phandles to the usart controller and bluetooth
> +
>  # cts-gpios and rts-gpios properties can be used instead of 'uart-has-rtscts'
>  # or 'st,hw-flow-ctrl' (deprecated) for making use of any gpio pins for flow
>  # control instead of dedicated pins.
> --
> 1.9.1
>
