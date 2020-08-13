Return-Path: <SRS0=hLv5=BX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67FBC433DF
	for <linux-serial@archiver.kernel.org>; Thu, 13 Aug 2020 17:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EC1020658
	for <linux-serial@archiver.kernel.org>; Thu, 13 Aug 2020 17:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPVllVsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgHMRDx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgHMRDs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Aug 2020 13:03:48 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E131C061383;
        Thu, 13 Aug 2020 10:03:47 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id f9so3036411pju.4;
        Thu, 13 Aug 2020 10:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:references:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wz2hK3wAL9yJiAoCqnRIdOZbFPH3ATcurNRb0aTkKj4=;
        b=EPVllVsTmTk09TKwqg4RaJKj5pVEA6dbVIyZOB83Y/eDhqqLyIbsAGAoNWLonb44oZ
         tMhdQvGu1U9gfd+7pwO2LU/aCFCyselSEML5YCbzgeUpAqNns5StQ1IrsrG6vd0Dd8Vo
         c0iTNQyt7t0aBqutNroM/nqsHWxpkNyGKmINKAOU0ACH5lrDPeJIXYJpsA3ysMgkuCnP
         0ZF7qf7O+kmx31pEgks+TkTAJ4T1YE0UtEuF4u2K+93Zulvo8rKiWnfdpd6Brtynzhbr
         zNEG+umB+P9xXlasu8YJ9OL5s6Zy6zVvV07rnM12Hfhn7VZNxdi86+uTXwQyivMXMJFh
         bqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wz2hK3wAL9yJiAoCqnRIdOZbFPH3ATcurNRb0aTkKj4=;
        b=mR5VJFvQGxd4xOcKgemPZqiH7PhVT8chp/s+ut6hNnAv2m8Yaq9tWXthHvXWV6PiZR
         0mT8k/KSiNiBb5RtkM0q5xTNiWSBZlERnnvGwcp0/H5nVBUU4oZ53xlGPRoei2jfJvF2
         AB8oeite6d6yc2IQw5O/dU+te40TnF015O2VabcEnqOtoO3vI6h+4kkQhuNvntJTlwJQ
         MtQSRHQ9mvPqE3ax+PL1kURYM8D/gz9wW2TjiozuUHhj2sB/rtC7C9z0AM5dB0/p9sDa
         42pb26M4UBBQafEweTdW8K0b/idgjMJJkHzbEzWkdNOlDyQOZ7DK9nv9AFLV7oOvymdV
         sHGQ==
X-Gm-Message-State: AOAM532Lch9GF7TRXRpRstjYl4OcA59nnkXWfWZO5obuVD39YBBIeB4G
        3vVJ9fF/0gqeQz+mkupKvhM=
X-Google-Smtp-Source: ABdhPJxa7ss6SYgJJwoGOwmzKoAoQvwSblNpI1V+hcaw6j/w/nJzHTaAUghkuFY80Z151UZwKseOtg==
X-Received: by 2002:a17:902:9a45:: with SMTP id x5mr4643256plv.243.1597338227112;
        Thu, 13 Aug 2020 10:03:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m19sm5937653pgd.21.2020.08.13.10.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 10:03:46 -0700 (PDT)
Subject: Re: Recursive/circular locking in
 serial8250_console_write/serial8250_do_startup
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        John Ogness <john.ogness@linutronix.de>, kurt@linutronix.de,
        Raul Rangel <rrangel@google.com>,
        "S, Shirish" <Shirish.S@amd.com>
References: <20200812154813.GA46894@roeck-us.net>
 <20200813050629.GA95559@roeck-us.net> <20200813115948.GA3854926@kroah.com>
 <20200813142022.GY1891694@smile.fi.intel.com>
 <c9421d8a-7a2b-23ce-61f5-41f2136cf228@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <e78b85b6-3134-290e-88e2-f1d6e88f0db0@roeck-us.net>
Date:   Thu, 13 Aug 2020 10:03:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c9421d8a-7a2b-23ce-61f5-41f2136cf228@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 8/13/20 8:33 AM, Guenter Roeck wrote:
> On 8/13/20 7:20 AM, Andy Shevchenko wrote:
>> On Thu, Aug 13, 2020 at 01:59:48PM +0200, Greg KH wrote:
>>> On Wed, Aug 12, 2020 at 10:06:29PM -0700, Guenter Roeck wrote:
>>>> On Wed, Aug 12, 2020 at 08:48:13AM -0700, Guenter Roeck wrote:
>>>>> Hi,
>>>>>
>>>>> crbug.com/1114800 reports a hard lockup due to circular locking in the
>>>>> 8250 console driver. This is seen if CONFIG_PROVE_LOCKING is enabled.
>>>>>
>>>>> Problem is as follows:
>>>>> - serial8250_do_startup() locks the serial (console) port.
>>>>> - serial8250_do_startup() then disables interrupts if interrupts are
>>>>>   shared, by calling disable_irq_nosync().
>>>>> - disable_irq_nosync() calls __irq_get_desc_lock() to lock the interrupt
>>>>>   descriptor.
>>>>> - __irq_get_desc_lock() calls lock_acquire()
>>>>> - If CONFIG_PROVE_LOCKING is enabled, validate_chain() and check_noncircular()
>>>>>   are called and identify a potential locking error.
>>>>> - This locking error is reported via printk, which ultimately calls
>>>>>   serial8250_console_write().
>>>>> - serial8250_console_write() tries to lock the serial console port.
>>>>>   Since it is already locked, the system hangs and ultimately reports
>>>>>   a hard lockup.
>>>>>
>>>>> I understand we'll need to figure out and fix what lockdep complains about,
>>>>> and I am working on that. However, even if that is fixed, we'll need a
>>>>> solution for the recursive lock: Fixing the lockdep problem doesn't
>>>>> guarantee that a similar problem (or some other log message) won't be
>>>>> detected and reported sometime in the future while serial8250_do_startup()
>>>>> holds the console port lock.
>>>>>
>>>>> Ideas, anyone ? Everything I came up with so far seems clumsy and hackish.
>>>>>
>>>>
>>>> Turns out the situation is a bit worse than I thought. disable_irq_nosync(),
>>>> when called from serial8250_do_startup(), locks the interrupt descriptor.
>>>> The order of locking is
>>>> 	serial port lock
>>>> 	  interrupt descriptor lock
>>>>
>>>> At the same time, __setup_irq() locks the interrupt descriptor as well.
>>>> With the descriptor locked, it may report an error message using pr_err().
>>>> This in turn may call serial8250_console_write(), which will try to lock
>>>> the console serial port. The lock sequence is
>>>> 	interrupt descriptor lock
>>>> 	  serial port lock
>>>>
>>>> I added the lockdep splat to the bug log at crbug.com/1114800.
>>>>
>>>> Effectively, I think, this means we can't call disable_irq_nosync()
>>>> while holding a serial port lock, or at least not while holding a
>>>> serial port lock that is associated with a console.
>>>>
>>>> The problem was introduced (or, rather, exposed) with upstream commit
>>>> 7febbcbc48fc ("serial: 8250: Check UPF_IRQ_SHARED in advance").
>>>
>>> Adding Andy, who wrote the above commit :)
>>>
>>> Andy, any thoughts?
>>
>> So, we have here a problem and my commit is indeed revealed it since it's
>> basically did spread of what we used to have only in two drivers (and
>> originally reported problem was against third one, i.e. 8250_pnp) to all 8250.
>> Even if we revert that commit, we got the other problem appear, hence it's a
>> matter who to suffer until the clean solution will be provided.
>>
>> As per earlier discussion [1] (and I Cc'ed this to people from there) it
>> appears there is another issue with RT kernels which brought initially that
>> controversial disable_irq_nosync() call. Same here, if we drop this call
>> somebody will be unsatisfied.
>>
> 
> The lock chain in [1] is
> 	console_owner --> &port_lock_key --> &irq_desc_lock_class
> and in my case ([2], comment 13) it is
> 	&irq_desc_lock_class --> console_owner --> &port_lock_key
> 
> Looks like we just changed the order of locks.
> 
>> The real fix possible to go to completely lockless printk(), but on the other
>> hand it probably won't prevent other locking corner cases (dead lock?) in 8250
>> console write callback.
>> spin_lock_irqsave
>> The fix proposed in [2] perhaps not the way to go either...
>>
> 
> The code in [2] (Comment 10) was just a hack to prevent the hard lockup
> from happening and to be able see the lockdep splat. It wasn't supposed
> to fix anything (and it doesn't).
> 
> Can we change the order of spin_lock_irqsave / disable_irq_nosync ?
> 
> -               spin_lock_irqsave(&port->lock, flags);
>                 if (up->port.irqflags & IRQF_SHARED)
>                         disable_irq_nosync(port->irq);
> +               spin_lock_irqsave(&port->lock, flags);
> 
> [ plus of course the same for unlock ]
> 

I tried the above, and it solves the problem for me. It is less than perfect
(interrupts will be disabled for more time if the code has to wait for the
spinlock), but I _think_ it should work.

Should I submit a patch ? Or is there a major flaw in my thinking ?

Thanks,
Guenter

> 
>> The idea about not allowing disabling IRQ for console port may be least
>> painful as a (temporary?) mitigation.
>>
>> [1]: https://lore.kernel.org/lkml/CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com/T/#u
>> [2]: https://bugs.chromium.org/p/chromium/issues/detail?id=1114800
>>
> 

