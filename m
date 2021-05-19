Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F330C433ED
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 21:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F72E611AD
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 21:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhESVhc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 May 2021 17:37:32 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:39544 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhESVhc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 May 2021 17:37:32 -0400
Received: by mail-ot1-f41.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so13071994otc.6;
        Wed, 19 May 2021 14:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b9AJYfJ17q275zL0Tl68tue+i0tZohtAZ//tG0ipyj0=;
        b=kL0+hQ+n2plrU7e4cdT6V8kBTmBot5lcYLRxCQ+AnYVU+PnLa+hO7R430grmzOwnkg
         MGI6/fj1It2e+SI5E9u8vXzTloEhubFQCbv/SswKIzWfEQXUoxSs8LzG+EYZK0QG+1dG
         2nyuALcSM4jjIEnKH78OrGNpJr5KP9R3l9ZG8EW7JRhoyTySakdaEln3u6am2bb490FC
         rD0gxfhcDWjhowmk8SnT/2jpJNtQdcAh+JyovCGWKC964dthfmWt8QcZzLLSj1x3BLTP
         yz25yLyGmz7dqB3jpH+iS2tI7HlVRlQbt4/Juy8O79320JaVyelxRPdWKCK3OMdd4hq7
         zeeA==
X-Gm-Message-State: AOAM5313OlKDDHvfqyiyawwvWRe1WVt/z5FGaSATF1VjogIUJJok0zY0
        UfEen/YP4/o8WlSVRniiIg==
X-Google-Smtp-Source: ABdhPJxXixBAzcyGcAsCCerVC9LDjQpLAHkBT5dxCqS6Pefn0cVnqYZorqDmnq7LW6vf2TlIkcyvog==
X-Received: by 2002:a9d:39e3:: with SMTP id y90mr1309416otb.257.1621460171829;
        Wed, 19 May 2021 14:36:11 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o14sm166119oik.29.2021.05.19.14.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 14:36:11 -0700 (PDT)
Received: (nullmailer pid 3697882 invoked by uid 1000);
        Wed, 19 May 2021 21:36:10 -0000
Date:   Wed, 19 May 2021 16:36:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jirislaby@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: serial: amlogic, meson-uart: add
 fifo-size property
Message-ID: <20210519213610.GA3697605@robh.at.kernel.org>
References: <20210518075833.3736038-1-narmstrong@baylibre.com>
 <20210518075833.3736038-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518075833.3736038-2-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 18 May 2021 09:58:31 +0200, Neil Armstrong wrote:
> On most of the Amlogic SoCs, the first UART controller in the "Everything-Else"
> power domain has 128bytes of RX & TX FIFO, so add an optional property to describe
> a different FIFO size from the other ports (64bytes).
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/serial/amlogic,meson-uart.yaml       | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
