Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3024C433ED
	for <linux-serial@archiver.kernel.org>; Fri, 16 Apr 2021 08:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A42F6115B
	for <linux-serial@archiver.kernel.org>; Fri, 16 Apr 2021 08:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbhDPI6A (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 16 Apr 2021 04:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbhDPI6A (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Apr 2021 04:58:00 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C07DC061756;
        Fri, 16 Apr 2021 01:57:34 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id b17so22521456ilh.6;
        Fri, 16 Apr 2021 01:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M41GXL+PjIBxhmb0o54t+3XJBKJFPW9+U1USw54R9hY=;
        b=fhGyue5C+F26oxcl+7iNvwj2auKwyobI/O6r5AZdpToMxHOPtb8ytmeJwDnpskPK7u
         Tjv4krNvFKdcPLqRB4jut/B2+MggQMfI/d3hDhU7t7Vf439lnzP/HS6RWzUChteD6X/H
         c9cDyG5fYDjKECOoXcrlVdZ27qfOMI2mhIggLxn9NuzzZUPaharXbCd9Mh0Vd7uaZR4C
         NSI0qnpagovoeEjNSGzZ2OL0gEwqEmNgLBuDGeRV6g9p1w+LLp4jZRSVrMckdUeEtcNh
         3Llc5xLE/q/5FvR3mZtbEaW5Ni/Aernc5nogsYvkKUg24KuzFaNQOVwJsD0i5QQrN2aF
         E5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M41GXL+PjIBxhmb0o54t+3XJBKJFPW9+U1USw54R9hY=;
        b=kVeccXG1Z+S/SwHMyeSTVZgmGq7KRpk72/YCcyb7zPoGLBAWyqgyYiR+CN3ZpNOX8s
         2JT40WnL72Fic7qZf/Di/FO7Hi8No64GLyMJ+8sct8WQWBUqC17EPlQ0jz4UGQQxlncB
         EfzW07unjd16O06Nbn8dvo2pxkOI0GdZc+tx2JsVm0vR+SCE1Tkt73PeyLF1/1RSbkmR
         ozKMJNRGQh24QgsQ7XZMK6hp88kUtkNQURKdiTxBf0P8A5K/tJcp0mo023DFRKvX+V0K
         23UUg+2FVsSq4Ow+K0n3thOPiKtlUb5jY9n61WhPnwwiRF9TntcS4gcxCSxy8hrnR72K
         f5bw==
X-Gm-Message-State: AOAM530N/69t8Psiwt8EufsfdE/W1yVzjhZy+sqV+syA+S1Amu1c8T9+
        wnLQ43HgeeZ7qsMUo1gWq0TcGWvYhxYO7cSRbG4=
X-Google-Smtp-Source: ABdhPJwMMdZeIC/59rPjHi9k0xK3kulpo9R2Ei3Ee4tP58bhwp/eQ1V/Y3zd+9pcWUL43L/jea9JZDo70ghxCbCY9fA=
X-Received: by 2002:a05:6e02:684:: with SMTP id o4mr6180647ils.218.1618563453889;
 Fri, 16 Apr 2021 01:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <1618219898-4600-1-git-send-email-dillon.minfei@gmail.com>
 <YHRGPpQ03XgBMkiy@hovoldconsulting.com> <CAL9mu0JF-9hy3Z_ytpEO+hzKh0D+f-0gYaUBEA0v28EOHpC80w@mail.gmail.com>
 <CAL9mu0Ke97FUZ03jvdH8Lz2qRnVY82B7tAEtjbhW97sPOVkAxQ@mail.gmail.com> <YHlMYZCCxL+SS9ye@hovoldconsulting.com>
In-Reply-To: <YHlMYZCCxL+SS9ye@hovoldconsulting.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Fri, 16 Apr 2021 16:56:57 +0800
Message-ID: <CAL9mu0K4L-vGL1EyYc+p0q7tadQ39-VHcp1nd4gZs_HGKSmP2w@mail.gmail.com>
Subject: Re: [PATCH v2] serial: stm32: optimize spin lock usage
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        kernel test robot <lkp@intel.com>,
        linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Gerald Baeza <gerald.baeza@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Johan,

On Fri, Apr 16, 2021 at 4:35 PM Johan Hovold <johan@kernel.org> wrote:
>
> On Tue, Apr 13, 2021 at 07:44:39AM +0800, dillon min wrote:
> > Hi Johan, Erwan
> >
> > It seems still a bit of a problem in the current version, not deadlock
> > but access register at the same time.
> >
> > For driver , we should consider it running under smp, let's think
> > about it for this case:
> >
> > static void stm32_usart_console_write(struct console *co, const char *s,
> >                                       unsigned int cnt)
> > {
> >          .....
> >          local_irq_save(flags);
> >          if (port->sysrq)
> >                     locked = 0;
> >          .....
> >          access register cr1, tdr, isr
> >          .....
> >
> >          local_irq_restore(flags);
> > }
> >
> > if port->sysrq is 1, stm32_usart_console_write() just disable local
> > irq response by local_irq_save(), at the time of access register cr1,
> > tdr, isr. an TXE interrupt raised, for other cores(I know stm32
> > mpu/mcu do not have multi cores, just assume it has), it still has a
> > chance to handle interrupt.  Then there is no lock to protect the uart
> > register.
>
> Right, the sysrq handling is a bit of a hack.
>
> > changes to below, should be more safe:
> >
> > .....
> > if (port->sysrq || oops_in_progress)
> >       locked = spin_trylock_irqsave(&port->lock, flags);
>
> Except that the lock debugging code would detect the attempt at
> recursive locking here and complain loudly on UP.
>
> If you really want to fix this, we have uart_unlock_and_check_sysrq()
> which can be used to defer sysrq processing until the interrupt handler
> has released the lock.

Great, uart_unlock_and_check_sysrq() is fit to fix this. you mean make
the flow like below:

    stm32_usart_threaded_interrupt()
      spin_lock(&port->lock);
      uart_unlock_and_check_sysrq(port, flags);
      ...
      uart_prepare_sysrq_char();
          printk();
            stm32_usart_console_write();
              locked = spin_trylock_irqsave(&port->lock); //only
handle oops, normal case

If so, I will submit v3 as you suggested. thanks.

Best regards.
Dillon,
>
> > else
> >       spin_lock_irqsave(&port->lock, flags);
> >
> > ....
> >
> > if (locked)
> >      spin_unlock_irqrestore(&port->lock, flags);
>
> Johan
