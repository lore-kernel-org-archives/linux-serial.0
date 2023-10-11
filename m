Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90233CD98F5
	for <linux-serial@archiver.kernel.org>; Wed, 11 Oct 2023 05:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjJKFwQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Oct 2023 01:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344108AbjJKFwO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Oct 2023 01:52:14 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1EB98
        for <linux-serial@vger.kernel.org>; Tue, 10 Oct 2023 22:52:11 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-584a761b301so4847441a12.3
        for <linux-serial@vger.kernel.org>; Tue, 10 Oct 2023 22:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697003531; x=1697608331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uB2f3GYH/kpgRnRbL88LHcmeeqsYhInJn57hhNzYiD0=;
        b=hMcKV6qkXA2cZuAW7MyYxzwoIgL9goT6csC5oEA6w42qZUSzZ+yY0lD60xeaitUssO
         7GEKn1cL1gmby2Nu2PRp6+ORA4gzZe9JquZiVLAVS6h1iCehNlgzlxtctBgu1zqupv4L
         eQqyMSmGbaveSJziZWVFJh8o51NtQfLXICrObLlnj6SoXU7z6W5paqgX5rIcUOzT/Ftx
         +nIbKYERuKl+h0EbHgplhHikEaJzW+7ro8wlWe3wlUYE1hpMWJvEdFt3LgK7k05gjoBy
         OTAP1MA8l9weU5/M/sSuScm/T7HDkRQadsQTqZ2cb7cpIZn62uhn3JmBIE+rZQiRbDs8
         7SIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697003531; x=1697608331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uB2f3GYH/kpgRnRbL88LHcmeeqsYhInJn57hhNzYiD0=;
        b=V/9WT6rgUQfDEvFI8Vr/8ZZUO8C2bYAEgFdjnMlFeXGMrRYmfwEQIvnip8ktAAiQtx
         ZqE7cZWCC0FzXVQu6NuGc0gFcqsdnDMMPB5RZbpx2JHUHNiRFAX1a5iTlnvQBW3+7BEq
         LbjM09RATdtRmSUgmahNta3ov7LRm/14l3S9gzeko+1o2agzkgaF8nYwSwX1yHX0oT5x
         Sqy0TkxQQsi66J+ggY9E8ndVs0A7RBFmhWBxgrv9oXqp1pRGc6klFOfP3KVfUpWFls7g
         JcfKRysPr2/ueGbR7bEmcufT56KPe705z4JtmslTl0bzKvGHGd72k6Cpk5Fb5Rb0tliG
         U0zQ==
X-Gm-Message-State: AOJu0YymdvZal1/xV/6aNu5sDXLjqQ4ZiLtMqdndjAi9GTRNf3L92BVd
        nPYOydqytZmOOiAI4/OQLa1adgCZA03uVP67qFjoGw==
X-Google-Smtp-Source: AGHT+IEeEqkGLmFo9PNY3EdvhcjfnAFjglTfyVtroZYi102GSplRjzRGVpjR04ewfA1Sji5L5yjrCQuQw30ii3vCSdo=
X-Received: by 2002:a05:6a20:914b:b0:158:7fdf:66df with SMTP id
 x11-20020a056a20914b00b001587fdf66dfmr25459333pzc.18.1697003530678; Tue, 10
 Oct 2023 22:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231010170503.657189-1-apatel@ventanamicro.com>
 <20231010170503.657189-5-apatel@ventanamicro.com> <2023101053-scholar-resolute-a9a0@gregkh>
In-Reply-To: <2023101053-scholar-resolute-a9a0@gregkh>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 11 Oct 2023 11:22:00 +0530
Message-ID: <CAK9=C2XDkYg4kVHFT4bLETBecSGgHkPaTW9wpzLEe_Fjg0UGVQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] tty/serial: Add RISC-V SBI debug console based earlycon
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 10, 2023 at 10:46=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Oct 10, 2023 at 10:35:01PM +0530, Anup Patel wrote:
> > We extend the existing RISC-V SBI earlycon support to use the new
> > RISC-V SBI debug console extension.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/tty/serial/Kconfig              |  2 +-
> >  drivers/tty/serial/earlycon-riscv-sbi.c | 35 ++++++++++++++++++++++---
> >  2 files changed, 32 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index bdc568a4ab66..cec46091a716 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -87,7 +87,7 @@ config SERIAL_EARLYCON_SEMIHOST
> >
> >  config SERIAL_EARLYCON_RISCV_SBI
> >       bool "Early console using RISC-V SBI"
> > -     depends on RISCV_SBI_V01
> > +     depends on RISCV_SBI
> >       select SERIAL_CORE
> >       select SERIAL_CORE_CONSOLE
> >       select SERIAL_EARLYCON
> > diff --git a/drivers/tty/serial/earlycon-riscv-sbi.c b/drivers/tty/seri=
al/earlycon-riscv-sbi.c
> > index 27afb0b74ea7..b1da34e8d8cd 100644
> > --- a/drivers/tty/serial/earlycon-riscv-sbi.c
> > +++ b/drivers/tty/serial/earlycon-riscv-sbi.c
> > @@ -10,22 +10,49 @@
> >  #include <linux/serial_core.h>
> >  #include <asm/sbi.h>
> >
> > +#ifdef CONFIG_RISCV_SBI_V01
> >  static void sbi_putc(struct uart_port *port, unsigned char c)
> >  {
> >       sbi_console_putchar(c);
> >  }
> >
> > -static void sbi_console_write(struct console *con,
> > -                           const char *s, unsigned n)
> > +static void sbi_0_1_console_write(struct console *con,
> > +                               const char *s, unsigned int n)
> >  {
> >       struct earlycon_device *dev =3D con->data;
> >       uart_console_write(&dev->port, s, n, sbi_putc);
> >  }
> > +#endif
> > +
> > +static void sbi_dbcn_console_write(struct console *con,
> > +                                const char *s, unsigned int n)
> > +{
> > +     phys_addr_t pa =3D __pa(s);
> > +
> > +     sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRITE,
> > +#ifdef CONFIG_32BIT
> > +               n, pa, (u64)pa >> 32,
> > +#else
> > +               n, pa, 0,
> > +#endif
>
> Again, no #ifdef in .c files please.

Okay, I will remove #ifdef from here as well.

>
> thanks,
>
> greg k-h

Thanks,
Anup
