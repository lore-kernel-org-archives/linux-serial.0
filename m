Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348D0C433FE
	for <linux-serial@archiver.kernel.org>; Fri, 22 Apr 2022 07:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386732AbiDVHT4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Apr 2022 03:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444657AbiDVHTy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Apr 2022 03:19:54 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342F350E34
        for <linux-serial@vger.kernel.org>; Fri, 22 Apr 2022 00:17:01 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l7so14636522ejn.2
        for <linux-serial@vger.kernel.org>; Fri, 22 Apr 2022 00:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kKzqFYULcaKbgHWS4pm8RBaixFS7n+6/vYUvELbma6o=;
        b=X5T5yN3xfhW0CQder3imIIGFrrjcK3Y6Es7wJHGpMRRQGT64qmbLdN+s473tScuOYX
         fVPPQk5NgCUd/BXhYOPXohHkApEDuDbazZopyQDl/kxEQkf0U9uQi+wa0O9GUBSeait5
         XOMSJtS3nprM5punmsUKhNqVprhZ0ucMAEwBFHzOJPEeT/6MrjmP2eegOfYEVjXIwlnf
         r/QoOA8HZk8NDayqV06u5zphUw2ycosjHFRYFDbjPgjetXJAbLE1S1q/LHJpUhzUqrzA
         Zxos7gpgYeibbTZrsYi1/yVwdgdlhNO8JHiN3FwqYF2+uo2vLjwDUPHFfYhTipkwwCJM
         IJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kKzqFYULcaKbgHWS4pm8RBaixFS7n+6/vYUvELbma6o=;
        b=XcdQgg/JNb1bGr6jo4Mc0m2nNqh6utNFA3sBahrIOF2X5qDTe5K0kpREqb1eZNpmFe
         VhVo1lbp0BmSdEbKCa7xY8d0QXP2G/miJwzLoxrPRBLiVl3qwPRlLslAxIE5vkHLTzYv
         zFHuzC5QzKOEtKxO6kLMXcnYeqhdFY2D5tAfHd+vw/wCaIaPu3g085kHpEwg5wNMgLDm
         icH4UlX6M9dkzzpolksImIWonRO3LrWtVU6evagPvUbom7jWv7KBFKcC195zSPbUtgUg
         rQL7F3JvsLvWZkrRqXdLXB3lN6naX0NJ0z4SFPO0ciddc23GcYogBbNzi2vJldOkb8AK
         B9YQ==
X-Gm-Message-State: AOAM532x3TusZ1l6BMgKiKuWWqFIiZ0IvczAeVLk7JAGf9hYq1DOjCZc
        1WE4qcY0r3WVv3HbhS8AkzaKWg==
X-Google-Smtp-Source: ABdhPJyaQK+LejRxdXC/EaYZE+04lv8g6ZxZaowwRLuHiGG3jXNYNdbPSmsEhAr8bx6Sdg9uV5VEPA==
X-Received: by 2002:a17:906:a08b:b0:6cf:65bc:e7de with SMTP id q11-20020a170906a08b00b006cf65bce7demr2978338ejy.220.1650611819709;
        Fri, 22 Apr 2022 00:16:59 -0700 (PDT)
Received: from [192.168.0.230] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x12-20020a170906710c00b006ef8f9ee226sm456452ejj.115.2022.04.22.00.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 00:16:59 -0700 (PDT)
Message-ID: <d953b4e8-4e0a-8a6d-16cf-1ea4e4bd0190@linaro.org>
Date:   Fri, 22 Apr 2022 09:16:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 07/15] dt-bindings: clock: Add r8a779g0 CPG Core Clock
 Definitions
Content-Language: en-US
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
References: <20220420084255.375700-1-yoshihiro.shimoda.uh@renesas.com>
 <20220420084255.375700-8-yoshihiro.shimoda.uh@renesas.com>
 <c86f78ac-ccf5-30ad-5de4-33211ca8b351@linaro.org>
 <TYBPR01MB5341D2CAB8DD77E95C14AF8CD8F79@TYBPR01MB5341.jpnprd01.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <TYBPR01MB5341D2CAB8DD77E95C14AF8CD8F79@TYBPR01MB5341.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 22/04/2022 07:32, Yoshihiro Shimoda wrote:
> Hello Krzysztof,
> 
>> From: Krzysztof Kozlowski, Sent: Thursday, April 21, 2022 4:49 PM
>>
>> On 20/04/2022 10:42, Yoshihiro Shimoda wrote:
>>> Add all Clock Pulse Generator Core Clock Outputs for the Renesas
>>> R-Car V4H (R8A779G0) SoC.
>>>
>>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>> ---
>>>  include/dt-bindings/clock/r8a779g0-cpg-mssr.h | 87 +++++++++++++++++++
>>>  1 file changed, 87 insertions(+)
>>>  create mode 100644 include/dt-bindings/clock/r8a779g0-cpg-mssr.h
>>>
>>> diff --git a/include/dt-bindings/clock/r8a779g0-cpg-mssr.h b/include/dt-bindings/clock/r8a779g0-cpg-mssr.h
>>> new file mode 100644
>>> index 000000000000..07a94cf45581
>>> --- /dev/null
>>> +++ b/include/dt-bindings/clock/r8a779g0-cpg-mssr.h
>>> @@ -0,0 +1,87 @@
>>> +/* SPDX-License-Identifier: (GPL-2.0 or MIT) */
>>
>> Any reason why not licensing it the same as bindings document
>> (GPL-2.0-only OR BSD-2-Clause)? The same applies to patch 5.
>>
>> MIT and BSD-2-clause are almost the same, AFAIR, so let's stick to one
>> (BSD-2-clause) for consistency?
> 
> Since r8a779g0.dtsi (which uses this) is under (GPL-2.0 or MIT), I use it here.
> Also, r8a779g0.dtsi includes dt-bindings/interrupt-controller/arm-gic.h and
> the arm-gic.h is under (GPL-2.0 or MIT). So, using it is better, IIUC.

This would mean we want to license the bindings the same as we license
the DTS. It's not the case. For the bindings we have the strong
preference - GPL-2.0 or BSD-2-clause. For the DTS - not that much, just
recommendation, I think.

> In other words, r8a779g0.dtsi doesn't include any the bindings document
> so that there is not needed to use the same license, I think.
> # I'm not a lawyer though...

If you would like to follow your recommendation, you should license also
schema as MIT, because your DTS uses it as well (as a derivative work).

Anyway MIT and BSD-2-c are very similar, so there is no much difference
here.


Best regards,
Krzysztof
