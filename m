Return-Path: <SRS0=20mg=6P=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8DBC47247
	for <linux-serial@archiver.kernel.org>; Fri,  1 May 2020 01:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC4D820836
	for <linux-serial@archiver.kernel.org>; Fri,  1 May 2020 01:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOsxv6vE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgEABk2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Apr 2020 21:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726384AbgEABk2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Apr 2020 21:40:28 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202E7C035494;
        Thu, 30 Apr 2020 18:40:28 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x15so945748pfa.1;
        Thu, 30 Apr 2020 18:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mQqYrPQYFIDRJNtN/SAJy2t+xhyEUoAd2W8p48g17wQ=;
        b=qOsxv6vEvbD4wGxk4LHlqwR83qbl5dodfHnuXOGhvA4bduTWwFKJL2ZL+Qy5brd1TH
         LUjSN4TQgb2a1HhOCErAV6sbo+5OK5dTL25GYXh1RrCdrQmomW36pW9jlhh7dmVYb4Rb
         Xuq2uqKfq71qhtgKEjCjqTdZAJPbCPWf9m946U6eOmBjDggUu4h+yIjI8Egg+K5ycJ3A
         oOs5Lwqy19kTJohvRjttP13COYBFrMX4Fu5KVcTINGR4W5JKH88g3m7m9pU+eieV7yY5
         YkeOu0vci/6NUb9qkD2f4Lvb8blVGeMkZY2c7NW6INSurKZZDuZeJAEpn3o47E3uYWVw
         6m9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mQqYrPQYFIDRJNtN/SAJy2t+xhyEUoAd2W8p48g17wQ=;
        b=aTcmaGOacI3Lr9L1tE3QePivtiNPrcXpk0Cy61CoP4IeA8gZNx6yBQlGJeykkiA/OW
         WmdAjq4y/0Eeo5/GTUt426EpMsm69foLceaApM2o0J2qidWGxWmLXKFuzsQROXsAz7R1
         ODzVgdCk8/+p7WYIAuM9gDB9XrwJtKgeDvhI2illt36fUMkWvPerbdamxG1HJKRnnMiV
         AI8gdK7rOfmUjhIhGzjRSd3m8nrgSLb2nXhNu5iavJZEwB1cpGZK7UpGWBbXZZF1FPA8
         XfXRLIk7wJ93nrdSVkAEhX36tSzSUQYjX4pf1mGhAk/dYPiOfuSIb6c0XN6k/qY846C8
         AdHg==
X-Gm-Message-State: AGi0PuaHyA0lBt/LBvwX6HFDrQ1tGKrpLbRxDmxfa/Ak1Ua9JOgaXxQc
        Dw9wIK1UISrlRNQ9wpgwGz1qKzdQ
X-Google-Smtp-Source: APiQypJz7l4igwtJb1meMfrQsLaxqn5KYdCbRys7N0lK7x/6DU1RlFfxq8c0rVr+R8v+8Msb3+0V9A==
X-Received: by 2002:a63:1d46:: with SMTP id d6mr1982542pgm.236.1588297227198;
        Thu, 30 Apr 2020 18:40:27 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id f74sm2027363pje.3.2020.04.30.18.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 18:40:26 -0700 (PDT)
Subject: Re: [PATCH -next] tty: serial: bcm63xx: fix missing clk_put() in
 bcm63xx_uart
To:     Greg KH <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jiri Slaby <jslaby@suse.cz>, Zou Wei <zou_wei@huawei.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1587472306-105155-1-git-send-email-zou_wei@huawei.com>
 <4cd8f963-9292-faef-1e24-df90821274d6@suse.cz>
 <73c4cebb-467b-e5d5-89bf-8a6fe29cf858@gmail.com>
 <20200428111842.GA1159152@kroah.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <589eda5a-296b-daa1-f40c-fd27056ac4b8@gmail.com>
Date:   Thu, 30 Apr 2020 18:40:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428111842.GA1159152@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 4/28/2020 4:18 AM, Greg KH wrote:
> On Mon, Apr 27, 2020 at 10:29:58AM -0700, Florian Fainelli wrote:
>>
>>
>> On 4/26/2020 11:19 PM, Jiri Slaby wrote:
>>> On 21. 04. 20, 14:31, Zou Wei wrote:
>>>> This patch fixes below error reported by coccicheck
>>>>
>>>> drivers/tty/serial/bcm63xx_uart.c:848:2-8: ERROR: missing clk_put;
>>>> clk_get on line 842 and execution via conditional on line 846
>>>>
>>>> Fixes: ab4382d27412 ("tty: move drivers/serial/ to drivers/tty/serial/")
>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>> Signed-off-by: Zou Wei <zou_wei@huawei.com>
>>>> ---
>>>>  drivers/tty/serial/bcm63xx_uart.c | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
>>>> index 5674da2..ed0aa5c 100644
>>>> --- a/drivers/tty/serial/bcm63xx_uart.c
>>>> +++ b/drivers/tty/serial/bcm63xx_uart.c
>>>> @@ -843,8 +843,10 @@ static int bcm_uart_probe(struct platform_device *pdev)
>>>>  	if (IS_ERR(clk) && pdev->dev.of_node)
>>>>  		clk = of_clk_get(pdev->dev.of_node, 0);
>>>>  
>>>> -	if (IS_ERR(clk))
>>>> +	if (IS_ERR(clk)) {
>>>> +		clk_put(clk);
>>>
>>> Why would you want to put an erroneous clk?
>>
>> Doh, somehow I completely missed, you are right this does not look legit.
> 
> Ugh, can you send a revert for this please?

Yes, now done:

https://lore.kernel.org/linux-arm-kernel/20200501013904.1394-1-f.fainelli@gmail.com/
-- 
Florian
