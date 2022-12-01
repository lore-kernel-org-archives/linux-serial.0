Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D494BC4708C
	for <linux-serial@archiver.kernel.org>; Thu,  1 Dec 2022 11:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiLALmM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 1 Dec 2022 06:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiLALlz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Dec 2022 06:41:55 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE1F983B7
        for <linux-serial@vger.kernel.org>; Thu,  1 Dec 2022 03:41:52 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bp15so2036552lfb.13
        for <linux-serial@vger.kernel.org>; Thu, 01 Dec 2022 03:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0UiAnxiG5gru9IeukT0uPFqmufGik114HWN4x39w6FA=;
        b=zopg1txRN5QgqaXfvugj89RD4LqFxqoqVjHWRsqgKB0npSUazcU7D9c2uZ9eF+aBjn
         YF6qfci1wHSt4AFzDdaT6TP9OhQ3Mdaza3DpmSV5hpIUekk3KR80oodi3SN9yWI5tGS6
         BuQ4A1vklebhvhifCHCdZnMSoSeCWvFM/Ob8qdlXPxy4zsG7kk5g+VQP3o6YbOTvD/iZ
         2WoTXkrwVdgV3weLjEU6HWVghtCCvmbFUyO94sTViyHwjHW1koa5iH6wuV0IKiROfrwq
         tf+I6a/cjSMNzM9dEX7KO+nfOz8/O/3aZxCS+RhXktnqnxBEzb01V5YJ95RsD8VHUo5a
         Jrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0UiAnxiG5gru9IeukT0uPFqmufGik114HWN4x39w6FA=;
        b=NEDpLRldNHWOLJwr69R9sXKZeFi879jZLxqHlBxjDJ4h5xUsOdlhZ9WBntiwOidXdR
         bawaUTNlSZc64NJVI97gWxWkSxaVXt4msCeaFa0TMEkcPiw1htvLZN62dJvRxwOPcJKA
         1Kwx6HzImxCnBy5CPYWdAbYtfpCxO88z6eolnCa+2SGiLunDerpN28FPhIpgQ4tz3WzG
         edmtnoR6QGzC/8mbN0nMWCSimHEk3gFV1yi6CGXmMyWQqicK4vxZ1lRy+VprXPO2EEQR
         rIt0xQHiJmD7M8Dk3XgNYgLmtmkEgBSTbDI6tovQyjY1lhnQmz+hEL4FhJaZwBdmhLlr
         e1ew==
X-Gm-Message-State: ANoB5pnwnFq7TIFT1tXM9TCbCFN88XQIjwJlWbny+8xDh9fs9fZvgbcl
        eRPd5+KDN+4p5BTaZy3T7EgsXw==
X-Google-Smtp-Source: AA0mqf5NJwSDFJVZ4ee0obiZShaUI/uPkLiEO75TR/uSDPOAHIZkEPvJJ1JC3LaLkJUeMh2M4XFoqQ==
X-Received: by 2002:a05:6512:a83:b0:4aa:f944:f7ec with SMTP id m3-20020a0565120a8300b004aaf944f7ecmr17809472lfu.467.1669894910308;
        Thu, 01 Dec 2022 03:41:50 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w10-20020a05651234ca00b0048a8c907fe9sm612837lfr.167.2022.12.01.03.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 03:41:47 -0800 (PST)
Message-ID: <a1d8197e-33fa-e853-ab73-81b167ec45ec@linaro.org>
Date:   Thu, 1 Dec 2022 12:41:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 5/9] dt-bindings: riscv: Add bouffalolab bl808 board
 compatibles
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-6-jszhang@kernel.org>
 <60991459-945f-35db-f26a-fb27824728ad@linaro.org> <Y4iMrKjLAHpkCygo@wendy>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y4iMrKjLAHpkCygo@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 01/12/2022 12:14, Conor Dooley wrote:
> Hey Krzysztof,
> 
> On Thu, Dec 01, 2022 at 12:05:04PM +0100, Krzysztof Kozlowski wrote:
>> On 27/11/2022 14:24, Jisheng Zhang wrote:
>>> Several SoMs and boards are available that feature the Bouffalolab
>>> bl808 SoC. Document the compatible strings.
>>>
>>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>>> ---
>>>  .../bindings/riscv/bouffalolab.yaml           | 34 +++++++++++++++++++
>>>  1 file changed, 34 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/riscv/bouffalolab.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/riscv/bouffalolab.yaml b/Documentation/devicetree/bindings/riscv/bouffalolab.yaml
>>> new file mode 100644
>>> index 000000000000..91ca9dbdc798
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/riscv/bouffalolab.yaml
>>> @@ -0,0 +1,34 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/riscv/bouffalolab.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Bouffalo Lab Technology SoC-based boards
>>> +
>>> +maintainers:
>>> +  - Jisheng Zhang <jszhang@kernel.org>
>>> +
>>> +description:
>>> +  Bouffalo Lab Technology SoC-based boards
>>> +
>>> +properties:
>>> +  $nodename:
>>> +    const: '/'
>>> +  compatible:
>>> +    oneOf:
>>> +      - description: Sipeed M1s SoM:
>>> +        items:
>>> +          - const: sipeed,m1s
>>> +          - const: bouffalolab,bl808
>>
>> I don't think that SoM is usable alone. It always needs a carrier, so
>> drop this entry.
> 
> For my own information, if a SoM is not capable of functioning without a
> carrier there is no merit in it having a compatible?
> Does this also apply if there are multiple possible carriers from
> different vendors?

Compatible makes sense anyway. There will be different boards using this
SoM (not only carriers, but final products) and they all will have
common piece - the SoM. It's the same for other SoM designs (e.g. for iMX).

Best regards,
Krzysztof

