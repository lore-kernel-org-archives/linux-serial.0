Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AFEC43217
	for <linux-serial@archiver.kernel.org>; Sat,  2 Apr 2022 20:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345874AbiDBUkW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 2 Apr 2022 16:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343922AbiDBUkV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 2 Apr 2022 16:40:21 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E53DE28
        for <linux-serial@vger.kernel.org>; Sat,  2 Apr 2022 13:38:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h4so8798574wrc.13
        for <linux-serial@vger.kernel.org>; Sat, 02 Apr 2022 13:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DaSE7ULJOB4VxQX7AgKGqYahg9TkFoibRaqDkyl52xM=;
        b=Nf/J8rLvBLHtIWMts7FPOG5zve1MCpb0B3B8dIoRxKi5I2F4fU6dATO2UbdJGeJwCh
         V7tTCd4GVXYUquBf/em/Ze1vUYOQ2hPO7gDrGPtUmofvbWHebSmDtD/JlIqUm76evwEW
         ZIIAtxKyca/gO7VmLeOvvUiVCBp+MPneZBZdPqRlp/V40fC9tG/rpyuSILddgym8/G/T
         eawyfTOThuK00gLrCvj6sKXMdJ0PUDlyRssa3kBXRA2U7eHCWt5m+5CKM6uXa9RGhSjx
         bwZEXHmy98jDfNtwey8NgXmdZS9R9XnF/qY0wYtRzTGP3wp4JrxZiwpQPlQkDet6VXVY
         MaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DaSE7ULJOB4VxQX7AgKGqYahg9TkFoibRaqDkyl52xM=;
        b=8DB+dLI0yOlvJjD0kmxrOLY5+WC2Pu8gp9xHPbVfgK514J9P5ga1M7ynTdGRKNySwx
         aXoYWHaYSL+HS2f94IfG+ZqHE+suZGLD3pgOCwSkpCEgaQQQonvcIBIBz7ZZe0QqsEXI
         u7wlHLpswJGRD2FM90VSpX1TPDWjh4uPpkkQfzyCI7uP+dH8SxHkl6vdV1/QK/Wm3oRK
         Gmpe0FIhYed9PPabowclpoHh596kZHNf3mNzBYjDGmhRAjXzWRqgB83YAGwgNRlvUwd6
         uxxSFFbDJ2J8XPciYonC95N/7ORdZ8o4DZFzmVESYd7383Z6+XDQQwjyh1ebkWf45o5x
         sADA==
X-Gm-Message-State: AOAM5337e71IH/BoKNo2b2eCY4vPlSC9nOuSicScbf1foVhgdh88cbw9
        oK2tYNsyrbcZ0pVd+h7pw9sHAA==
X-Google-Smtp-Source: ABdhPJxlZFShJSotZ4ap67uraKENWXMz9kwuTh/ClWcepN0MdbvmowjSzVO+TUQHaBz+xPYi+v0T7A==
X-Received: by 2002:a5d:6944:0:b0:203:e024:7cdd with SMTP id r4-20020a5d6944000000b00203e0247cddmr11838810wrw.503.1648931905090;
        Sat, 02 Apr 2022 13:38:25 -0700 (PDT)
Received: from [192.168.0.171] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c3b0800b0038cc8f116d3sm13112262wms.44.2022.04.02.13.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 13:38:24 -0700 (PDT)
Message-ID: <9a584eac-6ac9-e4ed-ef90-49569f4a4baa@linaro.org>
Date:   Sat, 2 Apr 2022 22:38:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 9/9] dt-bindings: qcom: qcom,gsbi: convert to dtschema
Content-Language: en-US
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org
References: <20220402184011.132465-1-krzysztof.kozlowski@linaro.org>
 <20220402184011.132465-10-krzysztof.kozlowski@linaro.org>
 <20220402202917.GA36054@9a2d8922b8f1>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220402202917.GA36054@9a2d8922b8f1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 02/04/2022 22:29, Kuldeep Singh wrote:
> On Sat, Apr 02, 2022 at 08:40:11PM +0200, Krzysztof Kozlowski wrote:
>> Convert the Qualcomm General Serial Bus Interface (GSBI) to DT
>> Schema.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../bindings/soc/qcom/qcom,gsbi.txt           |  87 ------------
>>  .../bindings/soc/qcom/qcom,gsbi.yaml          | 133 ++++++++++++++++++
>>  2 files changed, 133 insertions(+), 87 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,gsbi.txt
>>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,gsbi.yaml
> 
> Great initiative to convert everything in one go!
> 
> [...]
> 
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,gsbi.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,gsbi.yaml
>> new file mode 100644
>> index 000000000000..b97e359f3f90
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,gsbi.yaml
>> @@ -0,0 +1,133 @@
>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/soc/qcom/qcom,gsbi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm General Serial Bus Interface (GSBI)
>> +
>> +maintainers:
>> +  - Andy Gross <agross@kernel.org>
>> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> +
>> +description:
>> +  The GSBI controller is modeled as a node with zero or more child nodes, each
>> +  representing a serial sub-node device that is mux'd as part of the GSBI
>> +  configuration settings.  The mode setting will govern the input/output mode
>> +  of the 4 GSBI IOs.
>> +
>> +  A GSBI controller node can contain 0 or more child nodes representing serial
>> +  devices.  These serial devices can be a QCOM UART, I2C controller, spi
>> +  controller, or some combination of aforementioned devices.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,gsbi-v1.0.0
> 
> Only 1 entry? const.

v1.0.0 looks like there could be some more, although they did not reach
mainline. The GSBI seems to be replaced by different blocks, so maybe
there will be no new entries here.


Best regards,
Krzysztof
