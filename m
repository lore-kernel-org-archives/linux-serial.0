Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894723;
	b=ncZ2OMC8ukAMGh6uJwqKflxnZgRpraFMoHJGqIDzTe4oL8i6zA59fYHqAT932DUgSljU
	 OB+CRJdjFDPNV5S5sW/RSVpeMDwLNf7IqgH886AmYoqp7NFBy2X6LFCG+Zw6ycFL89Fll
	 FMvxmDTeKno5iexDPMMSP0kRD5G35u73Dnp490UBSMr16UzRy+hEv3EyYtXL8CcAy6Cs1
	 GA9dG3Ul1jFQ/gFnUS7KsSNubW5gaBfMyxSeH7J9sTustcta0Yo20gj+fkKKhlGV35UPX
	 y51Coq0bpfOikyjT6+W99Y3pMf9oVIbOWMeUK3BjPhto+2w5xOyxWKT0K/5qaddYoug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894723;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YmlvGuVjsawZ/B8QYQwrdMEeo/FtYdo8b7szvaaHQXs=;
	b=OSoxIeDa3jp4XOQbYfF0YU75sGoFVi1127fRuY8ZoKKgRDqpTKoEjXoiARbHfBTuxb3S
	 Nz8uVp9O7pzsR022TcwcmL/ihUiFTBwBABqQZ+yc+DsVWt3FDWrcEevGL0nkVGHSjLJFt
	 i0oScnCWP3iKkROp77501TOcA0u0T10lmBKPsVasky7uozbqwehgw6dezGbzCwoCwuliy
	 dbdrU7b15fRpnqsIbxMMUQTMvOaYhswbKu8ZKjgzV/+T21n1RfeO4T5U2gLuSCBfuYllF
	 EQOO8/nX3zTIcO0dGIt+KuOYgeAqXfqPy61PLrTEb0Hoj40OccGw2ewo0sqyiIC9z7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MNcB9Fop;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FD9606A31A
	for <linux-serial@vger.kernel.org>; Sun, 25 Oct 2026 02:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MNcB9Fop
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546001F01825;
	Sun, 25 Oct 2026 02:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792894722;
	bh=YmlvGuVjsawZ/B8QYQwrdMEeo/FtYdo8b7szvaaHQXs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=MNcB9Fopen2b/mvgGwAOOW3N80IBaXVVDmO1HHG89MfUCDiaNKj9tHBRwpc68NYai
	 QGAPLxMy2BeHCR1XN4MEUUsXNvo7ZIomMIW77+5AJ51U+aFljDqdJTMLg/z7d9o/Ao
	 IgKHeB4aPk2dKPuvq7Y5LdpsOV+goovQ55dBpe3FhqMitSgZpIe1D4bTO9N9yXvzIb
	 ECi0QVydmnIjitDNAG3yKMb6b+iKCDf8R6vgztlRfCFBLPoMSneXHhKbq5XhzjEehx
	 aYYmLH8OHOngs4GdE3neBA80HZ6u2vL5xlKulpNAYnPnH+I8tywDCGhgC3RJAh8IiT
	 xnHJ8KECMMdmw==
Message-ID: <sashiko-outbox-183981@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/3] serdev: handle devices without an ACPI or device
 tree node
Reply-To: sashiko-reviews@lists.linux.dev
To: "ChunAn Wu" <an.wu@canonical.com>, linux-serial@vger.kernel.org
In-Reply-To: <263a607c3602f31a3f6fdd245e3c2008cdf97abd.1792856688.git.an.wu@canonical.com>
References: <cover.1792856688.git.an.wu@canonical.com>
 <263a607c3602f31a3f6fdd245e3c2008cdf97abd.1792856688.git.an.wu@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 02:18:41 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Serdev clients instantiated by a driver have no ACPI companion and no
> device tree node. Their modalias read returns -ENODEV, their add uevent
> is suppressed, and they cannot be driver-matched, so creators force a
> bind with device_driver_attach().
>=20
> Resolve both TODOs in the serdev core by modelling matching on the SPI
> bus: let the creator pass a modalias to serdev_device_add() and give
> struct serdev_device_driver an id_table. ACPI and OF are still tried
> first; clients without their own modalias keep returning -ENODEV. The
> device name, derived from the controller, is unchanged.
>=20
> Split struct serdev_device_id and its defines into a new
> include/linux/device-id/serdev.h, following the pattern already used by
> the SPI and I2C buses, and wire the new ID struct up in file2alias and
> the of_table coccinelle check.
>=20
> Update the existing serdev_device_add() callers to pass NULL. The two
> in-tree firmware-less clients (dell-uart-backlight, yoga-tab2-pro-1380
> fastcharger) also pass NULL here so the tree keeps building across the
> series; the two following patches switch them to a real modalias and
> drop their force_attach workarounds.
>=20
> Signed-off-by: ChunAn Wu <an.wu@canonical.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792856688.gi=
t.an.wu@canonical.com?part=3D1

