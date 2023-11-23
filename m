Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ciBEmrJg"
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448031BF
	for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 02:43:42 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5c19a328797so508692a12.3
        for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 02:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700736222; x=1701341022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sXx1tqGc4gio/QqB9Zb7ckRSF4i2cZOS4lFJoNm/Vo=;
        b=ciBEmrJg9nD8dBXHPjNsCi0nFqo5mPhOKfU9lqwTi+vXtkrFcNFH2oUUXjkgZ07Ewl
         oXT+q1Gwu6CfJvc/+nAwpWd48G9sQCEExhQf4YUQDGLiNqPydHWeQamOYIOUkFKc/ZJ0
         AvkHPeeZT5ildW7jHYeU3CTZRpErLvqUxju4ajKZ5XutNPkq7uUODuPVM4kyQgRaLKU/
         Cc4J1CWD0mHDByE5WrrqLx5kMPaYK5Qz+vOYcQYU1/YLSX+Ix6bAE201EkfHR4uR4CNx
         GpndpUd6Nw6q9a2c7GYNJ+jdfdxoJFRGYQCT1tl6TmNwpnIG4nxGEtckK9hxVs9m7Er+
         IoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700736222; x=1701341022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6sXx1tqGc4gio/QqB9Zb7ckRSF4i2cZOS4lFJoNm/Vo=;
        b=kUDsEbpMSdyde09C9ClIMyKxXyae9sPWtyW+iucSNar1xONMZFZdF7dDmPDrWLpWyb
         CyU2lhIqwgE0tlhqjYl8qDfVn8en6v84gBYkBxNfbUaRQm4PZQjLnYCbKfk0gbACC+U2
         fsbbhFFL4zkTHCa80m62/jf5fhNGGygEo5ig+ROxVIgb3PNHtMEHTLtFGICDY1C2ZWY7
         8IYrYL43kmp4hWl2Skqcf5bbrMoUxTckluCoo6xci+shMbSrJP7W8y8TkVar5ezi/Iei
         heYVoHUx04yGty04xLPTZBRPJoKuSWNYPEBiSrUidTmEZwz+fCWKQB+QHnWep/wMJUcf
         v8mg==
X-Gm-Message-State: AOJu0YzO4qAHFPRmrTHZ7oPvwgbx4xUous9LqXR+u1gZrEDxOe+89Fk9
	hDt6ntm7soEgQxYRC8HE+23WmTtTwV9sEOkw6aJDOQ==
X-Google-Smtp-Source: AGHT+IGQemXED5MdhPDs8hDtb2L/rF6Iac2SFIvvm1TlJvtt3KBDFlw9g5du469cf44grjodKd7ZU/U/xKDe/AsrzAY=
X-Received: by 2002:a05:6a21:9982:b0:189:11e8:6237 with SMTP id
 ve2-20020a056a21998200b0018911e86237mr5725421pzb.51.1700736221598; Thu, 23
 Nov 2023 02:43:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231118033859.726692-1-apatel@ventanamicro.com>
 <20231118033859.726692-4-apatel@ventanamicro.com> <8c0f4eba-1923-4686-b07b-1f3b78b298e9@sifive.com>
In-Reply-To: <8c0f4eba-1923-4686-b07b-1f3b78b298e9@sifive.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 23 Nov 2023 16:13:29 +0530
Message-ID: <CAK9=C2U7gD2DC+zTGvSb+6uhmA=Y-nL2Mpn8tbp8R81g_6ruEA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] tty/serial: Add RISC-V SBI debug console based earlycon
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Conor Dooley <conor@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, 
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 4:11=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Anup,
>
> On 2023-11-17 9:38 PM, Anup Patel wrote:
> > We extend the existing RISC-V SBI earlycon support to use the new
> > RISC-V SBI debug console extension.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  drivers/tty/serial/Kconfig              |  2 +-
> >  drivers/tty/serial/earlycon-riscv-sbi.c | 24 ++++++++++++++++++++----
> >  2 files changed, 21 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index 732c893c8d16..1f2594b8ab9d 100644
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
> > index 27afb0b74ea7..5351e1e31f45 100644
> > --- a/drivers/tty/serial/earlycon-riscv-sbi.c
> > +++ b/drivers/tty/serial/earlycon-riscv-sbi.c
> > @@ -15,17 +15,33 @@ static void sbi_putc(struct uart_port *port, unsign=
ed char c)
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
> >
> > +static void sbi_dbcn_console_write(struct console *con,
> > +                                const char *s, unsigned int n)
> > +{
> > +     sbi_debug_console_write(n, __pa(s));
>
> This only works for strings in the linear mapping or the kernel mapping (=
not
> vmalloc, which includes the stack). So I don't think we can use __pa() he=
re.

In which case, we need extend sbi_debug_console_write() to
do the va-to-pa conversion for both earlycon-riscv-sbi.c and
hvc_riscv_sbi.c

>
> > +}
> > +
> >  static int __init early_sbi_setup(struct earlycon_device *device,
> >                                 const char *opt)
> >  {
> > -     device->con->write =3D sbi_console_write;
> > -     return 0;
> > +     int ret =3D 0;
> > +
> > +     if (sbi_debug_console_available) {
> > +             device->con->write =3D sbi_dbcn_console_write;
> > +     } else {
> > +             if (IS_ENABLED(CONFIG_RISCV_SBI_V01))
>
> "else if", no need for the extra block/indentation.

Okay, I will update.

>
> Regards,
> Samuel
>
> > +                     device->con->write =3D sbi_0_1_console_write;
> > +             else
> > +                     ret =3D -ENODEV;
> > +     }
> > +
> > +     return ret;
> >  }
> >  EARLYCON_DECLARE(sbi, early_sbi_setup);
>

Regards,
Anup
