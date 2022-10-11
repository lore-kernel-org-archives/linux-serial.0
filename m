Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87458C433FE
	for <linux-serial@archiver.kernel.org>; Tue, 11 Oct 2022 12:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJKMIY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 Oct 2022 08:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJKMIW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Oct 2022 08:08:22 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CDE51A03
        for <linux-serial@vger.kernel.org>; Tue, 11 Oct 2022 05:08:20 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id z8so3539846qtv.5
        for <linux-serial@vger.kernel.org>; Tue, 11 Oct 2022 05:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d7sQGgcfeLetHsYqqAQzwhlkQO31idzHL2CtdWtj7pI=;
        b=fFpMQBJU+KIup5rqPl5HSkr/RGGMV7irnqdmJssu6pEBstzv0l8cg2Yyh4W0MSrMjS
         1UHEW48g9iVzieWXgwHcY2sYLOt8PGh7CZUX15ojxeZ8yjvBxSHv2WSDFYFUduWYP9nw
         FCg96WFT2ulQ3hmp+VnOAjxmLC62pNPaUoyRZaduPPyWuVZSCJxfQDpFWFu7r13xNirS
         IKWsSZyCLPIsSGgpTaS94qvR6G4n+kY0wFKw9Gg0jspinDQ/WolzwqymbY8U1sloEBA9
         A+IPAE5NrQeJUa3snTIDBFMzGx3H7TLwRCa6tpNRmjgaH4XwOlPnKAepUx7845XuTUAP
         2G7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d7sQGgcfeLetHsYqqAQzwhlkQO31idzHL2CtdWtj7pI=;
        b=6smvt5dFJNRjU2sqnqTKyaEhjW9nr24Y5OqfsDyXgh3Lr/8zodNcHXBwcCn5kadVxa
         t8KkvcsKiNTe489d5acBiVrtXLdmANRtCsFzgd5CFUCzuISzwgOlUkwtJ4PbPXpi76U6
         8ofVoiYgs6QO+D0MeHYjRyJeP5wO+eU5fCZMB9mmryFjiZQIh0An37LLWvEbwXOmP/EK
         JLiF3qdeDLH9Q5DxITdDK+7OI06vcDM0hOtUBGU2erKDExP8c+Hynx6XOu/y5eMS2nGn
         Po2eI4cijbFCptCQ3Ufx4lBsPD4WHe/pjaDo0tWf7tfKdvlUTVnhuE3Rb992XIEwkoFu
         4f3w==
X-Gm-Message-State: ACrzQf3uWjA+799IqHhKCeYKkO0MT2Q3H76Rz8/nQN7Kj4whyRi4Lp5h
        UyL+6CX01nuzlAjAJW4Q9FxF8w==
X-Google-Smtp-Source: AMsMyM4eGhDDIfVAL6kaolpL8+jGYieCca2y9hJwcftMhjyac5scT6NHJ1gngHvyVO3MwMBzC9Cc2A==
X-Received: by 2002:ac8:7f93:0:b0:35b:bbdd:5699 with SMTP id z19-20020ac87f93000000b0035bbbdd5699mr18616407qtj.46.1665490099267;
        Tue, 11 Oct 2022 05:08:19 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id c2-20020ac87dc2000000b0039a8b075248sm3987764qte.14.2022.10.11.05.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 05:08:18 -0700 (PDT)
Message-ID: <e64594f9-e5dc-9a79-8240-fa0e749b9655@linaro.org>
Date:   Tue, 11 Oct 2022 08:08:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 1/8] dt-bindings: ingenic: Add support for the JZ4755 SoC
Content-Language: en-US
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20221009181338.2896660-1-lis8215@gmail.com>
 <20221009181338.2896660-2-lis8215@gmail.com>
 <84b6dae0-d503-bbd2-d483-80462917afa4@linaro.org>
 <CAKNVLfZmjfmKb5ybY8NDhV-bQCQn7o_bSVK=aM4byftasW6dLg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAKNVLfZmjfmKb5ybY8NDhV-bQCQn7o_bSVK=aM4byftasW6dLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 10/10/2022 16:18, Siarhei Volkau wrote:
> пн, 10 окт. 2022 г. в 17:55, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>:
> 
>> How do you plan to merge it? Usually these go via subsystem trees...
> 
> It's a new case for me, could you explain the problem a bit more?
> What things should I bother with in the next patchset version?
> Thanks in advance.

Each binding goes via subsystem maintainer, not via DT bindings tree, so
keeping all in one patch messes with that.

Best regards,
Krzysztof

