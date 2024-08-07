Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EAF1C8234
	for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2024 11:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723029456; cv=none; b=tY4xIM5xUf8iacpqqlk7XBYg/m0iuZ42SVANATSu94HbG+z1gEA5l79zTmkhoYqUAOX3OR9QxAuJV1Nw9WU9TEe78oIZuDyyVrHR/uNGTatLE/3NQBcbxybG4IiQgtiTdfyyXWvKk2j79QlhdSg0KI9H7wgbXMhtaTYFuKiBWho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723029456; c=relaxed/simple;
	bh=yFZfnIIZNy81/zF1j/wi9hJhWAUXJzjhPkiUHNQ7Wfk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jPuKBeVCxxS1rkFccczcC/saa+wqMAbw1HFzY4ing2O+hIgAC+a5QxpwR+4og4PHliRMsuyifa84Rd+K7mCg0vLlE24dysSg/lZKEovqC0y/z9yhuiwxGpz1jW9GLgqE0++3ZCdCU7UMn6iz8Fw4Btkm8W/2+RXnCF6V8gVVvcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rumyRgdY; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rumyRgdY"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f15e48f35bso16396931fa.0
        for <linux-serial@vger.kernel.org>; Wed, 07 Aug 2024 04:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723029453; x=1723634253; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yFZfnIIZNy81/zF1j/wi9hJhWAUXJzjhPkiUHNQ7Wfk=;
        b=rumyRgdYjOME48AbBSjp7yhh9YTqaS+oOlWbUGUmZRsrwkl4NeFsQG1+tyWsNOUoPL
         wx2EIw2a6AUnzh5/ioyJ2/AXgTbTAsIWmCXJFrZnVajNb1rRwh/hXAF5YEEN3tr1NGfL
         PouaFttjGaXs4/iN1msuhfFuda+XNIhhz+RsTGhveAL1fY7NRD//d/6c8AoezaaRQLeu
         3VFF8/3Q4qSIXwlNq2Q85Dr9Z0djQ011WIZxpFKPxwy9NA3QNy1FPLWpD/hlzcEcIj5H
         buHe6ttbRCgBNQY4DHgXZld51vszHI53akuZKKR+LUHeCNeHxoUb+rgN4Yx1lLdsCrNj
         56Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723029453; x=1723634253;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yFZfnIIZNy81/zF1j/wi9hJhWAUXJzjhPkiUHNQ7Wfk=;
        b=wf+5Pd5xemOMFBV5wtmKBTS21a/xPzUDJ/oxW6dFoqFMCen7kP3rgOGo5FeKVvl8d0
         iJqg0JaZ2OhQ0ZXR2B9CzSdbhdGDk0fFwKvmS1cFzTlQbGoUMxXWhWw2y6a4N063RftC
         H2rdCX/H2YTKZR9THazoB3HRmL4fRWfa5N52yniDF4uby5qj+tj06l6kcqCjz0scow62
         G48YLvxAMfVw0m66VXHivV3UgJ6R4vGZAwG42QKRFds3z8RFIjzGyEkRNIE77M7OTrIH
         XZI5l53JRvxM51NuQlR+uauY96z/Jgm73kBoDTIaY8Eh9J2WHzSUDHuJvLpVuNLIosV0
         G4ng==
X-Forwarded-Encrypted: i=1; AJvYcCUJqritTM8zNhDPdxt+Qf6B4v5ZNICR177zVqcxBxzCyAgX8rJ991l12+XC7D7P+7RCAqmjjVZgoTdebkHbbFdNRoPeuCPv2JmfVGTt
X-Gm-Message-State: AOJu0YzObvrU8Wz/Cw9ViKoqrDgr0JnQ+DJDd/dhV19/0eRIrnjQ2XiM
	DehVlJWImyP/8GMMelElxMnzOE/MG8s/2RH5uErXJGZSGxbkett1ZyKYuN8+0u4=
X-Google-Smtp-Source: AGHT+IFfokbTfiz3cEaEz9zIyLPTh26PV7jtIRgBmVbuOcTQFlwYQExnV7O+buVk4alISzfzQORRdw==
X-Received: by 2002:a2e:8609:0:b0:2ef:2c4b:b799 with SMTP id 38308e7fff4ca-2f15aabccc8mr130526341fa.28.1723029453010;
        Wed, 07 Aug 2024 04:17:33 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42905802023sm24343105e9.37.2024.08.07.04.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 04:17:32 -0700 (PDT)
Message-ID: <71e73974d0c3ce99e46ed85a42742a8d46e53c73.camel@linaro.org>
Subject: Re: [PATCH 0/2] tty: serial: samsung_tty: simple cleanups
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>,  Jiri Slaby <jirislaby@kernel.org>, Peter
 Griffin <peter.griffin@linaro.org>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org
Date: Wed, 07 Aug 2024 12:17:31 +0100
In-Reply-To: <2024080714-spongy-wannabe-7a9e@gregkh>
References: <20240806-samsung-tty-cleanup-v1-0-a68d3abf31fe@linaro.org>
	 <2024080714-spongy-wannabe-7a9e@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-07 at 13:09 +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 06, 2024 at 04:29:44PM +0100, Andr=C3=A9 Draszik wrote:
> > While looking through the samsung tty driver, I've spotted a few things=
 that
> > can be simplified by removing unused function arguments and by avoiding=
 some
> > duplicated variables and casting.
> >=20
> > There are no functional changes here.
> >=20
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > ---
> > Andr=C3=A9 Draszik (2):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tty: serial: samsung_tty: drop unused ar=
gument to irq handlers
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tty: serial: samsung_tty: cast the inter=
rupt's void *id just once
>=20
> This series blows up the build for me, are you sure you tested it?
>=20
> drivers/tty/serial/samsung_tty.c: In function =E2=80=98s3c64xx_serial_han=
dle_irq=E2=80=99:
> drivers/tty/serial/samsung_tty.c:948:45: error: passing argument 1 of =E2=
=80=98s3c24xx_serial_rx_irq=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer
> target type [-Werror=3Ddiscarded-qualifiers]
> =C2=A0 948 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D s3c24xx_serial_rx_irq(ourport)=
;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ^~~~~~~
> drivers/tty/serial/samsung_tty.c:856:68: note: expected =E2=80=98struct s=
3c24xx_uart_port *=E2=80=99 but argument is of type =E2=80=98const struct
> s3c24xx_uart_port *=E2=80=99
>=20
> And so on...

Odd, I did test this, yes. Not sure why I don't get these, let me check.

Cheers,
Andre'

