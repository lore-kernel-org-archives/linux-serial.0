Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A79C433FE
	for <linux-serial@archiver.kernel.org>; Wed,  1 Jun 2022 10:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbiFAKNv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Jun 2022 06:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351910AbiFAKNt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Jun 2022 06:13:49 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D4F4CD44
        for <linux-serial@vger.kernel.org>; Wed,  1 Jun 2022 03:13:47 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id t5so1501006edc.2
        for <linux-serial@vger.kernel.org>; Wed, 01 Jun 2022 03:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AlvALx0zMnGDVnEapBQ7KHJlm9HnZCeBAZQY2Z7YIfQ=;
        b=MyCjNSjG2AHbNB2hBMdKLs7JyeIE2MU21L7NxYzqYkgJshTjTAEE3mD+wxlpLMSZa1
         6kCgUApP3XMk/l0RKFbqTKkRmn+B8M5eZoQ9wj6leLnRPShsmt0NiHxg5OAui/Wjj4iJ
         i4vfSEUecvq6/DBHNM7UiaodK0JQQ7g3UoEYaWKtumlj0/PvIpngsENEmCTNfzM89Tb9
         QkF+JF2c2z/S4FXGch+hlLzAcJGTiwGowPWEiaeRIqEt7wYuCN7+DXZTH5/EvCioiExI
         p4j/Ly9/9+f7IV1cf8EFCHLLNIAVtSW+2Z8+zxv26svn+bQyu09y+iFILQTj/RvG+YQl
         /OJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AlvALx0zMnGDVnEapBQ7KHJlm9HnZCeBAZQY2Z7YIfQ=;
        b=f0ORHwMpanOrmgO0XjAER5ZVnEZTo4iK5b64DhZRo17ylvKAYBs3kWv+GuBCXduGKD
         K39DFz0AvC4DEHcRfu0AMLqjHVHAc+KZcuywnQ+dAFSKKrVd6XmOgKWdAACWe95+oEEw
         4ISnPytaH4+YBKtRuXCW8ITsE0emlcmPq8RE4iv6Bi7tOla/o7V6oStuhE+d0NWD8dmK
         SnyUciR42GI69Dcye05XLA6DrK5KmcqDr9udFxkxS8kieD/RoOfXHf7yYe8O4S0TTaDl
         8vrM5p2W9wiQG1UuQbEYV8VPuui049ne7C/lv0p3kul4iR4RZeQ7ptqzWIzroDYmSvfT
         qwiA==
X-Gm-Message-State: AOAM5329x6f2PphVtMoLXMIiCbp94/RsA2J7s7u4UBeYRHByA2F8z8n9
        lkbPdceCp0OxbFDwXnuu8gduew==
X-Google-Smtp-Source: ABdhPJx/6T0uvLJqvrWkeIA6nNBw+V6b78iDiCeD1eckOus4w0IQXWKCNYVm2nBgb3y+6PpRaLcMOw==
X-Received: by 2002:a05:6402:51c9:b0:42b:63c2:6657 with SMTP id r9-20020a05640251c900b0042b63c26657mr51960414edd.255.1654078425689;
        Wed, 01 Jun 2022 03:13:45 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p5-20020aa7cc85000000b0042bb1e2e2f7sm716587edt.8.2022.06.01.03.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 03:13:44 -0700 (PDT)
Message-ID: <44798b51-1410-d1db-3c53-0a90beb714ea@linaro.org>
Date:   Wed, 1 Jun 2022 12:13:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 12/17] dt-bindings: phy: mediatek,tphy: add MT8365 SoC
 bindings
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        qii.wang@mediatek.com, matthias.bgg@gmail.com, jic23@kernel.org,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, chunfeng.yun@mediatek.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20220531135026.238475-1-fparent@baylibre.com>
 <20220531135026.238475-13-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531135026.238475-13-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 31/05/2022 15:50, Fabien Parent wrote:
> Add binding documentation for the MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
