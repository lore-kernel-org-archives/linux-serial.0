Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793955852;
	b=MrhpoKL0se1LGwK5D+JxtlZenT/dEXvuB16nf0OHh781WX2GY7nnGC02hj7+7CT9Jy5T
	 nCGoqRxFtdxUg8Mhan9URqaSgLpJ5pJZhPJOz4ZMdPlXKBKLw2LogrZ0wnQFxa/FxjiQc
	 ztzIkhuczQIzEH/WHO5JLww72ToIkQPYcxtkipf9V/s/sv7Ct2FKYeW0iN/gBoC4KhNGe
	 Kddds7GE1gle5IJidyI0+OjR4V+X1fV2lhZ/PwoCfpcgC3KXpewO5gUKoICs9vV0cTyJx
	 6Xf5Wx4syRN2AH3OCHD1DHe+D6XAB4fMh5MI8oUrq24ycHRLDQy8cdaRoHDCEtKiXew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955852;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yO0puPTnj39RxDhOiKxke1RCF3gi/JICO/C9rJv1hQw=;
	b=ceCpGqOHBs6c8+RpW5Dyh7Ri0glm2XTgRhGBkskOLdWoCwdZOJ/daBanrutSCa1vo0fi
	 sxTLKiKF2+Hxt2AVAHYxESogGPADPMk1lP+w0eako0zb44cOPaqAsKhid1piV4XcRtEoT
	 glrxOr3aNUNL1eAJYgjYFPt5IVkhvFyqZhlZ88WziUXMWMiOh5gd46oCC59rMXzHec/9s
	 DzjfTyQ4aif86GmWOQkRbXZeG6/j4Zk0krAKZBqiDgEptCVNGwJrU54GU4vR1qozo3mpK
	 XyuawFUGnII4q0XLnSy0j5B0spCR1gMnoPdWoJAWHB5d4quRjgdtdNOVi199TW225jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Umm7XAwE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89030606A326
	for <linux-serial@vger.kernel.org>; Fri,  6 Nov 2026 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Umm7XAwE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39DC1F0089F;
	Fri,  6 Nov 2026 09:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793955852;
	bh=yO0puPTnj39RxDhOiKxke1RCF3gi/JICO/C9rJv1hQw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Umm7XAwExFZAdBnnEG+Co0ybs995EsceFGyiPLqQqJVLx19IurW9FifkTj+8QKRrw
	 hHEGZYYYjIApvp8Yc6G/BLz68Ev5LTy3HGgBFouArSnzlqBew9IV//SRu/ZT3+4I3k
	 LZEe0L8Yl4CNDpgdY2WoqIDgE7bq/NDQ3iI6S1Y0LZa27QJDvMLtlsMM6nCLJKcNsZ
	 o6k4StFXVl/dPiYpLFTk8gAGUO0V9xl187bbU7zd0ZJvuqth6RUmvlja6CKSt7ciiG
	 T4Q3HDolN4v+buNzmJ3Ozykf8QXyiIP+5QLwsNnp2quLZ5PtXGkkBEqFRX88nAWYvF
	 Po2UxKOKannTw==
Message-ID: <sashiko-outbox-201097@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: use isdigit() in tty_find_polling_driver()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <blum@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261106090122.2265-2-blum@kernel.org>
References: <20261106090122.2265-2-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 09:04:11 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Use isdigit() to replace the open-coded implementation.
>=20
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106090122.2265=
-2-blum@kernel.org?part=3D1

