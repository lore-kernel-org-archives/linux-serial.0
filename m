Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0DAC761A6
	for <linux-serial@archiver.kernel.org>; Fri, 31 Mar 2023 20:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjCaUBD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 31 Mar 2023 16:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjCaUAo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 Mar 2023 16:00:44 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6E125571
        for <linux-serial@vger.kernel.org>; Fri, 31 Mar 2023 13:00:11 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id b6so4227469ljr.1
        for <linux-serial@vger.kernel.org>; Fri, 31 Mar 2023 13:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680292806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5WRlDF1f+RCLCDuo7Nfqb1nCqlJyXHPq1o27PEf7SPE=;
        b=NokzOMs9ypNdf54DrpoI1sz7OzAWoQZgpz2r0YXMSaZrlGMBk/M975gm5UwGJHOBrZ
         9MeNzr3klGRPVzh53J2K+cDaicAXw1hbm0z+beUEpRNmqi8EZEnrN4rtHdC2sCb297Ma
         8HdFIFr72y8Et/v6fjgxMsVx6TX1ahEh8zhk4RARPFilLlY3S6VId94pLMH20AXrY30z
         az9boddNIbb7Z90edpbV7Il/fMsMkJHsR8Ml+aRen5OdD5ZxzlFkAEH/mrQ7kk0BMRWQ
         sZJLI+A4mzpPduWmlvSpafz8Q6D3bvfXq2tgc+u7xVEb9QfyugAzXyumQHxTdhchLset
         9bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680292806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WRlDF1f+RCLCDuo7Nfqb1nCqlJyXHPq1o27PEf7SPE=;
        b=mCdW3sjbzbAUcD2ubPKDh+Ca2Vl+f07630jjXhV3rAEXyqLNXhZ9ibltMRnn4X8hqQ
         EO5R87qOvhEILUXqKBwjmf/u+7uD/um9sys54vqUINx1QtMlErnYcEs/gNsfh9BMIvVg
         HOBDwvQ/Rc/jf2Xi0kLDazzMBQcwPfwEdQ1DXK4mLeXVJ57aXz5VJBibLG5zG1wZqXQ6
         lmaByDz/DI/T15yKrE/qWGFoUuky3d4rwLNSC9pKZJTunUI9lTljsobWpL60UadqjWpA
         m05P3haRA1rSIAXpcaSgpLsNb57IURUEH0nUSHFYcNeGLjkS2diac+uOHM1fHbgFzG0T
         +s4g==
X-Gm-Message-State: AAQBX9fTZbUj4UerSLRe0xDu8WhzqKtEVesljDa+4Bx5Jv88qfSqECYZ
        reKFF2FN+4i5d7Cf+edkhQDI9Q==
X-Google-Smtp-Source: AKy350aSM2VSOwLxTJJjuHgN7ck0iL6bvz9jdioxcllAtJLs/0g5hoqbSCrMJ8d/FlfuNELYKiqdlw==
X-Received: by 2002:a2e:9bcf:0:b0:29e:a3a0:ee2f with SMTP id w15-20020a2e9bcf000000b0029ea3a0ee2fmr8134125ljj.30.1680292806126;
        Fri, 31 Mar 2023 13:00:06 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z6-20020a2e8e86000000b002a06cebd555sm495914ljk.75.2023.03.31.13.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 13:00:05 -0700 (PDT)
Message-ID: <423085ec-95d8-377f-39cb-58836ab724ec@linaro.org>
Date:   Fri, 31 Mar 2023 22:00:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH tty-next 1/2] dt-bindings: serial: ni,ni16650: add
 bindings
To:     Brenda Streiff <brenda.streiff@ni.com>
Cc:     Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230329154235.615349-1-brenda.streiff@ni.com>
 <20230329154235.615349-2-brenda.streiff@ni.com>
 <9cd03cb0-0924-3431-8fe3-4d5f4a27b1a1@linaro.org>
 <b47c51dc-a4c3-ed7b-65ae-3938971f453b@ni.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b47c51dc-a4c3-ed7b-65ae-3938971f453b@ni.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 31/03/2023 19:59, Brenda Streiff wrote:
> 
> 
> On 3/30/23 02:28, Krzysztof Kozlowski wrote
>>> +      - enum:
>>> +          - ni,ni16550
>>
>> As Rob pointed out - you did not test it at all.
>>
> 
> I did, with dt-schema 2023.1 and the 'make dt_binding_check' command as
> described in Documentation/devicetree/bindings/writing-schema.rst
> (with no DT_CHECKER_FLAGS, because I was unaware of it until Rob's post)

No need to use it...

> 
> Is this a documentation gap, or is the DT_CHECKER_FLAGS option slated to
> become the default for 'make dt_binding_check' in the future?

You shouldn't need any flags. Regular testing shows errors:

ni,ni16550.example.dtb: serial@80000000: compatible: 'oneOf' conditional
failed, one must be fixed:
	['ni,ni16550', 'ns16550a'] is too long
	['ni,ni16550', 'ns16550a'] is too short


Best regards,
Krzysztof

