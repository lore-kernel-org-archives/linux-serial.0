Return-Path: <SRS0=EYjC=7H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CFDC433DF
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 13:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2F4E2071A
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 13:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmE4lvPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403888AbgEYN7J (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 May 2020 09:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403805AbgEYN7J (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 May 2020 09:59:09 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F203EC061A0E
        for <linux-serial@vger.kernel.org>; Mon, 25 May 2020 06:59:08 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p30so8693088pgl.11
        for <linux-serial@vger.kernel.org>; Mon, 25 May 2020 06:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XIP7X5TdJ1uTPRdOwU0l7J4+NkniZpv7iFSYavr6hoQ=;
        b=gmE4lvPo+VjU4QVXpuwIMgm8q8RAAPxYoJVlwYilgT4CvuA5VGOHJwa7ki4RwW1qbT
         M27WyDmv6tFAGv5kwEnPQ6UQRHL7H4I8iwTZ7vIYkssXqFYvFIHBomFYgHGyUjeTZKDt
         l0xDwpbIX8iGhmdRDxqZTO4Gu7ujpmK4PvXg9h1eb78CWddF5NlJgkPG5j7Pczo7OrMt
         1gAktmf2/CSgcBOFPcJ7YN6XU/AY0vauFSUn7ofBefjTSyJOiysxs2N++ocNxyuEfqF/
         SjJVMxqZ8Vi5uTfP0JgdXe/O6GPcIRJJ9eCVry4T9cs1eRIygJ+aGxKsWCxv8eHYajAG
         /TFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XIP7X5TdJ1uTPRdOwU0l7J4+NkniZpv7iFSYavr6hoQ=;
        b=GsfiF86m2HXCf4zmO0nH+JDL09G8D+uuFMT3U9H8mYk8V89X0vczKs8Knzp+RxR22o
         yrzE/4gQ7QCYyxC3kOIMweRdcJcvC/8DffBNegWc+aGPu+p6dnkcPUzE3VS7zEylLTGa
         QlR2ykNwZeFDSczM6XTRiSgBsEQwv74TGYcuC6xa9l7UsNYni2u70hYZGvtrJ4TgcL7u
         npXwFC3G3t6kNqv2kxjQTjCWQu6c6/deFV225HsYtSwL+4R07YksLu1u2z+gX5qI9Qns
         pm4f31lQljSuz8PY+12WxbOKWNqvnsOb/MXJ1V0JvcGeqsn/gl7jIIL5jPTwjHse1Ged
         byRA==
X-Gm-Message-State: AOAM533db6I8WMGrdZmI5J9QPSL12YHaKHwdkJ2enfARVdI6qeThvR94
        pke5sb8fN/FWGyb8/WDJw9A=
X-Google-Smtp-Source: ABdhPJwlgxIsTcIR8FGJqP831RQsbv2+Jk+8ba8wLQwBlx5JJ/05zg4dm7as9e2qNhHbEWVBdnQMaw==
X-Received: by 2002:aa7:8a48:: with SMTP id n8mr17207752pfa.257.1590415148516;
        Mon, 25 May 2020 06:59:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id go1sm12428519pjb.26.2020.05.25.06.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 06:59:07 -0700 (PDT)
Subject: Re: [PATCH v3 2/6] serial: core: Allow detach and attach serial
 device for console
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>
References: <20200217114016.49856-1-andriy.shevchenko@linux.intel.com>
 <20200217114016.49856-3-andriy.shevchenko@linux.intel.com>
 <20200524171032.GA218301@roeck-us.net>
 <20200525103830.GO1634618@smile.fi.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <4341626e-7d83-2a9a-5048-e0fe2a878fb1@roeck-us.net>
Date:   Mon, 25 May 2020 06:59:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200525103830.GO1634618@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 5/25/20 3:38 AM, Andy Shevchenko wrote:
> On Sun, May 24, 2020 at 10:10:32AM -0700, Guenter Roeck wrote:
>> On Mon, Feb 17, 2020 at 01:40:12PM +0200, Andy Shevchenko wrote:
> 
>>> -	if (uart_console_enabled(port))
>>> +	if (uart_console(port))
>>
>> This results in lockdep splashes such as the one attached below. Is there
>> any special reason for this change ? It is not really explained in the
>> commit description.
> 
> Thanks for the report.
> 
> Yes, because imx_uart_init() doesn't properly register a console.
> I'll send a quick fix for that soon.
> 

A quick scan suggests that this is not the only driver with 'struct console'
which doesn't call register_console(). atmel_serial.c and ar933x_uart.c are
two more examples. Are you saying that all such drivers now generate this
lockdep splat ? Does that really make sense ?

Guenter

>> [   15.439094] INFO: trying to register non-static key.
>> [   15.439146] the code is fine but needs lockdep annotation.
>> [   15.439196] turning off the locking correctness validator.
>> [   15.439392] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.7.0-rc6-00244-gcaffb99b6929 #1
>> [   15.439469] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
>> [   15.439887] [<c0112578>] (unwind_backtrace) from [<c010c4f4>] (show_stack+0x10/0x14)
>> [   15.439982] [<c010c4f4>] (show_stack) from [<c06dfcb0>] (dump_stack+0xe4/0x11c)
>> [   15.440053] [<c06dfcb0>] (dump_stack) from [<c01883e4>] (register_lock_class+0x8a0/0x924)
>> [   15.440127] [<c01883e4>] (register_lock_class) from [<c01884d4>] (__lock_acquire+0x6c/0x2e80)
>> [   15.440202] [<c01884d4>] (__lock_acquire) from [<c018756c>] (lock_acquire+0xf8/0x4f4)
>> [   15.440274] [<c018756c>] (lock_acquire) from [<c0ddf02c>] (_raw_spin_lock_irqsave+0x50/0x64)
>> [   15.440350] [<c0ddf02c>] (_raw_spin_lock_irqsave) from [<c07af5d8>] (uart_add_one_port+0x3a4/0x504)
>> [   15.440431] [<c07af5d8>] (uart_add_one_port) from [<c089c990>] (platform_drv_probe+0x48/kk0x98)
>> [   15.440506] [<c089c990>] (platform_drv_probe) from [<c089a708>] (really_probe+0x214/0x344)
>> [   15.440578] [<c089a708>] (really_probe) from [<c089a948>] (driver_probe_device+0x5c/0x16c)
>> [   15.440650] [<c089a948>] (driver_probe_device) from [<c089ac00>] (device_driver_attach+0x58/0x60)
>> [   15.440727] [<c089ac00>] (device_driver_attach) from [<c089ac8c>] (__driver_attach+0x84/0xc0)
>> [   15.440800] [<c089ac8c>] (__driver_attach) from [<c08987e8>] (bus_for_each_dev+0x70/0xb4)
>> [   15.440874] [<c08987e8>] (bus_for_each_dev) from [<c08999a4>] (bus_add_driver+0x154/0x1e0)
>> [   15.440946] [<c08999a4>] (bus_add_driver) from [<c089ba38>] (driver_register+0x74/0x108)
>> [   15.441020] [<c089ba38>] (driver_register) from [<c144edb8>] (imx_uart_init+0x20/0x40)
>> [   15.441090] [<c144edb8>] (imx_uart_init) from [<c010232c>] (do_one_initcall+0x80/0x3ac)
>> [   15.441162] [<c010232c>] (do_one_initcall) from [<c1400ff0>] (kernel_init_freeable+0x170/0x204)
>> [   15.441241] [<c1400ff0>] (kernel_init_freeable) from [<c0dd5c48>] (kernel_init+0x8/0x118)
>> [   15.441313] [<c0dd5c48>] (kernel_init) from [<c0100134>] (ret_from_fork+0x14/0x20)
>> [   15.441414] Exception stack(0xc609ffb0 to 0xc609fff8)
>> [   15.441571] ffa0:                                     00000000 00000000 00000000 00000000
>> [   15.441738] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> [   15.441872] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
> 

