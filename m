Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E534C388F9
	for <linux-serial@archiver.kernel.org>; Sat, 21 Nov 2020 15:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB1512224C
	for <linux-serial@archiver.kernel.org>; Sat, 21 Nov 2020 15:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgKUPR2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 21 Nov 2020 10:17:28 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42076 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgKUPR1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 21 Nov 2020 10:17:27 -0500
Received: by mail-lf1-f68.google.com with SMTP id u18so17675319lfd.9;
        Sat, 21 Nov 2020 07:17:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YhyylT6KFhdowDIfJnJ40q7bI+v1PdaWRmLJxQFG7pA=;
        b=S3kEvDrwCE/i/Ta1ma7s1G1QFteFQlkJNxwJkApXFJ6VA7PPStDOFZoBqO1JRoRgHX
         25PXGPAIr+ahNDmnxd4GpuTWTyd6uUC9w8iaNIXp//Z1Vc7cIw0HS7bqAp8CMDStc0Jo
         EJXLHKP6e2lOb7U2QaPIBRmwH81dTWvw366X/ZjOaSY6yahmkjGcL3lZvHYFRad787R9
         5qCSVUmHpkIAJQs5CPGhetA+NtdE4iMdKY50Iu4yq5AxhM2CJJd/qqocP6ANHhBvwuf4
         aqLoGyejN5cOHDBWIfZyXdKx+07w751d80WEY6gT/RgZaKClehmgKs5DusT13E1OFfN1
         GpKg==
X-Gm-Message-State: AOAM533rmjno7LqSmt3vXu6IwNXk/OLLUBhz97SlO125r6xiCgqdNEzN
        PQSrPdOtC9JoUqidiTBJqkb4CANE/HJEkw==
X-Google-Smtp-Source: ABdhPJxG2SMsWy4gPbQN0ptYATRYhdlYy63rFINniGlIWK6dZehzcROeYtUq0q97YpOgpM4WDwn8yQ==
X-Received: by 2002:a05:6512:10c9:: with SMTP id k9mr9807523lfg.40.1605971844938;
        Sat, 21 Nov 2020 07:17:24 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id e14sm733549lfd.145.2020.11.21.07.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 07:17:23 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kgUdm-0007CG-Q7; Sat, 21 Nov 2020 16:17:31 +0100
Date:   Sat, 21 Nov 2020 16:17:30 +0100
From:   Johan Hovold <johan@kernel.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Johan Hovold' <johan@kernel.org>,
        "tiantao (H)" <tiantao6@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tian Tao <tiantao6@hisilicon.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "afaerber@suse.de" <afaerber@suse.de>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tty: serial: replace spin_lock_irqsave by spin_lock in
 hard IRQ
Message-ID: <X7kviiRwuxvPxC8O@localhost>
References: <1605776489-16283-1-git-send-email-tiantao6@hisilicon.com>
 <X7d85DKvisjA3nYv@localhost>
 <9ce93d7b-f769-58ed-e6bf-95c34bd0123e@huawei.com>
 <X7e7dYlYxPDsj71G@localhost>
 <40a52ea2273146b98b3ae3439a22d1eb@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40a52ea2273146b98b3ae3439a22d1eb@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 20, 2020 at 08:00:05PM +0000, David Laight wrote:
> From: Johan Hovold
> > Sent: 20 November 2020 12:50
> > 
> > On Fri, Nov 20, 2020 at 07:25:03PM +0800, tiantao (H) wrote:
> > > 在 2020/11/20 16:23, Johan Hovold 写道:
> > > > On Thu, Nov 19, 2020 at 05:01:29PM +0800, Tian Tao wrote:
> > > >> The code has been in a irq-disabled context since it is hard IRQ. There
> > > >> is no necessity to do it again.
> > > >>
> > > >> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> > > >> ---
> > > >>   drivers/tty/serial/owl-uart.c | 5 ++---
> > > >>   1 file changed, 2 insertions(+), 3 deletions(-)
> > > >>
> > > >> diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
> > > >> index c149f8c3..472fdaf 100644
> > > >> --- a/drivers/tty/serial/owl-uart.c
> > > >> +++ b/drivers/tty/serial/owl-uart.c
> > > >> @@ -251,10 +251,9 @@ static void owl_uart_receive_chars(struct uart_port *port)
> > > >>   static irqreturn_t owl_uart_irq(int irq, void *dev_id)
> > > >>   {
> > > >>   	struct uart_port *port = dev_id;
> > > >> -	unsigned long flags;
> > > >>   	u32 stat;
> > > >>
> > > >> -	spin_lock_irqsave(&port->lock, flags);
> > > >> +	spin_lock(&port->lock);
> > > >
> > > > Same thing here; this will break with forced irq threading (i.e.
> > > > "threadirqs") since the console code can still end up being called from
> > > > interrupt context.
> > 
> > > As the following code shows, owl_uart_irq does not run in the irq
> > > threading context.
> > >   ret = request_irq(port->irq, owl_uart_irq, IRQF_TRIGGER_HIGH,
> > >                          "owl-uart", port);
> > >          if (ret)
> > >                  return ret;
> > 
> > It still runs in a thread when interrupts are forced to be threaded
> > using the kernel parameter "threadirqs".
> > 
> > We just had a revert of a change like yours after lockdep reported the
> > resulting lock inversion with forced interrupt threading.
> > 
> > Whether drivers should have to care about "threadirqs" is a somewhat
> > different question. Not sure how that's even supposed to work generally
> > unless we mass-convert drivers to spin_lock_irqsave() (or mark their
> > interrupts IRQF_NO_THREAD).
> 
> Isn't that backwards?
> 
> You need to use the 'irqsave' variant in code that might run with
> interrupts enabled because an interrupt might try to acquire the
> same lock having interrupted the code that already holds the lock.
> 
> If interrupts run as separate threads that can never happen.
> So in that case all code can use the non-irqsave call.
> 
> So either lockdep is broken or you have a different bug.

Not all interrupts run as threads with "threadirqs" so the lock can
potentially still be taken in hard IRQ context also with forced
threading.

For console drivers this can even happen for the same interrupt as the
generic interrupt code can call printk(), and so can any other handler
that isn't threaded (e.g. hrtimers or explicit IRQF_NO_THREAD).

If a driver exposes an interface that can be called in hard IRQ context,
it must use spin_lock_irqsave() in its interrupt handler (or use
IRQF_NO_THREAD) because of "threadirqs".

Johan
