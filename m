Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02D7C4167B
	for <linux-serial@archiver.kernel.org>; Wed,  1 Jun 2022 10:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351632AbiFAKQE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Jun 2022 06:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351991AbiFAKQC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Jun 2022 06:16:02 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375D86AA74
        for <linux-serial@vger.kernel.org>; Wed,  1 Jun 2022 03:16:00 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c2so1498477edf.5
        for <linux-serial@vger.kernel.org>; Wed, 01 Jun 2022 03:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=l19XAZ4RQlB6J7TkjVOMmvipD7uiUl1NY4xv6/LugyI=;
        b=BtCIyFjN7SFARpIH1mnWAScPZAo/XJHoBZSi2HQQ7H83f88XfXLI/MeYvWG5YjOGez
         q8hrM8fnZplltFJ8MOqPvahGQWiFqMo+jgX0/eKYCSAlzbXiEOBkZ/Xs+9UJj3+dCAlR
         4+PnY1MSlS9esAdaRcE9nCR9J9JUnQ3jSYf97NA2Dw3NJ3I0WyGHJGJIEMdyqnOJ0H9E
         bXa4sJB7S/LusFzZBuAnmy8Z1k72D609NjRBnvVsityJqE+4PtcST5BiKZkMwEju4QCJ
         bLCtp5CXpJOQUQuceR7/5ipgBauLhhIZeuYEY6a/zfX/LzafUYE8w1vk3etCxbkkZhZn
         Rypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l19XAZ4RQlB6J7TkjVOMmvipD7uiUl1NY4xv6/LugyI=;
        b=bnJa2dRgBA4UjUvg8oGBfpC9LdMCrUUPwvJ5sNkfNCrGdZFdd+R/i4utGf87A6lhHW
         heQzTvfKx9EZQ6TAhYOY4LpIxDeMisidKkQAp33HdnMV0xuCQOYmt86FjwunQAqYBuhI
         VkAPv08ZtsOfTdkYOXQuZTdIXn0ffWLVil80MHax/DFeSz9rWRScg3xxXz+doayDcSZG
         PQ2PcGjQt5oJ5mc/8nTyLKVEkl/dlbk2vXNJusjzA7wz3BVC97N/60WFzl1nUVN6qAWF
         qFyD5b6ukJvl1PcwAn9z+UfYiZNVMST2rErf2ImzcG+8K43xbQLYv5/zFWQqiaMH2GsK
         p2Jg==
X-Gm-Message-State: AOAM532kbanhNUsGW3zaetvNS7d6CdH2L9It/mK27IJEZ2UQmJE56wST
        K4YBHCni7KlpQufW1w0eT1tAnw==
X-Google-Smtp-Source: ABdhPJwqLQ4Ui6MtgBlrktb1cmqeGlIiI3nvKGpc3MDfpcX9j7W/cB4tKjt/uwhPk3xrWT+HZr/CNw==
X-Received: by 2002:a05:6402:4410:b0:427:ab6f:a39a with SMTP id y16-20020a056402441000b00427ab6fa39amr69619893eda.120.1654078558779;
        Wed, 01 Jun 2022 03:15:58 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l15-20020a17090615cf00b006f3ef214dd9sm534351ejd.63.2022.06.01.03.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 03:15:58 -0700 (PDT)
Message-ID: <7f4c0956-7663-60fc-a603-fd40f0317a1b@linaro.org>
Date:   Wed, 1 Jun 2022 12:15:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 15/17] arm64: dts: mediatek: add mt6357 device-tree
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        qii.wang@mediatek.com, matthias.bgg@gmail.com, jic23@kernel.org,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, chunfeng.yun@mediatek.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20220531135026.238475-1-fparent@baylibre.com>
 <20220531135026.238475-16-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531135026.238475-16-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 31/05/2022 15:50, Fabien Parent wrote:
> Add device-tree for the MT6357 PMIC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt6357.dtsi | 272 +++++++++++++++++++++++
>  1 file changed, 272 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6357.dtsi
> 
(...)

> +
> +		mt6357rtc: mt6357rtc {

Generic node names, so "rtc".

> +			compatible = "mediatek,mt6357-rtc",
> +				     "mediatek,mt6358-rtc";
> +		};
> +
> +		mt6357keys: mt6357keys {

Generic node names.

> +			compatible = "mediatek,mt6357-keys";
> +		};
> +	};
> +};


Best regards,
Krzysztof
