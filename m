Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC44AC197A0
	for <linux-serial@archiver.kernel.org>; Fri, 17 Nov 2023 13:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345808AbjKQNLj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 17 Nov 2023 08:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbjKQNLi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Nov 2023 08:11:38 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296D3D59
        for <linux-serial@vger.kernel.org>; Fri, 17 Nov 2023 05:11:35 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5c19a328797so1459673a12.3
        for <linux-serial@vger.kernel.org>; Fri, 17 Nov 2023 05:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1700226694; x=1700831494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6E9rdo8qzUdOfFpLyb8P/NwaQhOJy8xXp5m1DZcVMbs=;
        b=0Jh9IEncApe3dbjC0pYFA6uGR96saTAaIoi1TMkeMwBv+5Oswt9hbuRJ9gjctTfZVv
         iMeoPeCv+tjez7DDFpZGYLpF/ix0UIse7qdmeKx/YKD6UZaOaF7s2Bl3/WoIOM9npcJd
         k4/VCKT43U6Ra9sPQiQL9xyaRHnRTWiEf4CJTybfC2jSvKB1gUsMrvLdklhzT079E9Qx
         5BnVRW2uSlZ6PyUutWCMgFdYUrAQzM88i0AJaWuN/lB0lsAmhPJ8HMEuP5gsxlx+c+XF
         GIFUUTcqdZL38LIARq68Z1xfFsG4inBCIhfeqGKvd1EODnp9bSBmRUGQlvHWoiGIvVqs
         sjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700226694; x=1700831494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6E9rdo8qzUdOfFpLyb8P/NwaQhOJy8xXp5m1DZcVMbs=;
        b=OcuiLtSSYkwRAx4iilmGjEzkiQXpGlRwuQiERxeWZOOWFhe2yOy28hhNj2077SFkR/
         me+pxLbzW0HA5+/4KdmK5OCGsFAI3mLuJIgDGkKiyuu2eEOwPKK6qdNQZjRV+bmR/eGE
         qDdzCEfPMsdWdfx5igfb/yORDONlxKObdouz0UBCF9CPmX5b41cszqkPa+KUxt8B6bcy
         XQkiG2JQNmqnZLDgByYbiTMFx8Vt+D/w3ToBplst7qqjnQnB3Q91e7L4u5UPWXOKXdJq
         xYWCTLYSRkPi0QcdIir35zaj7YZtMnL8mfhs70Zg6/iEooc4jDiF1TT95TAfZpJ2zClA
         hL6A==
X-Gm-Message-State: AOJu0YyDHcECPO20qN6qE6T7ecn0Nog4BNaUGzI/bDGYJ40aHu+YvtGZ
        kd6scPYAVWplz60WIxe3jX9tVQyZqgjO9WzbeSiC8A==
X-Google-Smtp-Source: AGHT+IFgkLOaY0/DJgU/R9AI39sZ+6DPT8zwZKvyF4UaFzfmMFJIGvIF2iBAT0bJLBWK5QSv+GXZ5swJVYptGL1IhU4=
X-Received: by 2002:a17:90a:974a:b0:281:3a4a:2e61 with SMTP id
 i10-20020a17090a974a00b002813a4a2e61mr14672875pjw.14.1700226694377; Fri, 17
 Nov 2023 05:11:34 -0800 (PST)
MIME-Version: 1.0
References: <20231020072140.900967-1-apatel@ventanamicro.com>
 <20231020072140.900967-9-apatel@ventanamicro.com> <2023102153-retread-narrow-54ee@gregkh>
In-Reply-To: <2023102153-retread-narrow-54ee@gregkh>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 17 Nov 2023 18:41:23 +0530
Message-ID: <CAAhSdy1T-Ca7V21SSW=UCByujv39te7wRYGm40ZqDQ-JxH6pbA@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] tty: Add SBI debug console support to HVC SBI driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Oct 21, 2023 at 10:16=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Oct 20, 2023 at 12:51:39PM +0530, Anup Patel wrote:
> > From: Atish Patra <atishp@rivosinc.com>
> >
> > RISC-V SBI specification supports advanced debug console
> > support via SBI DBCN extension.
> >
> > Extend the HVC SBI driver to support it.
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/tty/hvc/Kconfig         |  2 +-
> >  drivers/tty/hvc/hvc_riscv_sbi.c | 82 ++++++++++++++++++++++++++++++---
> >  2 files changed, 76 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
> > index 4f9264d005c0..6e05c5c7bca1 100644
> > --- a/drivers/tty/hvc/Kconfig
> > +++ b/drivers/tty/hvc/Kconfig
> > @@ -108,7 +108,7 @@ config HVC_DCC_SERIALIZE_SMP
> >
> >  config HVC_RISCV_SBI
> >       bool "RISC-V SBI console support"
> > -     depends on RISCV_SBI_V01
> > +     depends on RISCV_SBI
> >       select HVC_DRIVER
> >       help
> >         This enables support for console output via RISC-V SBI calls, w=
hich
> > diff --git a/drivers/tty/hvc/hvc_riscv_sbi.c b/drivers/tty/hvc/hvc_risc=
v_sbi.c
> > index 31f53fa77e4a..56da1a4b5aca 100644
> > --- a/drivers/tty/hvc/hvc_riscv_sbi.c
> > +++ b/drivers/tty/hvc/hvc_riscv_sbi.c
> > @@ -39,21 +39,89 @@ static int hvc_sbi_tty_get(uint32_t vtermno, char *=
buf, int count)
> >       return i;
> >  }
> >
> > -static const struct hv_ops hvc_sbi_ops =3D {
> > +static const struct hv_ops hvc_sbi_v01_ops =3D {
> >       .get_chars =3D hvc_sbi_tty_get,
> >       .put_chars =3D hvc_sbi_tty_put,
> >  };
> >
> > -static int __init hvc_sbi_init(void)
> > +static int hvc_sbi_dbcn_tty_put(uint32_t vtermno, const char *buf, int=
 count)
> >  {
> > -     return PTR_ERR_OR_ZERO(hvc_alloc(0, 0, &hvc_sbi_ops, 16));
> > +     phys_addr_t pa;
> > +     struct sbiret ret;
> > +
> > +     if (is_vmalloc_addr(buf)) {
> > +             pa =3D page_to_phys(vmalloc_to_page(buf)) + offset_in_pag=
e(buf);
> > +             if (PAGE_SIZE < (offset_in_page(buf) + count))
> > +                     count =3D PAGE_SIZE - offset_in_page(buf);
> > +     } else {
> > +             pa =3D __pa(buf);
> > +     }
> > +
> > +     if (IS_ENABLED(CONFIG_32BIT))
> > +             ret =3D sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRIT=
E,
> > +                             count, lower_32_bits(pa), upper_32_bits(p=
a),
> > +                             0, 0, 0);
> > +     else
> > +             ret =3D sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRIT=
E,
> > +                             count, pa, 0, 0, 0, 0);
>
> Again, you need a helper function here to keep you from having to keep
> this all in sync.

Sure, I will update.

>
> > +     if (ret.error)
> > +             return 0;
> > +
> > +     return count;
> >  }
> > -device_initcall(hvc_sbi_init);
> >
> > -static int __init hvc_sbi_console_init(void)
> > +static int hvc_sbi_dbcn_tty_get(uint32_t vtermno, char *buf, int count=
)
> >  {
> > -     hvc_instantiate(0, 0, &hvc_sbi_ops);
> > +     phys_addr_t pa;
> > +     struct sbiret ret;
> > +
> > +     if (is_vmalloc_addr(buf)) {
> > +             pa =3D page_to_phys(vmalloc_to_page(buf)) + offset_in_pag=
e(buf);
> > +             if (PAGE_SIZE < (offset_in_page(buf) + count))
> > +                     count =3D PAGE_SIZE - offset_in_page(buf);
> > +     } else {
> > +             pa =3D __pa(buf);
> > +     }
> > +
> > +     if (IS_ENABLED(CONFIG_32BIT))
> > +             ret =3D sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_READ=
,
> > +                             count, lower_32_bits(pa), upper_32_bits(p=
a),
> > +                             0, 0, 0);
> > +     else
> > +             ret =3D sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_READ=
,
> > +                             count, pa, 0, 0, 0, 0);
>
> And here too.

Okay.

>
> thanks,
>
> greg k-h

Regards,
Anup
