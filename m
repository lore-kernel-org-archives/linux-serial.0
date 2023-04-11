Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B10C76196
	for <linux-serial@archiver.kernel.org>; Tue, 11 Apr 2023 05:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjDKFo1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 Apr 2023 01:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjDKFo0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Apr 2023 01:44:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C04AD
        for <linux-serial@vger.kernel.org>; Mon, 10 Apr 2023 22:44:25 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-504a131087aso1264871a12.2
        for <linux-serial@vger.kernel.org>; Mon, 10 Apr 2023 22:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681191864;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=py+ttLtkRvphwWFQ7k3+KBL1vA9UoVnVONpB+O7yRyg=;
        b=jfDf7xjPMXmrsxYDNwRpXrnPR1y3US8XtDYCWsdhPlWwWnre7Rv3fJWEDI3+J7A9rR
         3idnYbD6fga9GgLK5iz/BIskjhowxdrRC9cFdQyMA6vP+0Vg6fxyTUQIyIPpvDeuXvaL
         jgPk2v9fHintPFRqiKX2NPSAG48JetptcPNKMoGl5OEMkuLmdtny+T6QT3Gfx93bHtaw
         QVlI5HYkE1pYPWUpXlURmbbj5YxM4V/s27X3l+pLomekjJE7T1/4LeQc4O9WyRQfaDeg
         531xev8SCfoFgew5iSFws54QkV0VF3zBRWQmDy1SMrt6VpGvnbDk2CwB4IIMyD4qnHCP
         KM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681191864;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=py+ttLtkRvphwWFQ7k3+KBL1vA9UoVnVONpB+O7yRyg=;
        b=broJCCfci6ntIIPMy+PXsr8S+CRLZb4hLB8hLZNsue+0MM+HWWAMm0Bjo9IjHQRQpG
         VPYgTHKKawN/79pdH9qxxB47ndVSQyVdv41BPTbrJB50V4e72Qs3WmfDTV7HJj1sEgYs
         7LuzpK2tGWjdMd3NkMrd/BljrKrMAOGTYlmwVOVE0yBerpkqxMCucDkLLeX1lJD5eL7v
         GBp0MeiUJiWeYIJ7AfKNrI2Mji2gRMQmA275dntoHWS6QqVIDw5Boyuf4gl2skLqOBOj
         /XzKtSaWy1vYYgkSjh71iayUJ33ZbjYdEzQ2oQfuE4EPIc4m+Qqiw7YUmHjtZ95xqgno
         Likw==
X-Gm-Message-State: AAQBX9drLTlLJ+yT4YdkQ3j9Q2HrrfmAHD4/FVgi3m9Ksy+e12Z4U5r/
        jPaw6LtRQRubPFLmcdx9Z8TxZwyNsBe3UrXKeNzkhw==
X-Google-Smtp-Source: AKy350asX8D2+/XQO3G15EftTVG/lQXidxyHsKoe4zMuLHYQq/jCH/X9/zeoRsEksnJ8iutCoDQngg==
X-Received: by 2002:a05:6402:788:b0:501:e26e:502b with SMTP id d8-20020a056402078800b00501e26e502bmr8617612edy.29.1681191864048;
        Mon, 10 Apr 2023 22:44:24 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:dad2:72b7:3626:af61? ([2a02:810d:15c0:828:dad2:72b7:3626:af61])
        by smtp.gmail.com with ESMTPSA id p18-20020a1709066a9200b0094a2f92aaeesm3396276ejr.158.2023.04.10.22.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 22:44:23 -0700 (PDT)
Message-ID: <b2f81c57-9b7c-9ad6-6ce6-cc94703599db@linaro.org>
Date:   Tue, 11 Apr 2023 07:44:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 tty-next 1/2] dt-bindings: serial: ni,ni16650: add
 bindings
Content-Language: en-US
To:     Brenda Streiff <brenda.streiff@ni.com>
Cc:     ilpo.jarvinen@linux.intel.com,
        Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230329154235.615349-1-brenda.streiff@ni.com>
 <20230410211152.94332-1-brenda.streiff@ni.com>
 <20230410211152.94332-2-brenda.streiff@ni.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230410211152.94332-2-brenda.streiff@ni.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 10/04/2023 23:11, Brenda Streiff wrote:
> Add bindings for the NI 16550 UART.
> 
> Signed-off-by: Brenda Streiff <brenda.streiff@ni.com>
> Cc: Gratian Crisan <gratian.crisan@ni.com>
> Cc: Jason Smith <jason.smith@ni.com>

Thank you for your patch. There is something to discuss/improve.

> ---
>  .../bindings/serial/ni,ni16550.yaml           | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/ni,ni16550.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/ni,ni16550.yaml b/Documentation/devicetree/bindings/serial/ni,ni16550.yaml
> new file mode 100644
> index 000000000000..13928e89f5aa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/ni,ni16550.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/ni,ni16550.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NI 16550 asynchronous serial interface (UART)
> +
> +maintainers:
> +  - Brenda Streiff <brenda.streiff@ni.com>
> +
> +allOf:
> +  - $ref: serial.yaml#
> +
> +properties:
> +  compatible:
> +    const: ni,ni16550
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clock-frequency: true

I missed it last time - why do you need this property? You do not have
any clock input, so which clock's frequency is it?

Best regards,
Krzysztof

