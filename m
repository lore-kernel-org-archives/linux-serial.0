Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FF8C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 22 Sep 2021 06:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6635E61184
	for <linux-serial@archiver.kernel.org>; Wed, 22 Sep 2021 06:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhIVG6v (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Sep 2021 02:58:51 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:44608 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbhIVG6u (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Sep 2021 02:58:50 -0400
Received: by mail-wr1-f41.google.com with SMTP id d6so3600725wrc.11;
        Tue, 21 Sep 2021 23:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Yh0iKTCDgYFSJb9XyCYVMvV6OqeBY6bHXPRIYvm+yjg=;
        b=DHH8MnWsS94RMlIvrvzGevuRA74xSZaO1WgIJJ1BFnisOIcsikf1Szzl6AZiWdJM1a
         n1kfTgyJZgldeKPTU18jcUMayQ9Edw45WsOJxo4gh6EG70o03w5tfDPYFBkVju8jR82w
         HbASvX0B0wcFaDB8GmwwTyptXGrRjz6QuEGG4K9wn2zC3mdWj/ICyOgu8M8MUEEGi2VK
         mBkguP2xEfhuLvgo8xiwxIB4Ae+F9ldX1HFBboyDoa6AfZ4uOC8J4ZOfrKFes6hk98zB
         G/Q2/SsNUhmA4hvrZHe3teIi2TySa2B1B83FVL8GrsKQQGfmIaWuWHtPf5xadWPDQidw
         ir5w==
X-Gm-Message-State: AOAM5303zMuX53Hi8W3HTweAJYJokh529+snaHq9CbO4VDQvjMdTKZ5c
        PN7pKzVkzzEGGxoXLXhlmL4aNZlPjU8=
X-Google-Smtp-Source: ABdhPJyttFxWYlul8CE2uWk9E3jp4KZqp4CxVqDLXA0aqJyIInsfN9Mr2HtAfGCdR5CEcLvoYpEVSg==
X-Received: by 2002:a7b:cd0f:: with SMTP id f15mr8629589wmj.173.1632293839620;
        Tue, 21 Sep 2021 23:57:19 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id i67sm1164807wmi.41.2021.09.21.23.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 23:57:19 -0700 (PDT)
Message-ID: <1fd9ed1a-edd2-a154-da1c-022a89b2c722@kernel.org>
Date:   Wed, 22 Sep 2021 08:57:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 16/16] tty: drop tty_flip_buffer_push
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091415.17918-1-jslaby@suse.cz>
 <20210914091415.17918-9-jslaby@suse.cz>
 <YUMWaCpT4s8dQKiy@hovoldconsulting.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <YUMWaCpT4s8dQKiy@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 16. 09. 21, 12:03, Johan Hovold wrote:
> On Tue, Sep 14, 2021 at 11:14:15AM +0200, Jiri Slaby wrote:
>> Since commit a9c3f68f3cd8d (tty: Fix low_latency BUG) in 2014,
>> tty_flip_buffer_push() is only a wrapper to tty_schedule_flip(). All
>> users were converted, so remove tty_flip_buffer_push() completely.
> 
> Did you consider inlining tty_flip_buffer_push() or unexporting
> tty_schedule_flip() instead?

Yes -- I see no reason for two functions doing the very same thing. It's 
only confusing.

> The name tty_flip_buffer_push() is arguable more descriptive since the
> work may already be running and is also less tied to the implementation.
> 
> The ratio of drivers using tty_flip_buffer_push() over
> tty_schedule_flip() is also something like 186 to 15 so that would
> amount to a lot less churn too.

OK, I can do either way. I chose this path as tty_schedule_flip was a 
wrapper to tty_flip_buffer_push. In any case, I wouldn't take the number 
of changed drivers as a measure. But if it makes more sense for people 
regarding the naming, I will "flip" the two flips.

> Also, can you please start adding cover letters to your series to
> provide an overview of what it is you're trying to accomplish?

I am not a fan of cover letters as they are not Cced to people who are 
Cced in separate patches. So what would you like to see in the letter? 
This series are just a random cleanup and IMO there is not much more to 
be said except what is in their commit logs.

thanks,
-- 
js
suse labs
