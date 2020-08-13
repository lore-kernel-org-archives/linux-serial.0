Return-Path: <SRS0=hLv5=BX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBCCC433DF
	for <linux-serial@archiver.kernel.org>; Thu, 13 Aug 2020 05:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89E3B20768
	for <linux-serial@archiver.kernel.org>; Thu, 13 Aug 2020 05:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvW+5p9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgHMFGd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Aug 2020 01:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgHMFGc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Aug 2020 01:06:32 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB03C061757;
        Wed, 12 Aug 2020 22:06:32 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d22so2204614pfn.5;
        Wed, 12 Aug 2020 22:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l7Gd3m+l+WQZG6hx+TJ+/PJV8/ZKvFTo9d5/gMASdug=;
        b=jvW+5p9xSWMOLmI2q5K1VeRNAcla5WpZdkSsOySFkmZkwU4xtNGjiFsfDxryGSDiFz
         /bkUHqrBsr7/+cJiwQmXUv8pg8Ziph77TbwheglQaEgcS4s6tQz0POS0DF6CuAUkTnr1
         7jeFYdOqq5mHJ2DrhcB6pBthTBPo/j7jBj2cxVn169zEWg/kzzFGh6FRDUW+G0d543Wo
         6m92oIkIrqt1Klm8Y/s+vA6epCGke1g3FHHkNuAAZ0ab7MsrSG1D0ekCPIydUmP1gsO/
         z3KvuAIF/h7/+oubCWHixYdk8Z1W/9fFao3/D7RFkzRaBMDeBB6lVN9HZphqanHy8I0C
         FPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=l7Gd3m+l+WQZG6hx+TJ+/PJV8/ZKvFTo9d5/gMASdug=;
        b=Ji0HCdxqgImV45wxGwrWXaSMGxP8q16zN5I0fhf6exeJaooot9d5oWG3g2yWPXqqqu
         AzcX9p4u6g/AyhKhN2Lxqzkj7KqZPGLpu+RoxQ+gT/NDfvJVPj8Yx356rx5IQUVVjuPD
         fsY24nqKIMKeZf1qbtKx25TFwMPR30EbHsCNwquPaBo4Co5a8g5/rDkJuyubfIqSGmAt
         sZIsGYqbENKUTJ3xJ9N8RQz3LvzrPFjnbQq+W9OQ5J/s+7wu04/pEFjseUdUVZ48zjg9
         FJ3r1VyMWkLMWmCPpwBhWa+WTwT+W1WuNaWORzK+Y+dcCdLNmbCtyWSIlICIlUQxUuAZ
         /NqA==
X-Gm-Message-State: AOAM531xgUNRy4UpXZnJFwktcFp5/W+4SAKNNPkcTeiGPD1uYDY7gK0o
        b1ku0iMcaeUDFVpxAyrYpWg=
X-Google-Smtp-Source: ABdhPJwn8XLNWsyFJJI90LfEQmbYsg1NbcOao3/9lM5cvVg4Lb6UWgILt234JkAwNaKWO+PJUKPPsw==
X-Received: by 2002:a65:620f:: with SMTP id d15mr2182119pgv.270.1597295191721;
        Wed, 12 Aug 2020 22:06:31 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j8sm4283364pfh.90.2020.08.12.22.06.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Aug 2020 22:06:30 -0700 (PDT)
Date:   Wed, 12 Aug 2020 22:06:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Recursive/circular locking in
 serial8250_console_write/serial8250_do_startup
Message-ID: <20200813050629.GA95559@roeck-us.net>
References: <20200812154813.GA46894@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812154813.GA46894@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 12, 2020 at 08:48:13AM -0700, Guenter Roeck wrote:
> Hi,
> 
> crbug.com/1114800 reports a hard lockup due to circular locking in the
> 8250 console driver. This is seen if CONFIG_PROVE_LOCKING is enabled.
> 
> Problem is as follows:
> - serial8250_do_startup() locks the serial (console) port.
> - serial8250_do_startup() then disables interrupts if interrupts are
>   shared, by calling disable_irq_nosync().
> - disable_irq_nosync() calls __irq_get_desc_lock() to lock the interrupt
>   descriptor.
> - __irq_get_desc_lock() calls lock_acquire()
> - If CONFIG_PROVE_LOCKING is enabled, validate_chain() and check_noncircular()
>   are called and identify a potential locking error.
> - This locking error is reported via printk, which ultimately calls
>   serial8250_console_write().
> - serial8250_console_write() tries to lock the serial console port.
>   Since it is already locked, the system hangs and ultimately reports
>   a hard lockup.
> 
> I understand we'll need to figure out and fix what lockdep complains about,
> and I am working on that. However, even if that is fixed, we'll need a
> solution for the recursive lock: Fixing the lockdep problem doesn't
> guarantee that a similar problem (or some other log message) won't be
> detected and reported sometime in the future while serial8250_do_startup()
> holds the console port lock.
> 
> Ideas, anyone ? Everything I came up with so far seems clumsy and hackish.
> 

Turns out the situation is a bit worse than I thought. disable_irq_nosync(),
when called from serial8250_do_startup(), locks the interrupt descriptor.
The order of locking is
	serial port lock
	  interrupt descriptor lock

At the same time, __setup_irq() locks the interrupt descriptor as well.
With the descriptor locked, it may report an error message using pr_err().
This in turn may call serial8250_console_write(), which will try to lock
the console serial port. The lock sequence is
	interrupt descriptor lock
	  serial port lock

I added the lockdep splat to the bug log at crbug.com/1114800.

Effectively, I think, this means we can't call disable_irq_nosync()
while holding a serial port lock, or at least not while holding a
serial port lock that is associated with a console.

The problem was introduced (or, rather, exposed) with upstream commit
7febbcbc48fc ("serial: 8250: Check UPF_IRQ_SHARED in advance").

Guenter
