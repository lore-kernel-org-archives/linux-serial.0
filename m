Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF90C4332F
	for <linux-serial@archiver.kernel.org>; Thu,  7 Apr 2022 08:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbiDGIJz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Apr 2022 04:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242698AbiDGIHP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Apr 2022 04:07:15 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BB015AAD0;
        Thu,  7 Apr 2022 01:05:15 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id h4so6561903wrc.13;
        Thu, 07 Apr 2022 01:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=k5Z8OUhRelN5FFoWfx6yeRuNCnOOHjN18Zd6brbR9SU=;
        b=PtI2+yLW3StPs6vlHQ3CCez8aCoDkMC41BmeACTvGOhmClXu+ETzfrmHXe2LfGtw+Y
         mzlWfjPr6LgPIq4byAeKUp9bVFGvkoiqXSGwtQS1ZqTG2YX1feuink69kDI/cczyqV0W
         WOEyn2Jyw/TZeTB1wfqtWbctFp3vzhOLq9grGEoU/wIGDNMkclxJIaSwDHrQLq2Qfomk
         Iss/5vAlvx02Dr0dSVDMl/UihsG98nmqN2juf8nJuwCCBz+wpnRyU78qqplLBCgB04XD
         GZqej45rrTqXS8cookvrGgKjdXeVO+rXRat5mz53yUUiCZI5SL/FzGJrJ/L/q8GBg440
         KGSA==
X-Gm-Message-State: AOAM532c91gsipTWKVybtzWaZrOGLeaU/rJ/bp4otkn3cKZOMvO9mxDM
        DeiJ3JwUtrxwasEpdV3xyH0=
X-Google-Smtp-Source: ABdhPJw8gESXWjC2gFPHl9EZ0YUgdmxtQHzQMJ3vbvugJZriyw/pHYEHwSHrUZLKqJMXehIo+aPzVg==
X-Received: by 2002:a5d:6d0a:0:b0:204:109f:7833 with SMTP id e10-20020a5d6d0a000000b00204109f7833mr9927973wrq.76.1649318714105;
        Thu, 07 Apr 2022 01:05:14 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id e13-20020a05600c4e4d00b0038e44e316c1sm6682893wmq.6.2022.04.07.01.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 01:05:13 -0700 (PDT)
Message-ID: <5be92b82-da56-2591-dbf1-fbf63f91c37b@kernel.org>
Date:   Thu, 7 Apr 2022 10:05:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/1] tty: serial: samsung: add spin_lock for interrupt
 and console_write
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
References: <20220407071619.102249-1-jaewon02.kim@samsung.com>
 <CGME20220407071223epcas2p16bb11821a0894a3375e84d17c4ff0844@epcas2p1.samsung.com>
 <20220407071619.102249-2-jaewon02.kim@samsung.com>
 <b53be23f-7935-dae3-9dc8-f850493a5fa9@kernel.org>
 <6dcddc8a-7ca2-b424-fc8f-7000be3f9116@linaro.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <6dcddc8a-7ca2-b424-fc8f-7000be3f9116@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 07. 04. 22, 9:58, Krzysztof Kozlowski wrote:
> On 07/04/2022 09:46, Jiri Slaby wrote:
>> On 07. 04. 22, 9:16, Jaewon Kim wrote:
>>> The console_write and IRQ handler can run concurrently.
>>> Problems may occurs console_write is continuously executed while
>>> the IRQ handler is running.
>>
>>   From the patch POV:
>>
>> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
>>
>> But given this is a v3 with no version changelog below "---", you've
>> just kicked the Greg's bot to wake up :P.
>>
> 
> There was a cover letter with such changelog:
> https://lore.kernel.org/all/20220407071619.102249-1-jaewon02.kim@samsung.com/
> 
> It's indeed easy to miss...

Ah, OK, my bad -- I skipped it as usual -- I don't consider cover 
letters that useful. And in this case, even more provided it is for a 
single patch.

thanks,
-- 
js
suse labs
