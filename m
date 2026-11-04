Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816851;
	b=EodDuyE0ZKszK5tFbTrx8jZ99gYdhWquRB9EokopSUilSUMSpB1tfZSXwtGvS6b2VIOx
	 RzcjFqD6v/dldGanIVA/+0YXjX09p6tPmyhxIrJ/CfsrK+qOk+WItnGNFNHTXJA991MgQ
	 vZjVokTLNfvQs03zzUN5CLombYAWM3CrQqtGVZERuDcnkrI7+seRRgQZ9dt5Hi6B0krR3
	 H9vGL9PHfqxZ/+XvqENkIOY4RkMqVflTpsgq96RHliJN4KCd68pkD4w6EwGJ5bLS/bSg1
	 mOo39nHf4SLplQu0Q8P6ljgeXskYWE7sKlQDpxUMJuTAk8KmVOyHjOd+mHnr2umMYHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816851;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SjYqhypl4JRucJ5UPE+LN1999M9UvMsh+6C/hu8WGNY=;
	b=J4132xt+4821VwzEXdoWrnjvcCwWUvr6tNp3OYoD65jhkb3bu2qwPSHQ4uzN7K9AgiZo
	 20E0nEg0NJNBEK1eueOJrSVq2uOc+RUTqnIVx5Qnde079uCkK6859TrRoYkiNAONuJUNA
	 mOk7YCf6IQe+Lppnz2sanU7GB7s618ZmKVM35rc0G96KJ9+PFz+J/VIciYvW/gp46tWD1
	 Yi3mhWoehI1EGOGx6SvM6atZHw0Cbrk7gA6TUXmb8V7Pf/jhZHtxtTLXYOZT895EeYjF6
	 4g6KAMFJ3u1+WirX/Is0KEfcqZgIJWjo23h1MKu+9AAUuTeNC9c9vlVSumg3prGxRrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f645Ivwt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E23606C448
	for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2026 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f645Ivwt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF1F1F000C1;
	Wed,  4 Nov 2026 18:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793816851;
	bh=SjYqhypl4JRucJ5UPE+LN1999M9UvMsh+6C/hu8WGNY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f645IvwtD+DtDfQyXq6uMpuyFJzQN5QkRA3YqfHw7oUM7PYhWvBCPfxRP3C/bbrO9
	 cQ3Y63FOLlK5YxtcyuZGL1oUGyncUV28JGl1/9a3EL+xl2/En2uJx8PjBAX/YUDUiB
	 8ZGsmHsq/w7Amz80VuPSw0wUkI4IL+DLwS2IIDTQ1no2tbtIjXhG6RWsjccCyoQEC6
	 ROQ/FO2fJuURh+2ubB1xUFXMDZgbvHxqTGzVCLODGs88+I7WXVB4GvfKV/e38xhekj
	 bgB52BIw20eXtrDKgXwedxPdFYnHh/TmXVe6aYjSmJNdjSITRiD3XQPqN4vAnlhELd
	 6F6DR0fPVvK1w==
Message-ID: <sashiko-outbox-197843@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vt: modify a constant prefix that looks like a ReST
 target
Reply-To: sashiko-reviews@lists.linux.dev
To: "Randy Dunlap" <rdunlap@infradead.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261104182258.3226665-1-rdunlap@infradead.org>
References: <20261104182258.3226665-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 18:27:30 +0000
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
> Precede it with '%' to indicate that it is a constant.
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104182258.3226=
665-1-rdunlap@infradead.org?part=3D1

