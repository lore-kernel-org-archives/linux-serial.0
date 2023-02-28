Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FA7C64ED6
	for <linux-serial@archiver.kernel.org>; Tue, 28 Feb 2023 01:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjB1B6h (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Feb 2023 20:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjB1B6d (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Feb 2023 20:58:33 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834677EFD
        for <linux-serial@vger.kernel.org>; Mon, 27 Feb 2023 17:58:32 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id f13so33812474edz.6
        for <linux-serial@vger.kernel.org>; Mon, 27 Feb 2023 17:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677549511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5kj/tOIuYssE3nfGvgZJGSzN2o3Am/0V2s7h/8HaHc=;
        b=NfUYNKGwTUEy71gSoN184oikRRYKXHBrMJkYcEmmm8eQYSLvJCdfB85BQJHtt8w520
         lzQoOb9rNne6rBGBwN5h9cv622c1/nrV3c29LfSFu2yta7HupHybn5VG6uVGNG4hyG3X
         WNEjtUlslfMZv1wQc8qSs+d3m4cpo291vumqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677549511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5kj/tOIuYssE3nfGvgZJGSzN2o3Am/0V2s7h/8HaHc=;
        b=Vttz7r2vVf7msGcTp8Y5Kv0JM2mscGHi4ZUW/vMJ9BIRyPMPBQt2lm/SuWSHTNdGTP
         XzHbU2VUhcXjYQtRi4MIssFmMHDmXGCgf7fs1HDVkDvymWI7MAuJYRicxLRd4JBIZTJM
         voXw7iyg4JZ3jTOoGxwqi62B9i0l2Y6YZOH73s+iJgwNbv8q6pEpjXEVwXQrYRu/Y+Od
         lLJ/UiktziJSjkXL6C9I+wpAIz+P5ubzxJBwIsKswAcSCXAgmjIaYvzUvFpHC0ABWvvv
         xBAAv/PMSbxKzqqs3Hl/NzRkNjdJ4AB/kXkMc+9ETiUmbxa7tfdghzuBkdLsh/JJKXvT
         u5/A==
X-Gm-Message-State: AO0yUKV4gr8jl+MeDq7Hvbw0Pb305dWtzVI3n2tLQDslTSOZXedRalVF
        fsOCqqkWBDnJRP8leIbjck9gniTcmh8NNBv/Pkg=
X-Google-Smtp-Source: AK7set9NT4BsFVbdeNiDhVWf6L3Dt6wNej/4lXQRUYIDbgsrcwIJ9lE4dlbZGiVIXEEFfoHZy7gbjg==
X-Received: by 2002:a17:907:a49:b0:8a6:5720:9101 with SMTP id be9-20020a1709070a4900b008a657209101mr1110027ejc.4.1677549509914;
        Mon, 27 Feb 2023 17:58:29 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id kd5-20020a17090798c500b008c0b8dd4cbdsm3890572ejc.112.2023.02.27.17.58.29
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 17:58:29 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id f13so33812179edz.6
        for <linux-serial@vger.kernel.org>; Mon, 27 Feb 2023 17:58:29 -0800 (PST)
X-Received: by 2002:a17:906:2ec8:b0:877:747e:f076 with SMTP id
 s8-20020a1709062ec800b00877747ef076mr368063eji.0.1677549508810; Mon, 27 Feb
 2023 17:58:28 -0800 (PST)
MIME-Version: 1.0
References: <1677529301-19530-1-git-send-email-george.kennedy@oracle.com> <face2b1b-0f2e-4a79-a71b-79681fc56273@t-8ch.de>
In-Reply-To: <face2b1b-0f2e-4a79-a71b-79681fc56273@t-8ch.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Feb 2023 17:58:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=whxC0ob3f--B-igBp34ujA5PZQMcTnDQ8Zh8HA7+ZbeWg@mail.gmail.com>
Message-ID: <CAHk-=whxC0ob3f--B-igBp34ujA5PZQMcTnDQ8Zh8HA7+ZbeWg@mail.gmail.com>
Subject: Re: [PATCH v2] vc_screen: modify vcs_size() handling in vcs_read()
To:     linux@weissschuh.net
Cc:     George Kennedy <george.kennedy@oracle.com>, jirislaby@kernel.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 27, 2023 at 5:46=E2=80=AFPM <linux@weissschuh.net> wrote:
>
> This still seems to be broken for me.

Looks that way.

> I still need the patch from
>
> https://lore.kernel.org/lkml/20230220064612.1783-1-linux@weissschuh.net/

.. and that has the same problem with "what if the error happens
during an iteration that wasn't the first, and we already succeeded
partially".

The "goto unlock_out" is bogus, since it jumps over all the "update
pos and check if we read something".

It was the correct thing to do *above* the loop, but not inside the loop.

IOW, I think the proper patch is to also turn the "goto unlock_out"
into a "break". Mind testing something like this (whitespace-damaged,
but you get the idea):

    --- a/drivers/tty/vt/vc_screen.c
    +++ b/drivers/tty/vt/vc_screen.c
    @@ -403,10 +403,11 @@ vcs_read(struct file *file, char __user
*buf, size_t count, loff_t *ppos)
                unsigned int this_round, skip =3D 0;
                int size;

    -           ret =3D -ENXIO;
                vc =3D vcs_vc(inode, &viewed);
    -           if (!vc)
    -                   goto unlock_out;
    +           if (!vc) {
    +                   ret =3D -ENXIO;
    +                   break;
    +           }

                /* Check whether we are above size each round,
                 * as copy_to_user at the end of this loop

which hopefully really fixes this (at least I don't see any other
"goto unlock_out" cases).

              Linus
