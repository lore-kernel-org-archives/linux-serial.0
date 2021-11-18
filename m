Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F032C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E6A561B39
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244103AbhKRH5P (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:57:15 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:43974 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244031AbhKRH5H (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 02:57:07 -0500
Received: by mail-wm1-f45.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so4083327wmz.2;
        Wed, 17 Nov 2021 23:54:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=/WPksyNIJfHVwRowN/X0gm5j/hURdH3QuE+5mF2pGYM=;
        b=QM0p6XSJCXBLJ5iZi5rb690ofcYWIXx22x+hN2NCvR0lfisUvmF6gPGDvJ7W9jjgAe
         s9skfQCPEGjdvD+oc9+/YbtehtQVz+mwLQuhTHiQ4vYK3atSFMrwvR1ve0YyVHX0/rgb
         BksI426ljNMFx/1m2uhEV01md5V12RLG++XLHF5PpD789Pazjyd8kmHzSpyUcoCQMZEU
         AQalu5EJfFvNhLG55lsz/cDJdhFEpsJE7eCaIwx+fEwlOKR6V3HC3T+4CnXZVPhQHOzz
         JOOQGsz94JciGSY9TqNqVEuCILoJcURm+X8v5hQFJm+QngC9l/AiLLYUNJMc4v2d33ae
         yGGw==
X-Gm-Message-State: AOAM533GOTLwQ9093iye27iDnAzLujucksCdLlWncu6NT0rTfApvPSKs
        QMa5HTIRFGMOW9zrtUNi904=
X-Google-Smtp-Source: ABdhPJwc25V0qqm9TTcQx2Oeh41d9gR3LuMfmq/O5UgECJPmZ1+mNaARXI6lFCDpzvAVExFYhDlt/Q==
X-Received: by 2002:a1c:a711:: with SMTP id q17mr7550692wme.158.1637222047111;
        Wed, 17 Nov 2021 23:54:07 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id o12sm3335053wrc.85.2021.11.17.23.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 23:54:06 -0800 (PST)
Message-ID: <01079c75-2d2f-fe57-db0e-6aadf9963846@kernel.org>
Date:   Thu, 18 Nov 2021 08:54:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 16/16] tty: drop tty_flip_buffer_push
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Johan Hovold <johan@kernel.org>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091415.17918-1-jslaby@suse.cz>
 <20210914091415.17918-9-jslaby@suse.cz>
 <YUMWaCpT4s8dQKiy@hovoldconsulting.com>
 <1fd9ed1a-edd2-a154-da1c-022a89b2c722@kernel.org>
In-Reply-To: <1fd9ed1a-edd2-a154-da1c-022a89b2c722@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Friendly ping Johan, Greg: any opinions on the tty_schedule_flip vs 
tty_flip_buffer_push case -- which one should I keep?

I would like to move forward with these as I have a lot kernel-doc 
writings pending and depending on this patch (be it "drop 
tty_flip_buffer_push" or "drop tty_schedule_flip").

Thanks.

On 22. 09. 21, 8:57, Jiri Slaby wrote:
> On 16. 09. 21, 12:03, Johan Hovold wrote:
>> On Tue, Sep 14, 2021 at 11:14:15AM +0200, Jiri Slaby wrote:
>>> Since commit a9c3f68f3cd8d (tty: Fix low_latency BUG) in 2014,
>>> tty_flip_buffer_push() is only a wrapper to tty_schedule_flip(). All
>>> users were converted, so remove tty_flip_buffer_push() completely.
>>
>> Did you consider inlining tty_flip_buffer_push() or unexporting
>> tty_schedule_flip() instead?
> 
> Yes -- I see no reason for two functions doing the very same thing. It's 
> only confusing.
> 
>> The name tty_flip_buffer_push() is arguable more descriptive since the
>> work may already be running and is also less tied to the implementation.
>>
>> The ratio of drivers using tty_flip_buffer_push() over
>> tty_schedule_flip() is also something like 186 to 15 so that would
>> amount to a lot less churn too.
> 
> OK, I can do either way. I chose this path as tty_schedule_flip was a 
> wrapper to tty_flip_buffer_push. In any case, I wouldn't take the number 
> of changed drivers as a measure. But if it makes more sense for people 
> regarding the naming, I will "flip" the two flips.



-- 
js
suse labs
