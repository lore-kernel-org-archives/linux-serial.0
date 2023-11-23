Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="V19SrVhh"
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DB61BE
	for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 02:39:45 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5bddf66ed63so531496a12.1
        for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 02:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700735984; x=1701340784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQ5cHR9g9Ex7S7K/JEODWQbh9BgcOaeTZEBwA4kKzCg=;
        b=V19SrVhhpEqFvV+Amp8RUVdhnT1zkmIZsAEd24PdNeQRX420Dntqw5VMraaikgflFM
         T38pE2KhtV3Jjjzd2m4jA71yPAdsyMya+d33Wvy+hPIjIQ5FjwgiHSTZuSjVfXbraz9O
         MFoT16P8OBNSMT2JCbeP2DaKCXt0fghEwnM59MUsR54s4KtfIwIzTcEkZbVmBKTvJB/+
         pulUz9f9NfMbmfnRLsPeZA/1uR8Kh7bSIZRtFwvX7vc1r4AVfJnYYUBA1e82IHZ4o0LR
         PXOqp8IsI3u5OQgTe/GoJlsQfDQzMKpTXOz0R7yzA+u5HDyi+VJvuUhSgE6aL/vmbJsO
         G5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700735984; x=1701340784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQ5cHR9g9Ex7S7K/JEODWQbh9BgcOaeTZEBwA4kKzCg=;
        b=MAqR44LfnLT1H8rOs5+OuyuNZpYnUvj9ZimH/93F4DJy6gTV6s1RB1yEX06VSAHgOP
         hLB04ih1o9SB+mRMC2/IZRdMQwk0Tbkv33CQEUJH4mufXHibAYz2ymsOKPWA5RcPCAkJ
         pKX2mJ1BBIQ9D+vap0lN3VEYTv+HdpNbGhoDXSrES1guhdXLkHYlDTxewajJC+NOAt7k
         tKc3vClDJkvPUt98k1ufci2UXXD2pK+SxJNNfTmX7UGshfQDfAWvTk/1Yo+BpUQfYGk4
         tNdVMwynQG9NwXPDMGcpiFKP9ZDRuG3bgU+COQXd+/XT3rlQLML5r6NAtt+t0SJ1WzDc
         FWhw==
X-Gm-Message-State: AOJu0YwjmWITCjbYaXHcWqT7OcONbWzSMh9/J0u+DNx7B4iRGxGHpsoh
	bbkpTc3GccuqyIf1vimkaoVHr8e21hqUJusL3bygDK9Gk1sCWx6w
X-Google-Smtp-Source: AGHT+IG99YAMevSp0jGufV7mXYc4HBJFz0NMYVlrsS8HZwf7nEtTjYohwnzETeJL+MEJrNZlmD9vq5lOCr8swdpaVqw=
X-Received: by 2002:a17:90a:bf0b:b0:280:47ba:767a with SMTP id
 c11-20020a17090abf0b00b0028047ba767amr3176568pjs.16.1700735984411; Thu, 23
 Nov 2023 02:39:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231118033859.726692-1-apatel@ventanamicro.com>
 <20231118033859.726692-6-apatel@ventanamicro.com> <fb72e212-711e-4be9-9b92-89b2dc121476@sifive.com>
In-Reply-To: <fb72e212-711e-4be9-9b92-89b2dc121476@sifive.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 23 Nov 2023 16:09:32 +0530
Message-ID: <CAK9=C2W+Rb85Dm+sN=PXgN3wpbJFrvctBvC-Coi1Q_TsvthWYA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] RISC-V: Enable SBI based earlycon support
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Conor Dooley <conor@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, 
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 4:18=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Anup,
>
> On 2023-11-17 9:38 PM, Anup Patel wrote:
> > Let us enable SBI based earlycon support in defconfigs for both RV32
> > and RV64 so that "earlycon=3Dsbi" can be used again.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  arch/riscv/configs/defconfig      | 1 +
> >  arch/riscv/configs/rv32_defconfig | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfi=
g
> > index 905881282a7c..eaf34e871e30 100644
> > --- a/arch/riscv/configs/defconfig
> > +++ b/arch/riscv/configs/defconfig
> > @@ -149,6 +149,7 @@ CONFIG_SERIAL_8250_CONSOLE=3Dy
> >  CONFIG_SERIAL_8250_DW=3Dy
> >  CONFIG_SERIAL_OF_PLATFORM=3Dy
> >  CONFIG_SERIAL_SH_SCI=3Dy
> > +CONFIG_SERIAL_EARLYCON_RISCV_SBI=3Dy
> >  CONFIG_VIRTIO_CONSOLE=3Dy
> >  CONFIG_HW_RANDOM=3Dy
> >  CONFIG_HW_RANDOM_VIRTIO=3Dy
> > diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv3=
2_defconfig
> > index 89b601e253a6..5721af39afd1 100644
> > --- a/arch/riscv/configs/rv32_defconfig
> > +++ b/arch/riscv/configs/rv32_defconfig
>
> This file isn't used anymore since 72f045d19f25 ("riscv: Fixup difference=
 with
> defconfig"), so there's no need to update it. I'll send a patch deleting =
it.

Okay, I will drop the changes in rv32_defconfig.

>
> Regards,
> Samuel
>
> > @@ -66,6 +66,7 @@ CONFIG_INPUT_MOUSEDEV=3Dy
> >  CONFIG_SERIAL_8250=3Dy
> >  CONFIG_SERIAL_8250_CONSOLE=3Dy
> >  CONFIG_SERIAL_OF_PLATFORM=3Dy
> > +CONFIG_SERIAL_EARLYCON_RISCV_SBI=3Dy
> >  CONFIG_VIRTIO_CONSOLE=3Dy
> >  CONFIG_HW_RANDOM=3Dy
> >  CONFIG_HW_RANDOM_VIRTIO=3Dy
>

Regards,
Anup
