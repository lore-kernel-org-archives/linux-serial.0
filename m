Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65E4C433ED
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 18:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E81A6112F
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 18:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbhDZSHz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 14:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbhDZSHU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 14:07:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03461C061756
        for <linux-serial@vger.kernel.org>; Mon, 26 Apr 2021 11:06:37 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q9so2667394wrs.6
        for <linux-serial@vger.kernel.org>; Mon, 26 Apr 2021 11:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z/Kwipu1y6TOCAmGCH4eBv1sqy5s6UK9+gQOmGBdFDo=;
        b=tFAA8OM1OMnP4mVo1BUP3TdeKSXg/EB0WafYRtzUUiTKjsWUSQ3QroqS/dybgZJz5x
         0uistVBTmvOSdV/sjTYDOP5Va1MmX7/WqO0JJj+tBOPk5GLQHczf9D8P5whtygJ67rTY
         Xn1LpQA4AeN6syvVSQIdFiCAapyOmzrQqelxryNExRsNAUxIlqXMJwYj+ns6o5CwHKK2
         ylC+cLMlFFWQrWOfS5pjYnUnB/NhnEYOL62/OL4tMLc0yPxaXghMMP4NPRf4+0vQdGOq
         o/LMILSLqmJbvcyuMj+8GgtaWJZ/8VgNqAKdegca6JMGKy9kxT/rfUr+s3QipNmawIWl
         iCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=z/Kwipu1y6TOCAmGCH4eBv1sqy5s6UK9+gQOmGBdFDo=;
        b=S1HNNpaHCrMh2MpXLL2KDCXwJRRUnt+JaPE7hq5FMfKLM8VBX62PoxI7uckLve2r0F
         nv6fm/BGG1Ry8vf8ixgc3ZnhyujUhEff44Rtbbb+GMotpmuPFPnthk7q8EEsRKn0t/Cq
         HisDUupB2k9uDuRABJW7iPOVWYrmaJczBkRPJDKIipv4MpBMUsUyBXR5gXN6BSPNF8PQ
         8uSj7xNYQUgZ/vOthmNbi37JW7gsKVBs0N+jkjtWqZkl7aXOLkI1UEPNpzwzkgH1iSp8
         Da7s+4bEVJW5IHPCdMnxg+L0YSESpv0zKo+9HAOibwGPZ0a4ZOqXB/PPZXEamGOGYnfJ
         5DUA==
X-Gm-Message-State: AOAM53248zadtIKO1BOZ/tFJXJA0Vk7+6jw5op3qZ2GdpF6WgffYHrMa
        r3VUzd8OeOLOEbmiGfIOpbI9Vw==
X-Google-Smtp-Source: ABdhPJzgk2IzpTkyCjHJ4GcBEEoXLGQijoX+9t+CrvlLufNwU/zLqVZ2i9U0e2ub5m3mdqW1C5Dt0g==
X-Received: by 2002:a5d:590a:: with SMTP id v10mr24510931wrd.306.1619460395637;
        Mon, 26 Apr 2021 11:06:35 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:b76e:7362:77c0:ddc3? ([2a01:e0a:90c:e290:b76e:7362:77c0:ddc3])
        by smtp.gmail.com with ESMTPSA id a9sm276663wmj.1.2021.04.26.11.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 11:06:33 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] dt-bindings: serial: amlogic,meson-uart: add
 fifo-size property
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        gregkh@linuxfoundation.org
References: <20210325152410.1795557-1-narmstrong@baylibre.com>
 <20210325152410.1795557-2-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <39c92a23-e009-6bc2-a20b-9b0ab3e01c75@baylibre.com>
Date:   Mon, 26 Apr 2021 20:06:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210325152410.1795557-2-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Rob,

On 25/03/2021 16:24, Neil Armstrong wrote:
> On most of the Amlogic SoCs, the first UART controller in the "Everything-Else"
> power domain has 128bytes of RX & TX FIFO, so add an optional property to describe
> a different FIFO size from the other ports (64bytes).
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/serial/amlogic,meson-uart.yaml      | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> index 75ebc9952a99..8ece7f420c19 100644
> --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> @@ -55,6 +55,12 @@ properties:
>        - const: pclk
>        - const: baud
>  
> +
> +  fifo-size:
> +    description: The fifo size supported by the UART channel.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [64, 128]
> +
>  required:
>    - compatible
>    - reg
> 


Is it ok with the generic fifo-size property ?

Neil
