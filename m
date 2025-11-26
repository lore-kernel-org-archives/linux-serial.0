Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62D119F12A
	for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2025 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764175537; cv=none; b=IW93OcJYL5zDQFwWiGEVNxcg2G6h5Arh4kz8CreSIF+zArHD1Jbv+PJmWobIYWEJakFDmKyKtcmR0CF8iEEMT6hoBSEm8eRN7RnWIB5ax/pPDbI4dSoDzjqbE4bpelqn6qztlEUEP5NfyYRUB1RM5qszsDoYfgQD2Dpoid0mIF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764175537; c=relaxed/simple;
	bh=7RIu1nc50sp6FS9SWrgebaUK4OCK/lP6YomrwcxsIAI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ERf1CBQRPjnP0fZ1wAmTbr04/iabsPFMRBnh+8BYY4U5d9Q9jUpjSl8GkjpKuX6Uz6a2LjhkFQ+T34QSoQ/n2HZgzz6AtqhocLA/wCloF65BnKrX053v3oJdsPWyPkukS1vssU7k57OwsjlMcAvEHmuco0djthedcHMj3UHQVEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=v3+kIcvM; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v3+kIcvM"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6406f3dcc66so49839a12.3
        for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2025 08:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764175533; x=1764780333; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7RIu1nc50sp6FS9SWrgebaUK4OCK/lP6YomrwcxsIAI=;
        b=v3+kIcvMrKharG34DWthN/tQNk9HDB2WxdypRTHUB/tN6G0CEKKlgWZM+aaqHaV2Zm
         /oK47rUoAARrSI/O2S5St9uxKkGY8h7/hQ7TNLpF16AvxAKurrNT6G26dUR9zQVMJ20O
         eu7uYqmgQn3CpVUZqjZvXvki42pekUTIul3ypHPvUZFkJeuNe8mChHlZMyil7PFheT0k
         6xqeI+sAiyfIOjpAviadHB4mzu4I7fa6xxzD6eYeVXHzqhcX44KNDwzvU2SVsfrVneu8
         Lev2BKkxG9qVH/Dmlnrw1vbjwQ1LD8C7wDS33FZ8Ai4Jug4Cf9Rtv8iWOssfIRPF64ls
         bZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764175533; x=1764780333;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RIu1nc50sp6FS9SWrgebaUK4OCK/lP6YomrwcxsIAI=;
        b=mfAVtOX4HEctyVloc8GS4aZZ6f5GXWOMoL8ymqpf5N19WvICsFI8OjavSy2jwKoZjZ
         6MOReytdw9oD1NXS41cZaPHcvRNslbo910S5BmwBLWy35ruM0xU0MYaODvWXbNW0evMP
         Z+jZL5MNkpkEaxXfV1N7fEaaXP4QLbSLL/YUcz5A8rS0PqmKhv8sp0YMHLaaMNd+Ngq2
         I05NQ/K/FBZFJ8Efs6JsjhHfK8BsdRBQNGmqtDx8MI3Qws6Jl6oaPENMfx/2nOan7GIh
         0MUwPZxzOHY6rJ1WPOM/mggbK1Nn21ghOD7/vJy4MukrugIqP2KeJqarokLNIPUrWfcW
         1Nzg==
X-Forwarded-Encrypted: i=1; AJvYcCWYB89io2hT0vFllorDTpOg+aleUnBLfJYvoEjv8LnIWbBeRIPHhU9CbqwA40RIXomn4ZqrRrSHk/WUyGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjEijhfHjrq6WqXPN9l4m5ULeeYG04tc7BXNoJiCLFbilQJWRb
	r/eg3z9ha1SyyZjI5OzyJqrFy0nKetZyIznYl4AJT0fNBwZ7LKg/0sJhGoYYw6WcHPY=
X-Gm-Gg: ASbGnctPbQQQOFYCkVJlI/6gxEaZMSpOJVIfJ3KtFZ5EA3AXNf0keoartK30+yIyaG8
	+Exybsn4CV8nnX51f4PZVAqsqGViqS1emm57AoRQvLMuTl33kH9TyfxevlJ01A+GqePXDeofEnf
	MiLZGcDICJJjGfbK+j9jrop8AARl7SmY5F24CmOjYX6m9yuv02H0nx0gPhpdtGERyfNJNRiWgrW
	1HoM61fujp4i8UuUpwG687pcEkSQ+9kvYdAAHtNqTcUS9PCHWrGLznl7zia5fxXcNhWF0R9BLTN
	ZuwjALMw5ZR67YwxmqfnAT/lc6KSE8DXgsQa2biIhBCtycd4wyPwSRKsQmjMEk2jkVo3x3r5jtj
	vyHtGwWTxSZ15VY9ig/NqKoJPjpz1Ga3FAYh6Tcl3Lek6E4P4DUAy6fMb6hCH7T2+KUloQS3ZyJ
	ZDPzIXV1lewOqtEFE=
X-Google-Smtp-Source: AGHT+IE7RxX6VIDHvNmXEM8iK9TJfsYHSeTRkOJXFlfqixz6tFZUOmLdWgmdqhBxPjPo6XbkEmqRhA==
X-Received: by 2002:a05:6402:274f:b0:645:cd64:31c5 with SMTP id 4fb4d7f45d1cf-645cd6431f3mr9566658a12.26.1764175533073;
        Wed, 26 Nov 2025 08:45:33 -0800 (PST)
Received: from [10.203.83.104] ([151.35.181.229])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453642d267sm17950587a12.22.2025.11.26.08.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 08:45:32 -0800 (PST)
Message-ID: <97d8026590edd4911eb03d775b10f14ecc60ba6e.camel@baylibre.com>
Subject: Re: [PATCH] serial: tegra: remove Kconfig dependency on APB DMA
 controller
From: Francesco Lavra <flavra@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Kartik Rajput <kkartik@nvidia.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>,  Robert Marko
 <robert.marko@sartura.hr>, Thierry Bultel
 <thierry.bultel.yh@bp.renesas.com>, Douglas Anderson
 <dianders@chromium.org>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org
Date: Wed, 26 Nov 2025 17:45:25 +0100
In-Reply-To: <aScp6mooEKUkBkA6@smile.fi.intel.com>
References: <20251126090759.4042709-1-flavra@baylibre.com>
	 <aSbikmpzkADKkna6@smile.fi.intel.com>
	 <562c2b30820d083ff0b5e04ac176ed66c0064363.camel@baylibre.com>
	 <aScp6mooEKUkBkA6@smile.fi.intel.com>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-EKhWMttrzvdjrYMHMS/T"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-EKhWMttrzvdjrYMHMS/T
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-11-26 at 18:25 +0200, Andy Shevchenko wrote:
> On Wed, Nov 26, 2025 at 01:08:23PM +0100, Francesco Lavra wrote:
> > On Wed, 2025-11-26 at 13:20 +0200, Andy Shevchenko wrote:
> > > On Wed, Nov 26, 2025 at 10:07:59AM +0100, Francesco Lavra wrote:
>=20
> ...
>=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Support for =
the on-chip UARTs on the NVIDIA Tegra series
> > > > SOCs
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 providing /d=
ev/ttyTHS0, 1, 2, 3 and 4 (note, some
> > > > machines
> > > > may not
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 provide all =
of these ports, depending on how the serial
> > > > port
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 are enabled). Thi=
s driver uses the APB DMA to achieve
> > > > higher
> > > > baudrate
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and better perfor=
mance.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 are enabled).
> > >=20
> > > I think this removes a good piece of information. Perhaps rephrase?
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This driver ma=
y use the APB DMA when available to achieve
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 higher baudrat=
e and better performance.
> >=20
> > I think this sentence would make it sound like the driver performs
> > better
> > if the APB DMA controller is available, but in reality the driver just
> > uses
> > the generic DMA API like most serial drivers, and there is nothing APB-
> > specific in it. If another DMA controller (e.g. GPC on Tegra234) is
> > available instead of the APB one, the serial peripheral will be just as
> > fast.
>=20
> OK. But this is not the case for Tegra234? Or is it and it uses DMA for
> UART?

Yes, that is the case, Tegra234 has just a different DMA controller
(TEGRA186_GPC_DMA), which is used by the UART driver as long as the
relevant device tree node properties are in place.

--=-EKhWMttrzvdjrYMHMS/T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmknLqUACgkQ7fE7c86U
Nl8Xgwv/QpYpkRG+HQ/Gpx+YaFVbMHzzufhGg9iGhGsQMNjKUORsUJSpogB8gp7H
geennZAn9E02VtI5uXq+VxVbJmkaQhKvOYEjy7VmR9UPS9Ka9i6npGp/b6ISvFs+
PU7T5GNKq2g9Tse+qv1E50pdrDEiExmWy0EW1MpO9up5E5Fl0mu25Uhmweu6HfiD
o8lHHkrQEfU5qbExsxKHz3gWPN66rTl7lBtN4M60VslEbrLW3LSFX/h+/t9qLUsO
CbGXyFyJfefK7fEA6c7K9SFO3qiXK9xKoh/hlzIiXaNJAawUaAEfyJ5jbeRMfHks
Nxk7JXBOMVFRO/qgEU4PafoRvS0NINb5U69lFp3BWkOT0ib4vv3s/VLHyT2vDbts
EG9VFYEupTpb9qmDqyiYLAR8kHwffiRL54mZ83pXaFCK/2sUPhX+ZPN4WRduHuSQ
+9uOLYZ1tXcvbWtnTa4krZoq2PjFugGqZpR7NhELwtbKVb/zZOgdVU0WUoQE8/2K
ZiV5IUTu
=L3lp
-----END PGP SIGNATURE-----

--=-EKhWMttrzvdjrYMHMS/T--
