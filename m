Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B75BC433DB
	for <linux-serial@archiver.kernel.org>; Wed, 17 Mar 2021 16:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B1C64E83
	for <linux-serial@archiver.kernel.org>; Wed, 17 Mar 2021 16:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbhCQQKL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 17 Mar 2021 12:10:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51322 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbhCQQJ5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 Mar 2021 12:09:57 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615997396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hwKDld2EP/RjJvTWK3wWLuGLPUOseKk2gXsNIifUgeI=;
        b=BznCf9ZNnwTSz8RBNa/lw+zWvBadwEZRWjH/zpoiEc+TcUvnteaP0kWp4cdnC93sQaVWXe
        TME7LnU/6ULOoC/fAEG1tBWjkZurV0R2h3j2GEZV5OT9W3EK+GzaB8y1Rxx+Bm1nlZAUXw
        5ZyVEYnuFEQMTJUTvxk/WmqvrHQGdUqjym8+9Tav6LrxCmFklMczfw7e8Z5idRDLxs+C17
        BsZ76HVyCa7H+0zr09ZEmYw0q4ecKD74yiNwYuT4cGipZb7481CETsn9R1ZCefaNQgyQtf
        Ju3smpjWhnnAWVNbLmFgi9RFEl4ryaEItrp8UE8K2TzxgS5+F9H08z1jgM/nmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615997396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hwKDld2EP/RjJvTWK3wWLuGLPUOseKk2gXsNIifUgeI=;
        b=FNC2eDXJ7lq6vLSvi176oqorvJAp/JZ7kVofZ0dk49PErO6YLtERACNbwHX3urw39swHw6
        U/PEmQLwG8jaqoDw==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-serial@vger.kernel.org
Subject: Re: [patch 1/1] genirq: Disable interrupts for force threaded handlers
In-Reply-To: <20210317144806.y4dogv6n2s62fpnw@linutronix.de>
References: <20210317143859.513307808@linutronix.de> <20210317144806.y4dogv6n2s62fpnw@linutronix.de>
Date:   Wed, 17 Mar 2021 17:09:55 +0100
Message-ID: <87pmzxyd64.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 17 2021 at 15:48, Sebastian Andrzej Siewior wrote:
> On 2021-03-17 15:38:52 [+0100], Thomas Gleixner wrote:
>> thread(irq_A)
>>   irq_handler(A)
>>     spin_lock(&foo->lock);
>> 
>> interrupt(irq_B)
>>   irq_handler(B)
>>     spin_lock(&foo->lock);
>
> It will not because both threads will wake_up(thread). It is an issue if
> - if &foo->lock is shared between a hrtimer and threaded-IRQ
> - if &foo->lock is shared between a non-threaded and thread-IRQ
> - if &foo->lock is shared between a printk() in hardirq context and
>   thread-IRQ as I learned today.

That's the point and it's entirely clear from the above: A is thread
context and B is hard interrupt context and if the lock is shared then
it's busted. Otherwise we would not have this discussion at all.

