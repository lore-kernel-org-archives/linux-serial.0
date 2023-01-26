Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A01C61DA3
	for <linux-serial@archiver.kernel.org>; Thu, 26 Jan 2023 15:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjAZPEc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 26 Jan 2023 10:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjAZPEc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 Jan 2023 10:04:32 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4946B981
        for <linux-serial@vger.kernel.org>; Thu, 26 Jan 2023 07:04:30 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id w11so3395961lfu.11
        for <linux-serial@vger.kernel.org>; Thu, 26 Jan 2023 07:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=85g64dsl/DcFY/LlzFQvHEB0mO6DyTsjvCN0CbsFtNw=;
        b=RkiI+vwnnL7VCkolwfyJmz2pmhwyz1uPFgE9WrH3eTnJ0h1OjtfKBo3De8gNoeWD+X
         l3xRPZIq/L9vFJzv6PULtvhXKKJtDa9LLTd2AiHrb4BZ60JZC+IqDP/SwDQlwxNDg3Lu
         9JvSTWA0sLX1/2yvxrUmgT4h1TvymGWt7fVAn2xOTJDbbM8Feyi8EviAkCrynsKOph1z
         JlCZLF6rHye2m3z2r22q6SSNhTHJoseOKvgJklu5p9zXC51NgfsruhZVLFQ0SRjjMd8L
         sQonnT13MfN0mupzXLJTbk49qRIe8hctNAc3jWuKFq37gyG4sRWzTKJCqEAo/+pvSIr+
         DyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85g64dsl/DcFY/LlzFQvHEB0mO6DyTsjvCN0CbsFtNw=;
        b=iwEk4Q5MZG5yTtKUcV4lcvW0o7R9IqrUT1xxtJc5U5Bk4/1rT0VEoJWFlvsd6kZ7Af
         Ugll7xMnuI9/VjIH7CXH/mdDd9iYa6T0zWzR+uQq+fuABKxaev5Vie0RgpJItVQgyQu5
         F8f6RdNjpEY/94F0uhjLisiyZgCfnI1HpoStPdfNHUOdqUtbX41Bo5BcyYPJST5xwxW4
         J/rhG0F45JeESLNFm5+BSXsSO4j6Ra9NUyJurjzrBaBsPLnqQjXPdN9Mb5q5g9DC2xNc
         rqpu7MDmxAc/JFOrJ3PMBeKkCeNSdLi8RiuR77xMuIoZmh+u0UXX8FCQi1jZpmDtwM4e
         SJwA==
X-Gm-Message-State: AFqh2koru2VJs38Y7onEQHjJUoGP2Qq6vxX/FAt2UgRfpfrjFGFDHFzO
        CvV2wypoJF9Cjbo2a+hiJvFmWQ==
X-Google-Smtp-Source: AMrXdXu6eyBeVwquiscq6dc3oKOQoMKYuh59bv0ZswxZ5ffCDxH44vMaC4VrsM+OBs46fi7tYToQIA==
X-Received: by 2002:ac2:4f0c:0:b0:4ca:f887:fe99 with SMTP id k12-20020ac24f0c000000b004caf887fe99mr9661416lfr.25.1674745468435;
        Thu, 26 Jan 2023 07:04:28 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id p8-20020adff208000000b002423edd7e50sm1618824wro.32.2023.01.26.07.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 07:04:27 -0800 (PST)
Message-ID: <0a47dfbd-d786-c7bd-e4f5-c71e1b649b9f@linaro.org>
Date:   Thu, 26 Jan 2023 16:04:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v9 7/9] dt-bindings: timer: mediatek,mtk-timer: add MT8365
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tglx@linutronix.de,
        maz@kernel.org, lee@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, gregkh@linuxfoundation.org,
        chunfeng.yun@mediatek.com, angelogioacchino.delregno@collabora.com,
        nfraprado@collabora.com, allen-kh.cheng@mediatek.com,
        sean.wang@mediatek.com, zhiyong.tao@mediatek.com
References: <20230125143503.1015424-1-bero@baylibre.com>
 <20230125143503.1015424-8-bero@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230125143503.1015424-8-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 25/01/2023 15:35, Bernhard Rosenkränzer wrote:
> Add binding description for mediatek,mt8365-systimer
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

