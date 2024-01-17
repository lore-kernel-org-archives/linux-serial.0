Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778DB22325
	for <linux-serial@vger.kernel.org>; Wed, 17 Jan 2024 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508778; cv=none; b=GRR18q4o8yKAzoVzEyrV4szhVgDkf4FucXW5fl56snq1dXeyNjGyjjtZiIMXEJ7dENAuFpUDkv5rvXIFnzX4F1TsnFu2MjTiEHFkJJiPAkGsusM7n+aYuJTkedMxnsf9RQhMaBjIs+NR8CWUKf0HSnYIm9FhSV01L/vuyC48luM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508778; c=relaxed/simple;
	bh=55HKiHT9VhXQDcvhsVYui2uBU7EYV5t4AI48/DT5ybQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=iM1GxHHPjSyYdUPiaFzOZ2mDcZIg8sBQIv5biLTaWja5VfWZYri6b5JvwSkCqf1G1tBxTLi4N3YGR61eiljr9/UG3UYjoTmMkGLxeW8Wufvk3YqmuJeLsP9xiX8tLasZs0h8DopbmOcehiMu7A0/Z59BnXeM4WQcSkue8vavZhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C2a1b2O4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C2a1b2O4"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d5f1e0e32eso11400595ad.3
        for <linux-serial@vger.kernel.org>; Wed, 17 Jan 2024 08:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705508775; x=1706113575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwDfdGSK5tbIitnnChIc4CkmHS3deC+kI8bko4f+KI4=;
        b=C2a1b2O4V8WeJlzJiOI0kVD1b/7+GXNSDx+tstsJaQMqng4UYDES2dYqHq5/BGpBQZ
         VCCS6MDBi4TPKlryCbdDz6Nnh7LR0ZU2eQUfpZ1vF0nidVQJrAX/6XibkQiVMy+zV9Iu
         rLDxK+eP69VYlj4QnIUauGAPPjUWbeiFyEFGWO4uAvUHail4vUpFtQM97YqaAS2whjzE
         LFC64KszKzVO93rD9dxccfrzeOW098bSYjK4/xGdrqKxgeHr39kE2vLGPj6tzIivsz8L
         lyQ5jZOiVVrgDVVYzzIsMR9E5GmfxSpCjlVMj2xCFufXV8+FxKN0zPCV3BaRgtjtR98f
         uGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705508775; x=1706113575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwDfdGSK5tbIitnnChIc4CkmHS3deC+kI8bko4f+KI4=;
        b=rHJYp8qrqSJcVRjxXi0Pxz34b5ymYpFQ9quXM8BsaZ7R2fnyet1MJxThoJQTZcFru6
         0mx9Pl2DICxxSfhp91PHzK0PIrun924+xxbY+G82CLMOzm644t8SLXWm+UGe+ukA4ZAd
         2KO4PcSfacUktso4ds7ar7WSymWYr/mKDEHJGDs9HSQrRCZwLt9fj0AxbhwkeRfnNUVE
         I9uemcSJuTePJlH3jSmoiTZA+CgbwKM+6TVYLQKqj4xUipQ/ykBTPvXjqCU5C38a5j0b
         Pr3RboL5kIq+VrEhHHdzJwCoapHXp2aFSWCD07NbuyvMPtkten2GN1n1DnTbbP7yvkIu
         ThTg==
X-Gm-Message-State: AOJu0YxQqgArmiFHkTvmqqattY+EsJ0k3vE5DWaDLNSjrkegmynumjac
	z4dclw5FJHKGc63pRjhxtDDP/s6/r0Rximy1nHHv/IWU1ulcAQ==
X-Google-Smtp-Source: AGHT+IHtz96i192wuHbHGDlX8ymOFFRVWDC3NtgoZ8FjqGRAy/Ibw6ttfpwcK2tiXMCHQca0amVpgrIuJz3W6RfsGUg=
X-Received: by 2002:a17:90a:b30d:b0:28c:fec9:f205 with SMTP id
 d13-20020a17090ab30d00b0028cfec9f205mr4686711pjr.29.1705508774764; Wed, 17
 Jan 2024 08:26:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org>
 <20240110102102.61587-11-tudor.ambarus@linaro.org> <CAPLW+4=YYdUSaaLcsdEyPswC4s6onxuSh24vSfw4xys=sPZG_Q@mail.gmail.com>
 <b21a54a7-fe13-4a29-8e7e-6b653d5c24ef@linaro.org> <026bdf502c0af8260c67a7a851562633a6976031.camel@linaro.org>
In-Reply-To: <026bdf502c0af8260c67a7a851562633a6976031.camel@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 17 Jan 2024 10:26:03 -0600
Message-ID: <CAPLW+4=G0+Vuwm0Jdp4wxbL9aUTaM8S+srXYwYkm10K+=hXbOg@mail.gmail.com>
Subject: Re: [PATCH 10/18] tty: serial: samsung: make max_count unsigned int
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, krzysztof.kozlowski@linaro.org, 
	alim.akhtar@samsung.com, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 9:38=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:
>
> Hi,
>
> On Wed, 2024-01-17 at 15:21 +0000, Tudor Ambarus wrote:
> >
> >
> > On 1/16/24 18:21, Sam Protsenko wrote:
> > > On Wed, Jan 10, 2024 at 4:23=E2=80=AFAM Tudor Ambarus <tudor.ambarus@=
linaro.org> wrote:
> > > >
> > > > ``max_count`` negative values are not used. Since ``port->fifosize`=
`
> > > > is an unsigned int, make ``max_count`` the same.
> > > >
> > > > Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> > > > ---
> > > >  drivers/tty/serial/samsung_tty.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/=
samsung_tty.c
> > > > index 90c49197efc7..dbbe6b8e3ceb 100644
> > > > --- a/drivers/tty/serial/samsung_tty.c
> > > > +++ b/drivers/tty/serial/samsung_tty.c
> > > > @@ -760,8 +760,8 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(=
void *dev_id)
> > > >  static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port =
*ourport)
> > > >  {
> > > >         struct uart_port *port =3D &ourport->port;
> > > > +       unsigned int max_count =3D port->fifosize;
> > >
> > > What if port->fifosize is 0? Then this code below:
> > >
> > >     while (max_count-- > 0) {
> > >
> > > would cause int overflow, if max_count is unsigned?
> > >
> >
> > good catch, Sam!
>
> Does it matter, though? As this is a post-decrement, the test is done fir=
st, and the
> decrement after. Therefore, it'll still bail out as expected.
>

Good catch on my good catch :)

> > I'm thinking of amending this and add at the beginning of the method:
> >
> > if (!max_count)
> >       return tty_flip_buffer_push(&port->state->port);
>
> This will not help with overflow. It'll still have wrapped around after c=
ompleting the
> while() (always, no matter what start-value max_count had)
>
> Cheers,
> Andre'
>
