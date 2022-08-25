Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4DDC28D13
	for <linux-serial@archiver.kernel.org>; Thu, 25 Aug 2022 06:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbiHYG6y (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 Aug 2022 02:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbiHYG6w (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Aug 2022 02:58:52 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3FCA1D2A
        for <linux-serial@vger.kernel.org>; Wed, 24 Aug 2022 23:58:51 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id s1so24195941lfp.6
        for <linux-serial@vger.kernel.org>; Wed, 24 Aug 2022 23:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ru9SpbqH38i+/HCULGGRRkwAB5xZGhAPPEBe8VIbuVY=;
        b=grbaP9d3L824VTVSPhpmGWtTulHg7jns+IAx4lpJsJOqyLymPeeFFU5dqLxIPNJwhJ
         024mT8CasogSt2BX33fxd3nik+37FvmstNMi02rolF4bz0tZJOVC4H0naYVwkieoN+o1
         A+oa31wiAe5yHC8o359JEwwkrxK9fvgtKNmb0cffoJXJJOWqpBhsJe4oST+eNSaaWbkB
         YOD3n4iLS21QNiA0DYteZp1Bc/y0yr9RuTbMG9S1j7CEPVagcsx0XCpQgLiTXCzpkCKN
         iT3tqDO/r/cxJ+e73ACO1brs02Rl/m4vRIgrkeg954zY71o8LAaTiO3Edu9+XcRTnGGy
         lqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ru9SpbqH38i+/HCULGGRRkwAB5xZGhAPPEBe8VIbuVY=;
        b=L/E5sHKPxJKgjZCmIKyNg59IkKJxuNpSv2yl1dyZZM7vX/bjMXBPz/eGV5XGhQ/y4m
         eKqttu/4KX7HYaRpy0dFqL1O9yTcEH3zOSOhOe8o/9kE3Trp0K1oD/E4R5/5rAowJH2n
         DhNGilJ9FvAAhY+p0pbVqTjYB8WtqhgiHQfQtBqlWd+W9MsQ/qYwHmqkbli8KSevRl/O
         BAnJOSFqDDsn2cqSJPBzBao4zhDdkJQqnbI79TYzE86oRnwEXb6Ak/+luZS5k3jb4shF
         LhSYIHx+g/wH61Wi1XUw3157bcqNLyoshdzT8SqzAOSryz4EDv2klVkAuN5CgBPFz0ll
         EHZw==
X-Gm-Message-State: ACgBeo0APpLFi7abvl+NZyyC1qaJ2uxCoBHhYDCACWwaSDnMrMNhS33I
        oUtvA3fbDS+p/to0zmQuNtl6MzcS76LmYR0ZU7s=
X-Google-Smtp-Source: AA6agR7EbTEOcaW559NfuYrmueSa1EcTuokes0+mBX/MzT3e/12MgVlIf1TsZJXwfRkZjD4TJC2VHw==
X-Received: by 2002:ac2:5d2c:0:b0:493:221:f011 with SMTP id i12-20020ac25d2c000000b004930221f011mr674330lfb.349.1661410729501;
        Wed, 24 Aug 2022 23:58:49 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id g5-20020a056512118500b00492f1755d8bsm327259lfr.243.2022.08.24.23.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 23:58:49 -0700 (PDT)
Message-ID: <bd3f90cd-865a-3119-c416-9654db0805da@linaro.org>
Date:   Thu, 25 Aug 2022 09:58:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] dt-bindings: serial: samsung: Add 'power-domains'
 property
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220823145649.3118479-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220823145649.3118479-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 23/08/2022 17:56, Rob Herring wrote:
> Some Samsung UARTs are in a power domain, so allow 'power-domains'
> property.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
