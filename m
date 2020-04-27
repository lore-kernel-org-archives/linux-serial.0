Return-Path: <SRS0=JuT/=6L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0BFC55199
	for <linux-serial@archiver.kernel.org>; Mon, 27 Apr 2020 09:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDE692064C
	for <linux-serial@archiver.kernel.org>; Mon, 27 Apr 2020 09:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="raiJTN/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgD0JLy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Apr 2020 05:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgD0JLy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Apr 2020 05:11:54 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52CAC09B052
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2020 02:11:53 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id k28so13173574lfe.10
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2020 02:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yBDkRvrTx74S5+gZjwEZ9iACmQsB1T2mQm+OV8dNjho=;
        b=raiJTN/HRYGaHVksUpfYX1wyYGDzcsdeCn7DrhKbOfDdjw/MLRxJJ8twCfPbR+Hi+d
         m8bbSAERhc78/7BNmN1M53+RrtZEJ6gtB3M4L/MvDLvZWeuPCjfITc/mc+iiDbRI3jjR
         G56jqF9qTkDPlKs5mhLYIS5vYGfrbcvcZP6AW/yU1q9cczrf8qBd6r6oWB5XL28M/Frw
         orziZWnsTcshI8t2j3gcbvEYPcMnUScLotRV1QDBsU66EKXEGD/B5hQGFC8FNcH0EZn5
         2nZz6AH/d9ZmaJHEkzCchnk/7O80CEbGvOIVKmb/R/WB+M2sfP/FfJQ89qshWJydfTWv
         l8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yBDkRvrTx74S5+gZjwEZ9iACmQsB1T2mQm+OV8dNjho=;
        b=bj+23iBgzl2WTaaed5Tf1PCZWMxOBXKUEzr0FmEnIUAKRZ053HlZ873GWo7MNgdHOU
         nNWpOEvEnCvSdkTRIgquF96yopYk+POd7ZWQSgBYOSC7vWl7ONXS/Xi9/RSJsa9yf3aS
         YwulmTK2OzoAKU/RrkY6quNK67fcY9ofhe9rj1MoXvRIrb+ZMjeIrYfkDu3KFkzIHGhP
         nFKA3frfWtf6A6+d6kfM1beOZnmgzMMW0D4EkZa557uxAILuMhVREeYDdmEJ5OuER+Fo
         FTTjAT+7UU4pxDBIXR7D+8EWI9gAE/MdEj6v8I91bG4PJgwp5bXmSz2deER9VmvsEH23
         TOxw==
X-Gm-Message-State: AGi0PuYNw76rdKpFlBF7VG6C14N7qCd1f1bYPWkAALwh4upj5b7qz3hj
        T+iEbfQCxmgQRDXxrggAGhJ5OWOMe7pLZw==
X-Google-Smtp-Source: APiQypJyVX/9wGU9KkPKAbdOn5EfnQbiZMB1wIjiO7M9xszAG/gddAjg0bucMZClaTTySjGPgz8dTA==
X-Received: by 2002:ac2:5930:: with SMTP id v16mr14736464lfi.103.1587978712022;
        Mon, 27 Apr 2020 02:11:52 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:468e:1152:9c79:cdeb:725:5fa4? ([2a00:1fa0:468e:1152:9c79:cdeb:725:5fa4])
        by smtp.gmail.com with ESMTPSA id h6sm9088671ljj.29.2020.04.27.02.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 02:11:51 -0700 (PDT)
Subject: Re: [PATCH 2/8] dt-bindings: intc: Convert ingenic,intc.txt to YAML
To:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     od@zcrc.me, =?UTF-8?B?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mips@vger.kernel.org
References: <20200426185856.38826-1-paul@crapouillou.net>
 <20200426185856.38826-2-paul@crapouillou.net>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <f865b39a-3e8d-a367-45b2-aa5e7412e81a@cogentembedded.com>
Date:   Mon, 27 Apr 2020 12:11:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200426185856.38826-2-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello!

On 26.04.2020 21:58, Paul Cercueil wrote:

> Convert the ingenic,intc.txt doc file to ingenic,intc.yaml.
> 
> Some compatible strings now require a fallback, as the controller
> generally works the same across the SoCs families.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
[...]
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.yaml
> new file mode 100644
> index 000000000000..28b27e1a6e9d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/ingenic,intc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ingenic SoCs interrupt controller devicetree bindings
> +
> +maintainers:
> +  - Paul Cercueil <paul@crapouillou.net>
> +
> +properties:
> +  $nodename:
> +    pattern: "^interrupt-controller@[0-9a-f]+$"
> +
> +  compatible:
> +    oneOf:
> +      - enum:
> +        - ingenic,jz4740-intc
> +        - ingenic,jz4760-intc
> +        - ingenic,jz4780-intc
> +      - items:
> +        - enum:
> +          - ingenic,jz4775-intc
> +          - ingenic,jz4770-intc
> +        - const: ingenic,jz4760-intc
> +      - items:
> +        - const: ingenic,x1000-intc
> +        - const: ingenic,jz4780-intc
> +      - items:
> +        - const: ingenic,jz4725b-intc
> +        - const: ingenic,jz4740-intc
> +
> +  "#interrupt-cells":
> +    const: 1

    Do double quotes work the same as the single ones?

[...]

MBR, Sergei
