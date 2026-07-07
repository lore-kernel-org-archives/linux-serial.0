Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F35638F22D
	for <linux-serial@vger.kernel.org>; Tue,  7 Jul 2026 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415376; cv=none; b=rMwQJplFGb8zwrd3ifQG1XbkU10M4TpWMTuKJJC+ZqMtfeBtCv5z5+hmHkCl+uIdZn5ziFwWRUAlPIqDpC+KUqIeftNXQtGNBlobYTJM5wPQR5WxuTqDPTNHWf0coCrtKs8HPvBxKuHOhSP6L/9TgEy08In2u/G7SHlN0iWmkrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415376; c=relaxed/simple;
	bh=ti3PkygQPFObvTVX4tkb/opN8zcVPqcHK3opGZzoU/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLBLFjdshHoF2gj6BgPHczZ+ndeOTNhhKj9+52FziMTkQkLaFUCosUkBjwg56rWoYwaHUTRLxmZOGxzwXhWS1FgG8Gx8HzFore1TP1uIay8JHjh+Eicds1fKMk/XXCPpnM4dkWI1FfxDVkFYHh77HXiXRXUvT1pL6JXCSgRy4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=RLdqtt/s; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="RLdqtt/s"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493c19bad03so36580625e9.2
        for <linux-serial@vger.kernel.org>; Tue, 07 Jul 2026 02:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783415373; x=1784020173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ti3PkygQPFObvTVX4tkb/opN8zcVPqcHK3opGZzoU/Y=;
        b=RLdqtt/sn+/soq0LRR5QE2QLW01RMeemYfdAG42sw6J42oqKSNKPDKQFz9PNop7kJO
         taZf+L0V0Ln+hkiwBCzRg3JjfJJoAvGbHA5BpS3VnWZtlqejmuqDWj2m5lfz/kslVW1N
         v2bWlUh4gStS0VuIazDnatr1n0twSvHVc5Ep3WA5KWOOlaZ3L95IBHJMYNFkaaWnfluF
         +UbsVONbvSmXXn2hkY5nS3qA0NwqjB29dlRyPOVHiIEOmPv+Y1LkTUDnisvqjRmat+Uf
         /LJz3Tzr9sMaHw3BJFFxRiv7GZZQEYrWig/M1as737aSHZSdqDRaoePJrQgdvZePMMYT
         6tBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783415373; x=1784020173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ti3PkygQPFObvTVX4tkb/opN8zcVPqcHK3opGZzoU/Y=;
        b=b5eANXB6BtR1CTg8WOfaAawGlsYFjFOeTpNQ8s8DzkVz5CX3YPL29LJ13M2XD5w8qX
         EV1ePaTZ5TNHCkd3ycApFQTGOukcNbrsT9ew8XiY1sV4s/qkldhd+LXouM5Bm+SBVJpG
         rVn1YsnUmBvD59n5Jcw6r1hVDXxwoWb7zud1Oy/P3mlD7DaM0M30yjVbUyUjnXcoRapa
         y/jFwctLGJpyTZWb/63GoNwdtL6XMhcuHvjSiph0gReWujM71431FBF36gWXR7Q0Qb6u
         XOo3D+naQJJH9myx3JaFO74QdzhejIOlc+L5CGJuk+3lCH5ZvuCNoN+5y5Gn6Rnxq37x
         LorA==
X-Gm-Message-State: AOJu0YxzXqN+RSv8Pr+ej0tdkieLmAn9f3OJVo3Ykopr+2jowmNkCrGk
	KQjGGLh+Qcxdyhi3xmF1VF974rrFda+aXgGYV4/RjJFfuZAo83vSLVOHuRGCPjEjgfvKe840Gd/
	M8ICjUwU=
X-Gm-Gg: AfdE7cnWfvh0aA7LeR3jffC+9uhW7tIyeGrEyWuKN6PU27/azaZRODkjgXfvmU4UIGK
	yMvrnbz9taaNVhztWLui8/0sexxd9HsfbSuhVesMrFQErj8mmLd0ul1IeLYgbHOL6AzTcdLyiHE
	teKWbQXhd3GNLWy/J1NLd2eYLZJnpz5pEL+bciw9PaGk2UGWKUNinXecx6zliVz3f7sUyEsIQ0i
	c+jcbLVOD9IhnGtkyzrFg3b9vJKDVOSuoXFAckDaQyYVdE/rCdZmMXe3Km3wj762ZJt08AbLlpu
	iBuZAq192siJSp3aUFDpTsE41o1N3k0/yR9DLhl4ILGZ2PAWgeTYC5WKOb1dkpAXSnz8A7Vd5KA
	bljtvEDYm6aWRQthZPDl+dwlRP6T6JM5kPs6wzAJEx3KKvDVnLUNr6rNF9h5xLNcKt9xVmAa11F
	LxOBZjUj2hVW4Y8J7pvl2mr1psVO1MNSNnPkHI7f+WigqK10v4suR3dsiyn8OwFr5JJXLFNxl1L
	PYG
X-Received: by 2002:a05:600c:8b27:b0:492:3d05:5639 with SMTP id 5b1f17b1804b1-493df083892mr46010105e9.36.1783415372942;
        Tue, 07 Jul 2026 02:09:32 -0700 (PDT)
Received: from localhost (p200300f65f47db0437b4d928ee3eb6f8.dip0.t-ipconnect.de. [2003:f6:5f47:db04:37b4:d928:ee3e:b6f8])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493e0f32660sm40922565e9.2.2026.07.07.02.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:09:32 -0700 (PDT)
Date: Tue, 7 Jul 2026 11:09:30 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Kevin Cernekee <cernekee@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] tty: serial: rp2: Use named initializer for
 pci_device_id::driver_data
Message-ID: <akzB9zul5o1OMnsm@monoceros>
References: <20260524131905.871222-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4o53tl4ehar5swrm"
Content-Disposition: inline
In-Reply-To: <20260524131905.871222-2-u.kleine-koenig@baylibre.com>


--4o53tl4ehar5swrm
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] tty: serial: rp2: Use named initializer for
 pci_device_id::driver_data
MIME-Version: 1.0

Hello,

On Sun, May 24, 2026 at 03:19:05PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> The .driver_data member of the struct pci_device_id array were
> initialized by list expressions relying on hidden assignment of .class
> and .class_mask in PCI_VDEVICE().
>=20
> Make the initialization more robust by using a named initializer. This
> robustness is relevant for a planned change to struct pci_device_id that
> replaces .driver_data by an anonymous union.
>=20
> This change doesn't introduce changes to the compiled pci_device_id
> array. Tested on x86 and arm64.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>

This patch was sent before the merge window leading to v7.2-rc1 and got
no feedback and isn't in next. So I wonder if it's still on someone's
radar?!

Best regards
Uwe

--4o53tl4ehar5swrm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpMwkgACgkQj4D7WH0S
/k4tvQf5AVGvqK42afQsU2RlWYxJobKiC1U0wkDxrq4hBuSXpPWkv+Bfa9j29AxM
Em6AX+koL+7fBD9ZK2czgxijFul80b3xBP1577DC9NfPki+v36hlQ61VmuLw2fJq
GLZKbTcQSvtA3dE+LrQ8/rkbRV+T+QBgbsrHI0ZOyXVA0VsY145urpLM5oGd7FgG
Y9Xi4p95tsGv9XERxcWtOYZpwwsCAWFg9RmleFjB+aqXqmqtYnwiZzQH7YP791MP
zte/g0ggpi3jQuqLpa5dApZ3DwwIEM5hj9V+PGEzd6UofTGvEhG89HpT81OG0HVx
bIBIaCmZW8ZbYhGp6B3N/QNhIXi31A==
=9WcL
-----END PGP SIGNATURE-----

--4o53tl4ehar5swrm--
