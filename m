Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A4E1A2C2C;
	Wed,  8 May 2024 01:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715133151; cv=none; b=FFe4tT2/hlWiiMkA0oat4L5LAb7dbGQi+EiZc63Tr6uh0BmQEtp7cU42q4XP4vzuYZKNA25mRATlbvsiZav/y7QWasP+JzJZ0NczadiJ3cQnYYlgxBINrIjNhPrzX/4NLC0dWDvIGbs6alTm2/LAqzkxK01qW3fxO/1P3L4vktQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715133151; c=relaxed/simple;
	bh=ugJZMfnWp1tZ+Efw8vGTidZeEWR3MbrG1EGUAcX/GwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pd8IFr0a1O6CqZNh3YFoDitmHT0kbN/W1U5EGQoJv7Usndm/guP+5aiKgRaZA0lhAxafzDgDknqe4V1V/7bL/XRfAfuyGgNtEd74WyczouJNzLn/PllO/e/x82+AoEi7BKVufQocjjHQAdWPZJ/njdcxUp8lW0M5qS4RlwTEVqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDN9fIC6; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDN9fIC6"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c96c096a32so1653280b6e.1;
        Tue, 07 May 2024 18:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715133149; x=1715737949; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mI+mlKCTeaIo8cDU5awpjfrsbBEG0F37ujmJyccwavs=;
        b=bDN9fIC6ypWa/HCq4NowkoLqEy8UJ+eElJa3LZal0AA55yINiDVG51vNmIBPFEGepX
         vv50TQPcENibdnco58KLYCzGy4Isp8rEKorU31cMUkdhDn0VHuLjXBZie43gWG1vShCp
         op++a+UafBLmdQVy4RTVpexHAGtVMUcEtmJsZ4m1aoqSWYMwxSNd/WWAi9ZK8n1Nz5wJ
         l/3Y0x2jVzf4P+bcj+VnpQr2wiSLiu9/cCftheazI9+fYvbiu/rRggw5qr5KR4iuZtk9
         GffhN6/JUsb+CGCgRNKk6oEC7Jbx+p5vWEpLiJ2WkTZyH8Hc1KD1vMBW7P9YrM4A9vjk
         xc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715133149; x=1715737949;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mI+mlKCTeaIo8cDU5awpjfrsbBEG0F37ujmJyccwavs=;
        b=GAZBU00Lmw6HcSiXfJvKoE4IEnQskIZj1s4Pbx/N1iKoWExSS0brngPR5Ss8h4YTcQ
         rqmGtNt2bnTyKPf0kAnbh943LFXnY0MPm9vWYP4JBzlug224eaTcDgoxfNlU7emATy2a
         7/pYlLrYSPtMxLAUV1v20hyqi5jjWf4lMDA8pGlf1M4T0hBQEuLZj+TuyMa7iA4iLO5J
         N57WN4/QmuUGwSY+7kqp2kIjK26w+PJGCUHZiYyp7uQxaobmmxm5BGO4EoCztqfsC16/
         2qqa05ZK/QaySGmf1OchJvHg+gO3z4PP7xlgkSV71gQBrTVFDRyl8hjRd6VKdSAwFLId
         Kxiw==
X-Forwarded-Encrypted: i=1; AJvYcCUPiZmjY/uLZhfAaYfANQee3rRnLzKwxphbIk+u+HmOpz4tc5r3cRpR1OiHV9GaVMsfFFbYwJ/mbBBBLtQbFQBz7XHlGAAwD4vsYG+h
X-Gm-Message-State: AOJu0YzwIaHBR+o9VaHRmrjbokfzvaarZ1DG3HEboLx4Cu3o5e9+NgVw
	S4XcOhl7BOf8I4lSQGaP5m9GKfOH84g0JKraalPlTC3xWPGMEP1roYlscg==
X-Google-Smtp-Source: AGHT+IEJBP5w2JhbaALlm0C7oFF6eo94CpcfwN6RXnsiTYujzNVFtAzrdWQzEwmxOcg4PIIONtFLnQ==
X-Received: by 2002:a05:6808:8da:b0:3c9:7810:faf0 with SMTP id 5614622812f47-3c9852bda11mr1292898b6e.20.1715133148934;
        Tue, 07 May 2024 18:52:28 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id fh21-20020a056a00391500b006e6c16179dbsm10037041pfb.24.2024.05.07.18.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 18:52:28 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 1DC5218462DC1; Wed, 08 May 2024 08:52:24 +0700 (WIB)
Date: Wed, 8 May 2024 08:52:24 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Serial <linux-serial@vger.kernel.org>,
	Elvis <elvisimprsntr@gmail.com>
Subject: Fwd: Add method to allow switching kernel level PPS signal from DCD
 to CTS serial pin
Message-ID: <Zjra2GZIDC7BPoZx@archie.me>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ceDjgLgiBjV9uhOH"
Content-Disposition: inline


--ceDjgLgiBjV9uhOH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg, hi maintainers,

On Bugzilla, Elvis <elvisimprsntr@gmail.com> requested a new RJ45 UART
feature [1]:

> BACKGROUND
>=20
> There are appliances that do not have a full DE9 RS-232 port and only RJ4=
5 COM ports, which do not include the DCD pin required for PPS signal detec=
tion. =20
>=20
> RJ45 COM port do include the CTS input pin #8, which can be used for PPS =
signal detection.  This is a feature that has been available in FreeBSD for=
 some time. =20
>=20
> https://man.freebsd.org/cgi/man.cgi?query=3Duart
>=20
> FreeBSD allows switching from DCD to CTS pin on the fly using a system tu=
nable in a loader.conf file.  Example: dev.uart.0.pps_mode=3D"1"
>=20
> This allow one to connect a serial GPS receiver with PPS output to a RJ45=
 COM port for a Stratum 0 GPS+PPS source. =20
>=20
> https://github.com/elvisimprsntr/pfsense-ntp-gps?tab=3Dreadme-ov-file
>=20
> KERNAL PATCH HACKS
>=20
> Some kernel patches have demonstrated receiving PPS on the CTS pin, but r=
equires hacking up the kernel and will will not persist on kernel update to=
 new installations. =20
>=20
> https://github.com/not1337/pps-stuff
>=20
> FEATURE REQUEST
>=20
> Add a tunable option to allow the end user to switch between PPS on DCD t=
o CTS pin, similar to the way FreeBSD does.

What do you think about above feature request?

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218813

--=20
An old man doll... just what I always wanted! - Clara

--ceDjgLgiBjV9uhOH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZjra0QAKCRD2uYlJVVFO
o/iyAQDHM8NvcDtZ8zMGlWMT2semUK8Jnc39VvUKdDj0DgrBvAEA66gysRM5CVqY
hSTSD2PPhC+SKhMd1bUEpl6tZOM1MA8=
=RSX+
-----END PGP SIGNATURE-----

--ceDjgLgiBjV9uhOH--
