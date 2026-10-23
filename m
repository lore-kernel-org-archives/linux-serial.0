Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762704;
	b=bsjirCym/oS+5xVlk1mEIBFM6KAvUu0i39SfiXLmUpwZ1kVTH6GEOUANR6LTOBkxZrXs
	 CNDFtSbr6Yw36S3aQCRcpumTYCDtJ4h/t9xuAo4jUrVpECotQX1Xu6m3dWWkGuHGwTLWM
	 5NctWYxL6rEf4t4hWzH3aoICP6aNrWUUQwnuBzkMIxPG34Def0K4TRzm9gwCMDLR+7XET
	 pL5zGGNoQ26IawKVQAkJO8scl47rvcXoDRK5oSgwgtDt3Fxeb+Njd9O3J6Osci9H5N3/o
	 8PBXr6dmjzc90+k2lYROCoaWyfwuzhyLXpV9WlySoIoWS97kt2pxvkzS3bzzdLVF5mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762704;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MHrhe5teSdIGDeARfQaN6UsYD43H3pifdcbQVPckBgw=;
	b=wLVa3zjyc3ItyKLlpOxmIvkeowrbbEx9Dt7jm2nDZZLa/yC0qB2Y+Z8FFkaxVLWYubjp
	 +wxb6m/DEOyoC3VVNlQBotRGFR7Z3UOAbbt8Qa5rDYKj9jABxbahfv6WvHPsEwxBpKCxm
	 odvzd9lTWZ3Yzmbp5IRyEXxJWMoptwcR8uTopf6uikByFfhPY+3GbkJghzKETD3LIKXF6
	 sKaiiaHsIJspRPM+XoMqOGAJL3Y67mO4cDHkIdoQD9GTNcQFToRefc2m/fJtrgokGVgYd
	 rGPmeqale8T0FeY2y/pRPqfL9Cvf8dJcgOjej5Td7DYojEt2QayWnBijJWEaxV7pr8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gR9T/D7p";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0A2606A31E
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gR9T/D7p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0FB1F01825;
	Fri, 23 Oct 2026 13:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792762703;
	bh=MHrhe5teSdIGDeARfQaN6UsYD43H3pifdcbQVPckBgw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gR9T/D7pruZBZo1yy++vAfOS+HYh009Jmcawga853OyXe0QV+TyZP0cKdw9E08Jmu
	 lL9gC1BdCXgPHNYnHBTZDX5OK+R5JsF+xXC5V8FhHMEd4Ms5wP+CLX/+QTlpSQrc9r
	 4aMTCtYqqHz9l/s9xJqNs7/xC73FCL8y8mKxqjZ8LON/je3tYOaeVZMBE53ysw9xv5
	 7ikv63c2tdrVoPRgAu3Io51ckhuQ06fSh6TASs9uIA8Jq1vxJ66z3BDchZEKhzaDuA
	 0xE9QvZ12mkBeJVZ+NJYXMv3gTCH4aFIEwePW5EjqP6NxV5wbgx67HlMNkm+BpTc6i
	 W4LBsNY0K5gRw==
Message-ID: <sashiko-outbox-182834@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/7] vt: Add con_unblank callback to struct consw
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261023132448.115747-2-tzimmermann@suse.de>
References: <20261023132448.115747-1-tzimmermann@suse.de>
 <20261023132448.115747-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 13:38:22 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Add struct consw.con_unblank as inverse operation to con_blank.
>=20
> If implemented invoke con_blank to turn the console from blanked to
> unblanked. Also update the semantics of con_blank in this case: The
> blank parameter of con_blank receives a VESA blank mode from enum
> vesa_blank_mode instead of the hybrid unblank/blank values it has
> used so far.
>=20
> With con_unblank not implemented, invoke con_blank for blanking and
> unblanking as before.
>=20
> The old semantics of con_blank will be removed when all consoles
> implement con_unblank.
>=20
> v3:
> - fix typo in commit description (Helge)
> - add mode_switch parameter to con_unblank
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023132448.1157=
47-1-tzimmermann@suse.de?part=3D1

