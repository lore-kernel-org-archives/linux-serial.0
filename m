Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738574;
	b=A10UZTx5YoqX3eoujuRRGKgTmIZQIRwEn3jz5WhZ4zXUereUsjvN+7Dr4IvAg5xUKitO
	 Vhy4BRnf1Ode7fXgkL27x2vdvYU4LM9I7YXiTeRGHMGInMbJ3za3aFjFocgbEd2twHi+C
	 8NTjXNxGI3cPbo+P8I2gm5j03ebiby2cQU3C/G6QPikt/oGz9ix8QoDcD92uzxF1Ce9cb
	 69Nrl64LZWMx2HjxkNmpVzfZnN8EktYAZhdamIAzFDj//cGb0Zi2V1hu+bRq7ddR/MjUI
	 a4Z9PYi0TH3LTSP9MM9dmjeSxir909MDL3XUVSI2lVIFyz+YXDIeZQXKZQRUu5A7JoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738574;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=R4gsnbw7h9pu9XA/fUOEu+vohNVIOQai4j8lBjSBSG8=;
	b=gBLdzAoatfRCP1/VuhFlSqFPuxGgLZES2SYtyxke32Qdmwr9qO1TBH80qrABCBxlC5Sw
	 uKIHjVqx4uykbvXX2ZP3GXYAHin2pPwFxQnWI/6yRzOxzTzwJ8G7Gs72n9CUxRa6yQsY8
	 +vlvmRy7ITcSWbvIJ6DBOBA3hMfWBxMX9xfgtllWiVINNSNjZSFWb0elZDNpZEpxKwMek
	 zgVIv3xsmYRtWIdCD9oZh+O07M8ocSNSzXiWhdtAHDCD3t0/QFsx2jb7u5IJJOFkUGEFb
	 088D+/9d/7wVWKGyQZUmEwU2hZ5PEjM9T2oeaNuFyyZ3Fb2vRi/8jQaYnPx2q4QAYkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MwOyTKfa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64049606A31B
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 20:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MwOyTKfa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248BD1F000C1;
	Tue,  3 Nov 2026 20:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793738574;
	bh=R4gsnbw7h9pu9XA/fUOEu+vohNVIOQai4j8lBjSBSG8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MwOyTKfa+ha6BnGFkZphDncAjN6B3a0GNQLLnwvkQgofcz3EgDrPQqJ4scoH8iq9m
	 Tuj27d3+DNXK0GcUoZ3+U6EaLqm5D7PaJgxB0hWWNFkas09KQPyNdVdis6AZZzYCce
	 ADyrIzwnv3mQOvHGW4sTuJoS7jWPsvHpz/2DSd54Uo8TTEXJz5nObGcaxuIuOXclmf
	 Aut9aB+G8JcxejhjDa9XP2SQb2tB2usg+TKDcoHRdKXxUvek1MEli4GBeJPYkf0iXW
	 nhD5sE8bsk58/1iEPg3Tlb6BpaIH5i0D4VA/R8TA2NEgTQnM2OZ+eaOJPsF/flEU35
	 11387vWe3DMWA==
Message-ID: <sashiko-outbox-196004@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vt: modify a constant prefix that looks like a ReST
 target
Reply-To: sashiko-reviews@lists.linux.dev
To: "Randy Dunlap" <rdunlap@infradead.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103203929.2916563-1-rdunlap@infradead.org>
References: <20261103203929.2916563-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 20:42:53 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Use CUR_* (could also be something like CUR_x) instead of just "CUR_"
> because the ending '_' indicates a documentation target name, so
> unconfuse the name.
>=20
> Prevents these warnings:
>=20
> Documentation/driver-api/tty/console:36: drivers/tty/vt/vt.c:275: ERROR: =
Unknown target name: "cur". [docutils]
> Documentation/driver-api/tty/console:36: drivers/tty/vt/vt.c:317: ERROR: =
Unknown target name: "cur". [docutils]
> Documentation/driver-api/tty/console:36: drivers/tty/vt/vt.c:353: ERROR: =
Unknown target name: "cur". [docutils]
>=20
> Fixes: 1438d00569c4 ("vt: Add cursor-size helpers")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103203929.2916=
563-1-rdunlap@infradead.org?part=3D1

