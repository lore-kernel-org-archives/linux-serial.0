Return-Path: <SRS0=Q4yL=AE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACCCC433E0
	for <linux-serial@archiver.kernel.org>; Tue, 23 Jun 2020 09:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 534EA20774
	for <linux-serial@archiver.kernel.org>; Tue, 23 Jun 2020 09:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y7xQpZIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731976AbgFWJ72 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731947AbgFWJ72 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Jun 2020 05:59:28 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397D1C061755
        for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2020 02:59:28 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id g2so11354909lfb.0
        for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2020 02:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+qNNJvPj82XIpOTVemM+3ukaRdqJiO16sjw+SINvto=;
        b=Y7xQpZIELfj/IZLk6F58JA8yjaXRzK+OnoXwh0e5UY0T8XwF0JRi2sp3Vb55Apjdzl
         BSi6UOkqflqZjIYef8cv7UxPHjAA7/9KsKdrR33U13EOqr6h7bg/dR9Jdk+NWpJ8ymvX
         UC91iFxPSo9US6Co4+ZY1nXR8EW3/62ZjhAtls1kbdPJyw6mkaQEom/7iVp7+YWPwabA
         +5bSyhJu5g7bdXz/lfL0GoXdTwOvdUjPK3YJ1ao7j0OWPdryjFjv4/6hhg/rbmEMXVpa
         t/vrA87fmv4g3N0UtF4wcqAXTkgVFEhyCwu6KMP+BLan277W8KfEFtrcCa/f7aV/o/6h
         ql1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+qNNJvPj82XIpOTVemM+3ukaRdqJiO16sjw+SINvto=;
        b=MK986lLFeU9rM4zx7NRygRlIrR/GsHIAiTl57MQx7jmLFBKH8vE3gPiXvalTFcoVJS
         kGP0uCPZDhBlA5tu6fHmie3eXZKQyGmIQo9K/TBrUs/IlNQk6OdVqo9yw0312n3ZoJFV
         I+isWMpaM9NjvlKaQnSviaEx/ctXL5Bv3fdKUGiX1qoq0Nm7VExqlrnKnEuJm1O+BwTu
         qoG0NfDdg3T4ySq6txt4IoZzq9A9l4hNo47/Lhm/AS9UnSAUtQRv2YqINykr5/w3Vqt6
         ujU3Oh5ZIoYLYd/KmNC7fbo/d2xdz4Gvb3J8Z5Mjfa9pPYKrhApBQFeOftHEcNg2hEMl
         6KwA==
X-Gm-Message-State: AOAM533/gQD+fJ7SxvuAIxIfv27zOnlc6e8aq93dboWSsXR28Y/8DKms
        tSBF0+TdV3aTO/BFavqn3RKKaZonDScvuhaCePeF/g==
X-Google-Smtp-Source: ABdhPJxkpAaMxPSdM3YL9bHG+P55yNE/K8vEWIahviaLzu2MN/Htj2Uu74ty5Acituc9zXDbDVkVHS+V8RASHfrlfXQ=
X-Received: by 2002:ac2:47ed:: with SMTP id b13mr4365995lfp.21.1592906366549;
 Tue, 23 Jun 2020 02:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
 <1592835984-28613-5-git-send-email-sumit.garg@linaro.org> <20200622163621.s2322lmlv674bsds@holly.lan>
In-Reply-To: <20200622163621.s2322lmlv674bsds@holly.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 23 Jun 2020 15:29:15 +0530
Message-ID: <CAFA6WYNc7hdagBknFGjSF3rXnKGXL4FY+PutkA8iensv9dJHEg@mail.gmail.com>
Subject: Re: [PATCH 4/7] serial: kgdb_nmi: Add support for interrupt based fallback
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 22 Jun 2020 at 22:06, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Jun 22, 2020 at 07:56:21PM +0530, Sumit Garg wrote:
> > From: Daniel Thompson <daniel.thompson@linaro.org>
> >
> > Add a generic NMI fallback to support kgdb NMI console feature which can
> > be overridden by arch specific implementation.
>
> arch_kgdb_ops.enable_nmi should probably be killed off. Given we now
> have request_nmi() I'm dubious there are any good reasons to use this
> API.
>

Sounds reasonable. Along with this, kgdb_nmi_poll_knock() seems to be
unused and can be removed as well.

-Sumit

>
> Daniel.
>
>
> > This common fallback mechanism utilizes kgdb IO based interrupt in order
> > to support entry into kgdb if a user types in kgdb_nmi_magic sequence. So
> > during NMI console init, NMI handler is installed corresponding to kgdb
> > IO based NMI which is invoked when a character is pending and that can be
> > cleared by calling @read_char until it returns NO_POLL_CHAR.
> >
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/tty/serial/kgdb_nmi.c | 47 ++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 40 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
> > index b32c6b1..2580f39 100644
> > --- a/drivers/tty/serial/kgdb_nmi.c
> > +++ b/drivers/tty/serial/kgdb_nmi.c
> > @@ -42,9 +42,46 @@ MODULE_PARM_DESC(magic, "magic sequence to enter NMI debugger (default $3#33)");
> >  static atomic_t kgdb_nmi_num_readers = ATOMIC_INIT(0);
> >  static struct console *orig_dbg_cons;
> >
> > +static int kgdb_nmi_poll_one_knock(void);
> > +
> > +static irqreturn_t kgdb_handle_nmi(int irq, void *dev_id)
> > +{
> > +     int ret;
> > +
> > +     if (kgdb_nmi_knock < 0) {
> > +             kgdb_breakpoint();
> > +             return IRQ_HANDLED;
> > +     }
> > +
> > +     ret = kgdb_nmi_poll_one_knock();
> > +     if (ret == NO_POLL_CHAR)
> > +             return IRQ_NONE;
> > +
> > +     while (ret != 1) {
> > +             ret = kgdb_nmi_poll_one_knock();
> > +             if (ret == NO_POLL_CHAR)
> > +                     return IRQ_HANDLED;
> > +     }
> > +
> > +     kgdb_breakpoint();
> > +     return IRQ_HANDLED;
> > +}
> > +
> >  static int kgdb_nmi_console_setup(struct console *co, char *options)
> >  {
> > -     arch_kgdb_ops.enable_nmi(1);
> > +     int res;
> > +
> > +     if (arch_kgdb_ops.enable_nmi) {
> > +             arch_kgdb_ops.enable_nmi(1);
> > +     } else if (dbg_io_ops->request_nmi) {
> > +             res = dbg_io_ops->request_nmi(kgdb_handle_nmi, co);
> > +             if (res) {
> > +                     pr_err("ttyNMI0: Cannot request nmi/irq\n");
> > +                     return res;
> > +             }
> > +     } else {
> > +             return -ENODEV;
> > +     }
> >
> >       /* The NMI console uses the dbg_io_ops to issue console messages. To
> >        * avoid duplicate messages during kdb sessions we must inform kdb's
> > @@ -328,9 +365,6 @@ int kgdb_register_nmi_console(void)
> >  {
> >       int ret;
> >
> > -     if (!arch_kgdb_ops.enable_nmi)
> > -             return 0;
> > -
> >       kgdb_nmi_tty_driver = alloc_tty_driver(1);
> >       if (!kgdb_nmi_tty_driver) {
> >               pr_err("%s: cannot allocate tty\n", __func__);
> > @@ -380,9 +414,8 @@ int kgdb_unregister_nmi_console(void)
> >  {
> >       int ret;
> >
> > -     if (!arch_kgdb_ops.enable_nmi)
> > -             return 0;
> > -     arch_kgdb_ops.enable_nmi(0);
> > +     if (arch_kgdb_ops.enable_nmi)
> > +             arch_kgdb_ops.enable_nmi(0);
> >
> >       ret = unregister_console(&kgdb_nmi_console);
> >       if (ret)
> > --
> > 2.7.4
> >
