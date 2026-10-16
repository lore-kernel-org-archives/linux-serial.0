Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9874E5505D0
	for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174319; cv=none; b=InlvLgkDhKlIhXkgkv35mqpSAjlPvQFXimU4p1u3/z+qhJz+U/ZKI/tf7GKOxYgtDT4o7dnvPlEkKJuVdgFX86eDLjjZUl6gK4/U/kkvzntscBPepzRmS/YUpX8WWJSt46hAMUCLKTJ/p/sxzO5mcn5SzjUaOImzM8rS9aa/dWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174319; c=relaxed/simple;
	bh=s9jIcomC1d5yDhR/MasqvwDCCe5cNN9pLCV9IdUMtFc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ooM6XyqKv/od7xqzGr9ktB5K9ixSHDMUm6f3LHrww0VJSevRKXSm4d2fSCogMUzw1p2N6Mg1MP3LfKkiK2bsbl+sGpBqDhKymJCAOMbR5wssHYqTLCpzygzd4v3b407L3OIzjorid3kIUQRx//8fKf0NOFYOf3f+zSfQ18+h87U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyOb2LXb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyOb2LXb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DEB41F000C5;
	Fri, 16 Oct 2026 18:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792174318;
	bh=s9jIcomC1d5yDhR/MasqvwDCCe5cNN9pLCV9IdUMtFc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NyOb2LXbp2+ysb98jksvWe7RK4ZnDNZefsupKtMIgWQJHqTNPH2xFXiRudTOPGYa+
	 lvD4Z+9FG+kiwXiXDUiRXFppleuD+seqAcZ9z8Xb2D2xDbDtx2vVSyRBNlottBpl01
	 iYccZwyoh0QpVztIwQjXp3hz8zmyzJi1W6ycWwZPst4dac5+1kb7UIrnDetEj6/6gH
	 CAGcPSiRKhqDKrTfE/qQmNqp7ulxN1hHyOITMUHVXwgsEu8UugNssoHeEL/6S4vQa1
	 ZatjmTcrd1CzP9qXY1mJzNu1JpdHW1PWtMWjdm/0jJ+1ssLt85tMvX9DiQBGbBAQMv
	 G9OCAUnEAxHvg==
Message-ID: <sashiko-outbox-174754@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] rust: serdev: Replace `active` mutex with
 receive pause
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261016-rust_serdev_probe_refactor-v4-3-46832e034757@posteo.de>
References: <20261016-rust_serdev_probe_refactor-v4-0-46832e034757@posteo.de>
 <20261016-rust_serdev_probe_refactor-v4-3-46832e034757@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 18:11:57 +0000
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

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-rust_serde=
v_probe_refactor-v4-0-46832e034757@posteo.de?part=3D3

