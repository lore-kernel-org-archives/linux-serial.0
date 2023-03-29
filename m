Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA7FC761A6
	for <linux-serial@archiver.kernel.org>; Wed, 29 Mar 2023 08:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjC2IU4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Mar 2023 04:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjC2IUk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Mar 2023 04:20:40 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6180449DE
        for <linux-serial@vger.kernel.org>; Wed, 29 Mar 2023 01:19:29 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g19so5971810lfr.9
        for <linux-serial@vger.kernel.org>; Wed, 29 Mar 2023 01:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680077966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5UBlMMuDB8t3puZJG73DjV36iE47zlqn+c0B/SfjDhw=;
        b=G9AYEWaOjKIg6s/VF8xl+wi5BXbejFA1wMNYnuWR6LYWP2jV9TrGp+hSMVUVckUH99
         qM7VN0ZMxxvnuLxWFcZGHAgtBTMnTWe7NAKgO937dzW/f2vJKs8zFWNmY+ZAR7cwG2oT
         TLaCXrMspF6W4X+g76DNxGkwkFdsMG68NOtmURFCIO1g34MUc8L7OUMwr2LXtTrwHDvS
         HPJK1DaDJ+XE/72stQBRMl0uUQrsXGlYZinO/RLyxjaTi9g/KG4XuzBgMWOgkNcq57ej
         7w4E7/22PudZEwmgrVLmx0rHQfMFAO9bY1+Loo6WSzwPPkfQsVw2GTefhZUiHsRnXFJ/
         YUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680077966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5UBlMMuDB8t3puZJG73DjV36iE47zlqn+c0B/SfjDhw=;
        b=WYlOI1+GsLiFy9ytn6G1d0vB8SAZs/a3SfACUJwJ61nrVpiTJxbxEqZmxMM2rwlPRM
         pYKpjWhEtGQghswz+jhbqJNC4MW7G16Gt6WEiuWdgGRSAdjsLvwfI1+bi88spZtba5ay
         zEXHrhkkb+mPNn+a1drWc6HQTOkcIjMB2EpWrEvMR8chdR94LQRzs0kaVvfK6aeHVuXz
         5ShbliPz2kRKvbjv5MjVFUyH8v76vDsJfAxjUgzIDNCBG6UU9WM/rpL8+Ix/qjRMW3y8
         dP6tZ7kOLgAF0sWuUBgmsD5eAUrrEXJ3Ovh6qi8TZ4K8Q9tj/bEkVCs7kfQaeu5OBikR
         fhNw==
X-Gm-Message-State: AAQBX9eQCTN8K8C00fh4MM1wyUKorsLyC/dk/0fz9hR9W8lRC4crL4GT
        EiuV2SfkpvwVdoqlcJx5LJ+ZpQ==
X-Google-Smtp-Source: AKy350YN45EncbSPLMyiEe8R1YjUtQTmdEeX00K1ppGIfM9FlVJoRpKWUea2C8VrTuvp/91Z/fzx6A==
X-Received: by 2002:a19:ae02:0:b0:4ea:129c:528 with SMTP id f2-20020a19ae02000000b004ea129c0528mr5438921lfc.56.1680077965939;
        Wed, 29 Mar 2023 01:19:25 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id m18-20020a195212000000b004e95f53adc7sm5387208lfb.27.2023.03.29.01.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:19:25 -0700 (PDT)
Message-ID: <ba59626b-454b-f7d9-fe51-6e588c1ed40e@linaro.org>
Date:   Wed, 29 Mar 2023 10:19:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 06/12] dt-bindings: arm: Add initial bindings for
 Nuvoton platform
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-7-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230328021912.177301-7-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 28/03/2023 04:19, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Rename the bindings/arm/npcm directory as nuvoton.
> Add binding for ARMv8 based Nuvotn SoCs and platform boards.

Typo: Nucotn?

> Add initial bindings for ma35d1 series development boards.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  | 30 +++++++++++++++++++

Anyway robot pointed to issues here...


Best regards,
Krzysztof

