Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAE2C07E99
	for <linux-serial@archiver.kernel.org>; Fri,  9 Jul 2021 14:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50D74613AB
	for <linux-serial@archiver.kernel.org>; Fri,  9 Jul 2021 14:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhGIOD1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 9 Jul 2021 10:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhGIOD1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 9 Jul 2021 10:03:27 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1694EC0613DD;
        Fri,  9 Jul 2021 07:00:44 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id h9so12322948oih.4;
        Fri, 09 Jul 2021 07:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B9kefiP0hJzFF5Lg6Tw5Lm1XYmDUIHmiB9jmv+loBwY=;
        b=i2wdz8UNUpFmoKVYqqIjxyj24qGvZo7bsBlHmREinluqgoIS5ShTmmOOX+EL8MTbas
         V39syGCTE16xXX6tbY7ZGhE58/YlXmjlaz/VPWsS8A/EXxVRQi2OxG/gcm1RvNhSZrL4
         sqPQiMHwQRA/iehvDGiuV67Z6uAvC9oLJvokx5Kvkr0BMrCEzsg8/Std3t4ykDjmxh20
         cp+9jYFYZbW853o1yfxiWpCKKCsGKLTXY8uvMw1necGSo297iPlgRGx2GzzfFSUVlpkt
         hDlOiu3H7PJ5mdS5FgkgjbBBAXnJsRdwGOg8DsJUH+9wpLeMp1dIkAR15Njc393ebCNW
         JYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B9kefiP0hJzFF5Lg6Tw5Lm1XYmDUIHmiB9jmv+loBwY=;
        b=YQemBYI3f+xC6CZlNJPrC+8T/H8ebuX3Y5RQ3YWKZ9mcZO5oQ6fDDn1itza7RJuUfp
         yNaV+OMcHySh6by9Awnvv1oqxvWrxilOxbhY/di2Il1RHLrCfGbtWqFYGA2rlzQpWxGd
         S+QUUp0GBOK20//5Wtb8a/bSTLsr5WsSuhtXeOh7D7UVyBtYMHKVVeEEj55j5T3jcnI3
         S1epKb2oHJHzXG6vgl94RtqVjPoFLQpI+TMU8D9NVeHL8mlZt5z+lnf1FB41b3VIGM3D
         hk1zy4SrNEVXV3t8Ky7auARZX+tRZQ8Kpz+zg8XTnlW244hnUbbUTf1KnGpgdChHn5qI
         3qtg==
X-Gm-Message-State: AOAM533ShVYOOGEG8V+uYN6NHj8QE5y6IGPGVHvYt4uco+mVEl1aNoeM
        IBz2hJyIojExq8tJoTvx5LB8sZbuy7bHJ/OEoQ==
X-Google-Smtp-Source: ABdhPJyzIhEaaAewCFB6qfyj2NUUullYjjbKOxA6cxALLAwK90oF8zGLY7aCikmRrFZahBEg/nms0Wb2lFvIAizz9Mo=
X-Received: by 2002:a05:6808:651:: with SMTP id z17mr11458451oih.15.1625839243480;
 Fri, 09 Jul 2021 07:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <1625489588-26079-1-git-send-email-zheyuma97@gmail.com>
 <fde46fee-fad9-8f3b-79b0-ad426fd379dd@kernel.org> <CAHp75Vceenv5ctk6f_eEtXBVzodXHhnpuudaniLM9A1edqYrXA@mail.gmail.com>
 <ffa624c5-fc2a-780a-17d2-404cd94a289a@kernel.org>
In-Reply-To: <ffa624c5-fc2a-780a-17d2-404cd94a289a@kernel.org>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Fri, 9 Jul 2021 22:00:32 +0800
Message-ID: <CAMhUBjmGD+KH_faMJyZGBpufxPVWw7uz4tUgFtrenx-HovjxZg@mail.gmail.com>
Subject: Re: [PATCH v4] tty: serial: jsm: allocate queue buffer at probe time
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 8, 2021 at 3:13 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 07. 07. 21, 14:52, Andy Shevchenko wrote:
> > On Wed, Jul 7, 2021 at 10:50 AM Jiri Slaby <jirislaby@kernel.org> wrote=
:
> >> On 05. 07. 21, 14:53, Zheyu Ma wrote:
> >
> >> So how it comes an interrupt came before
> >> neo_param() in jsm_tty_open was called?
> >
> > If IRQ is shared we have a special debug feature to test shared IRQs
> > on freeing IRQ stage (*).
> > But it doesn't matter, the IRQ handler must survive at any stage after
> > the action has been listed.
>
> Yes, but IRQ_NONE is returned from the ISR in that case.
>
> The issue the patch is fixing is for a "malicious" device and I am not
> sure we want to fix this -- if I can put in a malicious device, I can
> use hammer to kill the box too=E2=80=A6

Well, this threat assumption is indeed strong, but this attack may be
real. For example, some programmable USB devices (such as FaceDancer)
may exploit vulnerabilities in the USB device driver to attack. Of
course, there has not been such an attack in the real world for PCI
devices. Or, some devices with DMA functions may also send malicious
data and some previous kernel commits have also fixed such bugs.

Anyway, thanks for your patient comments.

Regards,
Zheyu Ma
