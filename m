Return-Path: <SRS0=Q4yL=AE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE77DC433E0
	for <linux-serial@archiver.kernel.org>; Tue, 23 Jun 2020 09:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A78D420724
	for <linux-serial@archiver.kernel.org>; Tue, 23 Jun 2020 09:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCDTrw3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbgFWJ1r (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731912AbgFWJ1r (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Jun 2020 05:27:47 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5082C061573
        for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2020 02:27:46 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s1so22652665ljo.0
        for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2020 02:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=g4GpOFEiAv6IILixIZ3nSF1t5XkAHFjm0IxRZ8BZuEI=;
        b=DCDTrw3M7j9IAOZuyEF2rC07wZa/t9Kq0Yyd31rZpPq13PcHgFljV1yK0/Wg6disPR
         j/e+D9m0bUc40tkKLdF3HHMOlug5gf1TC/+JD26kGqOTvEHgjGwQUqUJ0LK6rQSWy8W5
         88tQzwpjmWHh7bBB29sUE1KxveRGryqTYEJ5NKOLdCZ0FPeViEOZJAFRsweBckPyHl4P
         96/09idx5ClRt9e3dC8HUVh31QR1hkqf3ABkKeNv+IXcGtXSDTFbTa531dnuS0NBZa9o
         c00Ba42lZDtecpA8J3KpahdKg74PJOhz0UFsxu3B7IJWRiCF6Z5iiAEDf7oIP62gvlJr
         C0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=g4GpOFEiAv6IILixIZ3nSF1t5XkAHFjm0IxRZ8BZuEI=;
        b=VabASBS9Ev4F/F7KTM9bs9OgXHdzpkB0GoYbpTNmtmfl5T64vF/ER5Kaq0L8ac/egE
         Z5sm1N4vUYgMxZW9LkWC5DIINFmExEr173R+Qa8ao7RVBqZwYp0ORzBcKuGADiRSanSf
         uXLU4HQxge4mUfaG+hDUOE8IYI82RrwTBeF2rA/snKghg0RBAmcAy0KA/mhRn1hvoz3f
         m7Z4QrCOK//HpLV6nKiwSPjQE0q2FcbiB2JnZUUFoiQpYprYAuebl1vF84eTx3P1KC9D
         TId9OpEDJIExLcLAnYl6HaBnWz9uw84CbsL0FR0mgz/8WtnCnx3Jf+FqMqvwiqc9eawG
         bGmg==
X-Gm-Message-State: AOAM532WmYl6FGr4H0vQQxv/khhaYypre6JrFcKdo/4MyBPwxaSMNjiv
        x2oHFvKIHDAG/KTDjzwLu+/Va/4tO8v2Qzs7yRz+9jU14as=
X-Google-Smtp-Source: ABdhPJx4P+SkOx7HvBFoghUp+UIv2D+JQW+7xegk1H0l13e02QYZ+Opu7pXBj7qz/LF2ulth3jXUrIFle4R3Twfzs4E=
X-Received: by 2002:a2e:6c15:: with SMTP id h21mr11129549ljc.403.1592904464852;
 Tue, 23 Jun 2020 02:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <CA+dbEpsJs8AgcpjU_-Vwh60BRL4Eq21L1=3sDNJRGHr2acLWLg@mail.gmail.com>
In-Reply-To: <CA+dbEpsJs8AgcpjU_-Vwh60BRL4Eq21L1=3sDNJRGHr2acLWLg@mail.gmail.com>
From:   Anthony Canino <anthony.canino1@gmail.com>
Date:   Tue, 23 Jun 2020 05:27:33 -0400
Message-ID: <CA+dbEpt3YmDE7Q_BBhZZw9CfrUJfrhfR16XVoevXSqi=kOQjJg@mail.gmail.com>
Subject: Re: Possible bug in drivers/tty/vt/vt.c
To:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi all,

I hope this is the right place to ask about a potential bug in the TTY
that I may have found in the TTY layer in the linux kernel. I have
failed a bug report
(https://bugzilla.kernel.org/show_bug.cgi?id=3D208293) but wanted to
email the list for the TTY layer directly. In summary, in the con_init
function of drivers/tty/vt/vt.c, I think this code is possibly buggy
is kzalloc fails to allocate:

  3391   for (currcons =3D 0; currcons < MIN_NR_CONSOLES; currcons++) {
  3392     vc_cons[currcons].d =3D vc =3D kzalloc(sizeof(struct vc_data),
GFP_NOWAIT);
  3393     INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
  3394     tty_port_init(&vc->port);
  3395     visual_init(vc, currcons, 1);
  3396     vc->vc_screenbuf =3D kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
  3397     vc_init(vc, vc->vc_rows, vc->vc_cols,
  3398       currcons || !vc->vc_sw->con_save_screen);
  3399   }
  3400   currcons =3D fg_console =3D 0;
  3401   master_display_fg =3D vc =3D vc_cons[currcons].d;
  3402   set_origin(vc);

If kzalloc returns null on 3396, I think during set_origin(vc) it is
possible vc_screenbuf will be dereferenced. I'd be happy to discuss
further if needed.

Thanks,
Anthony


On Tue, Jun 23, 2020 at 5:24 AM Anthony Canino
<anthony.canino1@gmail.com> wrote:
>
> Hi all,
>
> I hope this is the right place to ask about a potential bug in the TTY th=
at I may have found in the TTY layer in the linux kernel. I have failed a b=
ug report (https://bugzilla.kernel.org/show_bug.cgi?id=3D208293) but wanted=
 to email the list for the TTY layer directly. In summary, in the con_init =
function of drivers/tty/vt/vt.c, I think this code is possibly buggy is kza=
lloc fails to allocate:
>
>   3391   for (currcons =3D 0; currcons < MIN_NR_CONSOLES; currcons++) {
>   3392     vc_cons[currcons].d =3D vc =3D kzalloc(sizeof(struct vc_data),=
 GFP_NOWAIT);
>   3393     INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
>   3394     tty_port_init(&vc->port);
>   3395     visual_init(vc, currcons, 1);
>   3396     vc->vc_screenbuf =3D kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT=
);
>   3397     vc_init(vc, vc->vc_rows, vc->vc_cols,
>   3398       currcons || !vc->vc_sw->con_save_screen);
>   3399   }
>   3400   currcons =3D fg_console =3D 0;
>   3401   master_display_fg =3D vc =3D vc_cons[currcons].d;
>   3402   set_origin(vc);
>
> If kzalloc returns null on 3396, I think during set_origin(vc) it is poss=
ible vc_screenbuf will be dereferenced. I'd be happy to discuss further if =
needed.
>
> Thanks,
> Anthony



--=20
Anthony
