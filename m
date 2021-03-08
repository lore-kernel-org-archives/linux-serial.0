Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB18C4332D
	for <linux-serial@archiver.kernel.org>; Mon,  8 Mar 2021 19:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15333652A4
	for <linux-serial@archiver.kernel.org>; Mon,  8 Mar 2021 19:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhCHTUz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Mar 2021 14:20:55 -0500
Received: from mail-il1-f182.google.com ([209.85.166.182]:39342 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhCHTUn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Mar 2021 14:20:43 -0500
Received: by mail-il1-f182.google.com with SMTP id d5so9893383iln.6;
        Mon, 08 Mar 2021 11:20:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1L6btlnZFWT2wUztSO9tevXV6NJv+ZeIlELKczZZaFw=;
        b=fiBkEUwIBB2ZVI4HgXNGwSh5aYF0eU2WpWUEtsMn9N2qAwIZ+/k3qfXi9n5RoZr3Q7
         SQHMmOsyIhdoNxEayvuoSas6YiH57naDQ6CoW6Af8UOHDFw3rDn0jJ1TvmXV7XraiksP
         5A1yp5VlZNAprxBvmJOoqcN5dW5n7KzqIp06Jgd99k+DvCnO5x8d4iY0/szF/3v6tuUN
         2sMRQTnL6kHo/qIz7dZjQVblqq3HySJQGM4tG6bxkIBXpULEAcvs/b7mW7+hKTPBsE4M
         O6CguMWDa9N+JKFewtcjvIo2W86GULccvbr4LXaJ9BRdkpznfrWQ1lGEpIKC5xCpSQee
         yXAQ==
X-Gm-Message-State: AOAM532MXfbcSBj13rFIOpBhChWztK8iyvFD/EGEntVjQfQgqkZnu6/r
        dcXaN6Orp8+7bje4Nwfk0l3nIS+HHw==
X-Google-Smtp-Source: ABdhPJxNZi/akTGS5KF27FuIlkC3rfNJTzbmnPnH89Rfz7vgq18ujwtUCYa7gJdG40A1z3VSgdqRRA==
X-Received: by 2002:a92:c102:: with SMTP id p2mr21010388ile.227.1615231242427;
        Mon, 08 Mar 2021 11:20:42 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id a4sm3426705iow.55.2021.03.08.11.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 11:20:41 -0800 (PST)
Received: (nullmailer pid 2816246 invoked by uid 1000);
        Mon, 08 Mar 2021 19:20:40 -0000
Date:   Mon, 8 Mar 2021 12:20:40 -0700
From:   Rob Herring <robh@kernel.org>
To:     Martin Devera <devik@eaxlabs.cz>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jiri Slaby <jirislaby@kernel.org>, Le Ray <erwan.leray@st.com>,
        fabrice.gasnier@foss.st.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/2] dt-bindings: serial: Add rx-tx-swap to stm32-usart
Message-ID: <20210308192040.GA2807217@robh.at.kernel.org>
References: <aeefa74e-fa19-6c31-5240-0f14fca89298@foss.st.com>
 <20210302190303.28630-1-devik@eaxlabs.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302190303.28630-1-devik@eaxlabs.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 02, 2021 at 08:03:02PM +0100, Martin Devera wrote:
> Add new rx-tx-swap property to allow for RX & TX pin swapping.
> 
> Signed-off-by: Martin Devera <devik@eaxlabs.cz>
> ---
>  .../devicetree/bindings/serial/st,stm32-uart.yaml  | 32 +++++++++++++++-------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> index 8631678283f9..6eab2debebb5 100644
> --- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> @@ -9,9 +9,6 @@ maintainers:
>  
>  title: STMicroelectronics STM32 USART bindings
>  
> -allOf:
> -  - $ref: rs485.yaml
> -
>  properties:
>    compatible:
>      enum:
> @@ -40,6 +37,10 @@ properties:
>  
>    uart-has-rtscts: true
>  
> +  rx-tx-swap:
> +    type: boolean
> +    maxItems: 1

Type is boolean, but 'maxItems' applies to arrays.

In any case, this is already defined in serial.yaml, so just 
'rx-tx-swap: true' here.

> +
>    dmas:
>      minItems: 1
>      maxItems: 2
> @@ -66,13 +67,24 @@ properties:
>    linux,rs485-enabled-at-boot-time: true
>    rs485-rx-during-tx: true
>  
> -if:
> -  required:
> -    - st,hw-flow-ctrl
> -then:
> -  properties:
> -    cts-gpios: false
> -    rts-gpios: false
> +allOf:

And add '- $ref: serial.yaml#' here.

> +  - $ref: rs485.yaml
> +  - if:
> +      required:
> +        - st,hw-flow-ctrl
> +    then:
> +      properties:
> +        cts-gpios: false
> +        rts-gpios: false
> +  - if:
> +      required:
> +        - rx-tx-swap
> +    then:
> +      properties:
> +        compatible:
> +          enum:
> +            - st,stm32f7-uart
> +            - st,stm32h7-uart

The normal pattern is the 'if' has compatible. You can put the other 
compatible strings in the if, and then 'then' is:

then:
  properties:
    rx-tx-swap: false


Rob
