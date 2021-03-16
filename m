Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C55C433E6
	for <linux-serial@archiver.kernel.org>; Tue, 16 Mar 2021 09:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91C1F6501C
	for <linux-serial@archiver.kernel.org>; Tue, 16 Mar 2021 09:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbhCPJ5I (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Mar 2021 05:57:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236480AbhCPJ4o (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Mar 2021 05:56:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBAD665014;
        Tue, 16 Mar 2021 09:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615888603;
        bh=VZtm7TSm8SzD7rqru+ra4hRXldt8i3ssgmXztshpEgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YLqiHjh4YLI55r4/HmzYiPyoGVqrBh0rM8DG4WoZaSI+TH2KpSaCyH6jmC6+pp4XZ
         EAf9FImMvb3TI7Jw5iZGA/9WdRHTESg53CzDcxzD7ssQzk2S17FMJipTbR8cq0muYl
         rsbtApe/1UYMj1DNbDGjsj7jQWhu9JyUbV1MVMhiAqfXtJ1DXyvsmkHiejZCgMT4n4
         bIJ8LTykBSwiN8p5qmGfDC/JeXWvHwZW08JAfmFJgrOWltqQldMVFYMmJ6+bb8Sx/1
         NazFbM/dcO9FgvDXx9VHa6LKTOfbsYaZV/+Pp3BayS1EBcuAFn5cf4L6C01AOlbSHw
         pXCCNyERqxH8A==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lM6Ra-0000aJ-QE; Tue, 16 Mar 2021 10:56:55 +0100
Date:   Tue, 16 Mar 2021 10:56:54 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcan@marcan.st, arnd@kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] tty: serial: samsung_tty: remove spinlock flags in
 interrupt handlers
Message-ID: <YFCA5jFLV0Cu9YNe@hovoldconsulting.com>
References: <20210315181212.113217-1-krzysztof.kozlowski@canonical.com>
 <YFB0OcBg3Vj555eA@hovoldconsulting.com>
 <7f348e4c-3051-13cf-d461-eeda0ef53fdd@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f348e4c-3051-13cf-d461-eeda0ef53fdd@canonical.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 16, 2021 at 10:47:53AM +0100, Krzysztof Kozlowski wrote:
> On 16/03/2021 10:02, Johan Hovold wrote:
> > On Mon, Mar 15, 2021 at 07:12:12PM +0100, Krzysztof Kozlowski wrote:
> >> Since interrupt handler is called with disabled local interrupts, there
> >> is no need to use the spinlock primitives disabling interrupts as well.
> > 
> > This isn't generally true due to "threadirqs" and that can lead to
> > deadlocks if the console code is called from hard irq context.
> > 
> > Now, this is *not* the case for this particular driver since it doesn't
> > even bother to take the port lock in console_write(). That should
> > probably be fixed instead.
> > 
> > See https://lore.kernel.org/r/X7kviiRwuxvPxC8O@localhost.
> 
> Thanks for the link, quite interesting! For one type of device we have
> two interrupts (RX and TX) so I guess it's a valid point/risk. However
> let me try to understand it more.
> 
> Assuming we had only one interrupt line, how this interrupt handler with
> threadirqs could be called from hardirq context?

No, it's console_write() which can end up being called in hard irq
context and if that path takes the port lock after the now threaded
interrupt handler has been preempted you have a deadlock.

> You wrote there:
> > For console drivers this can even happen for the same interrupt as the
> > generic interrupt code can call printk(), and so can any other handler
> > that isn't threaded (e.g. hrtimers or explicit IRQF_NO_THREAD).
> 
> However I replaced here only interrupt handler's spin lock to non-irq.
> This code path will be executed only when interrupt is masked therefore
> for one interrupt line there is *no possibility of*:
> 
> -> s3c64xx_serial_handle_irq
>    - interrupts are masked
>    - s3c24xx_serial_tx_irq
>      - spin_lock()
>                        -> hrtimers or other IRQF_NO_THREAD
>                           - console_write() or something
>                             - s3c64xx_serial_handle_irq

You don't end up in s3c64xx_serial_handle_irq() here. It's just that
console_write() (typically) takes the port lock which is already held by
the preempted s3c24xx_serial_tx_irq().

>                               - s3c24xx_serial_tx_irq
>                                 - spin_lock()

Johan
