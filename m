Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6939C433EF
	for <linux-serial@archiver.kernel.org>; Tue,  8 Mar 2022 14:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbiCHOoz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 8 Mar 2022 09:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbiCHOoz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Mar 2022 09:44:55 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799FF3F33A
        for <linux-serial@vger.kernel.org>; Tue,  8 Mar 2022 06:43:56 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id n19so11516790lfh.8
        for <linux-serial@vger.kernel.org>; Tue, 08 Mar 2022 06:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iupLQJvgsZ7lCXLV8So/JiMrhE0LlDVXWvrGw7si8ns=;
        b=AEFXCwN0FBkNn7abmOdss/zpAb42JT4Fkk8iML8w+a/pDYnkRl/CV9XkicSMJnNza0
         sZm1s9Tanygh/3zCsXBB91uXVMOj4IEXnrXhB4D9fYup9DptR+lhzWMc0sS2grU4KrVL
         fTziO3Qi+dRYXgx558NAiTWjUIChZ1MUre2agq3wiygbHlVnx8BKnho1Cmh7yRSHeynv
         hM/6AIjQy1rPy8XqJcc4fse0y9uEOUCPNihYAuFjuoAmN38fn8CPdXVAZXUhzm2rDjZh
         MFyDC2paSuRPTQpb5wzl8TQmOFBA0qRC3QwbaJy3cMxT6uR5nzrXfhoHRWwKQj52wD6N
         qeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iupLQJvgsZ7lCXLV8So/JiMrhE0LlDVXWvrGw7si8ns=;
        b=C8vCs+wQuOJWOAZjUudN7kMP/Yd4Tbu7iS9hcS+puadmQuwqJcP82hgt3YWe0J/Jlr
         jV4n//3a0xBue47eefYt3+/7ar5ArbO98lEPa318g3X2FTV6+FEJr8Ucpi6uqSVT5IQw
         IlZ3htuf/jdTTQwGiWVEbp2j1KLdF8zSJ+TUzm/sohyE5u4/tXOcxQjPhvAAtR725jGt
         GzZFvw2RnkMbXxoWIYLlQLk6wRoY5Cw31B0OqmQnAGp7CA1QQmRi0UcPAAx+0i8OpK9E
         twz5udh1uOUT/oSyXeAgEHWpYY74JI06I6gjHHNuA1XzlPuj9yyu7hbpJMKFMdFEDdZG
         tdrg==
X-Gm-Message-State: AOAM533zH7a7sBbfkOJ6F0NtvKaUVi9Q8RcYupLKKB1LFIbiYdB0atEf
        yZyeL9SJLtbgc55kjrnBKfU2npNvTyc2LxpBBi42Tw==
X-Google-Smtp-Source: ABdhPJzpSHaTfLkql6MqsO/zx6ZERRumLVD9HsrUUrBGvSq3NXroYjehKCJTSdrb66KVTytnwwvW6wNphxMcN0BW7z0=
X-Received: by 2002:a05:6512:6ce:b0:448:46c6:b93e with SMTP id
 u14-20020a05651206ce00b0044846c6b93emr1537518lff.46.1646750634776; Tue, 08
 Mar 2022 06:43:54 -0800 (PST)
MIME-Version: 1.0
References: <20220307110328.2557655-1-sumit.garg@linaro.org> <20220307142356.ksx7k5xalqlsxnqk@maple.lan>
In-Reply-To: <20220307142356.ksx7k5xalqlsxnqk@maple.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 8 Mar 2022 20:13:43 +0530
Message-ID: <CAFA6WYNdc5fTk61GB2siLj-EkTtRE0u6fq-MtqF3Zt1uwJqJCw@mail.gmail.com>
Subject: Re: [RFT v4] tty/sysrq: Make sysrq handler NMI aware
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     linux-serial@vger.kernel.org, hasegawa-hitomi@fujitsu.com,
        dianders@chromium.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, jason.wessel@windriver.com,
        linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        arnd@arndb.de, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Daniel,

On Mon, 7 Mar 2022 at 19:53, Daniel Thompson <daniel.thompson@linaro.org> wrote:
>
> On Mon, Mar 07, 2022 at 04:33:28PM +0530, Sumit Garg wrote:
> > Allow a magic sysrq to be triggered from an NMI context. This is done
> > via marking some sysrq actions as NMI safe. Safe actions will be allowed
> > to run from NMI context whilst that cannot run from an NMI will be queued
> > as irq_work for later processing.
> >
> > <snip>
> >
> > @@ -566,12 +573,46 @@ static void __sysrq_put_key_op(int key, const struct sysrq_key_op *op_p)
> >               sysrq_key_table[i] = op_p;
> >  }
> >
> > +static atomic_t sysrq_key = ATOMIC_INIT(-1);
> > +
> > +static void sysrq_do_irq_work(struct irq_work *work)
> > +{
> > +     const struct sysrq_key_op *op_p;
> > +     int orig_suppress_printk;
> > +     int key = atomic_read(&sysrq_key);
> > +
> > +     orig_suppress_printk = suppress_printk;
> > +     suppress_printk = 0;
> > +
> > +     rcu_sysrq_start();
> > +     rcu_read_lock();
> > +
> > +     op_p = __sysrq_get_key_op(key);
> > +     if (op_p)
> > +             op_p->handler(key);
> > +
> > +     rcu_read_unlock();
> > +     rcu_sysrq_end();
> > +
> > +     suppress_printk = orig_suppress_printk;
> > +     atomic_set(&sysrq_key, -1);
> > +}
> > +
> > +static DEFINE_IRQ_WORK(sysrq_irq_work, sysrq_do_irq_work);
> > +
> >  void __handle_sysrq(int key, bool check_mask)
> >  {
> >       const struct sysrq_key_op *op_p;
> >       int orig_log_level;
> >       int orig_suppress_printk;
> >       int i;
> > +     bool irq_work = false;
> > +
> > +     /* Skip sysrq handling if one already in progress */
> > +     if (atomic_cmpxchg(&sysrq_key, -1, key) != -1) {
> > +             pr_warn("Skip sysrq key: %i as one already in progress\n", key);
> > +             return;
> > +     }
>
> Doesn't this logic needlessly jam sysrq handling if the irq_work cannot
> be undertaken?
>

Here this is done purposefully to ensure synchronisation of three
contexts while handling sysrq:
1. Thread context
2. IRQ context
3. NMI context

> A console user could unwittingly attempt an !nmi_safe SysRq action on
> a damaged system that cannot service interrupts. Logic that prevents
> things like backtrace, ftrace dump, kgdb or reboot is actively harmful
> to that user's capability to figure out why their original sysrq doesn't
> work.

I see your point.

>
> I think the logic to prohibht multiple deferred sysrqs should only
> be present on code paths where we are actually going to defer the sysrq.
>

It's not only there to prohibit multiple deferred sysrq (as that alone
could be handled by irq_work_queue()) but rather to avoid parallelism
scenarios that Doug mentioned on prior versions.

How about the following add-on change to allow passthrough for broken
irq_work systems?

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 005c9f9e0004..0a91d3ccf862 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -608,6 +608,15 @@ void __handle_sysrq(int key, bool check_mask)
        int i;
        bool irq_work = false;

+       /*
+        * Handle a case if irq_work cannot be undertaken on a damaged
+        * system stuck in hard lockup and cannot service interrupts.
+        * In such cases we shouldn't atleast block NMI safe handlers
+        * that doesn't depend on irq_work.
+        */
+       if (irq_work_is_pending(&sysrq_irq_work))
+               atomic_set(&sysrq_key, -1);
+
        /* Skip sysrq handling if one already in progress */
        if (atomic_cmpxchg(&sysrq_key, -1, key) != -1) {
                pr_warn("Skip sysrq key: %i as one already in progress\n", key);

-Sumit

>
> Daniel.
