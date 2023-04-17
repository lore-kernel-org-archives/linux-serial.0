Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86D9C77B70
	for <linux-serial@archiver.kernel.org>; Mon, 17 Apr 2023 07:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjDQHkw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Apr 2023 03:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjDQHku (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Apr 2023 03:40:50 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5223A80
        for <linux-serial@vger.kernel.org>; Mon, 17 Apr 2023 00:40:24 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-504ea515d6fso4399135a12.1
        for <linux-serial@vger.kernel.org>; Mon, 17 Apr 2023 00:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681717220; x=1684309220;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jOuJf1Uk2XVzTeZs33zX+691srOKO1AbhUKqZP8jH3E=;
        b=bD/FFEpVwIhN3pNSBZp3oeHUq+WS77cAz7PD/ZDAxvCN2FFkuT1Md8xPhUGKe3V14h
         KG2U6A26i2gEjFiIYpxVVOSGJ6vCsoDHLqpw+wPcwir9uk39FZSJFROsp5b9vErKDybJ
         fd2qa2dKD/pu+lZohU/reF67C6eliqsk7s6AdMgse9o7usfrvfePAr840Ucb+9KBgMNF
         9MwSrl4L6QmFXSI53P5U/syh7tDQyfs8u+xFeKcV5EOZ3zJFkM+c6UkSUW089UdKRsUh
         Wfi98fwzrmg0JUXmrM9uIl+Z5LnhsqdhR9shJ27fNa+ELDg4kk6iYumtkPvGzyywYlyn
         WH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681717220; x=1684309220;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOuJf1Uk2XVzTeZs33zX+691srOKO1AbhUKqZP8jH3E=;
        b=j6BJVQcuNgr/AGzOtamEpLZQDC5DleS+Nno5GtDpP82a0L1N2J2om/s/Rygz0pv+3M
         hKFZJn7e0yduozsrcXOFVQ23JYaN+arlq/2EbEVQVM542gWpKsm8qQ0ubljYIuHk8JSP
         0dFzDhR1tUytfToYElcQDEn4k+T9/gIvpyeabHH/M0PT5DZJF23x14KO5RfRCQlAZB7s
         D/Hz+wNzSrdjLXXNby/X2t8WYJeEEZhS7f+ReXPz3e5JuW5ehHD02zp8V3Vq6hROdBlZ
         c14YXl/VnTUTXtlgJzUPb0SBc5bOBurHDBqLLMNnJVK3USvQK2db3SRYox7O5ZI8eAgL
         dMqA==
X-Gm-Message-State: AAQBX9fCrlIRWvldSRFrukuhee53A62Ok62xFzLE7jkvi4wgIn2pTjtu
        Sl48NjvO8Ay55TAy8QbH34/xwQ==
X-Google-Smtp-Source: AKy350Y85eczDG7Mw8aICC9OfwA8qtxoVQbiQnVpgM7S2lQj5ctUHXmf9vdwjdbGCteBPpkM0yTRwg==
X-Received: by 2002:a05:6402:1645:b0:506:8d35:40b7 with SMTP id s5-20020a056402164500b005068d3540b7mr7121155edx.8.1681717219986;
        Mon, 17 Apr 2023 00:40:19 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id c18-20020aa7c752000000b00501d73cfc86sm5527649eds.9.2023.04.17.00.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 00:40:19 -0700 (PDT)
Message-ID: <c240cbef-1d9e-dc1b-b619-c22dacf8d41f@linaro.org>
Date:   Mon, 17 Apr 2023 09:40:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V2 3/6] dt-bindings: imx-thermal: add imx6sll and imx6ul
 compatible
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        linux-imx@nxp.com, "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20230410205803.45853-1-stefan.wahren@i2se.com>
 <20230410205803.45853-4-stefan.wahren@i2se.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230410205803.45853-4-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 10/04/2023 22:58, Stefan Wahren wrote:
> Currently the dtbs_check for imx6 generates warnings like this:
> 
> ['fsl,imx6sll-tempmon', 'fsl,imx6sx-tempmon'] is too long
> 
> So add them to the devicetree binding.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

