Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406603203B2
	for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2025 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764158915; cv=none; b=P/dS3cIca705LSXpPL0coFprZ2QZ3A0Sp1dfYPTcFdtVEea+WhQgFMrh8kfh62lQIM6oP5/IEgIXRAhnPbDqn5rP7u+YndUIW6le01vqyAoMsF8QKkR0S2dt+XGupOaadbSfzTvbEH9VRy/3iUOA+JIYmjLlQERH1bNt6001tuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764158915; c=relaxed/simple;
	bh=HxBlTFtX3t5Y8Fo0pCDBzEZqvphLiaUur9PtPCzTW14=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GCt5ca2CaDa4SVXgu/0nRM85SNVcYSjPEdhDtEjwCZ4Fm3NTksH8+533tmoYCDnRxq0g14hYqtUOrUSaOsDAexFDlMhsziCm0Uz4O1loz4wZo3m6/TDPzOxwH+8BtNMxA+egKKzjb2po7fA0vShP3yA1cnC8CnQfsGkfWogoe0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SWCvwvvV; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SWCvwvvV"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7277324054so984799366b.0
        for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2025 04:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764158910; x=1764763710; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxBlTFtX3t5Y8Fo0pCDBzEZqvphLiaUur9PtPCzTW14=;
        b=SWCvwvvVjPemqvtM7EFMyf5vXZT6t6oSzOFQp9tpMqDpH74IKFgMiR7UoBwkyEUis+
         kpNLxTn5EkWWYTelbV7B8K0WO6OHRcBTvH36tziiIDS/i+bCuWBA/sxZLfZ8K0Hv0dKx
         JRk9ygU+2dtP81q+2dGxAtlJq7ljC6P6lBV7kjPP1ndrXsoDWdgXghCAltC24rtk6Tv3
         agwrqYyMF65rHRfdNW2Lq+yD5H+5tHvMXPPYRLxIy441lUDpm3FBlA5fETAeSCcZ6svI
         sf+by/QJiCYrPQHdViAm58kTOG4Ro7/pGo78DmbA/H/U8Bxww7gR0XqXjmzSMDoPqLHe
         in9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764158910; x=1764763710;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxBlTFtX3t5Y8Fo0pCDBzEZqvphLiaUur9PtPCzTW14=;
        b=dhsTE+kTUkfMVtneGQom7HrujkMwqo0fGH1Dz6YnpHm7emNPVueNT+sjW9o44ORqte
         rGw53Cn0SLo3Yc/L8E+k8UeuamkzYrmZW8s0uKaCttjxo8cU2zW/66cjkW8eCVV6Qx0j
         Gr5DAQw1uwMblvexFjVb0XjgWg81ve6J6YZyijI+fkV9Mry3H3Bb8/gbzDh0NcZ/T3lm
         5KF4T6BTU+ioYUy73ju6sjO0+6abcNY0Ck6ia4Yg71Dh/Qy1gGA1m6Ep/7qQRztPfsAh
         5RQ/raq5IG+siE5JAUMsgJBP0VTtDnjELqFo/VUrj80IzsV/AhJF3PeEokVdTh45/7DO
         n0Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVHCVa7Ij/DQ/ZapoVYXkpVwuCjhQ9gLleK+EcrOl3ljK9A6wzQi68C1ubniCzkDXTfb74ftLmzp37JFe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzTa3u0K/8ztTNRLpJMVlxoQMPOg00otUBylsE3n/L9WltrILF
	jh4uFk/oA3HT5fsFwxZjigq8BzUk2+XT4uUA8jmTBXdcQdfPspWEwD2VNBPqfKpexYcp8URJFEz
	U1hLG2Ss=
X-Gm-Gg: ASbGnctnF1e+DurjhgrhLs0zUPx3xwgsdNp6zdAMbHYf9sO+KWPcSRwm6CTHSUGg4oh
	eLeVKhAvrnbkEC1isynrTcnNSMA1giA7Egb/mqoMTUHagtVnLp88JRB7g+Z1yRwHrqAc0Cd0vJE
	5ul0eXXXDOq7MrGfwe5kCnOa4IbLJ45ixu8tOGeILVAQ9dBHiegeZYHwLtwNq+LFu8Jz4TkUFGH
	Mx/XavZgmyra2k8LOaKp6qgn9238L+s6shfTsWhzXixbqPsCoI9oQWB/sPRjW6tZt85TfEYQi1p
	2YOpNzzmnTZ/JtfgAt3N3XAk/qD3lrutTW4gVJoY6/IVEqy8J2KceGMa1Zy53eL/hj4GaJtwJG1
	9hR3Ubc+dSYeGRLv/st4wS7A+yPg2B7kfiwhHYTCZaqc+o8x1WoYeNDyepmFISrnpd5+7kjE=
X-Google-Smtp-Source: AGHT+IEm+YINzry14cJz5VGuvq9qLkRBXoasqRXSz4870FK8vILR99qaEGTXydWuS/cun2Gi4zxEvw==
X-Received: by 2002:a17:907:7ea8:b0:b73:6987:e902 with SMTP id a640c23a62f3a-b7671852ae9mr2123702366b.48.1764158910222;
        Wed, 26 Nov 2025 04:08:30 -0800 (PST)
Received: from [10.203.83.127] ([151.35.193.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76b4d2db23sm711326766b.66.2025.11.26.04.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 04:08:29 -0800 (PST)
Message-ID: <562c2b30820d083ff0b5e04ac176ed66c0064363.camel@baylibre.com>
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
Date: Wed, 26 Nov 2025 13:08:23 +0100
In-Reply-To: <aSbikmpzkADKkna6@smile.fi.intel.com>
References: <20251126090759.4042709-1-flavra@baylibre.com>
	 <aSbikmpzkADKkna6@smile.fi.intel.com>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-4UsuA/CWlgnfn7hIJ4In"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-4UsuA/CWlgnfn7hIJ4In
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-11-26 at 13:20 +0200, Andy Shevchenko wrote:
> On Wed, Nov 26, 2025 at 10:07:59AM +0100, Francesco Lavra wrote:
> > This driver runs also on SoCs without a Tegra20 APB DMA controller
> > (e.g.
> > Tegra234).
> > Remove the Kconfig dependency on TEGRA20_APB_DMA, and remove reference
> > to
> > the APB DMA controller from the Kconfig help text.
>=20
> ...
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Support for the =
on-chip UARTs on the NVIDIA Tegra series SOCs
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 providing /dev/t=
tyTHS0, 1, 2, 3 and 4 (note, some machines
> > may not
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 provide all of t=
hese ports, depending on how the serial port
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 are enabled). This dr=
iver uses the APB DMA to achieve higher
> > baudrate
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and better performanc=
e.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 are enabled).
>=20
> I think this removes a good piece of information. Perhaps rephrase?
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This driver may us=
e the APB DMA when available to achieve
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 higher baudrate an=
d better performance.

I think this sentence would make it sound like the driver performs better
if the APB DMA controller is available, but in reality the driver just uses
the generic DMA API like most serial drivers, and there is nothing APB-
specific in it. If another DMA controller (e.g. GPC on Tegra234) is
available instead of the APB one, the serial peripheral will be just as
fast.

--=-4UsuA/CWlgnfn7hIJ4In
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmkm7bcACgkQ7fE7c86U
Nl+z/gwAmiaXnYGPOKC8sRI8pyITLU0osYVW+668wjvfdv8+jjBhN5SYA2bqqVP7
LbVe24AjIPaeWQCIPlRvROxUWF3CkCVHN6j7izYtGDJkISFv1FxsH3jVZGLH620b
DWJzrgPAfxyk3ZIzV3caYHwwkwU447NRli+eu2MRQz0DJhesr4eG8RcsCARx7oJB
wxTvLAUAi2lLOzCIw2MBaAOR2UUmEWHSUEDBrHRh03p3yxicL6c73iWBFn3A+U08
xMdRxghYvk9k60JIVtsXlVX/KuOmhT7gyP5eObvNzhm0fJ9i0F8ldHxMyvy/TyMP
do/r9iMlcHFNkNFwdbVH6KRKouePuQ9HBgiKBQwMHRQWCPrcc5WSzvGrN286gjSK
jDiEV7feaPRuq1ve0f1B3vo3PHcDNhKHa8p/MAalKLn8M90RPd3jhQHUwN3p2eDZ
c5+KSDX6+izS25EZGXa/YT0ehRC6HGaRbXWilTNab5HvzHjG5tl1jN9tx/RqyyKD
U6U8CYkV
=7XrJ
-----END PGP SIGNATURE-----

--=-4UsuA/CWlgnfn7hIJ4In--
