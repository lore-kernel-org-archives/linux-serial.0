Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAEBE743F4
	for <linux-serial@archiver.kernel.org>; Fri, 29 Sep 2023 08:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjI2I0P (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Sep 2023 04:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjI2I0O (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Sep 2023 04:26:14 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA13B1AA
        for <linux-serial@vger.kernel.org>; Fri, 29 Sep 2023 01:26:11 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40652e570d9so14670835e9.1
        for <linux-serial@vger.kernel.org>; Fri, 29 Sep 2023 01:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695975970; x=1696580770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WX41g5Ex2mgCQT3kQj51PYJPgefWmJ9XFZpouAvDF2A=;
        b=FxW3KCsQo8txXpMWzi3zSezrX+Y8aSco5Gz1q5587lukO7eseyKJii5o8m7YwM5FTl
         45ACBfxVNuovoQU3VTG+upg6xDZ7/s8I/dPHNBSaS/vitqLH/Q6zy8OHVBWunpeFbWe5
         614xehgH9A+34nyBLiQzxV/1sG4GkayPtNSksBHvMRXZf5WpHhU+qcD/iv3pNpwqqbDo
         OSaS3G8dXCgzcbzf3ij6yj2obTnJri3LIDsZl2oQYNUX4BAuX8P8WaZr9AuZIEt3KLbn
         TNqTdbQjCKQxK/FZ4TVUDf/BKiOThm6wF81lDgckR8ObCvp3xqtFSKm/5PUVGqeTvEnb
         QZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695975970; x=1696580770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WX41g5Ex2mgCQT3kQj51PYJPgefWmJ9XFZpouAvDF2A=;
        b=UgQvsN5PGs8+vz6+FWcy07eFKtJoTvuFwdtRTXMuiP/SpWucN06i1tPYaoqCyPgENj
         oTOYEzOXi0ul2k3Pt5M3pIeK0zMmHykbmuMhRE+MFZXR59cIgmIznqO/nRWqc4LVuk9L
         ymrSGD4a/idpp5fvGRXoQKGHSqjc42OhZZqRTyTv92UdK/XHxVCoWwBNg1ulpDJnK33r
         gxSBhzd6+4fUXnZj6wvYosAtSN7EHuWWqhESdf8IPuh1f7L6lsobTl/dYEz4bdwSCQe0
         79Jf8JGC2WOEZpcqwfhbFMeALV9tPS8NnsmVLb7h7Z4L5YXUVj6roYd3rMOuOzaAWv0h
         iN4A==
X-Gm-Message-State: AOJu0Yy+rUzadOSwNYey650GGzZhp0KHVIxzhp06U3mOJnujeEFda+AO
        s5XIP0f7TyEtE5ThifDVclHkGTFo0F0WFG0IrxhGbg==
X-Google-Smtp-Source: AGHT+IFotf6XO1lJDjNVA9fLU3PZ+wvlEqKsBa8iaRjpXi7p8SNYxOKrZWD/2txCrOvhDZQYnkNiaXxU6mEtgFRW1Ho=
X-Received: by 2002:a05:600c:3785:b0:401:b204:3b98 with SMTP id
 o5-20020a05600c378500b00401b2043b98mr3941830wmr.19.1695975970106; Fri, 29 Sep
 2023 01:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <f74665d1-4d28-01a2-5694-b06fde202d39@ghiti.fr> <20230928231239.2144579-2-twuufnxlz@gmail.com>
In-Reply-To: <20230928231239.2144579-2-twuufnxlz@gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Fri, 29 Sep 2023 10:25:59 +0200
Message-ID: <CAHVXubhG2c=ShFHF4hMMFm8=BYDTyDUduOizujbUWQBW+55wTw@mail.gmail.com>
Subject: Re: [PATCH] riscv: fix out of bounds in walk_stackframe
To:     Edward AD <twuufnxlz@gmail.com>
Cc:     alex@ghiti.fr, aou@eecs.berkeley.edu, conor@kernel.org,
        gregkh@linuxfoundation.org, guoren@kernel.org,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        liushixin2@huawei.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com,
        syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Edward,

On Fri, Sep 29, 2023 at 1:12=E2=80=AFAM Edward AD <twuufnxlz@gmail.com> wro=
te:
>
> Add vmalloc and kernel addresses check to prevent invalid access.
>
> Closes: https://lore.kernel.org/all/20230926105949.1025995-2-twuufnxlz@gm=
ail.com/
> Fixes: 5d8544e2d007 ("RISC-V: Generic library routines and assembly")
> Reported-and-test-by: syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.c=
om
> Link: https://lore.kernel.org/all/0000000000000170df0605ccf91a@google.com=
/T/
> Signed-off-by: Edward AD <twuufnxlz@gmail.com>
> ---
>  arch/riscv/kernel/stacktrace.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrac=
e.c
> index 64a9c093aef9..031a4a35c1d0 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -54,6 +54,9 @@ void notrace walk_stackframe(struct task_struct *task, =
struct pt_regs *regs,
>                         break;
>                 /* Unwind stack frame */
>                 frame =3D (struct stackframe *)fp - 1;
> +               if ((is_vmalloc_addr(frame) && !pfn_valid(page_to_pfn(vma=
lloc_to_page(frame)))) ||
> +                    !virt_addr_valid(frame))
> +                       break;
>                 sp =3D fp;
>                 if (regs && (regs->epc =3D=3D pc) && (frame->fp & 0x7)) {
>                         fp =3D frame->ra;
> --
> 2.25.1
>

I'm still not convinced this will fix the kasan out-of-bounds
accesses, the page can be valid but the read can happen at an offset
not initialized and trigger such errors right? I still think there is
something weird about the stack frame, as to me this should not happen
(but admittedly I don't know much about that).
