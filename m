Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEBF3A8FE1
	for <linux-serial@vger.kernel.org>; Sun,  6 Sep 2026 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710995; cv=none; b=HxGM+9AcZMsY8Z/MGm4O6BVrvG5lNw4BiUkaN0bV2LodBz237iIl2/L8m5QSTqSz7y0ueI7JGzesnr1Sympf3GJ/CuO7LQ6Q9wTXPC8Dc4rD7fm96kt62k5dciTTjrxz+Qqcm/XwyF/WwjZmpzkWHsocNF1y6BA/F2FUT6ll3ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710995; c=relaxed/simple;
	bh=CbP6us/lr59dRro+fa1nQni2pU5kzXHWVCz4cnGoxiQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oUCKhXAAK7uS+QuiMzIEZEN5pZE90dHMAdm8/n989jOkIZzqYzM44ACDM1PUUGGhgYNiQ3CzaPh+444HgLL/h1E/+06C2EjMQFfCeeUPl6xwhYkXNQdMXjfszFNhob6d1OZx7A7klP+EFZOa9FDsxBZF8lNaNxTrEAxnd1/aGEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgC6/Cvo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgC6/Cvo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034971F00A3A;
	Sun,  6 Sep 2026 16:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788710992;
	bh=CbP6us/lr59dRro+fa1nQni2pU5kzXHWVCz4cnGoxiQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GgC6/CvoA7zWYd707YOcASi8HMjqpygY+8d+z4Zm237+LYLXp0VgKl4nnaQp4Yo7c
	 nTofzk7kyMmlAk5t8wiT4lJPO1YvULZ8cdFHusjNZOOkTlnhPjgWVY/z+TnlvtA6FF
	 MBJhA8hEmO8DAl9ges5fH04G07thmsqbPn8W7U4dOR1fiX0GOf5C9UFA19ke3YNAz1
	 9K0/p5udn0QOurju8J+dwBZ0/9YbplreYIR0WF564gzLBcleeBekMMP4bmLv9WKs1V
	 s2CvDYsrYPQvHvz1xNtm/nC+ehVvqIwarwMMz18GOQ+yN/dOMIdpdVqwbfr872Rrdh
	 WpDlG27Rg9pVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] rust: serdev: Replace `active` mutex with receive
 pause
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260906-rust_serdev_probe_refactor-v1-2-69cdae0074ec@posteo.de>
References: <20260906-rust_serdev_probe_refactor-v1-0-69cdae0074ec@posteo.de>
 <20260906-rust_serdev_probe_refactor-v1-2-69cdae0074ec@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 16:09:51 +0000
Message-Id: <20260906160952.034971F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> There are currently 2 race conditions:
> - in probe if `Driver::probe` returns Err
> - in unbind
> . In those cases the driver data will be set to NULL before the serdev
> device was closed. If data is received while the driver data is dropped,
> the `receive_buf_callback` might try to access the `active` mutex on a
> null pointer.
>=20
> Removing the need for `receive_buf_callback` to lock the `active` mutex
> fixes these.
>=20
> Fixes: 99f59aa82341 ("rust: add basic serial device bus abstractions")
> Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-serial/20260905000836.C8FC91F00A3D@=
smtp.kernel.org/
> Closes: https://lore.kernel.org/linux-serial/20260903222159.70A911F000E9@=
smtp.kernel.org/
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906-rust_serde=
v_probe_refactor-v1-0-69cdae0074ec@posteo.de?part=3D2

