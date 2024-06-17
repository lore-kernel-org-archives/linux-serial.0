Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242CC43AA1
	for <linux-serial@vger.kernel.org>; Mon, 17 Jun 2024 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718653085; cv=none; b=HN+2VgmVhLfZyQwJYYMqblpYcCHIVpHXlqwmAJcbIFqsCqjmYf9zH/9F3U1/x+YkT0FUcn9RdGW/bcxt9+rhopDTSBZKE41+J5616rdU/FHvRfhSuFqM5MGIgWT7uy7Z/QARgGCtEm/SMUcx++4dOpbsOtr/0rx2T08hrY2D6F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718653085; c=relaxed/simple;
	bh=wlo+NPQPjkhJDcsoBLXWcznRisfoTBjuU62SEtBO9Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMBJd+by7d4IKdiz2RrlFqDWCJbBofdNYi72/WZN1GZTv4UpeZ2eShCaAiyKYoyRW8vAYog2dw5uAD817+SJk8hRpriegqOZPuW0BlW3bXmyqxeyoqilz6SphKUnD0DpOc9o1qFU+UzSMhcdAgi5I8ZTVfQaxP5uPGUH7YKD+kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hZbSvA9z; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hZbSvA9z"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c9b94951cfso2924155b6e.3
        for <linux-serial@vger.kernel.org>; Mon, 17 Jun 2024 12:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718653080; x=1719257880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeWty9541wg5SD9NtVmG1BHrErKfkqRa0zvwO/tO/ls=;
        b=hZbSvA9zbtcPY5dyNGk7eqWZFYlVHnjudkAFTg/FQqYgJtAtxqoc32hv1iR6YlYB/p
         ykR0LiIJc6oDs93r65G0JxmQpT29rpBsDRlAHJ8KdYsfJIGyulBWo1p1zpIuSiPsMrGH
         eSta4Qu4WM2KUw6RVxeGUVk850qO7oSEGOoT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718653080; x=1719257880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeWty9541wg5SD9NtVmG1BHrErKfkqRa0zvwO/tO/ls=;
        b=RNrwTmFq3TQAcQpC6/Eq/lf/ypGrii3+hwdOkRmDKWcj8mihBOsHfcBF6SKwGVU9AP
         rayjBmM3nVyMjM5F6nAiKMGy6aFOgloi/r9eKdxvcxNOQgwy6ejm9N7JzkYZrIyfwOCz
         Jox5cR64bWoOtdY4uNVSEhu5H+1dexCHmTccE1MT2lpBtsZ1g0McYuQ7jFIhf5bUZe7i
         tAV5776NoNIVxae7fD7OIKV3vDX7OgUrNJBuqIqLIFk9zgLguoW4UHK4ZFEQiBOSFgHK
         fZ4qwTw0HXwSblXyZFvYAOuQjF9hYCN6Z1TfR9sIE6jqr2mldUIeYiX6/LV3fZGqzHFU
         LzOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMDOd59mM+X8QLLv7eB5uVmdG6zVDkZZpXP/cbBB2QRbLULlhmTRMfloT2Bylv2phxvO1b46+mCdvBQEDtYFifRYS1BM1QGJocBAs6
X-Gm-Message-State: AOJu0YzarXCW7Vo+II8NbAMhjzCpbtri8035R3nIiTXEtfbDC+nsYTnF
	WZEVY2dW/G93o/JuftDggTXIrg462T1t1eUKB8+nJwsZrNI/6oc+2B45W80vWaP8RZNNsTa74Oc
	=
X-Google-Smtp-Source: AGHT+IH5vc34xSfgXpUOPXMpiD8tgr0ZrqkkPsWZghvaKLhWbRr9pMZ6boBzXE1w7rMAr7LahZr2Xw==
X-Received: by 2002:a05:6808:221a:b0:3d2:1cca:b7c3 with SMTP id 5614622812f47-3d24e8f0551mr11812515b6e.27.1718653080389;
        Mon, 17 Jun 2024 12:38:00 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798ab6aba50sm455453485a.70.2024.06.17.12.37.59
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 12:37:59 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-443586c2091so91971cf.0
        for <linux-serial@vger.kernel.org>; Mon, 17 Jun 2024 12:37:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyTFw01AjjRzhts7DbJ6r2mwxfql9QxGbCwwxf+rEGoe5lNLpNmuKs88keVkVB+XLoWgAUULMU+2kgSp/8yscTqFccdG0H3blguqag
X-Received: by 2002:a05:622a:1813:b0:442:172e:4dd2 with SMTP id
 d75a77b69052e-4449c71ad9dmr515541cf.18.1718653078487; Mon, 17 Jun 2024
 12:37:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610222515.3023730-1-dianders@chromium.org>
 <20240610152420.v4.8.I1af05e555c42a9c98435bb7aee0ee60e3dcd015e@changeid> <bc4892b7-7c34-4fcb-b4c0-e383890162f8@linaro.org>
In-Reply-To: <bc4892b7-7c34-4fcb-b4c0-e383890162f8@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 17 Jun 2024 12:37:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UuChPf0DH7aYq8r2XLCr7D+mbm4QSfthf-9ezvFeNUbg@mail.gmail.com>
Message-ID: <CAD=FV=UuChPf0DH7aYq8r2XLCr7D+mbm4QSfthf-9ezvFeNUbg@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] serial: qcom-geni: Rework TX in FIFO mode to fix hangs/lockups
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, Tony Lindgren <tony@atomide.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Johan Hovold <johan+linaro@kernel.org>, 
	John Ogness <john.ogness@linutronix.de>, linux-arm-msm@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Stephen Boyd <swboyd@chromium.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 17, 2024 at 12:10=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linar=
o.org> wrote:
>
>
>
> On 6/11/24 00:24, Douglas Anderson wrote:
> > The fact that the Qualcomm GENI hardware interface is based around
> > "packets" is really awkward to fit into Linux's UART design.
> > Specifically, in order to send bytes you need to start up a new
> > "command" saying how many bytes you want to send and then you need to
> > send all those bytes. Once you've committed to sending that number of
> > bytes it's very awkward to change your mind and send fewer, especially
> > if you want to do so without dropping bytes on the ground.
>
> [...]
>
>
> > +static void qcom_geni_serial_enable_cmd_done(struct uart_port *uport)
> > +{
> > +     struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> > +
> > +     /* If we're not in FIFO mode we don't use CMD_DONE. */
> > +     if (port->dev_data->mode !=3D GENI_SE_FIFO)
> > +             return;
> > +
> > +     writel(M_CMD_DONE_EN, uport->membase + SE_GENI_M_IRQ_EN_SET);
> > +}
>
> IDK if this is worth of a separate function, instead of checking for the
> FIFO in port_setup and writing it there, but generally this patch looks
> good to me

Sure. Somehow it felt weird to me to put it straight in there, but I
could go either way. Do you think I should spin the series just for
this, or just make this change if I happen to need to spin the series
for something else?


> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Thanks for your reviews, I appreciate it!

-Doug
