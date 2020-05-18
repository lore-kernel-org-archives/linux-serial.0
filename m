Return-Path: <SRS0=kmSd=7A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA1DC433E0
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 07:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FD292070A
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 07:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgERHFF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 May 2020 03:05:05 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35969 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgERHFF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 May 2020 03:05:05 -0400
Received: by mail-oi1-f193.google.com with SMTP id x23so1575857oic.3;
        Mon, 18 May 2020 00:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mwst2oJ9ZiHpuFTk/EHEIXQxKyuYO4XvyCKHwPLuFvQ=;
        b=F6Twt1+lKEgrMSMlZD6M2wSFt3wcAAAuYgqpLW2HXf6a7Hw7zBHxR6NaalQhUvdpVC
         7ntTCGCL4vCf/PKK1SKnaF+jRKwf6W/OxaR7SzFbuAeJJ1K6PSOYIMjydcs03sVbOjmC
         upzQWs10aDwCrf9TXXbozibdpyXgqhYyXT5/HURKItsUnFO+P46IE63gBPS3Hb9q+qwc
         syTPYcUjulSZ/ti8vEMVW+r4vATQ+lpPAv1gQc22fhCiDSoyIqXZo3UIFYLZZHLjRLTB
         mFmXvO0FGyNFOgAcZuZTX3QmS4BE2H0Dgxwg8ulXjz7JE0X7asqHeWIjv4byAqd1+EUU
         Oatw==
X-Gm-Message-State: AOAM531ewA8WpCiIVhcsIFahWcLgposEcAI6QMQ4Z6iPOlRBh4uLeP8b
        wp1w7SetSEGEk7QIJv6KfGpTFJpKVKQR5UA+rbY=
X-Google-Smtp-Source: ABdhPJy0eVnNyTzrW2/omSLVxGe8kfaMI2pqw3I/+FsC+Cu9/M01gEwxja6I4ke0ixSRPXiGHWR5yNXw9vPFyMYbXzQ=
X-Received: by 2002:aca:895:: with SMTP id 143mr9591469oii.153.1589785503554;
 Mon, 18 May 2020 00:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200420170204.24541-1-mani@kernel.org> <20200420170204.24541-2-mani@kernel.org>
In-Reply-To: <20200420170204.24541-2-mani@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 May 2020 09:04:52 +0200
Message-ID: <CAMuHMdVGem_2BGQK4dqZQb3sOd0LZk+RS_z4SvSRcNECEJHdwA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: serial: Document CTS/RTS gpios in
 STM32 UART
To:     mani@kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        fabrice.gasnier@st.com, linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Mani,

On Mon, Apr 20, 2020 at 7:02 PM <mani@kernel.org> wrote:
> From: Manivannan Sadhasivam <mani@kernel.org>
>
> Document the use of CTS/RTS gpios for flow control in STM32 UART
> controller. These properties can be used instead of 'st,hw-flow-ctrl'
> for making use of any gpio pins for flow control instead of dedicated
> pins. It should be noted that both CTS/RTS and 'st,hw-flow-ctrl'
> properties cannot co-exist in a design.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>

> --- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml

> @@ -55,6 +61,14 @@ properties:
>    linux,rs485-enabled-at-boot-time: true
>    rs485-rx-during-tx: true
>
> +if:
> +  required:
> +    - st,hw-flow-ctrl

Perhaps "st,hw-flow-ctrl" should be deprecated, in favor of the standard
"uart-has-rtscts" property?
Of course the driver needs to gain support for the latter first.

> +then:
> +  properties:
> +    cts-gpios: false
> +    rts-gpios: false
> +
>  required:
>    - compatible
>    - reg

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
