Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E56EC6FD19
	for <linux-serial@archiver.kernel.org>; Thu, 16 Mar 2023 07:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjCPHlg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Mar 2023 03:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCPHlf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Mar 2023 03:41:35 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959B662FDA
        for <linux-serial@vger.kernel.org>; Thu, 16 Mar 2023 00:41:33 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cn21so4160867edb.0
        for <linux-serial@vger.kernel.org>; Thu, 16 Mar 2023 00:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678952492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XCV529IEFhOmH3m3tRLWovg4tOpr2dMEgtJqbgkXqcs=;
        b=Zh18Vhp9rRhuMnAdTRrIcDIIzYh75ZfoWJsOngYCj42MDqfyGGnjV7lukJCgbQXyZq
         HGwfRYbGtUyUOaf+1UwoFbSweza4SF75Ef9589dBDRu1svt33CbziVQzAFDdPCbxfB/B
         ZYJPq+Tq8IwEveRf4e+XaxEUVCaHOEGwlomdED4uLsJO9MCXEyb8TUHO5LJ/1b2cCwrW
         AL/3dq/4CKtelS5gLvQpTQgGYJZR3Z+6CHqStv3HD1prdbsmeEU9bVeaY6fR0hP027uv
         pyoy1D2gzjz8VGuhP2oaDT2UndxD0TaMK5rG7F4j4URU8AZNaGj9//K1PCOMNGnJMabC
         hQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678952492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCV529IEFhOmH3m3tRLWovg4tOpr2dMEgtJqbgkXqcs=;
        b=pnhnxBnfk+gicv3DkIVmtZZtsZYpjJuufNDQyFuLkI0JlQslq+PUmKw1CwOUzEzkgh
         uVKFTH/PvCm/kCwqJwuCI77MpcFLzWijw1Ei3RbluDTqgc9g8gIrNeHXuh/LSqnw8fA3
         RyULg6tcPG72e9tMfqPRpROThclF2EiyM758dse49QVYIKU/uSNrPnfvESnYZwnsGrFu
         KNLwK0s+rizJdTuAghnBaheespPRfBmFyRkIGp0OX9t7ZekyjQaUXwpx+LPWqtRqsriq
         xXJa+nnukTWvS8YoxqWmwXRJ7pnqxi/B2ByTXb7pgyHH2oSd3Yl88CBzA2fuzbAwtL70
         mcYg==
X-Gm-Message-State: AO0yUKWBceTjhA1Nbluq2rtn6MZBOZpT1HlghzTUwZ3TIjX2iN+yzHhk
        hvX5U7aKt8rfcsgJSrOvu+iUCA==
X-Google-Smtp-Source: AK7set8f+C9O7FsbN4HnAGvrgGlK53j0Xbu6YDpcKfnAWsMyEJ9QMgkFyAalrVsK/WcThwVpGGydiw==
X-Received: by 2002:a17:906:ca02:b0:88a:2e57:9813 with SMTP id jt2-20020a170906ca0200b0088a2e579813mr8861398ejb.33.1678952492093;
        Thu, 16 Mar 2023 00:41:32 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id u14-20020a50a40e000000b004bbb691a334sm3482118edb.2.2023.03.16.00.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 00:41:31 -0700 (PDT)
Message-ID: <162c92f9-cf57-678e-1331-fe32d87c38d0@linaro.org>
Date:   Thu, 16 Mar 2023 08:41:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 00/15] Introduce Nuvoton ma35d1 SoC
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315072902.9298-1-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 15/03/2023 08:28, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> This patchset adds initial support for the Nuvoton ma35d1 SoC, including
> initial device tree, clock driver, reset driver, and serial driver.
> 
> This patchset cover letter is based from the initial support for Nuvoton
> ma35d1 to keep tracking the version history.
> 

To maintainers: patches should not be applied independently because it
will start failing tests...

Best regards,
Krzysztof

