Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D608B38F93B
	for <linux-serial@vger.kernel.org>; Tue,  7 Jul 2026 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415174; cv=none; b=Daj+eLxjVjVnIVt1igHfDFWAbqrlH8PMFBSD6GNdcH/wLcz1wE8Xc5MynHqjb2EW9gCLpHULtYG7rf9oeANd+sQ3kv9eLXT/2uj6mgCdHOj09RuBQWR5Efl0vYN+DiiCCE63VSX6UbuIcTOOx7XErvxRUylUzkR5Ua7Yb0f2xK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415174; c=relaxed/simple;
	bh=6eVSlguEwDWqI5eaBlFkb9sGynTF0H4vMBx0KAHeAGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TG0/YnjpeI+js41W2kMXRWeDonY/T057mnw6pR+5hfZCsxKSicKNfyL2qbY1GFQVfJhF7E8XnjACK9Kbl1TmwnofOHjWu0bdsORZkVS0rsNrLlSe2Cz4c90CnlRRHgq00/NwYpICz2UeEVoEpcn447NSbC3iPkGOf+GTds2lCD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=hcIZ7j8A; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="hcIZ7j8A"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493b779003fso19639055e9.3
        for <linux-serial@vger.kernel.org>; Tue, 07 Jul 2026 02:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783415170; x=1784019970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6eVSlguEwDWqI5eaBlFkb9sGynTF0H4vMBx0KAHeAGc=;
        b=hcIZ7j8AC0kIj5GL4WkpTiLIxn0yzKoebCEDQubIEzu3UZRiAka+/smk8SBLSdryVg
         93PRbPEVl97dqGv3qwmb8CYyZ2bx2M7oFDCvC0dtl6k2nIH7maKK4MTkbQkZjrKeXlzM
         /3lEoLcI3A82sGd7l5LL8zI4mEbo4hvTWt68IPzqNyYey2Kj2bkwy9xYxNABHl9Imele
         8LsP1Fgdds4Jv/3bXh5eOTrS19yxXdW2t5o5NfoeLt+HDE7WU0rCQmz2S0oekh0BI4M1
         iIn2EU7d/uCEdNx1ergi6xYZv0NmQhxm0ONhawXVUVAgbzT5Tgl0VpCdJPkpd7rf2ZvZ
         uJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783415170; x=1784019970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6eVSlguEwDWqI5eaBlFkb9sGynTF0H4vMBx0KAHeAGc=;
        b=BEsarhyS/hG5dOjRroyyuQxGdIB33+u8VAhrZVnI/3dXlD4cqy9t5+5VOb0YBVvFMC
         kLpTv2jRAMV4RqryuUAt0hxcIlfPjCOukiExUhIFlItV+C0o7dJSv0ZHloQi5pKSoI3u
         2p7jkysMT1mplcQtaYe5JJOzYsToEUOh/Ke6bNDT9efHUPU6CnITXfx3nzFqvUcG9Skc
         YNMlF6fD29wvVWmGqq//HPSiKTaVKGsnXjiNqk6Yvo5Xy27w1UAmTXDkWNiH1DDUtdnD
         U9Du1+M7ROmn+wQeEP2Pkx/pfvoADZKs6QHhT/h6abY7R4q/MCUSGjpI5FcRxOZDqiTX
         1Hog==
X-Forwarded-Encrypted: i=1; AHgh+RqV5ChjpHTGmzPwjj0ve2flldmtOvT/5S0V/wzuQ35kRcXDYFOHuV79kUFmPOtvzvTO/9yTNs6VHP+Q28Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvco+m/jqRTA+QkYoCykSjHYAON3eosU7SSDNohkYN6OAzDqjm
	TVBvwXTovc6DEgQVVfxWft/HLu66oyL7mvEyk/FZf3Ob2jh6NYTfjAUKpnakXaKsQ24=
X-Gm-Gg: AfdE7ckDLA5yQVlsfiYvxb5QdK4WCNW+50QMKMwIvrRVEXzRKn5/5QNvvUWIPWnC4hA
	5qIK0GzAfT0Gu4NU/hPgVj+VH9Q3ER6eRVD14LbVjID15WPzn9vBCfcu1wa7keSyPZNyJsHEzwI
	w4peJd6IiZuLt733r4zwA3u3v2IRm8lohkqZp6qV+CHI5N5rn+2at2oWnWZLjTdWLj+AHWl0Tvb
	VqMiJVngVt8LUK20+JKwkUZbnqdr9LSyOjkVFzuewn7Th7MyYeaONxzntRG2lXMCpNA9lB+JwIZ
	oZ69otxfgzO1Og4/gEzU2c7/nivxqeylKRx9sm1LKrmrO+W71MXZxs+nnhkWqpQGA6jJ+7gWDiO
	G7Utn2QJmV+MB7kAWrzoGNzUlNwWRxMdYFVxrTQNz4ryI8pwLDmNiaBlT4o7sNoGydSa/j44QJy
	93DCV1kQzj74SWP+SZlxcrF3sxTvg9LjsuN3eT+5JgVeZoaSN/2y0wr9aNnuLvM+77NzXd66uZC
	PNs
X-Received: by 2002:a05:600c:4e04:b0:493:c634:952 with SMTP id 5b1f17b1804b1-493df0379f7mr45919725e9.7.1783415170098;
        Tue, 07 Jul 2026 02:06:10 -0700 (PDT)
Received: from localhost (p200300f65f47db0437b4d928ee3eb6f8.dip0.t-ipconnect.de. [2003:f6:5f47:db04:37b4:d928:ee3e:b6f8])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47a9e4d8410sm32535168f8f.15.2026.07.07.02.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:06:08 -0700 (PDT)
Date: Tue, 7 Jul 2026 11:06:07 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>
Cc: Florian Eckert <fe@dev.tdt.de>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v1] serial: 8250_exar: Consistently define pci_device_ids
 using named initializers
Message-ID: <akzBAgCwNho3-jpr@monoceros>
References: <20260522140103.769262-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ya5muq7nyqwzkigj"
Content-Disposition: inline
In-Reply-To: <20260522140103.769262-2-u.kleine-koenig@baylibre.com>


--ya5muq7nyqwzkigj
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] serial: 8250_exar: Consistently define pci_device_ids
 using named initializers
MIME-Version: 1.0

Hello Greg,

On Fri, May 22, 2026 at 04:01:03PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> The .driver_data member of the struct pci_device_id array were
> initialized by list expressions. This isn't easily readable if you're
> not into PCI, still more given that it's hidden in macros. Using named
> initializers is more explicit and thus easier to parse for a human. And
> it's also more robust against changes to the struct definition.
>=20
> The mentioned robustness is relevant for a planned change to struct
> pci_device_id that replaces .driver_data by an anonymous union.
>=20
> Also drop a few explicit zeros that are not needed and improve
> indention.
>=20
> This change doesn't introduce changes to the compiled pci_device_id
> array. Tested on x86 and arm64.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>

Given this patch was sent around 7.1-rc5 and missed the merge window for
7.2-rc1, I wonder if you still have it on your radar?!

It still applies fine on top of next-20260706.

Best regards
Uwe

--ya5muq7nyqwzkigj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpMwX0ACgkQj4D7WH0S
/k4OXwf/XjZfOU1RX5rDi2FV3enSWxZOJfIrDW/YV0s/e7o9gQ2p8YXJg+kc+ryM
7KxTKPHis2y75+1LmTyX4fByjuVSXjM4+rBCByYI4wuWmFRuLefIjq/a5fE675dg
5KwjNOjVtLHy28peZeIFPGjM6Q9qs9ih7AG7dyWZdOtz/M7ioSwjph9NEiCfaX5c
bV9bpF6sKK12ynw3FFtdRYJ+IRvLpNdxdta2H6Zffl+b4pJwiupc+WLuxm2ynu19
0EUK8bLETwN/lUbEwBJR5cM+tfgemIX3WD2qGWQOrIozYJ/fEAe53UA2iFys2UZj
PgZc17+yabLaYHuIoeFIuzAHGLcI6w==
=FeB6
-----END PGP SIGNATURE-----

--ya5muq7nyqwzkigj--
