Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24744C433F5
	for <linux-serial@archiver.kernel.org>; Wed, 30 Mar 2022 08:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244194AbiC3ISt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 30 Mar 2022 04:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244212AbiC3ISs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 30 Mar 2022 04:18:48 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCDA21267
        for <linux-serial@vger.kernel.org>; Wed, 30 Mar 2022 01:17:00 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 5so34454370lfp.1
        for <linux-serial@vger.kernel.org>; Wed, 30 Mar 2022 01:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=M32C2MHJpxfv0C/rKIvNbWiRzkrTOQet2nkeXJtQzo0=;
        b=t9OAHmAFXejxXd/ABsEtkYmuhHgDTwLbTCfevdiYo0MasX/W4Y46/gP0+rZeUkxmdC
         dS5ElpGzDz7LVOreWpTiEHK9fMNj2+oARBc8IRc/n8r1xslr+8TSuUawqnqc1DOPUm03
         CK5eaZoH4W3sQOh0oN1PWyYR/ZZtbOXDBeIPYSBW72I1QOb24D1JZy4ug/FeS9NwjPHu
         8ajhDwHgSH+fjKntg393D4uOBL3kLfbkYgjClBIqObYX+4gyEPW/uIQSgLhRJ39M+7m9
         tDdT1z/Rk7wDig/QVWl4ianWvWELewIYqOzzYLdfALAmTyJTX/cCnyhxsTGKDis3Z1t+
         iglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M32C2MHJpxfv0C/rKIvNbWiRzkrTOQet2nkeXJtQzo0=;
        b=2wmyDhMBxNraER81K9bcgVDrkbxc74xvGW8SMuMxfWBTMAxW0e8FljxcWUBHHsqu9L
         vCajJ6AfE9tqRYrFs7tes0Ev9nCOK+gQ9gIqm25tnNyi8cgJbl7HLczunTfnP+EsM7ag
         m63JQbIk52rmgkvgRcNuGDvyqA4NwF951H70fK4p6wDyigbzAxk8MBCvPcgEMoYeoFro
         3SwNFC+QI61ItJ4U628I9ZZKbqv/620kaMdBxLU/JmYTs8FiVTbJLLDOBtIATCUEBN3B
         lj6856bIG//M3r822P//AR1I6DgrPuqF6Cj1rf5/qlganFSnQqjt/B10xw8rC5D3eMll
         k6GA==
X-Gm-Message-State: AOAM530WN/EyceONCqpe8t+/6VICCZXDE1nREezQDrloIyuziIzCqchB
        kEBUEOKdR1wRal0tfOaNIDKUi8NjduSVWXS/
X-Google-Smtp-Source: ABdhPJyTFIiM6MpxCMpjaTZ6/DzmmysJPS4k5E+NlHAafGVlbwGJmW82547Bn11svVa6TmJUro3aZw==
X-Received: by 2002:a17:906:a0ce:b0:6d1:cb30:3b3b with SMTP id bh14-20020a170906a0ce00b006d1cb303b3bmr38128430ejb.582.1648628207357;
        Wed, 30 Mar 2022 01:16:47 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id m20-20020a056402431400b00419315cc3e2sm9619545edc.61.2022.03.30.01.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 01:16:46 -0700 (PDT)
Message-ID: <d75fa410-db8d-eeed-5ace-ac88dce81610@linaro.org>
Date:   Wed, 30 Mar 2022 10:16:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] dt-bindings: serial: uniphier: Add "resets"
 property as optional
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1648617338-8600-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1648617338-8600-3-git-send-email-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1648617338-8600-3-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 30/03/2022 07:15, Kunihiko Hayashi wrote:
> UniPhier UART controller has a reset lines from system controller.
> Add "resets" property to fix the following warning.
> 
>   uniphier-ld11-global.dtb: serial@54006800: 'resets' does not match any of the regexes: 'pinctrl-[0-9]+'
>       From schema: Documentation/devicetree/bindings/serial/socionext,uniphier-uart.yaml
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/serial/socionext,uniphier-uart.yaml    | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
