Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F52757F3
	for <linux-serial@vger.kernel.org>; Mon, 10 Jun 2024 22:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058846; cv=none; b=F2So6sdjBHqNWGlaOIjDLB3Y+2RsSO+C5876fvUMyggkYZJaC9E7MzI4Mn4eiNbNqjnPBkOd/tkAKQVCLqk29/CA2Vgs7cOFBXEn8lTpg3/LzJj7YBGdtnEtHJrJURwryf9bvTKBdJSdzagmuEBoVv8/RMC+ol20acmAxS3X/pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058846; c=relaxed/simple;
	bh=jkVV1qC5l78Q3rbJemzf3Lvhx8BH5IjwVLa5ql5PA1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ul4UdLgCbmAQbIg9SSRE2wM+cud4A1X9joKneEKc81ChkqlJaBHXJXIYjW+fPSIrbXYHiGVrE669n3eRMVvy8NW1i2CdPIqpw2x6JZim1YH6eS8QC/fDg9NkOCK+9zsy7r9epTOJ2KAcUgeCNPpioa3jz+ib+kKJGDBlOJne/Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UH05GwZq; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UH05GwZq"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6e4e6230f42so2110747a12.0
        for <linux-serial@vger.kernel.org>; Mon, 10 Jun 2024 15:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718058843; x=1718663643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t61vhNKu4lfde12Y7MkGP0C3wTMA8CL4vSTRQiLNbi4=;
        b=UH05GwZqRj4/i4lRuav1v6KX2VqDTYP+85bgwD5BZ94Jj8bDTZsR9ciAorjmmAcnVX
         8WYqi1aHfAz0A5e+FUzA5WiSaaXkrduuTRha+jcrt+aJrRttpBQH0yDs8FvvPEyv7InA
         nuyEbxErXM4LEHmyhJj7NF/38TfHJOj39fVIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718058843; x=1718663643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t61vhNKu4lfde12Y7MkGP0C3wTMA8CL4vSTRQiLNbi4=;
        b=Epf2DjxWTn/pHM8cKmE0tiOh/fCrnHhLtCcgQejm57F4s+zRVaE7dSH3KyxS9wDYKX
         +zedGvFHq5w7nRGwJNDkf9KRvnY8n4YgBokbh6CsQtqXrktV7tR/bEIZij1UjAIKO1hk
         qlWUi++Ox0nB/adwmG8EoAE+YphgqZCXADeE8OHylAbk5H8hliFuG+DTkr7ivtEQ7jKh
         pOCNndd8ItiH0vL3bH6X3ljP9ZVuy08k7rPBFfVGKCrHD/YtrLptml0Y2nFLuk8+RCFs
         4qZ0xNvOMqKQ2JTLCP8ANqXxxFlfpSppn2k2Zia6sWYafmt8pfIkpjiPcoU3/7ej+3yl
         62hw==
X-Forwarded-Encrypted: i=1; AJvYcCV7zZbVYrL7teGLBlyKO0Hv38UEOPHn9LRFrhNt7RHuR4dQbHjPNoBn5FuGQyUtLrsw430AHDI7UzUOsnZ1mD7/HzeIWy2yOwnnZsLS
X-Gm-Message-State: AOJu0YwSW1S3+Kkw1Q7a4wwXFVHo8dnxjnvk2crCYVEN1/jNZ7xxnzGe
	hni+TUif3YE+Sv2sPhIgmoc1uV+TlaUcdiKyo1ZwH+5XhVi7+a3lm2vbFWGCijnQBOrDQDzvwYs
	=
X-Google-Smtp-Source: AGHT+IEAvMoQa079Pw434H4f8ZmN0k3IE7xjJK8YiVRXEhj7gp7tKlWFfCu2IQMXPZLOYGiVvoSyTw==
X-Received: by 2002:a17:90a:6b08:b0:2c2:da08:c341 with SMTP id 98e67ed59e1d1-2c32b552031mr1196321a91.23.1718058843119;
        Mon, 10 Jun 2024 15:34:03 -0700 (PDT)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com. [209.85.214.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c3122f8867sm2193983a91.36.2024.06.10.15.34.02
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 15:34:02 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ee5f3123d8so29955ad.1
        for <linux-serial@vger.kernel.org>; Mon, 10 Jun 2024 15:34:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWjLKeNHc/lQ7MrO86HsqhEncvPtkOeIWOMk6Hpo5L8TEFK0ccnEOH1kF+pGY7ZsirT53YprI1uGajNXyRO+mzt4JkVrGhlv2JKO3Vx
X-Received: by 2002:a05:622a:5818:b0:440:331b:59f7 with SMTP id
 d75a77b69052e-441401262famr1308541cf.6.1718058395830; Mon, 10 Jun 2024
 15:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604160123.2029413-1-dianders@chromium.org>
 <20240604090028.v3.6.I0f81a5baa37d368f291c96ee4830abca337e3c87@changeid> <2c5c3d46-5fe2-6678-34ea-647c28f5a4f0@linux.intel.com>
In-Reply-To: <2c5c3d46-5fe2-6678-34ea-647c28f5a4f0@linux.intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 10 Jun 2024 15:26:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XDcFsStOcViTQLLQqPtbCOqeVeoU0T7fi81jhHodpa=A@mail.gmail.com>
Message-ID: <CAD=FV=XDcFsStOcViTQLLQqPtbCOqeVeoU0T7fi81jhHodpa=A@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] serial: qcom-geni: Fix suspend while active UART xfer
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-arm-msm@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-serial <linux-serial@vger.kernel.org>, John Ogness <john.ogness@linutronix.de>, 
	Yicong Yang <yangyicong@hisilicon.com>, Tony Lindgren <tony@atomide.com>, 
	Stephen Boyd <swboyd@chromium.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 7, 2024 at 12:43=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> > @@ -311,11 +312,14 @@ static bool qcom_geni_serial_poll_bit(struct uart=
_port *uport,
> >
> >  static void qcom_geni_serial_setup_tx(struct uart_port *uport, u32 xmi=
t_size)
> >  {
> > +     struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> >       u32 m_cmd;
> >
> >       writel(xmit_size, uport->membase + SE_UART_TX_TRANS_LEN);
> >       m_cmd =3D UART_START_TX << M_OPCODE_SHFT;
>
> Unrelated to this patch and won't belong to this patch but I noticed it
> while reviewing. This could be converted into:
>
>         m_cmd =3D FIELD_PREP(M_OPCODE_MSK, UART_START_TX);
>
> (and after converting the other use in the header file, the SHFT define
> becomes unused).

Sure. I'm going to leave that to someone in the future, though. I've
already spent more time than I should on this series and, if we're
going to do this, we should convert the whole driver (and perhaps all
the geni drivers).


> > @@ -335,6 +339,64 @@ static void qcom_geni_serial_poll_tx_done(struct u=
art_port *uport)
> >       writel(irq_clear, uport->membase + SE_GENI_M_IRQ_CLEAR);
> >  }
> >
> > +static void qcom_geni_serial_drain_tx_fifo(struct uart_port *uport)
> > +{
> > +     struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> > +
> > +     /*
> > +      * If the main sequencer is inactive it means that the TX command=
 has
> > +      * been completed and all bytes have been sent. Nothing to do in =
that
> > +      * case.
> > +      */
> > +     if (!qcom_geni_serial_main_active(uport))
> > +             return;
> > +
> > +     /*
> > +      * Wait until the FIFO has been drained. We've already taken byte=
s out
> > +      * of the higher level queue in qcom_geni_serial_send_chunk_fifo(=
) so
> > +      * if we don't drain the FIFO but send the "cancel" below they se=
em to
> > +      * get lost.
> > +      */
> > +     qcom_geni_serial_poll_bitfield(uport, SE_GENI_M_GP_LENGTH, GENMAS=
K(31, 0),
>
> That GENMASK(31, 0) is a field in a register (even if it covers the
> entire register)? It should be named with a define instead of creating th=
e
> field mask here in an online fashion.

Sure. Done.


> > +                                    port->tx_total - port->tx_remainin=
g);
> > +
> > +     /*
> > +      * If clearing the FIFO made us inactive then we're done--no need=
 for
> > +      * a cancel.
> > +      */
> > +     if (!qcom_geni_serial_main_active(uport))
> > +             return;
> > +
> > +     /*
> > +      * Cancel the current command. After this the main sequencer will
> > +      * stop reporting that it's active and we'll have to start a new
> > +      * transfer command.
> > +      *
> > +      * If we skip doing this cancel and then continue with a system
> > +      * suspend while there's an active command in the main sequencer
> > +      * then after resume time we won't get any more interrupts on the
> > +      * main sequencer until we send the cancel.
> > +      */
> > +     geni_se_cancel_m_cmd(&port->se);
> > +     if (!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
> > +                                    M_CMD_CANCEL_EN, true)) {
> > +             /* The cancel failed; try an abort as a fallback. */
> > +             geni_se_abort_m_cmd(&port->se);
> > +             qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
> > +                                             M_CMD_ABORT_EN, true);
>
> Misaligned.

Done.
