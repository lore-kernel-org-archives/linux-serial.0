Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7801E4F07
	for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2024 12:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723032054; cv=none; b=KLd4NrzFnnLbvGhXdVW7vGarhhXju2nTyA5pRZltSSAOxowiFUFspVvPq8qhlUcRu3TEn/rGf7zqGZPQfsAe+oUxtES+QfH6+xYVnAUsWogLGi0/TKPwxzZnXt9AGOPfFS3xNpkBNkiVkOPTEOH4Fr6cXNal2mKNLglOjLUcXQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723032054; c=relaxed/simple;
	bh=t+m4L4rVNDRaiNoOKAJshkJEor7Cc94x42H9UtnK6zI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KhUMxQqHkfjZmspXU/14wTDzHzw0YGRuIdhJZBWUpHcxO9MSOiYciMzB0da59i8AJE3xPCRWV4ayFCesbQFbpoASfR9tBdVyjbzj7eEeTazmFLZprkwRAxTtS/atN4rndILdAe6ilGRyWX+zHLiVXJL08SldwK4qB/OnVghWcpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cSa0MZIi; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cSa0MZIi"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-367940c57ddso937085f8f.3
        for <linux-serial@vger.kernel.org>; Wed, 07 Aug 2024 05:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723032051; x=1723636851; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t+m4L4rVNDRaiNoOKAJshkJEor7Cc94x42H9UtnK6zI=;
        b=cSa0MZIi3POOO5hO8261TLG9xx23tQfQU5qEsGrMf2K9snnvFVRlDYDgeRv+e+15nF
         RfiVSbQnDLduDvXPYhNFFEgeCRYbe2iZY9IpBeutHNUezRGVL816A5DQdjdryp0Gg+vO
         yfZzL+maBenOODv8xiHs58BmB4HTm/RSSAXaW6Tkm0qxsJSNsJ+St07JaZnutS2k/61o
         qZp8K2GF5G2Gz9MtyTOaW2GEpxZXS18ma0BvdGE2e+nzt3U3B/iZ+ZERGn4CNYL3Wya8
         0uoA7tLp+mC+BrzMQ0Hb2ByflL3AMfUO0um+9lxR8tSpYhT6pJWHP8+8K3OhYSxZmgbm
         bXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723032051; x=1723636851;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t+m4L4rVNDRaiNoOKAJshkJEor7Cc94x42H9UtnK6zI=;
        b=XdFFwKmqrvkYUYlOh6o+NulPd6vAiBh6GwrMrNwhcRo3z6OhuWJ2By07PCACycBac3
         lYoYQycBvxWtZA4xci1XnkFO15xJhwcf84sfH4W6oMeUvY0wBbAo10ustOGYa7iKjZHB
         e32bZcyBPYhXD9n7Umzh7HtwAEM9/yk3T/djtyUuzxU+wU1fvSNC6Vr8dxzlCTQJLiw1
         MKtby748ogMYu1NaZcLStWSHbcvX7KX+n5Bik0w2R11VXPfHGXSFZHjYAZuuPREVxaRe
         4fQAE+kA2qhZOVHn7O+q+2pNipc95VxfBEp8yae0z+HIyM5Kx6hqIm7MgqWat2BOUqFx
         mrWg==
X-Forwarded-Encrypted: i=1; AJvYcCUEPRRFZtUrwyZahBIjZAaFChUSAYPXqUWmP4MsZG+lfSEcj2psrbz6EWdTAi+KHvXGIVh+cUeTCx8tMjVw3ATX3GxMGrGHJUCdTe34
X-Gm-Message-State: AOJu0YykfjuJ91AmnOTagdKKnQrziuc1hnTqyvvYtJ1JsUsDAh9Uh0ak
	CunbQTSNTmOb/YEV7zn4M0Np41hYHCztZCdTyTSduSPTATK3+YJ/+sQhyn3cMwU=
X-Google-Smtp-Source: AGHT+IGP3ie6uD/IRt+v4SdYtY4WBVVJPrpstbAIwmBQE/Jj3Po/WnUvP3DmFF/Q/DasBR2DbL6nTA==
X-Received: by 2002:adf:e40c:0:b0:367:8a2b:7354 with SMTP id ffacd0b85a97d-36bbc0c6c03mr14069509f8f.11.1723032051251;
        Wed, 07 Aug 2024 05:00:51 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf0dcefsm16111567f8f.11.2024.08.07.05.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 05:00:50 -0700 (PDT)
Message-ID: <5e73f1b405e06f9ee796d3b7002933f75613728a.camel@linaro.org>
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
Date: Wed, 07 Aug 2024 13:00:49 +0100
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

Looks like I had Werror disabled and therefore just missed them. Sorry for =
that.

Cheers,
Andre'

