Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IjYYjr5V"
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39168E3
	for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 00:21:24 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507ad511315so7447980e87.0
        for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 00:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700554882; x=1701159682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eigScL5e5mup7Z3+ShdJXrR842NJQMOChPfOYWt/3l8=;
        b=IjYYjr5Vl5E3DOL2HyuIX+VwEXG6draJ5yuU5PW9KxDFqWZhdD+Gh1R3uMRa0bnRlP
         jWkm+lnxJB4G4LF8EhrMob8Egl7r9jTKKolO0uITUhzJEn1KfFkTYi+EyqdaAF+3DIKF
         ufxzLoTNr6obSLde4UUuLj9V6RF81SIx/VteuBVQU+CH4yxTzOoalHijeCMpTMRruu49
         ZNevJMUtD1ZqrQUee0PASQ/y5eWK+X3vQOQnmK/2lz03950jl3K+b8REcGcAlgv512Q5
         JU6w2DJ6Os3YHAlNVqmuRLYmY/83AmlENnrPPNGRl7s5flUTpEUvVGMCrXsq1JAUNWit
         BSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700554882; x=1701159682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eigScL5e5mup7Z3+ShdJXrR842NJQMOChPfOYWt/3l8=;
        b=PR2pauxzKnijxjs0fLTEWbjoRAeScLQNx+9fsv4AXxoBc0cF0fFYxsZSNEKbPZ/rFn
         ckFTBA2q55YTe9X04Yh5mlM+UNHRwEvR/sEh4oLMcCTLGzQEniGrEZwupC/B/xCxEC9F
         cjtJNnAtkMGXJTAK6xeYfRLCNaDtRVDPgtlE85k21zLmdeiIOGu/vAKJaIEaRu5aT5kD
         OIQrlV9tpIQ8wzKj9jc8HbaVEKf92xnTOwndRT0IrSpqS7F6Ya05rv9e/XwIuYD52Dtn
         jU/QCVJOlMcimxMGX2qwch+FOKrDg7hNhWPea1R/Vi1efa4AGmGZW5BTbkC4MXi2zjWj
         +skg==
X-Gm-Message-State: AOJu0YyiWYQYKTEX4o3JpruVN4lQnJBrdHpVBzmdRW9HeKbJ0cK6gMHx
	q1FYTr/Y9e4U4+sb/fHbWyN6frHiEfhbYUDtMY+/JA==
X-Google-Smtp-Source: AGHT+IGbr2XYSRwYN9sWNDSkKbTgz7fmIbWZKQo/3+nZwrm2DQiOQ819Z3adb6Rl/lF0tqkEzzFHe3gA2gKk/dP5AMM=
X-Received: by 2002:a05:6512:398c:b0:50a:aa8d:1a60 with SMTP id
 j12-20020a056512398c00b0050aaa8d1a60mr6848280lfu.48.1700554882341; Tue, 21
 Nov 2023 00:21:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231118033859.726692-1-apatel@ventanamicro.com>
 <20231118033859.726692-5-apatel@ventanamicro.com> <1dd7f7b4-d2ba-4216-ac3f-3552c2bee24b@kernel.org>
In-Reply-To: <1dd7f7b4-d2ba-4216-ac3f-3552c2bee24b@kernel.org>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Tue, 21 Nov 2023 00:21:11 -0800
Message-ID: <CAHBxVyG-DK9cDqPedJcR2W2=LQFumQQ_0Z0UUdbbzgju7BaAtg@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] tty: Add SBI debug console support to HVC SBI driver
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Conor Dooley <conor@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, 
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2023 at 11:16=E2=80=AFPM Jiri Slaby <jirislaby@kernel.org> =
wrote:
>
> On 18. 11. 23, 4:38, Anup Patel wrote:
> > diff --git a/drivers/tty/hvc/hvc_riscv_sbi.c b/drivers/tty/hvc/hvc_risc=
v_sbi.c
> > index 31f53fa77e4a..697c981221b5 100644
> > --- a/drivers/tty/hvc/hvc_riscv_sbi.c
> > +++ b/drivers/tty/hvc/hvc_riscv_sbi.c
> ...
> > -static int __init hvc_sbi_console_init(void)
> > +static int hvc_sbi_dbcn_tty_get(uint32_t vtermno, char *buf, int count=
)
> >   {
> > -     hvc_instantiate(0, 0, &hvc_sbi_ops);
> > +     phys_addr_t pa;
> > +
> > +     if (is_vmalloc_addr(buf)) {
>
> I wonder, where does this buf come from, so that you have to check for
> vmalloc?
>

When VMAP_STCK is enabled, stack allocation depends on the vmalloc.
That's why we have to if the buf is allocated using vmalloc.

> > +             pa =3D page_to_phys(vmalloc_to_page(buf)) + offset_in_pag=
e(buf);
> > +             if (PAGE_SIZE < (offset_in_page(buf) + count))
>
> Am I the only one who would prefer:
>    if (count + offset_in_page(buf) > PAGE_SIZE)
> ?
>
> > +                     count =3D PAGE_SIZE - offset_in_page(buf);
> > +     } else {
> > +             pa =3D __pa(buf);
> > +     }
> > +
> > +     return sbi_debug_console_read(count, pa);
> > +}
>
>
> thanks,
> --
> js
> suse labs
>
