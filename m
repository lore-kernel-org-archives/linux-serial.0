Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1AF481A98
	for <linux-serial@vger.kernel.org>; Fri,  2 Oct 2026 09:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932478; cv=none; b=M5od48tPmbwYS7ZSM9PG8dRROEbxKchaRHdM0UZQQIa6BC+LL6hmcPms2576+KxOdpcVQN1GRoxKUrbjYCQUQSvGjfi373iwZqfiPJsFIIQHg+SyVCWSLQZiRQATIRS2oS+fOvmLKYiJctgMqliISAcB8bOhiHpAdBKLqFoU85Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932478; c=relaxed/simple;
	bh=w9+xgdEzVZR0ZzfQswhTvBdKYsB9Ne2VOAZRR704aNo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=forcyd9MKruOHdT5cJO7PHeMHzxOhnuhkTSlUOsI/oxAdfXSmT5AqF+BQ80h0A0vHIRyqhHa+F7hIRGxkY/6wLTsh3tiHtofxABooGKonNgxFUbUafQTPIbpa1hDLjSsEcMapkA/SCMX056uPaALy1b0knTu4yuXQYghk/GJYsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOXujiar; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOXujiar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01B71F00893;
	Fri,  2 Oct 2026 09:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932477;
	bh=w9+xgdEzVZR0ZzfQswhTvBdKYsB9Ne2VOAZRR704aNo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EOXujiarO5wcF/S/Kb+OATscQeM1YmfNCSvhwwuL8m8HjXOMNuNHYOAl76RAKhQaI
	 EreYr7ROvmmU1KiLciFoXyqJkIj5Dk03M7JOLTiwaQoBgQoRsRfcP8RpJXEL7Dg9oa
	 rADB8pY3ha4z1to1rIVWkqEJgy4rOvY+V8jjzdQdqTPWZOSTWov/y72Q1hApT5wv6E
	 KDqC8Afl62BjzlS9fx/z1s2dMmeyFb91xigrxQjjHVp+cn4jjuI32SRjtMjt9T7WOO
	 vpSiGm4L+vxQ0h3pv7CKmYWag9OAmSaBob9q8PZzxW/8MCEAQ8igspTzhAmbyyhPtQ
	 t7KdLOawb9AAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: add missing driver flag kernel-doc colon
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johan Hovold" <johan@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261002072736.2063004-1-johan@kernel.org>
References: <20261002072736.2063004-1-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:36 +0000
Message-Id: <20261002091436.E01B71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> A recent change adding a new TTY driver flag left out a colon required
> for well-formed kernel-doc.
>=20
> Fixes: 8df07fe93573 ("tty: fix saved termios reset race")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/ec3a09d6-4ba4-41b8-abb1-b59e265f4532@infrad=
ead.org
> Signed-off-by: Johan Hovold <johan@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002072736.2063=
004-1-johan@kernel.org?part=3D1

