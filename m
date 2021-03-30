Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83857C433DB
	for <linux-serial@archiver.kernel.org>; Tue, 30 Mar 2021 22:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E94E619D3
	for <linux-serial@archiver.kernel.org>; Tue, 30 Mar 2021 22:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbhC3WjJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 30 Mar 2021 18:39:09 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:36397 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbhC3WjF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 Mar 2021 18:39:05 -0400
Received: by mail-ot1-f54.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso17117643otq.3;
        Tue, 30 Mar 2021 15:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+kL3ZRB3j6i01duxPJ9vYcO9kwxP1k0mr9iO+0pJBac=;
        b=sPk1q1o/9jK45SPwIb01HUbKm06q5Yx3WRvEtU1Z832dmkeWAYG7kpU9+2q/t9w89R
         W9Tt2KL/Ia+qtgP/7mWZEcLrN4QB2St/IKCpSHhfdMbnBBlhL/DGg9VVFyBem1St9Ht2
         6xpao5FaWjVkf4MGz9a1SffhSIceqUkqR18S7G0+JyUWJeOmqgZRRQv2fQEi7Y3waDZb
         VRTnt08MIxws0iunR+/U7dccvOWzGhaiJcFWvOpRaPryCcIl64DB6Xvr7UI4GYsWCtLn
         Wx5fCviKHQfPq/JLkgyyNYYQmkgbZwSQfPw6WFrKS7RkqtYx01N0DpBymCGO6L4VO8rv
         g+0A==
X-Gm-Message-State: AOAM531LRh0uGXVV3Jfo/OTRRmrph3ZxcP/auiVE9UxOvYpEe1svxdid
        KfpHQk+gtF43JRvq5qQ8+jVhDWRKsQ==
X-Google-Smtp-Source: ABdhPJz1lPUhXrNxrHWj4A+J8TggtXB6qqS9Os++Ci/kdeMEGSETxa/ogDjwDKvpjvbG+y2lHU8MwA==
X-Received: by 2002:a05:6830:4110:: with SMTP id w16mr138691ott.348.1617143944665;
        Tue, 30 Mar 2021 15:39:04 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v1sm42689otk.67.2021.03.30.15.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 15:39:04 -0700 (PDT)
Received: (nullmailer pid 841804 invoked by uid 1000);
        Tue, 30 Mar 2021 22:39:02 -0000
Date:   Tue, 30 Mar 2021 17:39:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: serial: 8250: update for
 aspeed,sirq-active-high
Message-ID: <20210330223902.GA837825@robh.at.kernel.org>
References: <20210330002338.335-1-zev@bewilderbeest.net>
 <20210330002338.335-3-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330002338.335-3-zev@bewilderbeest.net>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Mar 29, 2021 at 07:23:37PM -0500, Zev Weiss wrote:
> Update DT bindings documentation for the new incarnation of the
> aspeed,sirq-polarity-sense property.

Why?

This isn't a compatible change.

> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
> index f54cae9ff7b2..0bbb7121f720 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -13,7 +13,7 @@ allOf:
>    - $ref: /schemas/serial.yaml#
>    - if:
>        required:
> -        - aspeed,sirq-polarity-sense
> +        - aspeed,sirq-active-high
>      then:
>        properties:
>          compatible:
> @@ -181,13 +181,11 @@ properties:
>    rng-gpios: true
>    dcd-gpios: true
>  
> -  aspeed,sirq-polarity-sense:
> -    $ref: /schemas/types.yaml#/definitions/phandle-array
> +  aspeed,sirq-active-high:
> +    type: boolean
>      description: |
> -      Phandle to aspeed,ast2500-scu compatible syscon alongside register
> -      offset and bit number to identify how the SIRQ polarity should be
> -      configured. One possible data source is the LPC/eSPI mode bit. Only
> -      applicable to aspeed,ast2500-vuart.
> +      Set to indicate that the SIRQ polarity is active-high (default
> +      is active-low).  Only applicable to aspeed,ast2500-vuart.
>  
>  required:
>    - reg
> @@ -227,7 +225,7 @@ examples:
>          interrupts = <8>;
>          clocks = <&syscon ASPEED_CLK_APB>;
>          no-loopback-test;
> -        aspeed,sirq-polarity-sense = <&syscon 0x70 25>;
> +        aspeed,sirq-active-high;
>      };
>  
>  ...
> -- 
> 2.31.1
> 
