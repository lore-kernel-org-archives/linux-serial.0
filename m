Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAFD13CA8A
	for <linux-serial@vger.kernel.org>; Thu,  8 Aug 2024 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723104711; cv=none; b=WZS4yUKSbSeN9jiBECTI2qJ3o2xWgSh0zO4GpOdI0YcVPvnWi/ea2vvSYZ79KYKHu29YeaNyjQW4wo/GpjzxBQV+QfjA4kUXytJfcSqi4VIfpcQOGm/+XSih366D7k3IWD5140nIJvRUqOyFw9rIXz5GXV1I43ZVSlcKPqjXeCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723104711; c=relaxed/simple;
	bh=CVEB7K/HCGlXrmGy1RHGDaOx+otbdb1A+vDSXRc53ho=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k9hz4AQrD47q3I0nJ2v5Q72koxSdGXtw9QK9V8EJnMli2+222b6Z30rTWfeQMx0SWU7G6QMLPrWlwXc8rtn82K8JvHRXFbRv/+jtDSrvzYkqb0ZmvLOjpA0ew+FDSnm7PcN3PplqcNN90y2+2lux1J8ssuT9NwBEbK+U3NlnlVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xgDZiU/m; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xgDZiU/m"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428119da952so4490455e9.0
        for <linux-serial@vger.kernel.org>; Thu, 08 Aug 2024 01:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723104708; x=1723709508; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=imaAmnxdmHHr/VbTzYVPQHsek2dIIM4b+CpPCVUc4QY=;
        b=xgDZiU/mmXSCM0pVR2Cc+MO/1i0tlrW9G5Jr2jcdofeWxNNnGu7tbEvA/ZiMVbZGRD
         82SCrDghR0IMOerEw10fDW6MOkrJVR+sCPVb5ytW6Sgq+cEnoMc0v5kPeXHVo0ke0suj
         dTf6HAPqdT6eRaMalPkQpW7//cRERLXZ5OOMTgkoNdA1HViH/21QafaXcjWTUMvpRaiE
         QIwIFbmgxTSJUDSYCzZKRsWbJA+Rr4T0Bm77Y0l6KZmeihO/nDVRAlXx6Avh0DDss0hP
         jE65s+EYK393vA7YwWL7zXFwLIBruM9F0G4roGzco5NAACXunMiFGl0tiUAZCXrxOTGx
         gT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723104708; x=1723709508;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=imaAmnxdmHHr/VbTzYVPQHsek2dIIM4b+CpPCVUc4QY=;
        b=XfcvdN9XYePVpmzAoX3l9cATSXrbwzODNqPWN2BWyhK3SgYW2xkp8bYgjH3Q4s8OQR
         JTrmetHATW1f4M7ZUoTZrE/+nu/Teu9nPqWGltKl6/jP9rqSGCfmxU3ucUFUTKMhoVsu
         GXkIctOCmqjauYHO0PMpRjiwSZoeska4pYI0RxgJBcNJ+kKAzHZ8f7KUIVh7vdRMtV4I
         nK3QoF7FHPAJOh+F2z6GOmF+i9HX1VBlhC6hVwJO72PxdcclUIPP3GgdiAPHdR3/1SSw
         v8LDK3j+gf8SCb2JW2YmwSmtd84GLFU3u6v7KXsegwin680ahXbr5Is+89VHQWx4pe6p
         piDg==
X-Forwarded-Encrypted: i=1; AJvYcCXAas7hRHkeQ+TuF77Y3e3V8B7ABtYrqB07HHgDYGagsJUiWdfNWUMAyii9BdlvZ9cCjAaGzSAr2Gm12Zxj2KYRhaBM8corhgHOivZR
X-Gm-Message-State: AOJu0YyORTYDGjUs2UScKhMdszREf69zQXm/j8aJCMkgytZlT8jf1FbL
	mG7+Jbvd6+Rq4fxbqyakDl/Tg6q/dD31Nl0z3ULrBstOyfWxFpQrSRu1J3e61jY=
X-Google-Smtp-Source: AGHT+IEjup3Gwty6V8M2pYX9RIBvrefx+VP/F13Y4OSUeerPt73EPMRI9epzxgCdxc3p3/S1ybwB3A==
X-Received: by 2002:a05:600c:cc3:b0:426:6389:94c4 with SMTP id 5b1f17b1804b1-4290af238e7mr8354375e9.37.1723104707669;
        Thu, 08 Aug 2024 01:11:47 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c738d21sm9864665e9.12.2024.08.08.01.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 01:11:47 -0700 (PDT)
Message-ID: <a8a532a86732393e20f9cce2c9c1145f379477cd.camel@linaro.org>
Subject: Re: [PATCH v2 2/2] tty: serial: samsung_tty: cast the interrupt's
 void *id just once
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski
 <krzk@kernel.org>,  Alim Akhtar <alim.akhtar@samsung.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus
	 <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Date: Thu, 08 Aug 2024 09:11:45 +0100
In-Reply-To: <65ce2214-dad5-4a73-8806-07aab5404cf8@kernel.org>
References: <20240807-samsung-tty-cleanup-v2-0-1db5afc9d41b@linaro.org>
	 <20240807-samsung-tty-cleanup-v2-2-1db5afc9d41b@linaro.org>
	 <65ce2214-dad5-4a73-8806-07aab5404cf8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-08 at 09:31 +0200, Jiri Slaby wrote:
> On 07. 08. 24, 13:58, Andr=C3=A9 Draszik wrote:
> > The interrupt handler routines and helpers are casting the 'void *'
> > pointer to 'struct exynos_uart_port *' all over the place.
> >=20
> > There is no need for that, we can do the casting once and keep passing
> > the 'struct exynos_uart_port *', simplifying the code and saving a few
> > lines of code.
> >=20
> > No functional changes.
> ...
> > @@ -944,17 +939,17 @@ static irqreturn_t s3c24xx_serial_tx_irq(void *id=
)
> > =C2=A0 /* interrupt handler for s3c64xx and later SoC's.*/
> > =C2=A0 static irqreturn_t s3c64xx_serial_handle_irq(int irq, void *id)
> > =C2=A0 {
> > -	const struct s3c24xx_uart_port *ourport =3D id;
> > -	const struct uart_port *port =3D &ourport->port;
> > +	struct s3c24xx_uart_port *ourport =3D id;
> > +	struct uart_port *port =3D &ourport->port;
> > =C2=A0=C2=A0	u32 pend =3D rd_regl(port, S3C64XX_UINTP);
> > =C2=A0=C2=A0	irqreturn_t ret =3D IRQ_HANDLED;
> > =C2=A0=20
> > =C2=A0=C2=A0	if (pend & S3C64XX_UINTM_RXD_MSK) {
> > -		ret =3D s3c24xx_serial_rx_irq(id);
> > +		ret =3D s3c24xx_serial_rx_irq(ourport);
> > =C2=A0=C2=A0		wr_regl(port, S3C64XX_UINTP, S3C64XX_UINTM_RXD_MSK);
> > =C2=A0=C2=A0	}
> > =C2=A0=C2=A0	if (pend & S3C64XX_UINTM_TXD_MSK) {
> > -		ret =3D s3c24xx_serial_tx_irq(id);
> > +		ret =3D s3c24xx_serial_tx_irq(ourport);
> > =C2=A0=C2=A0		wr_regl(port, S3C64XX_UINTP, S3C64XX_UINTM_TXD_MSK);
> > =C2=A0=C2=A0	}
> > =C2=A0=C2=A0	return ret;
> > @@ -963,19 +958,19 @@ static irqreturn_t s3c64xx_serial_handle_irq(int =
irq, void *id)
> > =C2=A0 /* interrupt handler for Apple SoC's.*/
> > =C2=A0 static irqreturn_t apple_serial_handle_irq(int irq, void *id)
> > =C2=A0 {
> > -	const struct s3c24xx_uart_port *ourport =3D id;
> > -	const struct uart_port *port =3D &ourport->port;
> > +	struct s3c24xx_uart_port *ourport =3D id;
> > +	struct uart_port *port =3D &ourport->port;
>=20
> No need to remove const from port here and above, right? (Only from=20
> ourport.)

Jiri, you're right of course.

Thanks,
A.

