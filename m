Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185B2132122
	for <linux-serial@vger.kernel.org>; Mon, 24 Jun 2024 21:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719266339; cv=none; b=N4QMUSwi2a94ze36FOs3rdBiXg5ny+3reHhoRg4Zycrm5blLsHjmbS2SiVDDkyo4ikgVPsNGHwyLxaCsGxtPSoCvSZZMQCZPnTqdzFwpqxiB1ykurC19f++uVL2U01uIOURFHDuzniAJi5MpiDQrWHu8PHEZujX69NtJOLbMZTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719266339; c=relaxed/simple;
	bh=VLdhJLIwaxQ8wxTJQNH+te/BcT//2ZP5Bbh7eH2t22E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k05AcSw03yjuBGtuuV/aQqRZ/1YuDotgnriyiUsyQgusOocscKzzAmHegNC/pYwZ3kjGfOvffFNOpQ3Cg0/RscSMqdoo0/UU/e7PF35nhHXo/pGA8NvMNN7YIxkf7xU/uyRpUetx8JrpAqEymJybF23FUfVU2DJtTjJ0S+hK6p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BhQycbr5; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BhQycbr5"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b50aeb2424so23647896d6.0
        for <linux-serial@vger.kernel.org>; Mon, 24 Jun 2024 14:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719266335; x=1719871135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PykbmAe7/RecVGDwZZ/IKDsll6JeakGvoiBa3T2dozg=;
        b=BhQycbr5Gv+j5mUT5pcLolID+cPjQxl9s9QpOZmIvpIWpPVXQmMytFaWd0o705JEdT
         gvwr7rAl6YDjKf3j5N3XcoGWgte+ncksUnzLWh9+4V71DMv9v84nnYlRPeW7FQC3hQwX
         eFqN7f+Hk503dGmVfgHE1M7PXUHBv925IHSqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719266335; x=1719871135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PykbmAe7/RecVGDwZZ/IKDsll6JeakGvoiBa3T2dozg=;
        b=h91tr0ghSqqnaOeC9AwNlfJmGw7kJ7NNaeIpj3TPlBFEVcbR25W3UEVYewUiPwDReS
         v+XLN+EseDlJi8JaQlosVoASvI2wVi5wZNxCCdMLZiUseTPBG9v2oVFrvgw364kSEw2/
         oBiCTEptIn0fKbdmANTg6sTIU2D0niIh8bAyigv0ijQ2umS/3KqXeWx22tXgOHsRAs9g
         8KPkGzafQrw0Mok+E2heZQ9/n4u70De/DtErrpMIXs3bp3O4bPgUOTJ70kkZ4c4RX3ig
         Zd1jdQ9lnSkPS1zwpGL5I6bsp3UgAc2LANUiKVIiYLKUqHNS7KcF76hbBK7uxK08G3Kd
         3QNA==
X-Forwarded-Encrypted: i=1; AJvYcCVbnvcqAw4EWwVAyFtOsnVR/Ho863He+/MI6rQ7DXvlfAEZBN3fw9dZ18tY7ZoIED5K1ud7DGVu4PM9Ly7VzORm58AjGF3+Vk8E2pzR
X-Gm-Message-State: AOJu0YxiomfpuOYpcmAcnr3ZfiMlZMK4VKUpS2C2gA/2eWOWwBgKE+jd
	TvMhRvgHobdw1KnnNZ/EzF0Y1BzmxCZbEePEda8NgZ+J7cXRghhACYn8C+PPrHD8TdJN7EBGKNs
	=
X-Google-Smtp-Source: AGHT+IHqXXTNd2PrfBUOaSYYq8AyPVNxzYjtH6s+KPnx3LT8O/YDgMIfliZ17nHD0fjotjyBNVhOCw==
X-Received: by 2002:a05:6214:5583:b0:6b0:7327:c45b with SMTP id 6a1803df08f44-6b5409c4416mr57585676d6.16.1719266335341;
        Mon, 24 Jun 2024 14:58:55 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ed7e39bsm38195346d6.70.2024.06.24.14.58.54
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 14:58:54 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-443586c2091so55601cf.0
        for <linux-serial@vger.kernel.org>; Mon, 24 Jun 2024 14:58:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW642Z3yL5/pZnXVrLzl7SH9peLbdtFEovQVccDzXH805tlEDmYMDD5Gdd7KcqZrPjSH0mRJlgrpawPZc59bcxMt6vYgq+MOeBzhgx7
X-Received: by 2002:ac8:59d0:0:b0:444:ba78:c32c with SMTP id
 d75a77b69052e-444f36a7810mr388891cf.11.1719266334099; Mon, 24 Jun 2024
 14:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624133135.7445-1-johan+linaro@kernel.org>
 <20240624133135.7445-3-johan+linaro@kernel.org> <CAD=FV=UauWffRM45FsU2SHoKtkVaOEf=Adno+jV+Ashf7NFHuA@mail.gmail.com>
In-Reply-To: <CAD=FV=UauWffRM45FsU2SHoKtkVaOEf=Adno+jV+Ashf7NFHuA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Jun 2024 14:58:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XPKqjMcWhqk4OKxSOPgDKh-VM4J4oMEdQtgpFBw8WSXA@mail.gmail.com>
Message-ID: <CAD=FV=XPKqjMcWhqk4OKxSOPgDKh-VM4J4oMEdQtgpFBw8WSXA@mail.gmail.com>
Subject: Re: [PATCH 2/3] serial: qcom-geni: fix soft lockup on sw flow control
 and suspend
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 24, 2024 at 2:23=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Mon, Jun 24, 2024 at 6:31=E2=80=AFAM Johan Hovold <johan+linaro@kernel=
.org> wrote:
> >
> > The stop_tx() callback is used to implement software flow control and
> > must not discard data as the Qualcomm GENI driver is currently doing
> > when there is an active TX command.
> >
> > Cancelling an active command can also leave data in the hardware FIFO,
> > which prevents the watermark interrupt from being enabled when TX is
> > later restarted. This results in a soft lockup and is easily triggered
> > by stopping TX using software flow control in a serial console but this
> > can also happen after suspend.
> >
> > Fix this by only stopping any active command, and effectively clearing
> > the hardware fifo, when shutting down the port. Make sure to temporaril=
y
> > raise the watermark level so that the interrupt fires when TX is
> > restarted.
>
> Nice! I did quite a few experiments, but it sounds like you found
> something that I wasn't able to find. Specifically once I cancelled an
> ongoing command I could never manage to get it started back up, but it
> must have just been that data was still in the FIFO and thus the
> watermark never fired again.
>
> When I was experimenting, I also swore that there were cases where
> geni would sometimes fully drop bytes when I tried to "cancel" a
> command, but maybe I was mistaken. Everything I figured out was
> essentially by running experiments and I could easily have had a bug
> in my experiment.
>
>
> > Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver s=
upport for GENI based QUP")
> > Cc: stable@vger.kernel.org      # 4.17
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/tty/serial/qcom_geni_serial.c | 28 +++++++++++++++++----------
> >  1 file changed, 18 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial=
/qcom_geni_serial.c
> > index 1d5d6045879a..72addeb9f461 100644
> > --- a/drivers/tty/serial/qcom_geni_serial.c
> > +++ b/drivers/tty/serial/qcom_geni_serial.c
> > @@ -651,13 +651,8 @@ static void qcom_geni_serial_start_tx_fifo(struct =
uart_port *uport)
> >  {
> >         u32 irq_en;
> >
> > -       if (qcom_geni_serial_main_active(uport) ||
> > -           !qcom_geni_serial_tx_empty(uport))
> > -               return;
> > -
> >         irq_en =3D readl(uport->membase + SE_GENI_M_IRQ_EN);
> >         irq_en |=3D M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
> > -
> >         writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
> >         writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> >  }
> > @@ -665,16 +660,28 @@ static void qcom_geni_serial_start_tx_fifo(struct=
 uart_port *uport)
> >  static void qcom_geni_serial_stop_tx_fifo(struct uart_port *uport)
> >  {
> >         u32 irq_en;
> > -       struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> >
> >         irq_en =3D readl(uport->membase + SE_GENI_M_IRQ_EN);
> >         irq_en &=3D ~(M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN);
> >         writel(0, uport->membase + SE_GENI_TX_WATERMARK_REG);
> >         writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> > -       /* Possible stop tx is called multiple times. */
>
> If qcom_geni_serial_stop_tx_fifo() is supposed to be used for UART
> flow control and you have a way to stop the transfer immediately
> without losing data (by using geni_se_cancel_m_cmd), maybe we should
> do that? If the other side wants us to stop transferring data and we
> can stop it right away that would be ideal...
>
>
> > +}
> > +
> > +static void qcom_geni_serial_clear_tx_fifo(struct uart_port *uport)
> > +{
> > +       struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> > +
> >         if (!qcom_geni_serial_main_active(uport))
> >                 return;
> >
> > +       /*
> > +        * Increase watermark level so that TX can be restarted and wai=
t for
> > +        * sequencer to start to prevent lockups.
> > +        */
> > +       writel(port->tx_fifo_depth, uport->membase + SE_GENI_TX_WATERMA=
RK_REG);
> > +       qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
> > +                                       M_TX_FIFO_WATERMARK_EN, true);
>
> Oh, maybe this "wait for sequencer to start to prevent lockups." is
> the part that I was missing? Can you explain more about what's going
> on here? Why does waiting for the watermark interrupt to fire prevent
> lockups? I would have imagined that the watermark interrupt would be
> part of the geni hardware and have nothing to do with the firmware
> running on the other end, so I'm not sure why it firing somehow would
> prevent a lockup. Was this just by trial and error?

Actually, the more I look at it the more confused I am about your
qcom_geni_serial_clear_tx_fifo(). Can you explain and maybe add some
inline comments in the function since it's not obvious? Specifically,
things I'm confused about with your patch:

1. The function is named qcom_geni_serial_clear_tx_fifo() which
implies that when it finishes that the hardware FIFO will have nothing
in it. ...but how does your code ensure this?

2. If the function is really clearing the FIFOs then why do we need to
adjust the watermark level? The fact that you need to adjust the
watermark levels implies (to me) that there are things stuck in the
FIFO still. ...but then what happens to those characters? When are
they sent?

3. On my hardware you're setting the FIFO level to 16 here. The docs I
have say that if the FIFO level is "less than" the value you set here
then the interrupt will go off and further clarifies that if you set
the register to 1 here then you'll get interrupted when the FIFO is
empty. So what happens with your solution if the FIFO is completely
full? In that case you'd have to set this to 17, right? ...but then I
could believe that might confuse the interrupt handler which would get
told to start transmitting when there is no room for anything.


Maybe something is missing in my mental model here and testing your
patch and hitting Ctrl-C seems to work, but I don't really understand
why so hopefully you can clarify! :-)

-Doug
