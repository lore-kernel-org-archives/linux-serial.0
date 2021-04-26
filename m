Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD14AC433ED
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 06:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A606E61158
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 06:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhDZG6h (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 02:58:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39200 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbhDZG6h (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 02:58:37 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lavBr-0002Np-TK
        for linux-serial@vger.kernel.org; Mon, 26 Apr 2021 06:57:55 +0000
Received: by mail-ed1-f70.google.com with SMTP id y10-20020a50f1ca0000b0290382d654f75eso22465926edl.1
        for <linux-serial@vger.kernel.org>; Sun, 25 Apr 2021 23:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PiG26S9A4Ma4PvZG6HA23/0O0KeK876dtgY3zEwCBlk=;
        b=YfUJVlbstFH9eOwGAUje4FI5wbrk0KJKdF9eMArYw1uumk9qkJywgCgxBTJR8Ysz4w
         ehcmhCtXO+XIdheBf2hNUiAAygTHxztUq1sy+pjjWZM5VdvxEgKrplBlHjjZERagjfBQ
         qUPAgwhRzxMQvurv9dYWOZlaVpjOppFnGUQi41CJ2vqnrXl25C0G0u57g5s5YzC0f0PX
         e9pkK3iupqHJYtmK+MMqMOUJd7xW271EzyFBf0yEf8xy1lQOQaICGC2HyKkWd6mUdKjR
         La0YSL+VaDdQ0GVH3t4i1GwWsR6K73s83700HWbKKpA9WMZfY+CmuJ/a1t3efPICtatT
         lM+Q==
X-Gm-Message-State: AOAM532LXR0b9bd26c67MP492sva68zIZ60kLegadyotzZ9y+bD/INwk
        f0wNoSu78PpebXEwR94kXOttC6T+5E8Hh2uxLpA3N7iK0nwY7T04FcdVrYo4FywcQNW0p+x4mZc
        7SrcOb7RNaccxycJWXrdnjTG7WKFUmP0Lraof5gvEdw==
X-Received: by 2002:a17:907:100e:: with SMTP id ox14mr1263421ejb.484.1619420275259;
        Sun, 25 Apr 2021 23:57:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwO835Xk+2TvPHEBM/z6ve/TBSpnZyKQoNpLAHySwF/XL0mQZXWbctCsCAiP/MXBNwSuRXm5w==
X-Received: by 2002:a17:907:100e:: with SMTP id ox14mr1263408ejb.484.1619420275132;
        Sun, 25 Apr 2021 23:57:55 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id k9sm13724782edv.69.2021.04.25.23.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Apr 2021 23:57:54 -0700 (PDT)
Subject: Re: [PATCH] tty: serial: samsung_tty: remove set but not used
 variables
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "tiantao (H)" <tiantao6@huawei.com>,
        Tian Tao <tiantao6@hisilicon.com>, jirislaby@kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
References: <1619170740-63717-1-git-send-email-tiantao6@hisilicon.com>
 <YIKXs7WCF2zI3uvI@kroah.com>
 <660e8905-6c5c-e076-5211-a87a62ea5c87@huawei.com>
 <YIKeAFbqyl00tHXH@kroah.com>
 <6ea876c3-2ffb-ed39-e927-0eea57af21bd@canonical.com>
 <YIZkJUel4RPs4lMf@kroah.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <0c11c83b-250a-8d20-0311-347739bce56c@canonical.com>
Date:   Mon, 26 Apr 2021 08:57:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YIZkJUel4RPs4lMf@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 26/04/2021 08:56, Greg KH wrote:
> On Mon, Apr 26, 2021 at 08:45:44AM +0200, Krzysztof Kozlowski wrote:
>> On 23/04/2021 12:14, Greg KH wrote:
>>> On Fri, Apr 23, 2021 at 05:54:16PM +0800, tiantao (H) wrote:
>>>>
>>>> 在 2021/4/23 17:47, Greg KH 写道:
>>>>> On Fri, Apr 23, 2021 at 05:39:00PM +0800, Tian Tao wrote:
>>>>>> The value of 'ret' is not used, so just delete it.
>>
>> Tian Tao, please use scripts/get_maintainers.pl to get the list of
>> people needed for Cc.
>>
>>>>>>
>>>>>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
>>>>>> ---
>>>>>>   drivers/tty/serial/samsung_tty.c | 1 -
>>>>>>   1 file changed, 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
>>>>>> index d9e4b67..d269d75 100644
>>>>>> --- a/drivers/tty/serial/samsung_tty.c
>>>>>> +++ b/drivers/tty/serial/samsung_tty.c
>>>>>> @@ -2220,7 +2220,6 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>>>>>>   			default:
>>>>>>   				dev_warn(&pdev->dev, "unsupported reg-io-width (%d)\n",
>>>>>>   						prop);
>>>>>> -				ret = -EINVAL;
>>>>> That looks odd, shouldn't you do something with this instead of ignoring
>>>>> it???
>>>>
>>>> How about this ？
>>>>
>>>> diff --git a/drivers/tty/serial/samsung_tty.c
>>>> b/drivers/tty/serial/samsung_tty.c
>>>> index d9e4b67..9fbc611 100644
>>>> --- a/drivers/tty/serial/samsung_tty.c
>>>> +++ b/drivers/tty/serial/samsung_tty.c
>>>> @@ -2220,8 +2220,7 @@ static int s3c24xx_serial_probe(struct platform_device
>>>> *pdev)
>>>>                         default:
>>>>                                 dev_warn(&pdev->dev, "unsupported
>>>> reg-io-width (%d)\n",
>>>>                                                 prop);
>>>> -                               ret = -EINVAL;
>>>> -                               break;
>>>> +                               return -EINVAL;
>>>>
>>>
>>> You tell me, does the patch work for you?
>>>
>>> Is this really a "hard error" and did you now just break devices that
>>> used to work properly?  Are you correctly unwinding any previously
>>> allocated state when you return here?
>>>
>>> Please do some research on this, and ideally, lots of testing, before
>>> submitting it as a real solution.
>>
>> It's a patch coming from automated tool (e.g. Coverity), so I doubt
>> there is any testing here. However the "return -EINVAL" looks correct here:
>> 1. No particular unwinding is needed here,
>> 2. It's an optional property (not used by existing DTS, only
>> non-upstreamed by Samsung) thus treating it as hard-error is fine.
>> Probably better to exit than convert it to some default value.
> 
> So is that a "Reviwed-by:" or not?  :)

First, Tian Tao needs to send a v2 of that patch with a "return" instead
of break. Then this will be a reviewed-by. :)

Best regards,
Krzysztof
