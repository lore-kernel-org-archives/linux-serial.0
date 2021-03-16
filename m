Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB182C433DB
	for <linux-serial@archiver.kernel.org>; Tue, 16 Mar 2021 10:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DD176501D
	for <linux-serial@archiver.kernel.org>; Tue, 16 Mar 2021 10:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbhCPKML (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Mar 2021 06:12:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41391 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236523AbhCPKLp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Mar 2021 06:11:45 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lM6fw-0006Z3-Fx
        for linux-serial@vger.kernel.org; Tue, 16 Mar 2021 10:11:44 +0000
Received: by mail-ej1-f71.google.com with SMTP id e7so5456438ejx.5
        for <linux-serial@vger.kernel.org>; Tue, 16 Mar 2021 03:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b0duzRCaAd6HCnqDszh8HzHViWmbH3s2/7Iw8Q+UR7g=;
        b=WpU+cbivR9RlTp/qFml2YQourQEsM8u9Xy5e4xLpWT8QyS3+6WxZL+CDH2BBEU4fVc
         4OEw2npWN10acLv6OaWJVjEZtJaA/bUUXao9Y2iWV9X6I9rlcqo/5bj27sFKbh074Agf
         2hTmgE7DT/FrAb1bDRLMQh0SRmxMjwQOwe1Mmnes8+AZrOLnm07H9LSrBR/ze/ZtqcK/
         UxPNbdaSB+dlJKvvqkSIZqh5OdNM10ODWqynm/nWnUcm/F8OuohYunAU3LnznBzVdYc7
         aGcD/Q4TdmHSt+0nXyhUEJX+t92pvZSODY8b7CudsnxXURIylVATlbNrchkYYsle82Vh
         Cd0w==
X-Gm-Message-State: AOAM533a5+bDkGOVX6ctj0cVR9vhEe+KWG2BNzUG+trY91UhtIevimyc
        Jv6hiCmP3M9fFDqg+3DjjURVQuEAe8b2bO5dnrgRUXxeTp7LixfAR/YVFV8EHv0pMMG+cr696JH
        ix869uhTTrg1sAmAfKZ3czQl2XS0wdSjhhEWLtbpQzQ==
X-Received: by 2002:a17:906:9243:: with SMTP id c3mr29663330ejx.388.1615889504253;
        Tue, 16 Mar 2021 03:11:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2WvVnE529fDdG65yCEejk0MxK/8sqZnjAJjGw18sNXl1HOe3MN5ShhMd+pxFPJyRYKZpedg==
X-Received: by 2002:a17:906:9243:: with SMTP id c3mr29663314ejx.388.1615889504118;
        Tue, 16 Mar 2021 03:11:44 -0700 (PDT)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id t27sm9126163ejc.62.2021.03.16.03.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 03:11:43 -0700 (PDT)
Subject: Re: [PATCH] tty: serial: samsung_tty: remove spinlock flags in
 interrupt handlers
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcan@marcan.st, arnd@kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20210315181212.113217-1-krzysztof.kozlowski@canonical.com>
 <YFB0OcBg3Vj555eA@hovoldconsulting.com>
 <7f348e4c-3051-13cf-d461-eeda0ef53fdd@canonical.com>
 <YFCA5jFLV0Cu9YNe@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <816834ba-8dc2-05cd-9c81-a11d65980cfd@canonical.com>
Date:   Tue, 16 Mar 2021 11:11:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFCA5jFLV0Cu9YNe@hovoldconsulting.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 16/03/2021 10:56, Johan Hovold wrote:
> On Tue, Mar 16, 2021 at 10:47:53AM +0100, Krzysztof Kozlowski wrote:
>> On 16/03/2021 10:02, Johan Hovold wrote:
>>> On Mon, Mar 15, 2021 at 07:12:12PM +0100, Krzysztof Kozlowski wrote:
>>>> Since interrupt handler is called with disabled local interrupts, there
>>>> is no need to use the spinlock primitives disabling interrupts as well.
>>>
>>> This isn't generally true due to "threadirqs" and that can lead to
>>> deadlocks if the console code is called from hard irq context.
>>>
>>> Now, this is *not* the case for this particular driver since it doesn't
>>> even bother to take the port lock in console_write(). That should
>>> probably be fixed instead.
>>>
>>> See https://lore.kernel.org/r/X7kviiRwuxvPxC8O@localhost.
>>
>> Thanks for the link, quite interesting! For one type of device we have
>> two interrupts (RX and TX) so I guess it's a valid point/risk. However
>> let me try to understand it more.
>>
>> Assuming we had only one interrupt line, how this interrupt handler with
>> threadirqs could be called from hardirq context?
> 
> No, it's console_write() which can end up being called in hard irq
> context and if that path takes the port lock after the now threaded
> interrupt handler has been preempted you have a deadlock.

Thanks, I understand now. I see three patterns shared by serial drivers:

1. Do not take the lock in console_write() handler,
2. Take the lock like:
if (port->sysrq)
    locked = 0;
else if (oops_in_progress)
    locked = spin_trylock_irqsave(&port->lock, flags);
else
    spin_lock_irqsave(&port->lock, flags)

3. Take the lock like above but preceded with local_irq_save().

It seems the choice of pattern depends which driver was used as a base.

Best regards,
Krzysztof
