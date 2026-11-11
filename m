Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380095;
	b=a7uQrhM2GxfeBPje+GjSG/loYoEve8IZTDirDg0ZZN9vQxS1uBluyZFucLsUDKDvBEd0
	 9WPbOfaE8iIXe4gxvk3KrTSa8UHr+IiubXg68vwpbCp87juOWa9eDccxVZoWohge4jGU7
	 338cvY3JtWpEaL+EVzwfLFf8z3QH9KywH1eC3UXUuTfAg4Gre26u2itm1kpMPR1HPgasR
	 C0VZ5fNbZU/fcsfZtR+OpMOqRIPodzfiiZzs5QsiO7u8Gsn7oY6vdSCxiv0fcycd1rR8f
	 dWvkWpjjGUTvqAXBF19/YItFR+JRATk0K4oSMDv2kf7EbiFUGV2q0lMgj9A8eFG5c9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380095;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GHgqJYrYhwfpJ2s4cOv9IoeBIrtVH/Rn+VN0bzcAnl0=;
	b=p7uFAI2fXD4NiAMPDqZ2zSwnLtNErB3Vr5qnN02/o92unbt31eQBWtWQQxCwDfXwGocS
	 1bO09SQgQ9qI5JFYQxXofEPDK87n7a323N0TDwC18Bvf5p81h9u11Gogqb5UwP0voYdM4
	 1Mc6FExm6/CelJMWDSqinDeGYy5nMpLHxyWieQ8O1YWC6iusESjMrGo9Ew4hGyjiTyDsy
	 bTcf11AyqNXSDnS/WQu/6TxPnRfGxIVXUqB8Cc7nBkwINUUSWO5Gvv/8i/8dx0LxNYqAZ
	 NQ8xM+5R7ir29ltXLGN0AkAqXoggJfhAFzrASBDyJR0X+sgF4IQLO4glyANb1nlu4Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oN/kAa+o";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D290606A31C
	for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 06:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oN/kAa+o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD7E1F00A05;
	Wed, 11 Nov 2026 06:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794380094;
	bh=GHgqJYrYhwfpJ2s4cOv9IoeBIrtVH/Rn+VN0bzcAnl0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oN/kAa+oQ9IVl9T+R+XDFEtsHajUoCowFhM7iYR6nwlKTxjKEWscu1F5PrhxXJ8+d
	 Xs/ny+fHC09ZbeDsiaz5Jg71gc0ttroroqrEHK61xtvOOpiZ3ASpfhi1alNuAOlqAO
	 OsJ3b/uojECvsnZXNCT01FzPy9T/U/Xu1+NiZfabbIrRM1Hs2fKuV8I/fUurnJQlWI
	 8kAItmt0AftTn1iWIqrRoanhDSGI36m+MZyk6xb5SKxq14ZIG3j/J/ejHT9rQ51lVY
	 QaAebyTgEkxvZXFv0OXQZKEZ4/2KLaj/3kynRg9ZK++ZKiKCgUDv6ipHAn6T9JxCDp
	 oSX1v0zHKXgNg==
Message-ID: <sashiko-outbox-208471@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: pty: mark lockless flow control snapshots
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhu Jun" <zhujun2@cmss.chinamobile.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261111064744.17235-1-zhujun2@cmss.chinamobile.com>
References: <20261111064744.17235-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:54:53 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The PTY write and write-room callbacks inspect flow.stopped without
> flow.lock, while TCXONC updates it under that lock. KCSAN reports the
> write-room check racing with __stop_tty().
>=20
> These callbacks take a snapshot of flow control: the state can change
> again before a write, and the flip-buffer operations provide their own
> serialization. Use data_race(READ_ONCE()) for both checks to document the
> intentional race and ensure each check uses a single load.
>=20
> Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111064744.1723=
5-1-zhujun2@cmss.chinamobile.com?part=3D1

