Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57872C0303
	for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 19:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764530763; cv=none; b=p77UWS5OsSpw8SnnqYtl379GdsiX222xJSpgyOPZVmFvC4KZ42OjE2+20JvxdLA56cqY+LeAp6dUdTSW+9NYN/oKXL57zZyhDQdqo5WXST44ArSnEIFQRocFyiPxryFSdT5/wzjiIA6tREs7Mts8F/Qk9rog3yUS9N/y+XOVBAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764530763; c=relaxed/simple;
	bh=c+zOimuitl/67UI+nDkFprrYZ8WRNq7PHwAWktqqd5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbNVwcSlMkOFemuJk3rS2MqodIGxAcl3NHfG0JBonEoBm6nn8yKsZt51X2U7ljrKEXFz94cVU/Nj6H4IASr/uaPa/9E8q0SIJgBIQjEgaQralAwTe+c3wiRX+4JrcGkBDSINVfbrGo223N5v7IvE++WxOpzA28zb1fdnU5UaYDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJEYUYfd; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJEYUYfd"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b728a43e410so596248566b.1
        for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 11:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764530760; x=1765135560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3d7dbfFKw+GEwHSmAT14cmDoNzH19gX5uvXVu5ZZfE=;
        b=bJEYUYfdeaD5K2HqxqUapBrFHmhegoUBGvkkh4QGAVzS9v/eAkK7W7znNETr2Q4nbH
         fskDg1mecGuYdI1tAAk1DGRDgBEPrvY9snBIh4jQSyJgrXdNiwZvSRHZ+F96p00RaLhu
         BSWU2dYR7O6PW5U7Y9EikO5cXh6Pu9EqMYXu4r9KzA0zP1xwGrYPeqLt0w3pwW6YewGb
         wtaNmzPG4XwSDINOnWKdYgODSs49C529EyXT5G8JdqEKjeZZ0m7TFFHK8QnIwHeqkl4s
         kDGQ4kXX2vVW8W4reXaejB4yJejaMIwiGSIBlywtCoF+qDI0aUek1hJ9rDF1Rua0vkng
         +TIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764530760; x=1765135560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M3d7dbfFKw+GEwHSmAT14cmDoNzH19gX5uvXVu5ZZfE=;
        b=ij7kS7fcjQmyUeNM1eq6aqt5Isp03kdVnBuwMie+uuNb2jUcsEOBUjNxCcMCjQ8iH5
         C3V2AVp0xZntK1QHU+C1fUp1xrflAyF6yO5/3uzWpn7nptH47DKaPMgdCHamsUlTtPrK
         toDrU9f8q6lpaEZqKHyyOi017kNAEz2ZjPs4cYYl5WnE9X7+gDwguDcOgcmNS6VpZRx1
         9wT4qFg6LoDook99utGTJYqCg8yaqACRhNQOJcdLKqlmXNtfiuK7DO7+hQrQoy6UBqCp
         6uaiR+hUn1isfIE4WzdkcDSHlbfQSL7NkPzChwe5lxjKlBlvcayARbLlPRYFwaJKTmQz
         Md4A==
X-Forwarded-Encrypted: i=1; AJvYcCUoM3crT8C4ds+egr9xSsTD4nMDRj18vg36jkP3SnZGxq8QRRO+qGjSqABYYn2RbPK918pPK1yJJfBKU9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YygonI8bg7ZsScTUShDear7/EZD/UedTSk7OOHR1y/VO488iZ1L
	AZ4M7hKVgPEOHjmiAllQt1N6MSgLbgDd+dAJnNGN6XM3xuF52MSg30F1oHhESlD+AsYdw0V8ZIv
	crkBNQC0tfUarOkKmLxpApZINxPKd0To=
X-Gm-Gg: ASbGncuoEJCbAocQXNXlUs4Th+XbIO3pJifZP/tFFPjNyXGX3Wes7W+Gq37kMjoM9dt
	PBXaLTXqBpHlLT0OnKuWVeauzFY7Tz5FOpRJnYOL2x3OjA50vorvAJCl7XRNG4sasp3vG1t1MRh
	8aEXNoBcldFEs5XiTafyKs2m+Vuacy3qDsA/+PsJOR72aokrfZCk4qZ4QQDWOocfj8BPOicel5O
	pc/q6bd36nsXA2opQGFuFZcOkGaH1Fok6RiaBUUGqKVKMbHMSMDlvfi1rXIERRnnzOK3VoSJjDC
	iLx/gI+iyl8gatndD9pjASG9/9FWkmDVwyISNYxBrjfMRIh+zZ/nqOGUO32i6H2qnckKuwpnmTp
	aw5GMJGY=
X-Google-Smtp-Source: AGHT+IEAfnPpOdP3szsXsieq37h91KnUg7nXKyocxM6pCQLLCAn5ASF72wWS+ZHVZDBemdwDFoDVfw7QVmk/wTmSh/I=
X-Received: by 2002:a17:907:7b85:b0:b76:c498:d40f with SMTP id
 a640c23a62f3a-b76c498eb61mr2084268066b.4.1764530760194; Sun, 30 Nov 2025
 11:26:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com> <20251130104222.63077-12-crescentcy.hsieh@moxa.com>
In-Reply-To: <20251130104222.63077-12-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 30 Nov 2025 21:25:24 +0200
X-Gm-Features: AWmQ_bnA6w-wUbfVXbm36sarq_BJNhXOnBfHMBPL2wRoOBUC8sjwZidOj2skcuo
Message-ID: <CAHp75VfbpnMWqRUZTw+UzxrnnfWsHn2dgqVpz2WDQo5PW-sgEQ@mail.gmail.com>
Subject: Re: [PATCH v1 11/31] serial: 8250_mxpcie: enable enhanced mode and
 custom FIFO trigger levels
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 12:44=E2=80=AFPM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> Add support for enabling enhanced mode and configuring custom FIFO
> trigger levels on Moxa PCIe serial boards.
>
> Enhanced mode is activated via EFR[4] and SFR[5], which is required to
> access special function registers used for advanced features. Once
> enhanced mode is enabled, custom TX/RX FIFO trigger levels and flow
> control thresholds are configured through specific registers.

...

> +static int mxpcie8250_startup(struct uart_port *port)
> +{
> +       struct uart_8250_port *up =3D up_to_u8250p(port);
> +       int i, ret;

Should "i" be signed?

> +       ret =3D serial8250_do_startup(port);

Same Q here: Why do we continue if we know it failed already?

> +       for (i =3D 0; i < 5; ++i)
> +               serial_out(up, UART_FCR, UART_FCR_CLEAR_RCVR | UART_FCR_C=
LEAR_XMIT);
> +
> +       serial_out(up, MOXA_PUART_EFR, MOXA_PUART_EFR_ENHANCED);
> +       serial_out(up, MOXA_PUART_SFR, MOXA_PUART_SFR_950);
> +
> +       serial_out(up, MOXA_PUART_TTL, 0);
> +       serial_out(up, MOXA_PUART_RTL, 96);
> +       serial_out(up, MOXA_PUART_FCL, 16);
> +       serial_out(up, MOXA_PUART_FCH, 110);
> +
> +       return ret;
> +}

--=20
With Best Regards,
Andy Shevchenko
