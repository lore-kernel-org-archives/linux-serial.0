Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4139B172BA4
	for <linux-serial@vger.kernel.org>; Tue, 25 Jun 2024 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332843; cv=none; b=hEerYFcQ2G3cb2sYcvajfMr55uZpNd7uJPTudDTzSp0asV9LXEG03oHzAWfvZ+SAiT14O0l2WhVbNkqEP81ndVVSR5VElxDUZ2DfzIY0Yug2cxZQoq2x+i30Ps6ZAxL9mURhgjQvbLEkjqs5To4/wuR9cwoOxm/ZU1FBkUSYEhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332843; c=relaxed/simple;
	bh=FBgM8X7N6EV6X8VIVrL7KoXestIzzEPz81jUwgaNSTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obs54zi8bLB/KojP2XzRGwxv/mUXqzNcj67Np+rCdJ9TNlGIfqLznDUiaTerE9qo3/be9FtqYzU+KoXGmH9sp6ChwMSuIzF2iTOlAm+0bZJ0W1m/zvwANcJwn5/W1WwfoHfIhZpCXhRfIga81lt4nTR4Cn+1wcuNRGv/7XPwBiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kr5ItlXs; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kr5ItlXs"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-444e9ca8b68so9712701cf.1
        for <linux-serial@vger.kernel.org>; Tue, 25 Jun 2024 09:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719332839; x=1719937639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kd5y9hhIUx6r9hI0VhGrF9yxcbBN+8LVyQQ2ESHR5Ew=;
        b=kr5ItlXssd5XHeMY3sR1Gp0Eay0spKkS7xHUCx9FGrGtfco4rexAN4zQYVzqDowoBG
         iUWcsXjztqDDRQ2qFRDMdOwQKUuyVoaxWPp0O8yq1aZeT3MW9kpvrt2xeZYjl8IiFhPd
         ROOyNnP990NW/ELwJLehH+2lpVlpdSBR970Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719332839; x=1719937639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kd5y9hhIUx6r9hI0VhGrF9yxcbBN+8LVyQQ2ESHR5Ew=;
        b=pK60I4h7bc4/UvhLFLfkeQiils9Mbfung1bJ8MMMMH6hHllrPtHXDpRDkiqA96rs7i
         nE9JHgG2XzuY7lXNKMtGMR00v/xiI57JkI2FxxDaL3s4PZBfYQTuW2BbBo+24fy6XuaI
         JGrfKnY/41eZsr44IEv594bMi0TWRQwz4JaG/Wv8WiFRRkIJO1Rif4tiEgtkMDL7uKTQ
         mEcns65fMWNJTxuicC0D9ZpGFtG3+hqXFPXKRibuAsM/utUw1IJ1V5jW8bAWQiAXIBBj
         kV5N/kB9DK0tA/f+y7ToW8rXwbRsfSQsFIo0PYA78uqpFMeRrp/GsvL8bejbyu5+AAFm
         NBrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjC9zlmJdzR45py7ZjavjEPfNU8gTDFtMjvwHtIAjzodpfx/AlQAZjPXQmr/f9ZDowhnjlP6JKgH0AZBcNkUKNKc9lM8olZRNTkW7H
X-Gm-Message-State: AOJu0YwIahFztWc2ZAIiz0Or/NcP6Fu4wx6hU5uCRWbSpaLYllQm12az
	8iB8Bd8J7lFuZnFVTKiFbbkVKYacPImZHIe/bGwHbfElzGVzbYX5b/zudwncMoH32neFdHLy3WM
	=
X-Google-Smtp-Source: AGHT+IHygNq2ciWnx4WwZtxqbWajNGHgxdLoWYQeqCAE5QVjQc2BA9Q7SFIE+Zo7qrWtoWUZ0DyOUA==
X-Received: by 2002:ac8:7e82:0:b0:441:78:4ddd with SMTP id d75a77b69052e-444d9208f1dmr88053791cf.32.1719332839305;
        Tue, 25 Jun 2024 09:27:19 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444f3eb260fsm9822051cf.85.2024.06.25.09.27.18
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 09:27:18 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-445022f78e1so109271cf.1
        for <linux-serial@vger.kernel.org>; Tue, 25 Jun 2024 09:27:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJPSVlLDNOJNXUgFpMuY5QlEdMECRWObD9aCsXed/1i7/imOrcb0kXop3RmLytQx56VM4sqHOd1ZiQxgkMbh3MDrjtaXGelwcfkZXv
X-Received: by 2002:a05:622a:2a1a:b0:444:fe9d:7bc9 with SMTP id
 d75a77b69052e-444fe9d7f9amr1978871cf.8.1719332837590; Tue, 25 Jun 2024
 09:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624133135.7445-1-johan+linaro@kernel.org>
 <20240624133135.7445-2-johan+linaro@kernel.org> <CAD=FV=VZXnnbwTNc6dSqZvyCUc0=Wjg9mvBYsA1FJK3xR6bDEg@mail.gmail.com>
 <CAD=FV=UwyzA614tDoq7BntW1DWmic=DOszr+iRJVafVEYrXhpw@mail.gmail.com> <ZnraAlR9QeYhd628@hovoldconsulting.com>
In-Reply-To: <ZnraAlR9QeYhd628@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 25 Jun 2024 09:27:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U+D34mkDoFkmEXUm9fCAhC_RKbHnKXHsDZFQPxDaPmtg@mail.gmail.com>
Message-ID: <CAD=FV=U+D34mkDoFkmEXUm9fCAhC_RKbHnKXHsDZFQPxDaPmtg@mail.gmail.com>
Subject: Re: [PATCH 1/3] serial: qcom-geni: fix hard lockup on buffer flush
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 25, 2024 at 7:53=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Mon, Jun 24, 2024 at 01:45:17PM -0700, Doug Anderson wrote:
>
> > Also: if we're looking at quick/easy to land and just fix the hard
> > lockup, I'd vote for this (I can send a real patch, though I'm about
> > to go on vacation):
> >
> > --
> >
> > @@ -904,8 +904,8 @@ static void qcom_geni_serial_handle_tx_fifo(struct
> > uart_port *uport,
> >                 goto out_write_wakeup;
> >
> >         if (!port->tx_remaining) {
> > -               qcom_geni_serial_setup_tx(uport, pending);
> > -               port->tx_remaining =3D pending;
> > +               port->tx_remaining =3D min(avail, pending);
> > +               qcom_geni_serial_setup_tx(uport, port->tx_remaining);
> >
> >                 irq_en =3D readl(uport->membase + SE_GENI_M_IRQ_EN);
> >                 if (!(irq_en & M_TX_FIFO_WATERMARK_EN))
> >
> > --
> >
> > That will fix the hard lockup, is short and sweet, and also doesn't
> > end up outputting NUL bytes.
>
> Yeah, this might be a good stop gap even if performance suffers.

I've officially posted this as:

https://lore.kernel.org/r/20240625092440.1.Icf914852be911b95aefa9d798b6f1cd=
1a180f985@changeid

I realized that I didn't need to re-calculate "chunk" so the patch is
very slightly different than I posted above but should be effectively
the same.

-Doug
