Return-Path: <SRS0=EYjC=7H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7BCC433E0
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 14:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E22ED2071A
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 14:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ef2J71qV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgEYOjC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 May 2020 10:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgEYOjB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 May 2020 10:39:01 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4031C061A0E
        for <linux-serial@vger.kernel.org>; Mon, 25 May 2020 07:39:01 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d10so8758137pgn.4
        for <linux-serial@vger.kernel.org>; Mon, 25 May 2020 07:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hvp+8bkwiokoE+l94E9xwL9m3HUdjoJf6HD2ZNWHYPw=;
        b=ef2J71qVelL6W3PQYSsPoiEUuNU06mYcpt1cRflVMFXWIAXAJj0gHV9/TvkDrgjJYH
         S9MPtt+2OcBWfOUVPBoG/ONcF3yfJk3c+JX2RhYNMoPynSrA9Y57asAHrFokk4QhAOfp
         qbHU+hGLixYPLBeXgKGFoinGTEBNA6G4ulL0/wNW7YelVw9b5c+KZJ11wKQEfJmy5g33
         b0BjC0XwmPR8UWQK3VUs+RFbBHhIcg+7IeHbNwLyhpPwm89iULBx4S14k/Xvirg9uCbk
         N/1ipbbHKh932b+jeg8tBpfoAMjxuta1emUyIpu2nfMpqNpyJwkspO+IcgV2iMoqDv7M
         p/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hvp+8bkwiokoE+l94E9xwL9m3HUdjoJf6HD2ZNWHYPw=;
        b=jw5EttbzBP07V5nL3TLlbGvD6DrrRQzyZfS09/+U7IXIWJauh3hmPbLz8X5l3+bjlo
         xNrTqChRoU9QThijB2BCh/FPlie7ff0puu+gaGrAaH1CkehM1EhtNSMVvSU96QCVVeRB
         /i7keHBhy237dils3McIabn6ZlWwrPNCIoyR9G9vraKWUJ0hDYmFeGCCpulIfdR9dWWH
         w+vM4BelYTuTKNz3RhZx0mX+7nz6VEkjEYVFHwF46JcHLKtbivDMgRj8uejUlQ00anrZ
         eso9L+gnqCcibpzLf0Rf905pHJYLyzAEA89X6LWwW0f8f3k2xFy46ghN6ttiXcc7Pbpo
         eARQ==
X-Gm-Message-State: AOAM532OK4/I1tJDPHRoK0VSgt8gLwNf8RotI63o6eaTdYpijRR4Cwb/
        rGeYEC1FEUgWjhC4zFAQBvU=
X-Google-Smtp-Source: ABdhPJzhEuJRn+tYvUGNFlpFOC16szwDQSRiRWeJQsDnigEVXpu5Ia0BGTmMuP6GcQp9KOav5QuBUg==
X-Received: by 2002:a63:482:: with SMTP id 124mr26846781pge.169.1590417541092;
        Mon, 25 May 2020 07:39:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x132sm13194992pfd.214.2020.05.25.07.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 07:39:00 -0700 (PDT)
Subject: Re: [PATCH v1] serial: imx: Initialize lock for non-registered
 console
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
References: <20200525105952.13744-1-andriy.shevchenko@linux.intel.com>
 <c5b1caca-32fc-1482-b4f5-71787b73a814@roeck-us.net>
 <20200525140752.GA910887@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <4c710584-86a8-d4ba-c1f0-ce79c81c6cea@roeck-us.net>
Date:   Mon, 25 May 2020 07:38:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200525140752.GA910887@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 5/25/20 7:07 AM, Greg Kroah-Hartman wrote:
> On Mon, May 25, 2020 at 07:01:13AM -0700, Guenter Roeck wrote:
>> On 5/25/20 3:59 AM, Andy Shevchenko wrote:
>>> The commit a3cb39d258ef
>>> ("serial: core: Allow detach and attach serial device for console")
>>> changed a bit logic behind lock initialization since for most of the console
>>> driver it's supposed to have lock already initialized even if console is not
>>> enabled. However, it's not the case for Freescale IMX console.
>>>
>>> Initialize lock explicitly in the ->probe().
>>>
>>> Note, there is still an open question should or shouldn't not this driver
>>> register console properly.
>>>
>>> Fixes: a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")
>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> I really wonder if this is the correct fix, especially since it looks like
>> there are several other drivers which don't call register_console() either
>> but implement a console device.
>>
>> Guenter
>>
>>> ---
>>>  drivers/tty/serial/imx.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>>> index 986d902fb7fe..6b078e395931 100644
>>> --- a/drivers/tty/serial/imx.c
>>> +++ b/drivers/tty/serial/imx.c
>>> @@ -2404,6 +2404,9 @@ static int imx_uart_probe(struct platform_device *pdev)
>>>  		}
>>>  	}
>>>  
>>> +	/* We need to initialize lock even for non-registered console */
>>> +	spin_lock_init(&sport->port.lock);
> 
> Why are we having to do this for all console drivers recently?
> Shouldn't the original patch that required this gone through and fixed
> up all drivers?
> 

Good that I am getting paid for bisecting and reporting issues like this.

Oh, wait, I am not. Bummer.

Guenter

