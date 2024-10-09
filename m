Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1F11953BA
	for <linux-serial@vger.kernel.org>; Wed,  9 Oct 2024 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477630; cv=none; b=HFADTGOg3R7FskwDi8FwCvPQxzi9RmAW862rq678HwtenUZ0HWUqJ09GiX4vm9zz4BXVXGQpMtnJjl00mon/ZoPdZXkSlP/YCekAmRYETpvPemivQB1OAHDL7KBcbZvhy2kyWzNT2ovJdNuuhJUBHQVGqKmUoQeg5M96LoSg3q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477630; c=relaxed/simple;
	bh=NX34IxOgzpU/58lP/IC+KEU7eNMZKOWaom9j0SKbKLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZkMFXDLrXqfYJGqJ6HoQz5d0nm1vdk8R7QCPBtElDW5rSXn+TpdH8Uae6Fn7mSgv7EQKD8JqiG2cK9gy0dUZGArVvrvSnBAVTPtmRQb/3ATaPOvHeFUsQdFv83pfejgRTKmRP6mYnSEdKPICRDxp4Fvu9I8Fg+cHjDypCHb0Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X1znPr9U; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X1znPr9U"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e28fd8cdfb8so857741276.3
        for <linux-serial@vger.kernel.org>; Wed, 09 Oct 2024 05:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728477628; x=1729082428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPZfCYV/wy71ba4BSJvyuLIGj5SMt+aZjw2X+wMCyV4=;
        b=X1znPr9Ub7yckj/3cefLuGg/zu0ps3DGSjPhGaqjS8Yyj/aDEuPfXXJQReCX1DOlle
         qlbeEkEw3RI6gwQGWBzRqhVzdXkmH3K1LgKFu42871nuCrx0msDm394ZKvg8gmDKgUx3
         uxGCVXb91C9n2cYRSHsQ28vv1SV/UHndLJSz6uE2HoMrPb09GAIpxKyfi2x9quJZG1nj
         fXlhw42CqwdEOJCQFDgrIKUceLrb1dNsj/5h8kBnRm/aFBYImOMHm9n3AFqF3aKfHihx
         JJFKXWS7+mdG4pO789nd12yLIIUD3BWqPqWo45dszzqlcPNKZjkH6oCvS0OShYK6RT8h
         HCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728477628; x=1729082428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPZfCYV/wy71ba4BSJvyuLIGj5SMt+aZjw2X+wMCyV4=;
        b=pKdIp/gIozJbr1be1bQI/oE1tO//EzM8UhksfyR4WuSdnoX0yH3r/JEuf2/NlTEckH
         ypM8FbO9ZvnQ0KZ4XOaoVGUftAUl2ae2JwALDiRJLSKwquxvqXkc7jA+S70pnvDzJJrx
         AYKICJ6IplU78yqbmifNZrsBuzOru2G8/ArHfUuHs1vZ410ZLeI2Ks38Bt8GqVOGXuxo
         Yh7hZDjnuXGRHIGCoYSmzGWfOkjArBwR9G21bsBSkekdbF8CAxZx5cxp+aqPhNDXtfrp
         gBb7gWCyxrK+iiVG4mahR698BJJAWJYrFovOlcLjbB3cq4eDYtvdvuMkbrCvbW4p9M2n
         j1GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhzBTBGvRzUuIiOom6gRvyMYjIgmVZJKGm/QHh+/gjCaR4Nk8kAzRuxK4tKCPt+O1BgHhqsexHK/yGFVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRP7mLNigNsMHIIp34F7IwGypdhETE7xm/8YmMWDOEKMWAUUC/
	adb3ntHIGGCRE30WINgTmi7WmO+LDEo9JKYb5owjhhcLw8XzZUaRAQCvWw4YPjqLI4SQO8IN8QJ
	rknJ8w2odb/8Is7KuF6Mn4NzFJGS2M2U7IyHHjg==
X-Google-Smtp-Source: AGHT+IFMhQJXg0E+KgtQQV2VTHLP9Hnj16lRLdW5+uaKNhSiRNc2pcvPFCL51GS0djemx0sYBfMwlHxGs+hepVq+tqM=
X-Received: by 2002:a05:6902:15cd:b0:e25:cdc2:ed93 with SMTP id
 3f1490d57ef6-e28fe43f401mr1818390276.30.1728477627975; Wed, 09 Oct 2024
 05:40:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-8250-omap-no-console-suspend-v1-0-e7f0365c02f0@bootlin.com>
 <20241008-8250-omap-no-console-suspend-v1-2-e7f0365c02f0@bootlin.com>
 <CAPDyKFpnsV-c4F7SNPQmLBSM1sUknr-3sTyiXMDt9n43UBQkNg@mail.gmail.com> <d879d544-4b1d-4b4a-bfd4-efb35b6a57c1@bootlin.com>
In-Reply-To: <d879d544-4b1d-4b4a-bfd4-efb35b6a57c1@bootlin.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Oct 2024 14:39:51 +0200
Message-ID: <CAPDyKFoOV00JzQ=+j7FJzVb0Zb4j-qjR5YPT020TzyJKngeFMg@mail.gmail.com>
Subject: Re: [PATCH 2/2] serial: 8250_omap: mark the serial as on the wakeup
 path if no_console_suspend
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, u-kumar1@ti.com, tony@atomide.com, 
	khilman@kernel.org, gregory.clement@bootlin.com, thomas.petazzoni@bootlin.com, 
	theo.lebrun@bootlin.com, richard.genoud@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Oct 2024 at 14:17, Thomas Richard <thomas.richard@bootlin.com> wr=
ote:
>
> On 10/9/24 12:50, Ulf Hansson wrote:
> > On Tue, 8 Oct 2024 at 11:34, Thomas Richard <thomas.richard@bootlin.com=
> wrote:
> >>
> >> If the console suspend is disabled, mark the serial as on the wakeup p=
ath
> >> to keep its PM domain powered on.
> >>
> >> Suggested-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> >> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> >> ---
> >>  drivers/tty/serial/8250/8250_omap.c | 8 ++++++--
> >>  1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/=
8250/8250_omap.c
> >> index 88b58f44e4e9..6764fe2f9cad 100644
> >> --- a/drivers/tty/serial/8250/8250_omap.c
> >> +++ b/drivers/tty/serial/8250/8250_omap.c
> >> @@ -1660,8 +1660,12 @@ static int omap8250_suspend(struct device *dev)
> >>         if (!device_may_wakeup(dev))
> >>                 priv->wer =3D 0;
> >>         serial_out(up, UART_OMAP_WER, priv->wer);
> >> -       if (uart_console(&up->port) && console_suspend_enabled)
> >> -               err =3D pm_runtime_force_suspend(dev);
> >> +       if (uart_console(&up->port)) {
> >> +               if (console_suspend_enabled)
> >> +                       err =3D pm_runtime_force_suspend(dev);
> >> +               else
> >> +                       device_set_wakeup_path(dev);
> >> +       }
> >
> > Isn't this already managed by the serial core? See commit a47cf07f60dc
> > ("serial: core: Call device_set_awake_path() for console port")
>
> Yes you're right.
> So this patch is useless.

So patch 1/2 is all you need to get things working?

Kind regards
Uffe
