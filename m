Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3C8C4332B
	for <linux-serial@archiver.kernel.org>; Fri, 12 Mar 2021 14:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2569964FDD
	for <linux-serial@archiver.kernel.org>; Fri, 12 Mar 2021 14:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhCLOXx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 12 Mar 2021 09:23:53 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:42167 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhCLOXi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 Mar 2021 09:23:38 -0500
Received: by mail-io1-f47.google.com with SMTP id u20so25872097iot.9;
        Fri, 12 Mar 2021 06:23:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ZmH44YRtFRRzhiVu0fvhNooqcCOgV0svXvgD6Zd8yJQ=;
        b=Jt0XwX5GiCKf9mqov1EVjxLMgpsiogwseSq8DxFS6B8LU/bI1/4tBGq7v98D5/vwNR
         sdD+ArcM6tmIis4qfYnlHDrcWAnwta2iJkNR9KW8P6EZ2l5wbIppzRwhpGRjcnS+KT30
         w23C7CvSq2Bh/f/sbYOfSUQ6/cdhzGf9baMuLG2uhOX9sTelgUYUCn+I0j1/Oz2PwyAv
         Q9KyBHAP2gEmpc0tCAsmKvau2jFJZ+bZUY/KycOtphIFqyAYmSHdjkg1SQSFa61Kda4M
         +Wp/gGVIiUQ+ZISKXSep3HZlq5x/W5QYg0qHWKYuOyNxF2GpmXh8oP2Um7d5CyR2PYHb
         l13g==
X-Gm-Message-State: AOAM5325akPwvVoEk51F59hDO+/SvFWDk/ZLeiT+5k5WYmQ7GWRqQRuu
        kztdVkHqIkMqEsx7d48FJQ==
X-Google-Smtp-Source: ABdhPJxRPIqMZxLRKnf4tIhDsaPK5p8Vi8pbfKdHHTZJ/vkkYGFNLMknnLWvg6u3ZnTdR5rwFwJHHg==
X-Received: by 2002:a5d:8050:: with SMTP id b16mr10004247ior.201.1615559018073;
        Fri, 12 Mar 2021 06:23:38 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id w13sm2973938ilg.48.2021.03.12.06.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 06:23:37 -0800 (PST)
Received: (nullmailer pid 2976053 invoked by uid 1000);
        Fri, 12 Mar 2021 14:23:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     Martin Devera <devik@eaxlabs.cz>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Le Ray <erwan.leray@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        fabrice.gasnier@foss.st.com, linux-arm-kernel@lists.infradead.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20210312102713.27776-1-devik@eaxlabs.cz>
References: <YEsjMJae3cGOdyjG@kroah.com> <20210312102713.27776-1-devik@eaxlabs.cz>
Subject: Re: [PATCH v6 1/2] dt-bindings: serial: Add rx-tx-swap to stm32-usart
Date:   Fri, 12 Mar 2021 07:23:29 -0700
Message-Id: <1615559009.788146.2976052.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 12 Mar 2021 11:27:12 +0100, Martin Devera wrote:
> Add new rx-tx-swap property to allow for RX & TX pin swapping.
> 
> Signed-off-by: Martin Devera <devik@eaxlabs.cz>
> Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> v6:
>   - add version changelog
> v5:
>   - yaml fixes based on Rob Herring comments
>     - add serial.yaml reference
>     - move compatible from 'then' to 'if'
> v3:
>   - don't allow rx-tx-swap for st,stm32-uart (suggested
>     by Fabrice Gasnier)
> v2:
>   - change st,swap to rx-tx-swap (suggested by Rob Herring)
> ---
>  .../devicetree/bindings/serial/st,stm32-uart.yaml  | 29 ++++++++++++++--------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/serial/st,stm32-uart.yaml:81:12: [warning] wrong indentation: expected 10 but found 11 (indentation)

dtschema/dtc warnings/errors:

See https://patchwork.ozlabs.org/patch/1451861

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

