Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6936DC433B4
	for <linux-serial@archiver.kernel.org>; Fri,  9 Apr 2021 16:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D7361041
	for <linux-serial@archiver.kernel.org>; Fri,  9 Apr 2021 16:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhDIQSN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 9 Apr 2021 12:18:13 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:45752 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDIQSM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 9 Apr 2021 12:18:12 -0400
Received: by mail-ot1-f42.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so1093820otf.12;
        Fri, 09 Apr 2021 09:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nPXWno11S4Od5PcOam+OVspUYzqe84Gw2wWYNw5BBRg=;
        b=UX84FOU8c8GPBpj8I1bQuuRNXDke0/2CP6WPDghc9G4JbdPkCxj4qy8w7q/a1U+zAL
         qTNaKTLBO9JSx7Wb5tHUSVbfn358CNCNsFJgcv+VssYUVx+i/UJxWLy93uOWpOFEajx2
         hkAzU+ZHRKrrS4GT8UXWcFscjP1tTBvZJV0e8150qG0QW1BeF4nJ84EoI9qEbq7fOpXD
         qLqHZNRPCkYU7UKA4W6qYBSmRoPQgpHkPbNPwBnX1fVwdRPMQV/vR71YGnsMmI5QKIOr
         Q0o+IIhbdQKus1nlnoLvrdkfOG4t5aQAb45+hQK3PHNfhhB+/lYIwyy03H6TsNnoCAcN
         vFtQ==
X-Gm-Message-State: AOAM5338abtcZcEH4ITVhbZxfdiMEjU5YtdA4mnX4lfqcWYv4uOTp7F4
        uB7BvC5skPDR7Prs90uai/iG6H32iQ==
X-Google-Smtp-Source: ABdhPJwf5uML2LSRjZqxpDpvqc9tar6P33ne+FS3tnIzgi6Q+uhrWPe9XI2nGzLTXRfg7kzTMa0uyg==
X-Received: by 2002:a9d:7342:: with SMTP id l2mr5141154otk.175.1617985077974;
        Fri, 09 Apr 2021 09:17:57 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w1sm37517otq.75.2021.04.09.09.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 09:17:57 -0700 (PDT)
Received: (nullmailer pid 3749394 invoked by uid 1000);
        Fri, 09 Apr 2021 16:17:55 -0000
Date:   Fri, 9 Apr 2021 11:17:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Erwan Le Ray <erwan.leray@foss.st.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: Re: [PATCH 1/2] dt-bindings: serial: stm32: add fifo threshold
 configuration
Message-ID: <20210409161755.GA3745930@robh.at.kernel.org>
References: <20210406072122.27384-1-erwan.leray@foss.st.com>
 <20210406072122.27384-2-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406072122.27384-2-erwan.leray@foss.st.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Apr 06, 2021 at 09:21:21AM +0200, Erwan Le Ray wrote:
> Add two optional DT properties, to configure RX and TX fifo threshold:
> - st,rx-fifo-threshold-bytes
> - st,tx-fifo-threshold-bytes
> 
> This patch depends on patch ("dt-bindings: serial: Add rx-tx-swap to stm32-usart").
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>
> 
> diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> index c69f8464cdf3..e163449bf39e 100644
> --- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> @@ -65,6 +65,22 @@ properties:
>    linux,rs485-enabled-at-boot-time: true
>    rs485-rx-during-tx: true
>  
> +  st,rx-fifo-threshold-bytes:
> +    description:
> +      RX FIFO threshold configuration in bytes.
> +      If value is set to 1, RX FIFO threshold is disabled.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8, 12, 14, 16]
> +    default: 8
> +
> +  st,tx-fifo-threshold-bytes:
> +    description:
> +      TX FIFO threshold configuration in bytes.
> +      If value is set to 1, TX FIFO threshold is disabled.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8, 12, 14, 16]
> +    default: 8

We already have 'tx-threshold' for 8250, so reuse that and add 
'rx-threshold'.

Rob
