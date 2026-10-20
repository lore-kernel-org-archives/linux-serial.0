Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521943;
	b=hw7TXvCv+DRhJMDTn45HQ/gI+UvHQMM6WPegQlKb6Wge+4br2QRdFXrjnyg3+O9C5WnT
	 T0MVscTR8u1yOjcS2JJn3NE5g0dTftvU1QuIwXMfRkGnmJG1G+JY4/S91xdVsTEygQSzD
	 GIgVFJ43gXGTK7Op9Q6LYaQ6+lxIQDxHRRx9uK1Hos5e/t4IToo/85hGENyHiwxdL7Q2O
	 V1Lo+zYuw5QY1MTnyZoQVDalKhWjdhY608o29jS441rWyRwhq1uewfRoUohmnSoZZihZo
	 85p0xwU0YDkBT0IHuJKajCqEDAZ6HcHduoNbzLX06PZ3o4bE3QQHduzRchvGVD3TqYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521943;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NPdr2LZ/e5M+KiB37Boxf3PvCLDmvBKVALzcODoNjCA=;
	b=sol8FBwo0Ix0QWA+3p4WJesK3KqYB+e2WwMCLq92+HnaEqeXCfNrHXc5thjyDs7Pikqg
	 b/ZXiIDvIY2yNAuYNeUeHTwSwUI4g/qAYXLLuelIeoGWrkC5u4nicJFxomZmYmyfgJ5Ge
	 I6qI/ljKkRBNtii7nsftw5+gdpvaTGKCxFH5+PIdNLoDo5ausv1+oPSt1D70HdlXjZelG
	 jFOj+WJbKLAtlGjAkKq8NYlakzUBXfiS01iLSoYTkxiqsQhBaSjh81RoXLgDcZIL5UFRK
	 NpCmQBmdKE1Ru/VzSUH4FYjgRJytPHLIwLK6ntXMl8SfIeZEVAYkTCftx6PDXXUzgQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k1fhN8MM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6655606A319
	for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k1fhN8MM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2273C1F000C9;
	Tue, 20 Oct 2026 18:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792521942;
	bh=NPdr2LZ/e5M+KiB37Boxf3PvCLDmvBKVALzcODoNjCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k1fhN8MM8sqcYuMAJqPL2/8rwx9s3yw9nhuEPN7Z4tYy5DjqQ71p6M8BFukEBwnbE
	 6QremTgsU5zuKRNNZTY0L5DDn3owIxvv6emNsNXpNKKCVjWSMc83qjs2XbzH9vn7AK
	 MLPTNu/iuvAK+eu0iwFkbAQzP0SXRiJptenayB0kzCn+3QHp+PUGaJvKJ7x2qnla+A
	 qvDKRi78Xk6r93TWDZ2h26PVUKaN4W7PggdgFiM/hseQ6zJ0sdfROWw6Omp0s+8Qs3
	 kDJzjVT5hO1YQT1UvAO4vfRlo9ZqC3Rcg0YpQqtFbj3WAGmYhVITa/EewPk5YWhWkz
	 MaF8iindVR+eg==
Message-ID: <sashiko-outbox-179493@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] serial: core: avoid redundant baud assignment
 without any UPF_SPD_* flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hugo Villeneuve" <hugo@hugovil.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261020184131.2893575-5-hugo@hugovil.com>
References: <20261020184131.2893575-1-hugo@hugovil.com>
 <20261020184131.2893575-5-hugo@hugovil.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 18:45:41 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>=20
> If no UPF_SPD_* flags are set, the spd_* flags kludge is not necessary, so
> avoid redundant and confusing "baud =3D altbaud" assignment.
>=20
> No functional change intended.
>=20
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020184131.2893=
575-1-hugo@hugovil.com?part=3D4

