Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A159C07E99
	for <linux-serial@archiver.kernel.org>; Fri,  9 Jul 2021 14:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59172613BA
	for <linux-serial@archiver.kernel.org>; Fri,  9 Jul 2021 14:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhGIO6j (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 9 Jul 2021 10:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbhGIO6i (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 9 Jul 2021 10:58:38 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC0CC0613DD;
        Fri,  9 Jul 2021 07:55:54 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id f93-20020a9d03e60000b02904b1f1d7c5f4so8879624otf.9;
        Fri, 09 Jul 2021 07:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rQivxP0wk8WhrWIYZBJvlJxPpAiCEsCXAaaAfrJC7/0=;
        b=vAby8AZgo7eSPFaPJYoUSWOeLBoH7ES4hGyGxlWPTf6vv9VNRHjWy8EB23w9u3uhPy
         hkfCqMTYsQJdXzaX3sH2ytPG32pE0f7ynyqDly8k3dCrK5GzvDLF9XrkLUws5pXeQ0TM
         vBUa3yOG4xoTlvY6xwY3trAyrCsZV/VRDeyoyyL/PcLA7GOwdcM8Bz/3tnq0DrIg1LkD
         GQzsLWw71IPrBcIQFqTqp7kWWBZRadx+K2SLf6q+Iq10wpKjiRfarIjOdvrqnQxhbMd8
         K3XllzkNA3z/nBJvvkK6+VqInu7Cl/FBxbxgHtm7F6EppKTXYN4o1fCO7UfLOPWRYkYH
         6f+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rQivxP0wk8WhrWIYZBJvlJxPpAiCEsCXAaaAfrJC7/0=;
        b=C6qDQ6C9BU0YiAPgk1RwOY4BNuwQAAJjjcj+upKr/xPUj3nE24WEHkTeYArff0M9cg
         5mQt3qd724IZ3rguQRAEZrMH+aieK71r5ZGhSyrxcdTIDbMhd7SS03cZaJnIdwGq1Shu
         hA0Fx7KuqR/p3v5ny7YDFxxeYdNN2SSxJXGRVoYwJbRetlFGvwVMvDcJBaIMqi8BD6LD
         bzeDkyWNYrWjFv9UH8zTwRs+Brgje/X6100V0MITr/tZh+nhgAxL1l1roRGITOAEgpQz
         cWoEVJ91+LAUPULxxs2wrh27+OPlvZT6pwQ+BwC/b1xvN0XUMqRuFWY/aLG2h7vbBdAn
         apHA==
X-Gm-Message-State: AOAM531YVFucAyJenJRBv3zssDM+TU7Qxu0gZGBDjWspCTqcEhOyY618
        kHuBClbtlePIqXuEOJpaQqFnG1TZ421aIq6cKQ==
X-Google-Smtp-Source: ABdhPJy2iAS1+wb/91RDVkknnfZKwwpH8Z4PdAFAhdZzUB4jSYiEI98m/uAqm0VPuYXscxU9Ye3ErrqOwDHKTY/qfWg=
X-Received: by 2002:a9d:3b0:: with SMTP id f45mr19800007otf.5.1625842553859;
 Fri, 09 Jul 2021 07:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <1625489588-26079-1-git-send-email-zheyuma97@gmail.com>
 <fde46fee-fad9-8f3b-79b0-ad426fd379dd@kernel.org> <CAHp75Vceenv5ctk6f_eEtXBVzodXHhnpuudaniLM9A1edqYrXA@mail.gmail.com>
 <ffa624c5-fc2a-780a-17d2-404cd94a289a@kernel.org> <CAMhUBjmGD+KH_faMJyZGBpufxPVWw7uz4tUgFtrenx-HovjxZg@mail.gmail.com>
 <YOhbLaeGKGJEFEOe@kroah.com>
In-Reply-To: <YOhbLaeGKGJEFEOe@kroah.com>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Fri, 9 Jul 2021 22:55:42 +0800
Message-ID: <CAMhUBj=tZbGmqY5aRTpuAWyKs70yU8MBdn-MJBOhgbpCmc-0ag@mail.gmail.com>
Subject: Re: [PATCH v4] tty: serial: jsm: allocate queue buffer at probe time
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 9, 2021 at 10:20 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jul 09, 2021 at 10:00:32PM +0800, Zheyu Ma wrote:
> > On Thu, Jul 8, 2021 at 3:13 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> > >
> > > On 07. 07. 21, 14:52, Andy Shevchenko wrote:
> > > > On Wed, Jul 7, 2021 at 10:50 AM Jiri Slaby <jirislaby@kernel.org> w=
rote:
> > > >> On 05. 07. 21, 14:53, Zheyu Ma wrote:
> > > >
> > > >> So how it comes an interrupt came before
> > > >> neo_param() in jsm_tty_open was called?
> > > >
> > > > If IRQ is shared we have a special debug feature to test shared IRQ=
s
> > > > on freeing IRQ stage (*).
> > > > But it doesn't matter, the IRQ handler must survive at any stage af=
ter
> > > > the action has been listed.
> > >
> > > Yes, but IRQ_NONE is returned from the ISR in that case.
> > >
> > > The issue the patch is fixing is for a "malicious" device and I am no=
t
> > > sure we want to fix this -- if I can put in a malicious device, I can
> > > use hammer to kill the box too=E2=80=A6
> >
> > Well, this threat assumption is indeed strong, but this attack may be
> > real. For example, some programmable USB devices (such as FaceDancer)
> > may exploit vulnerabilities in the USB device driver to attack. Of
> > course, there has not been such an attack in the real world for PCI
> > devices. Or, some devices with DMA functions may also send malicious
> > data and some previous kernel commits have also fixed such bugs.
> >
> > Anyway, thanks for your patient comments.
>
> Right now, yes, we treat USB devices as "possibly malicious".  We do not
> do so for PCI devices yet.  If we want to do that, then we need to do a
> lot of work, not just "this one call in this one driver" type of thing
> as there are much bigger issues involved here.
>
> If you wish to take on this work, as you feel PCI devices should be
> treated this way, please do so!  But start in the PCI core at the very
> least, before worrying about the thousands of individual drivers.

Alright, I understand.

Thank you for your valuable suggestions, I will continue to learn and
make more contributions to the kernel.

Regards,
Zheyu Ma
