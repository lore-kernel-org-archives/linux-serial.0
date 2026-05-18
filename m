Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB0932938D
	for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102434; cv=none; b=jwX7gJjZgdF8K6T63yRFhZudbA+tyU8gZHLPZpLq95z/RII8jlq8nKsKxDQfjLMj5u6DWA/IjMxstSwV2z6D9l76LBzpHW0ve4fvRixoBCWFzJsDdaRY/R2GhR/q2InXqQpbf1/DAPqyf76xR67f15NSAxrYQFEwrnjhGJSSFrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102434; c=relaxed/simple;
	bh=UiEfgBfW3coEu7wwQGQiyay3gF+430dgg8ATYZXeF7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LESOd6b+cMY1UeO/Rec0m97ONaUgGcGAt7Ou5vos6nCKPz7KVFEfFktccrzMnGQYCvrAditUHkN7RW9zDX0gtZktAC2JD2Nnsqc28t9CFhUi9OdYAKKzfn1VegZXIHkh0XhgMgG7BhqjAU9RvY2yeCrfl1+4fnt0rOUlZ+yrpjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=sQNQXkNq; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="sQNQXkNq"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45e6a4d0be0so731875f8f.1
        for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 04:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779102421; x=1779707221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Xot4V/Knh6jczVa42p9tACz5SZka4ycTK17n4UJLu4=;
        b=sQNQXkNqGxv8VWv61/w4An2NTDJpiymWNVO3tM7sTjRbzhEs1YuSiU+ib1F0VC54iK
         k26yr00tD4JzXaRYBo0xY/j8wh2se/p1rcgPXitKKxw0THyCYi/PtFSgamDOzrgCFkXz
         Q2UsNBnyRj+0kayHwTZzJkSEt5w1jrGbaxEOWdH82ef8JYB+5WjM5PUtfUpOsWg575vU
         PkLAxsJvdDcSJjG1FbCJuyksH4gJnqk6HStRNcKry7WEfbJI1v6sFI1bqLVnRoSIqgkZ
         YUMcsjwFm94JGncSlpHDghv120a4+v6XiAo4vqv6S0B15xdoDNyvpRdkSrW1DM/Si+tB
         Q4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779102421; x=1779707221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Xot4V/Knh6jczVa42p9tACz5SZka4ycTK17n4UJLu4=;
        b=LOXvMTSkE6Ic4TB2OxZfit/16Wko2wvJW80uO3n7cISdTSwSoV6Mh65tzF6WGHgmkI
         c6jD7fwD3lB84+ORV0ZwrTqFGRyV0WXIt/sjE3j1ncVzvdZ/FP84azMNAv1NplzjR3R3
         63Ea8DxtJYqCwniWOd+ouqZ5k/TjU1cc9GJR7+TpawfY0jiaaoKcpOkCWdp8hvhuj4vQ
         TuHPphlcidEWIhczuI674xUc+/2IKGzq7+UEWzZHesLCwQKUw+EqGKlMIS0AUHq8U2DH
         AlIqxMnndtX5bjvlPijBVcaTOq9h32bkZrNiOiY+vkt8g6+6GZ21Dgalq6SbnAOAVbYP
         j19A==
X-Forwarded-Encrypted: i=1; AFNElJ+OhFFKLTXKMnN4nhob1md+q570EjALivQnXoio0vnfduLHVHp3s8q+LJd0EI2vy+lBInNCAD6kgzKTeXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbgP03CdWDHZnagFZ0d0hw9EwU60EnlEKZ+zGXsYfauYSkVb55
	vgbO+Dbt3uWHJ/D9xuUKw2hVVByIkHmHOnXBj+Qf/tzRRpLin09ghTRiwBZLE+tYXfQBhMzZGBT
	uE8H9
X-Gm-Gg: Acq92OFRDV2NjjZtKRitaxg+dUTsMBxueTbCXfohnyU9K3rjXUzYEd8O0eMfSBpL7vH
	h46fHbs7+vMS4A++L14lExheA8hTMehUUkKRsY6EwC6cgnt6hVvcJZS0W8ydvSqjz3T5dDXPrMw
	fM0Qycld4alkCH2r+MkpeNVvjCV0VV6L/4zr8xgsGL8b/tgQGt7B86vpgJOPHUmGsURH4S3DJqB
	95ne8mgpx99ZjmtWNimMO5yQ4xDJQNlax3hnQNp4nuPquXkthF6z+7P3exssn9qOj1iAIMWj2I5
	dqBo2L8cDN8loxgNpaByH9vj5H9Koad6WzOLmFbOfBCXUwNYicwUEA5AU4RP4P3rPME0W7WZtmO
	ab4zKi9O7Zz24qtYCIq7ngzY+Q57fKYPnQ9neKM0D28W8iH47ZIIVoLVGhS62Zfe+WddEABz1L5
	tc5KnR2X83PFSyMA9u1YRTgwYeUCjuYO1m4jIqo7jra5FQQ0n3T778lr3aWkGArDq1flmthIG6N
	JryL/oKxWe9kz6mSwvXFuy3Yw==
X-Received: by 2002:a05:6000:4014:b0:441:1fa5:4577 with SMTP id ffacd0b85a97d-45e5c5f20f3mr21988584f8f.26.1779102421585;
        Mon, 18 May 2026 04:07:01 -0700 (PDT)
Received: from localhost (p200300f65f47db049367b55fc4056f2b.dip0.t-ipconnect.de. [2003:f6:5f47:db04:9367:b55f:c405:6f2b])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45da15a6454sm36806910f8f.34.2026.05.18.04.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 04:07:00 -0700 (PDT)
Date: Mon, 18 May 2026 13:07:00 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Tapio Reijonen <tapio.reijonen@vaisala.com>, 
	Dan Carpenter <error27@gmail.com>, Xichao Zhao <zhao.xichao@vivo.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] drm: Use named initializers for arrays of i2c_device_data
Message-ID: <agrybgEu5PT7orKA@monoceros>
References: <20260518101456.632410-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dxlgyj4pqkjtneid"
Content-Disposition: inline
In-Reply-To: <20260518101456.632410-2-u.kleine-koenig@baylibre.com>


--dxlgyj4pqkjtneid
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] drm: Use named initializers for arrays of i2c_device_data
MIME-Version: 1.0

Hello,

I messed up the Subject, of course this should have been:

	[PATCH] tty: serial: Use named initializers for arrays of i2c_device_data

please fix up accordingly iff you apply this version. If I should resend
for this reason, please tell me.

Best regards
Uwe

--dxlgyj4pqkjtneid
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoK8tEACgkQj4D7WH0S
/k5ylAf+ONKL/jud2QbFfxYbtQRQMNGfX3fPOXzItlVXu7/nEQybFWUSXvG6X9pw
+MeUe8GCOZdRApBeXzFMzs7TLycKb+EuVV+530+NnPNbGiXVCKDy/Y6AVMqDilZs
Y8SiOfkoGoaCXgzJZRkvW6SVbwMH+mEc+wxEl4e+p1HvavHSxCWTMF4iOisVVt7X
RX9bk6mhMsHbq4CtXUAIBqkuxJkNOSHAlaU8VHtDV1IcbddVe6czCaW2lIhqAbGN
3uqZkZZfogGn2LiIGS9xw+WenVGOa3psDVJK2ed5qTeou9rFUV6souAfvMavXvjC
Y/C1R/Z+Ng+9wcFhIcR6aSleiuDzdQ==
=VJqf
-----END PGP SIGNATURE-----

--dxlgyj4pqkjtneid--
