Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38804C48BE8
	for <linux-serial@archiver.kernel.org>; Mon, 14 Jun 2021 09:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C40D61009
	for <linux-serial@archiver.kernel.org>; Mon, 14 Jun 2021 09:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhFNKAG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbhFNKAG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Jun 2021 06:00:06 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7140CC061574
        for <linux-serial@vger.kernel.org>; Mon, 14 Jun 2021 02:57:49 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q15so8173375pgg.12
        for <linux-serial@vger.kernel.org>; Mon, 14 Jun 2021 02:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5emckVGTTJ1gqTlVJC5F+2X4uXYUvs6MgCbuSxo4+Fg=;
        b=bmxrvzKfOOXypOYzOMgRs1Lkw07NwpI95SENojDZrRvvLxb8rqfLOiLY3V1wxaFhkO
         vBPejhKgb3ijXgstKrMzNC2IPFJsIK9BNuW4V+A8ThCbZR8aJ78VPQRjWUhPySVXscwz
         Xq0jmS4nQLS4Ic9ZOdmhRugRUDUShH1mVhrGVYZBdd7ueGVfSjOMtaCT2tzWhjzwSJin
         RJDPE1yRjiQT6OFKJufDsn/zuTdtzI1ReIEwj0JMVoD3Rl7ZZExZiW8OXTiNA27Uh3Gy
         8kqieThdkov3XV6Bv4z7zmztx4vWTZU6/0wgli9qNRefrDfnXd4fddzsztvGOkif4v1m
         KrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5emckVGTTJ1gqTlVJC5F+2X4uXYUvs6MgCbuSxo4+Fg=;
        b=NlbYy+cEY2HwyDKklBcqsMEKYl1+q48J4gBXaXPToKo407ko1II64rGufx58JSJWO3
         TmlwliUcNhmELlhNdzoyHNuWUnzOm5a9BCVxnPyyVS2Plgq9NOeEvWFQ8gPbuuyuKQ5x
         mCY+quWnr5XIQYGqV6CgCgwZsi0DUITvrB8O3Dp/iPBE5XZRk/0uLLiToq2CSFxGrdr1
         9GQasz4aFh/fCttvx2BUZ8bwHkSKDhfQMV9vAlzd+//CShpld3IUv7x73oKywatee8pL
         yQUhePFikOyAqPSTK42u+pRWBs0tdJIzffYi33DXwWSBa5uhETZBeEAEblKwyYmetiQt
         p2Rw==
X-Gm-Message-State: AOAM532Y7L/HOkEZR3SAiWhdrYSRzwVjlVLpsTo7+UfU6pMf+k+Jd+fU
        W12CyMh3RH7k7xm+3QMI9nE=
X-Google-Smtp-Source: ABdhPJxbgKciud5V/cH7yKjOOww1neEeONdVflSg4A1tahgn84bm26ebXLfctxKVHNsGVpNob8TH6A==
X-Received: by 2002:aa7:828f:0:b029:200:6e27:8c8f with SMTP id s15-20020aa7828f0000b02902006e278c8fmr20973366pfm.44.1623664668885;
        Mon, 14 Jun 2021 02:57:48 -0700 (PDT)
Received: from [192.168.0.118] ([103.242.196.232])
        by smtp.gmail.com with ESMTPSA id h12sm12224919pfh.9.2021.06.14.02.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 02:57:48 -0700 (PDT)
Subject: Re: [question] Is it possible to remove an active port (without
 shutdown)?
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        ldv-project@linuxtesting.org, andrianov@ispras.ru
References: <07b2ccfa-cf98-54a2-d03c-50507de06d52@gmail.com>
 <YMMxHFkhr7UDgk4o@kroah.com>
From:   Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
Message-ID: <b1131796-10c6-469b-34d9-be398de406b9@gmail.com>
Date:   Mon, 14 Jun 2021 15:27:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMMxHFkhr7UDgk4o@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 6/11/21 3:17 PM, Greg KH wrote:
> On Fri, Jun 11, 2021 at 03:03:42PM +0530, Saubhik Mukherjee wrote:
>> Consider the following events involving drivers/tty/serial/owl-uart.c:
>>
>> Suppose the driver is registered, and the owl_uart_probe() was called.
>> Then uart_startup() can be called in serial core. This calls
>> owl_uart_startup() which registers the interrupt handler owl_uart_irq.
>>
>> Now suppose uart_remove_one_port() in serial core is called. This
>> detaches port from the core. This calls owl_uart_release_port(port).
>> This writes NULL to port->membase after iounmap of port->membase from
>> port->dev.
>>
>> During this point, an interrupt is triggered and the interrupt callback
>> owl_uart_irq() is called (parallel with uart_remove_one_port()). This
>> tries to read port->membase to send or receive chars (with spinlock on
>> port->lock). This introduces a race condition on port->membase.
>>
>> QUESTION: Is it possible to remove an active port (without shutdown)?
> 
> You can remove it, if the driver is set up to do so properly.  Odds are
> the owl-uart code is not written to expect that to ever happen.
> 
> How are you "removing" an active port?  What triggers this action?

Thank you for the reply.

The active port is removed (without shutdown) due to the platform 
callback owl_uart_remove() during de-registration of the platform 
driver. The race condition described is due to the interrupt handler, 
owl_uart_irq(), executing in parallel.
