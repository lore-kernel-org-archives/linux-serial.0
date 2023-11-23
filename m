Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="mJ39gpRB"
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4031BD
	for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 02:44:34 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6c115026985so764964b3a.1
        for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 02:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700736274; x=1701341074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unmTJjjQSG4GhQBCjfHPKG9Uy9nrMwsNNaOqoSHqW9g=;
        b=mJ39gpRBk5Yq7BZAGzR631TPLGbHXdfHcR6bMU7BYSHGM0l4IXFcovt3rBxdKvSsSJ
         bGyNntZwwR2ez3745mP1wG5mHTWsA3iBPPHmf54EINfqXbpz7TShRulh1hyp5M/EZGDj
         +ppkUzMfZgquNGq/my9UHNKtWxeXoXmxPmbDb6sATgRUnII8N6UiV5j9/oapVx8+rN11
         P/MSYdbFfhMW0HULg4r3qrHSdDs/wxSYxdDcdQqldp+aODoV9cbEByG99RVKe9rjKPcA
         UtenG26kIdlyE7OeDbKfNJYpJjrVarjWaiu7q+HESSZVipY1fc19F2Ed/tX8h2VaH06R
         BUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700736274; x=1701341074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unmTJjjQSG4GhQBCjfHPKG9Uy9nrMwsNNaOqoSHqW9g=;
        b=uDi/DLBhRjuED3beyJUOPu5TsqX/1Y5uJtBZNMNAYCa5hCw2T0WHncZfQBNAZi0I8P
         U/einu0f+BkWwbtPUSSIiTak4/bm8dblIp0erpIMNa1UKdF3Enq/JRTNtfdcv2Jrz9XD
         FBxNTLowWh5yEGAtD21O3+xawUSrshWFPR9/pLTCH9iD7q1rF3BTkXzzZFvP0G1M8K9v
         Vn/r5ZyQJFMGb9jAs1rPurNfmERikAzVNV82oFpKIPowGjPETIFHiDoCeG1bjvvJqFnk
         0lOYfJUhpG+LVD+g/fuQGVHi6jPLZml6rTfOle6BQEPhhibr+YE/FxqjgArHCNyB5k+4
         4cMA==
X-Gm-Message-State: AOJu0YxQtkm6exjVxxURVxbkkFKFCRRuM1lX6KHxFgRgTMb7YXcPOvem
	xg0itHMqAm3XV02Z1rKzJXZyktkWgMtlA9/eGQdE/A==
X-Google-Smtp-Source: AGHT+IGkFYRhyV0fxJkdmnJmDbruM7tyCPnBEy8QS6oIFkUlufe60cG/P+XEsi8T11OkZWQvkjQH/aa9Fevg/e/ljSM=
X-Received: by 2002:a05:6a20:320f:b0:187:4487:c5e9 with SMTP id
 hl15-20020a056a20320f00b001874487c5e9mr4048871pzc.47.1700736273705; Thu, 23
 Nov 2023 02:44:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231118033859.726692-1-apatel@ventanamicro.com>
 <20231118033859.726692-3-apatel@ventanamicro.com> <adf2a8f4-f675-4d27-8b46-5d80d3251b6c@sifive.com>
In-Reply-To: <adf2a8f4-f675-4d27-8b46-5d80d3251b6c@sifive.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 23 Nov 2023 16:14:21 +0530
Message-ID: <CAK9=C2WmFFsVmZZj9j9VwdQOgBiXZOUujoj5VWcycPetkqHRMQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] RISC-V: Add SBI debug console helper routines
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Conor Dooley <conor@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, 
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 4:15=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Anup,
>
> On 2023-11-17 9:38 PM, Anup Patel wrote:
> > Let us provide SBI debug console helper routines which can be
> > shared by serial/earlycon-riscv-sbi.c and hvc/hvc_riscv_sbi.c.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/sbi.h |  5 +++++
> >  arch/riscv/kernel/sbi.c      | 43 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 48 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.=
h
> > index 66f3933c14f6..ee7aef5f6233 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -334,6 +334,11 @@ static inline unsigned long sbi_mk_version(unsigne=
d long major,
> >  }
> >
> >  int sbi_err_map_linux_errno(int err);
> > +
> > +extern bool sbi_debug_console_available;
> > +int sbi_debug_console_write(unsigned int num_bytes, phys_addr_t base_a=
ddr);
> > +int sbi_debug_console_read(unsigned int num_bytes, phys_addr_t base_ad=
dr);
> > +
> >  #else /* CONFIG_RISCV_SBI */
> >  static inline int sbi_remote_fence_i(const struct cpumask *cpu_mask) {=
 return -1; }
> >  static inline void sbi_init(void) {}
> > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > index 5a62ed1da453..73a9c22c3945 100644
> > --- a/arch/riscv/kernel/sbi.c
> > +++ b/arch/riscv/kernel/sbi.c
> > @@ -571,6 +571,44 @@ long sbi_get_mimpid(void)
> >  }
> >  EXPORT_SYMBOL_GPL(sbi_get_mimpid);
> >
> > +bool sbi_debug_console_available;
> > +
> > +int sbi_debug_console_write(unsigned int num_bytes, phys_addr_t base_a=
ddr)
> > +{
> > +     struct sbiret ret;
> > +
> > +     if (!sbi_debug_console_available)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (IS_ENABLED(CONFIG_32BIT))
> > +             ret =3D sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRIT=
E,
> > +                             num_bytes, lower_32_bits(base_addr),
> > +                             upper_32_bits(base_addr), 0, 0, 0);
> > +     else
> > +             ret =3D sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRIT=
E,
> > +                             num_bytes, base_addr, 0, 0, 0, 0);
> > +
> > +     return ret.error ? sbi_err_map_linux_errno(ret.error) : ret.value=
;
> > +}
> > +
> > +int sbi_debug_console_read(unsigned int num_bytes, phys_addr_t base_ad=
dr)
> > +{
> > +     struct sbiret ret;
> > +
> > +     if (!sbi_debug_console_available)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (IS_ENABLED(CONFIG_32BIT))
> > +             ret =3D sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_READ=
,
> > +                             num_bytes, lower_32_bits(base_addr),
> > +                             upper_32_bits(base_addr), 0, 0, 0);
> > +     else
> > +             ret =3D sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_READ=
,
> > +                             num_bytes, base_addr, 0, 0, 0, 0);
> > +
> > +     return ret.error ? sbi_err_map_linux_errno(ret.error) : ret.value=
;
> > +}
>
> Since every place that calls these functions will need to do the vmalloc =
lookup,
> would it make sense to do it here, and have these take a pointer instead?

Yes, that's better. I will update.

Regards,
Anup
