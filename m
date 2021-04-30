Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6B7C433B4
	for <linux-serial@archiver.kernel.org>; Fri, 30 Apr 2021 15:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8D336144B
	for <linux-serial@archiver.kernel.org>; Fri, 30 Apr 2021 15:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhD3PWA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Apr 2021 11:22:00 -0400
Received: from mail-oo1-f47.google.com ([209.85.161.47]:44599 "EHLO
        mail-oo1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhD3PV7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Apr 2021 11:21:59 -0400
Received: by mail-oo1-f47.google.com with SMTP id i3-20020a4ad3830000b02901ef20f8cae8so8272436oos.11;
        Fri, 30 Apr 2021 08:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K/nJwkgRAXqwdVzM6o6lLqjZ+U6/JacCPuepUB7jiw4=;
        b=VzxDFWWWJ90k9+MnlyMURS5RkFpPAGHphqUgp3Mn8VCk1Q2VV5rgYUxbmXbhFQxjC9
         q6GzrHlZjXggiPLWPPJ2FL24zH5PVaVD2keiT+xlDdYP/QkRrW1E/zgumEN2DqasiTrk
         8lcBcp/fXEH8GC5ttjWiXiGTN0vuH8Fw5o1h83CtaAcyoeM2KQnDMqLWAbUJAoj5iSXs
         lRJxlSFQLmwQa4X781jej4FXX1qOm++qa4UCmRTXqbhK/5uzQTpxybyIHLG2dNFYbhhn
         2Ua165dj5funKpHuIXFZDH+FCVDScxABuL/aVTZPGaOhEhUS+rZC5uz2NRhEvGUZqIQN
         raTg==
X-Gm-Message-State: AOAM5332dEqdVgq7jnKDQSTQZpgzVBA8UEMQzwMOMFUgURGtqDkDn0pH
        9Ou1vr7W7SjmB/n5wv+m9w==
X-Google-Smtp-Source: ABdhPJw2d5bcg23XAyoaeqsvA2LCgrU/4JHIpHaFIgr85/rVl1gXgp/F2SzdE5eO6kAyQXuGCodaPQ==
X-Received: by 2002:a4a:4c42:: with SMTP id a63mr1898053oob.33.1619796069909;
        Fri, 30 Apr 2021 08:21:09 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e12sm747891otq.46.2021.04.30.08.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 08:21:08 -0700 (PDT)
Received: (nullmailer pid 3347909 invoked by uid 1000);
        Fri, 30 Apr 2021 15:21:08 -0000
Date:   Fri, 30 Apr 2021 10:21:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: serial: pl011: Change to reference
 the kernel-defined serial.yaml
Message-ID: <20210430152108.GA3344055@robh.at.kernel.org>
References: <20210422085837.513-1-thunder.leizhen@huawei.com>
 <20210422085837.513-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422085837.513-3-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 22, 2021 at 04:58:36PM +0800, Zhen Lei wrote:
> The /schemas/serial.yaml from dt-schema only has the property $nodename,
> whereas the kernel-defined /schemas/serial/serial.yaml contains more
> useful properties, support for more complex application scenarios.
> 
> For example:
> 1) The property "current-speed" in fsl-lx2160a.dtsi
> 2) The subnode "bluetooth" in hi3660-hikey960.dts
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/serial/pl011.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

What about all these:

$ git grep 'schemas/serial.yaml'
Documentation/devicetree/bindings/serial/8250.yaml:  - $ref: /schemas/serial.yaml#
Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml:  - $ref: /schemas/serial.yaml#
Documentation/devicetree/bindings/serial/ingenic,uart.yaml:  - $ref: /schemas/serial.yaml#
Documentation/devicetree/bindings/serial/pl011.yaml:  - $ref: /schemas/serial.yaml#
Documentation/devicetree/bindings/serial/qca,ar9330-uart.yaml:  - $ref: /schemas/serial.yaml#
Documentation/devicetree/bindings/serial/samsung_uart.yaml:  - $ref: /schemas/serial.yaml#
Documentation/devicetree/bindings/serial/sifive-serial.yaml:  - $ref: /schemas/serial.yaml#
Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml:  - $ref: /schemas/serial.yaml#
Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml:    $ref: /schemas/serial.yaml#
