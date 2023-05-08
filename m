Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F966C77B75
	for <linux-serial@archiver.kernel.org>; Mon,  8 May 2023 06:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjEHGbk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 May 2023 02:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjEHGbj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 May 2023 02:31:39 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D961A11A
        for <linux-serial@vger.kernel.org>; Sun,  7 May 2023 23:31:09 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bd875398dso6290484a12.1
        for <linux-serial@vger.kernel.org>; Sun, 07 May 2023 23:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683527468; x=1686119468;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/OQ1Y1Dy1DcmXDOkFF4+nxsd0s1CfphsQW74olTDqGw=;
        b=K/w0jKgME2AOUJJRKDKulpIP5BE7fu316yYG2yR5ZiMAlp063cVXzESZRRRAMDM1GG
         GsP793uiIpYFthczfdKDGo8K4AzLs+UMJ0/NtCP5/4cfK+Q7tpBMXzjtYqid0BtySlbB
         q5FhM31BQTeEHEcA/IWnJL/ftQf6AGcNisNQNbwrIqZf2pqJCnEjKi1vhnhfQGniItZg
         s6s0WWp7NBfzwrocMErcUaHYuFfdJfBx82k3rOxlmNwE8MULZhmJ0jEoMG05Po/p4rrZ
         7C5CLCKbI34fRRtp5ddxW6ye0pmDaCoJ7xrcDNKoxqJigU+6I9EjmxhV2U0w8q2jBCYV
         o+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683527468; x=1686119468;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/OQ1Y1Dy1DcmXDOkFF4+nxsd0s1CfphsQW74olTDqGw=;
        b=ioIf3Zc626UFdelisGY+BWSuh44eLLduAr/b/Vn1CD+gvd0i4nqnvcVSgypQvaNotV
         R1pDiitAPxygRiJkfAp0BoLzZfFWQOSNsfGJlBFUBwvSRmCzGSbGa7sBIPFVl9CYS7YM
         TN+ZM7apUcJXZLPngGg7C+8v435wRN7LYuO2QCldoT1C6ShSbXCFq6qqpd5Zbsg0f2g5
         cKRaO/B91CVGhjco5ZzPMOynjtltIW7ZZ7vimOlFewKNf5dnLSbgDf2NaLIXrWRbN711
         ynxebOCs2NKMsBy0VnkhGjtLnv8IuoA4MFee7LaIoCm8xMG57b90lsX3T+joamzmDDSx
         3+eA==
X-Gm-Message-State: AC+VfDw6YbCjKL+WZi1GS+5624ZWRSGX6PYNpJtfQmfL9dfsCv875deL
        NesxR8UJlTtbgUF9kOeGPlhsAA==
X-Google-Smtp-Source: ACHHUZ5Ej9KOXTs2EAx/CHeY+tmJXILRqG31KllqiRtW3HMLq46+8Gb6Tsjesrbj2kRrYN64WAhpRQ==
X-Received: by 2002:aa7:c991:0:b0:50d:88f3:2e30 with SMTP id c17-20020aa7c991000000b0050d88f32e30mr5953819edt.13.1683527467870;
        Sun, 07 May 2023 23:31:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id i5-20020aa7c705000000b0050673b13b58sm5690029edq.56.2023.05.07.23.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 23:31:07 -0700 (PDT)
Message-ID: <65914d45-95fb-9b44-daf2-5885ba62a180@linaro.org>
Date:   Mon, 8 May 2023 08:31:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v10 06/10] dt-bindings: serial: Document ma35d1 uart
 controller
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Jacky Huang <ychuang570808@gmail.com>
Cc:     p.zabel@pengutronix.de, arnd@arndb.de, jirislaby@kernel.org,
        schung@nuvoton.com, tmaimon77@gmail.com,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, sboyd@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, will@kernel.org,
        Jacky Huang <ychuang3@nuvoton.com>, lee@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        mjchen@nuvoton.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230508025936.36776-1-ychuang570808@gmail.com>
 <20230508025936.36776-7-ychuang570808@gmail.com>
 <168351638748.4154745.16515916544783600377.robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <168351638748.4154745.16515916544783600377.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 08/05/2023 05:26, Rob Herring wrote:
> 
> On Mon, 08 May 2023 02:59:32 +0000, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Add documentation that describes the nuvoton ma35d1 UART driver bindings.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../serial/nuvoton,ma35d1-serial.yaml         | 48 +++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.example.dtb: camera-sensor@3c: port:endpoint:data-lanes: [[1]] is too short
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.example.dts:25:18: fatal error: dt-bindings/clock/nuvoton,ma35d1-clk.h: No such file or directory
>    25 |         #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.example.dtb] Error 1

This however is related, although might be coming from earlier failure.
I assume you run the check and you do not see any errors?

Best regards,
Krzysztof

