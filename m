Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571257;
	b=hbVhM76ZmmGN2mmaEJuJFPGIWuuF1evKKwFW2T0NnrgOylg4NdCQBTNgRlZBzIYqWaMm
	 TEliBr3h7Ur0kKTA+hsAQYN/PRWoY/1serAk7/IiWQcH21X+lStUTSzRre8XrrInWc6WV
	 2eEWYxKc/EoP7Ds1f8Upgty6ooxLF4yxHngbAGozQyfehRmOMu7yvqqxZisKJoEmwA/l3
	 7KCrO1T2UAWmKT+rTgqB0YJOniKHMFvimD6wtrzxYrlzFVbHj0gj+OPXegzzYlTumCF7R
	 9nEDcTKTGOySZcR2Ab9HA48pzD+n1dXk1af5a7Q4IpQHfy7bW6vq9GJBRzepSk/ZDhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571257;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kF6hKEGSQiTPw5VAvXCmaOof7X+cDZOiW22O52zNOW8=;
	b=0uVIZW2268je0D593Yoq7PRkL98Ewo6Ge9N8dOKEp//TM/X1WwsVDm02VE18+Bs2jbUF
	 nzkrpUxa26Q+oTwwLB7WDbcN8CFqAo1l0UbesImYkUWoXing4eA6zAZR4qgtrSkipUrFU
	 QwkZdgfiRocdOyw8xB8iqDV3reCrj4HLJqLHNs9x6XxwUuh5ivnV/euDTCI0L95sLxT+f
	 e6JDRH8rcMUzWXfS36YUavydz/YiQo+PH3P64n+ZAmh0bV1ukLoWGYoTi7b03+pcggLpD
	 xPfcxLj+sGf3THF3axTcD0RCOoMlH08levaXVNOquW+zpsUqBFMnIaA1nfYEg1niiCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dVQNwij8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13704606A319
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 08:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dVQNwij8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDA81F000C9;
	Wed, 21 Oct 2026 08:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792571256;
	bh=kF6hKEGSQiTPw5VAvXCmaOof7X+cDZOiW22O52zNOW8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dVQNwij8BBM5gJYRFe2HGCDgz1pZJ0GgaJZ0Ow0Rnh76A7vbKlOHR+3p6dBQ6V76X
	 mIduUoS0tibne43zEDrE5VnS/hsX4gOXPTqsJL9I3YloEzpsuSccf9fMEP5LOGazk3
	 OcpY+Em+mScq1Aop7W+Mf3nVvwozbKAAPTpOsp2r3yZQ61Y8Vd4Wp94J1J7GQUXRP6
	 aW20Y2ttnGm3gQXT3lLYxLBgBjDRZASnrjaKxMqwfkkVc01p6YUpKIKMMcDflqsGTI
	 D2te86Up7rUSq55WKMSi0s83GEjCaEWLNos+F5oNCOvRX0RKxmjwigUVDIDVHFtKxR
	 0ShR9txQQY1bw==
Message-ID: <sashiko-outbox-179965@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] [v4] serial: 8250: remove hub6 multiport support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>, linux-serial@vger.kernel.org
In-Reply-To: <20261021081746.3278002-2-arnd@kernel.org>
References: <20261021081746.3278002-1-arnd@kernel.org>
 <20261021081746.3278002-2-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 08:27:35 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> hub6 support was added in linux-0.99 and the hardware was already old at
> the time, being discontinued in 1990. The code for it has always been a
> mess since it adds another dimension to the I/O addressing in the driver
> that has leaked into many individual files.
>=20
> Hugo and Uwe have attempted several times this year alone to isolate
> the hub6 handling into the 8250_hub6.c file, but I feel that none of
> this has been a real improvement over the original standalone loadable
> module support.
>=20
> Any machine that would have used this ISA card in practice is likely
> 30 to 40 years old, and with i486 support now removed, it is clearly
> safe to just kill this all off. The only bit that has to remain
> is the ioctl interface, to ensure the serial_struct field is always
> zero.
>=20
> Link: https://mirrors.nycbug.org/pub/The_Unix_Archive/Unix_Usenet/comp.un=
ix.sysv386/1990-December/007174.html
> Fixes: a300273c458c ("serial: 8250: hub6: Add cleanup code")
> Fixes: c526404a4a92 ("serial: 8250: Fix corner case for port matching")
> Fixes: 7ab80d1e7243 ("serial: 8250: fix compile error with hub6_match_por=
t() when compiled as a module")
> Fixes: da7b5fd4e17f ("serial: 8250_hub6: add missing include for hub6_mat=
ch_port()")
> Fixes: 3d406299d882 ("serial: 8250_hub6: add hub6_match_port()")
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> Acked-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021081746.3278=
002-1-arnd@kernel.org?part=3D2

