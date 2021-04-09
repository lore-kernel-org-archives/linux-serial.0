Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CF6C433B4
	for <linux-serial@archiver.kernel.org>; Fri,  9 Apr 2021 17:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96DCC6115B
	for <linux-serial@archiver.kernel.org>; Fri,  9 Apr 2021 17:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbhDIRTk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 9 Apr 2021 13:19:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53838 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbhDIRTk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 9 Apr 2021 13:19:40 -0400
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lUun0-000887-Bl
        for linux-serial@vger.kernel.org; Fri, 09 Apr 2021 17:19:26 +0000
Received: by mail-wm1-f70.google.com with SMTP id y82-20020a1ce1550000b02901262158f1e9so769229wmg.8
        for <linux-serial@vger.kernel.org>; Fri, 09 Apr 2021 10:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MF7ir3WvrSx3fVs+kwq9HlQIkfNHtZbHStyjJVEI674=;
        b=t4iJZR2KaxP/JBvmDQwnflDd0GXK5UIsANpYCGWV0NT1JJ8Xyc31UMtdSq4ml20td9
         EKYYiyu/S2A9ecIgHAmVd5eX3zHkY1xnkHuRC8RG4/ySgpb7RlgnExD99UIaPx/VXGN2
         zgEOdrN7DX7nkBirEOUC+3ITXxZMsOET64i2F/2pnCagBC8A7Ap+T+XIzcdMInZHay78
         FdSHsBw/AMuID4VkcdeQ0FQxWEklxJ9YkZivr3Q44MzSMRaqSWENcol3uNlOPs1ciLC9
         MV7I5SgIikHH8Yp08gqKCqq5LJWLujvnVNoKgbZTYKtmJJysAVMr9SbZW75p3e0+YxZK
         iinw==
X-Gm-Message-State: AOAM530oL6jivbKJhLd/ld9/6P5mpuNWZiDBq7nZsTUubC88F6UwlGBj
        LwdgwKu/DMwEhpL0pTpaZrLICY9LxTBJQiCPkuJf97locb0AICpgGRUvjU+l8Iu0RTPA1tHzGMk
        /kd/aJxwa3sGnJYuwCv+RNlCjdHCIbFktkMNOOsLDaA==
X-Received: by 2002:a5d:6ad1:: with SMTP id u17mr18632732wrw.214.1617988766176;
        Fri, 09 Apr 2021 10:19:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoHmJCq+boBnAlfaIBVP5XJAn1stsfy3E4Yg3rVDRyUJcFf9LW6ZyaB9V9QoKKEjW3PrCWwQ==
X-Received: by 2002:a5d:6ad1:: with SMTP id u17mr18632724wrw.214.1617988766071;
        Fri, 09 Apr 2021 10:19:26 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id s83sm4841985wms.16.2021.04.09.10.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 10:19:25 -0700 (PDT)
Subject: Re: [PATCH v2] dt-bindings: serial: samsung: include generic dtschema
 to match bluetooth child
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210405172119.7484-1-krzysztof.kozlowski@canonical.com>
 <20210409160952.GA3737690@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <d4d90a42-8c18-2f5e-d77d-da006f9b108f@canonical.com>
Date:   Fri, 9 Apr 2021 19:19:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210409160952.GA3737690@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 09/04/2021 18:09, Rob Herring wrote:
> On Mon, Apr 05, 2021 at 07:21:19PM +0200, Krzysztof Kozlowski wrote:
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>>
>> Include the generic serial.yaml dtschema so the child node like
>> "bluetooh" will be properly matched:
> 
> typo
> 
>>
>>   arch/arm/boot/dts/exynos4210-universal_c210.dt.yaml:
>>     serial@13800000: 'bluetooth' does not match any of the regexes: 'pinctrl-[0-9]+'
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>
>> ---
>>
>> Changes since v1:
>> 1. Drop the new example, as Rob suggested.
>> ---
>>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Otherwise,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks, I'll send with fixed typo.

Best regards,
Krzysztof
