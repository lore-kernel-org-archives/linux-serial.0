Return-Path: <SRS0=BL42=AG=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FC4C433DF
	for <linux-serial@archiver.kernel.org>; Thu, 25 Jun 2020 14:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A24206C0
	for <linux-serial@archiver.kernel.org>; Thu, 25 Jun 2020 14:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="immxbCvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405365AbgFYOok (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405300AbgFYOok (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Jun 2020 10:44:40 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB54EC08C5C1
        for <linux-serial@vger.kernel.org>; Thu, 25 Jun 2020 07:44:39 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id x18so6835504lji.1
        for <linux-serial@vger.kernel.org>; Thu, 25 Jun 2020 07:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fduap2ao8XV9xH/CtXfk8O5faNPyUEK3VXurDc76CkA=;
        b=immxbCvDDnjcVR6I7K2zxsU2eqPW6B0zY5ugdUq0KUDFvfjmkWBub8x5ECN300pYj1
         KrvUE/knuZOmqRPKxQfBrI/TwA/BUBIGhp8elwBlM5Dx/x83DDsh6CZ4m+1GDSdHChkZ
         gSkSFYXj2RU+OH6DxBnSX+Tu75ONtkxzvGg60dV3/JKPQkzyUWWh4tx6yGKu+Jp8a9II
         kNA6iWwB/wNddf1PPVzTVHLVookrfKizoiwDOF6jgESFxRvd39G0y9LzsqfGySbRskO2
         CHNXXTFwhREg45kGofvOUMq0/yVdeVUV8EYo4O+s3lAXrz3ocvc5vuM+4L8scdMoNt7/
         4SXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fduap2ao8XV9xH/CtXfk8O5faNPyUEK3VXurDc76CkA=;
        b=MdqsCRP9OuGL9Ib1fcKPfjba0IFTC6GcVAxFEZ90YTADcmUOcGzgPDrzYC4gal+1uA
         0lAidHMjpk4LJuKrD/H0IN08nB1TsvRcrwSfaEj57TBDvNH7mzEJzxItMega4ssyP7Ko
         Hq9NafXWiCY9aWlpCrp/VNZTbtx9f9Jj3zQHz+ygtIHoHkHfiTIiVJSmJKstkFlTA4I1
         4z/QP+Qn2a4WYM2P0Gg5pF2do72JEmw4VvbHWWDBkN4AuZoMXlMDUBL03r1Z6/YUItF/
         udVAXLgldkat4UFbsj5ny11KNvoTqAdRuReHuj/kTcZlEajBT5T9m4exBblsInV//Gha
         Xa5A==
X-Gm-Message-State: AOAM533ax/1wo6bE1oIjDlCgxW7raLjLxnyrPIifIp5G8UHZ0lLzr5gr
        01hQ2uEeWHyfRZ90uPu3SnhWF/CROX0C5ajPzKo=
X-Google-Smtp-Source: ABdhPJwMpUMWu3sc/PFh4VtM/p2cAkIdmW4i24lmUfXkbyeRD39MfH/fynU/lKGWP9WG27SBBaQ6RNJWgzEmaKdsuYM=
X-Received: by 2002:a2e:9e87:: with SMTP id f7mr17763662ljk.44.1593096278193;
 Thu, 25 Jun 2020 07:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <CA+dbEpsJs8AgcpjU_-Vwh60BRL4Eq21L1=3sDNJRGHr2acLWLg@mail.gmail.com>
 <CA+dbEpt3YmDE7Q_BBhZZw9CfrUJfrhfR16XVoevXSqi=kOQjJg@mail.gmail.com> <20200623115148.GC1963415@kroah.com>
In-Reply-To: <20200623115148.GC1963415@kroah.com>
From:   Anthony Canino <anthony.canino1@gmail.com>
Date:   Thu, 25 Jun 2020 10:44:27 -0400
Message-ID: <CA+dbEpv3kBjEBAV+8d0ea7pFjw6qE7nYW1wC5_NADUNvC5=O4g@mail.gmail.com>
Subject: Re: Possible bug in drivers/tty/vt/vt.c
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Greg,

Thanks for the reply--what you said makes sense. If we find a case
where this happens in a normal execution, we will file another bug.

Thanks!

Anthony

On Tue, Jun 23, 2020 at 7:51 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 23, 2020 at 05:27:33AM -0400, Anthony Canino wrote:
> > Hi all,
> >
> > I hope this is the right place to ask about a potential bug in the TTY
> > that I may have found in the TTY layer in the linux kernel. I have
> > failed a bug report
> > (https://bugzilla.kernel.org/show_bug.cgi?id=208293) but wanted to
> > email the list for the TTY layer directly. In summary, in the con_init
> > function of drivers/tty/vt/vt.c, I think this code is possibly buggy
> > is kzalloc fails to allocate:
> >
> >   3391   for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
> >   3392     vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data),
> > GFP_NOWAIT);
> >   3393     INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
> >   3394     tty_port_init(&vc->port);
> >   3395     visual_init(vc, currcons, 1);
> >   3396     vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
> >   3397     vc_init(vc, vc->vc_rows, vc->vc_cols,
> >   3398       currcons || !vc->vc_sw->con_save_screen);
> >   3399   }
> >   3400   currcons = fg_console = 0;
> >   3401   master_display_fg = vc = vc_cons[currcons].d;
> >   3402   set_origin(vc);
> >
> > If kzalloc returns null on 3396, I think during set_origin(vc) it is
> > possible vc_screenbuf will be dereferenced. I'd be happy to discuss
> > further if needed.
>
> Yes, horrible and bad things will happen if kzalloc fails at that point
> in time.
>
> Luckily, it is impossible for that to happen, so we really do not need
> to worry about it at all.  This comes up every other year or so, and the
> gyrations that people have gone through to try to fix this up, for
> something that is impossible to ever hit, always end up breaking the
> codebase or doing other horrible things.
>
> In short, don't worry about it, unless you can show me how that can ever
> happen in a normal (i.e. not instrumented) system?
>
> thanks,
>
> greg k-h



-- 
Anthony
