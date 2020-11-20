Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4EAC64EBC
	for <linux-serial@archiver.kernel.org>; Fri, 20 Nov 2020 12:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D94A22236F
	for <linux-serial@archiver.kernel.org>; Fri, 20 Nov 2020 12:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgKTMt5 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Nov 2020 07:49:57 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37049 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbgKTMt5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Nov 2020 07:49:57 -0500
Received: by mail-lf1-f67.google.com with SMTP id s30so13295569lfc.4;
        Fri, 20 Nov 2020 04:49:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ihaqIlNyoXPWgNUx0pqd6VTxIMabScCyo7XaTtTbQ6k=;
        b=fqGOWhH2PV1hwBO7ccVACQK7sEWIw7TnqdVugoL0bFbzoNLGYwY6L+8wnTcEGPg0ba
         Y27Oih8srfzPqv/P0IuPQIetNDp+8Z+rgWuF8U7IBQ4GOK2N7WkQV0fGDqlGtVknfM/8
         PnCggmalCZVfUKCtYGbTNtlQKk97FLxi+J6DTbtXjlzUxm6fpGxF32pdYGdaOMpsBnjI
         5rirdX0sjDZCvsxRAqAymI3Yz5g0KRM8hYQt99MkbJnuMRTeeEYc//VhTnprGzSlykAa
         lDuiKS74jkyR1+D3FEWPVGPcOuLg/SK2FmvJZxEFnrO3FuRzIWYNlTxBuPdBmMasB7a/
         QvYg==
X-Gm-Message-State: AOAM530vTbzFGH2oGQBu2KgUqO4MJrXlE+60KpJF+Da7fRLJyF8XJl//
        VVbm1vlY7JMP6xlOJ+S7DD0=
X-Google-Smtp-Source: ABdhPJwhIKBQ9azhAbSVWT0L5aAOQm6FWyfUQCXxX/5MNNYPLDo1FPdvCXE3+ytVP7hoUjJA+xzVpA==
X-Received: by 2002:ac2:44ac:: with SMTP id c12mr8648105lfm.602.1605876594084;
        Fri, 20 Nov 2020 04:49:54 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id z4sm271546ljh.55.2020.11.20.04.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 04:49:53 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kg5rR-0007pd-Qp; Fri, 20 Nov 2020 13:49:57 +0100
Date:   Fri, 20 Nov 2020 13:49:57 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "tiantao (H)" <tiantao6@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Johan Hovold <johan@kernel.org>, Tian Tao <tiantao6@hisilicon.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: replace spin_lock_irqsave by spin_lock in
 hard IRQ
Message-ID: <X7e7dYlYxPDsj71G@localhost>
References: <1605776489-16283-1-git-send-email-tiantao6@hisilicon.com>
 <X7d85DKvisjA3nYv@localhost>
 <9ce93d7b-f769-58ed-e6bf-95c34bd0123e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ce93d7b-f769-58ed-e6bf-95c34bd0123e@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 20, 2020 at 07:25:03PM +0800, tiantao (H) wrote:
> 在 2020/11/20 16:23, Johan Hovold 写道:
> > On Thu, Nov 19, 2020 at 05:01:29PM +0800, Tian Tao wrote:
> >> The code has been in a irq-disabled context since it is hard IRQ. There
> >> is no necessity to do it again.
> >>
> >> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> >> ---
> >>   drivers/tty/serial/owl-uart.c | 5 ++---
> >>   1 file changed, 2 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
> >> index c149f8c3..472fdaf 100644
> >> --- a/drivers/tty/serial/owl-uart.c
> >> +++ b/drivers/tty/serial/owl-uart.c
> >> @@ -251,10 +251,9 @@ static void owl_uart_receive_chars(struct uart_port *port)
> >>   static irqreturn_t owl_uart_irq(int irq, void *dev_id)
> >>   {
> >>   	struct uart_port *port = dev_id;
> >> -	unsigned long flags;
> >>   	u32 stat;
> >>   
> >> -	spin_lock_irqsave(&port->lock, flags);
> >> +	spin_lock(&port->lock);
> > 
> > Same thing here; this will break with forced irq threading (i.e.
> > "threadirqs") since the console code can still end up being called from
> > interrupt context.

> As the following code shows, owl_uart_irq does not run in the irq 
> threading context.
>   ret = request_irq(port->irq, owl_uart_irq, IRQF_TRIGGER_HIGH,
>                          "owl-uart", port);
>          if (ret)
>                  return ret;

It still runs in a thread when interrupts are forced to be threaded
using the kernel parameter "threadirqs".

We just had a revert of a change like yours after lockdep reported the
resulting lock inversion with forced interrupt threading.

Whether drivers should have to care about "threadirqs" is a somewhat
different question. Not sure how that's even supposed to work generally
unless we mass-convert drivers to spin_lock_irqsave() (or mark their
interrupts IRQF_NO_THREAD).

Thomas, any comments?

Johan
