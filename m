Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792548223;
	b=Yx3LwnuI70CU2UgEyBspqT5aYR20JuzS06ZNMHCYrBHYwmcKKbnh4W9MndRKAKJLmCyu
	 U/biwheD97qzts7LKms62ARJDb9kQb6t3imyOz4oxBxQQ31714OCELkA41dZ231IX19EU
	 TLS/HCcg/ciEAAlgrQbfNIPc1sAje3YaRPEUJbDbPgikbQYPVp9XJb491yEztbYar8ft7
	 2luF9omxMVIjH9y5PHJ7wKP1OgetCMaJC3IkKmLstmx/NPfqFM0DJgl38glDzdg7pphH7
	 UkSG8vbnkJnaag0n9DfooFiqaC/O/Qqs1dx/W5yl+fnGmujXIXMbloPnC6jDZ41Fngw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548223;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SEkvzHLjXRGkuf757rxEX6wvqGqliGUo76c7iHpF9gU=;
	b=GeDbBf66qg43mqVTZjU9Yd8pUUCc+M08E4kgvG/dg7vOZ5f4JpfwxN4uMnDCpHchmN7V
	 Ke3G8i23BnaMDhJjB8fWuqQlsCLYLDAYF+I/Dxby+L2WVoHkC/gy/tW1YBB6pgvKGwrOz
	 IV+zQhm7zNL3mzpiOjMZcEmDiUyiAAxSUvQdAabnj5gKFDHNCOrMx8vaMl7xPX7XCZuoa
	 djz0VkOYUVRtHVHJS7Qk8oIAjkms9UmtnrL5tumxGPpBRx5xwgQRbkfN5mDMmpYp676cr
	 cjuqSpx3BRJ9EsCBKUImMspKTFl53LJEHtmAQaBrbRP+OyFWkfWcPMWrhgRHxyv31yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyf7qcbx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A73606A31D
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 02:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyf7qcbx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D73A1F000CA;
	Wed, 21 Oct 2026 02:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792548223;
	bh=SEkvzHLjXRGkuf757rxEX6wvqGqliGUo76c7iHpF9gU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hyf7qcbxyVoPlivf7zgGv6kNvIVq8/gmkU2sliG5Hn4zrlOkNtcWNvzAXmjZrDEYa
	 61CG+5+WEOknU/JMieTJin+co8sU+LSJr1SAEZV8X6U3kg9x1oYNI4y9jl5Vi467rT
	 nt2K7k9jnAPY/ydmh44kNJngUwVBT2TPVm6Yy3OiHyEjt+J53+5Z8e5ZuL10/I91v3
	 iqikPlNVRMkLiy1NkHb+iJ/G8X8QqWZPxq297jn2yRRKy1nWRPq9nbtdkRKwr9tScC
	 vOncYkX3pCQMsbXrZPXWwMX6Jiq0JTsq1xNxop69wJnr2taC2mTlICpRUMkMGGJqOW
	 1lu02ECQyBqmw==
Message-ID: <sashiko-outbox-179677@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/tty: tiocsti: expect the privileged parent to
 succeed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danish Khateeb" <danishkhateeb03@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261021020106.94174-1-danishkhateeb03@gmail.com>
References: <20261021020106.94174-1-danishkhateeb03@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 02:03:42 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The FD passing tests open a pty in a child process, which may drop its
> privileges first, and pass the FD to the parent, which always has
> CAP_SYS_ADMIN. The child's own TIOCSTI is checked against
> .expected_success, and so is the parent's TIOCSTI on the passed FD.
>=20
> TIOCSTI checks the capabilities of the caller, not those of the process
> that opened the tty, so the parent always succeeds. Where the child has
> dropped its privileges and is expected to fail, the parent's check fails
> instead:
>=20
>   # tty_tiocsti_test.c:620:test:Expected result (0) =3D=3D variant->expec=
ted_success (-5)
>   # tty_tiocsti_test.c:622:test:FD passing: expected error -5, got 0
>   ...
>   # FAILED: 13 / 16 tests passed.
>=20
> [ ... ]
>=20
> Fixes: 7553f5173ec3 ("selftests/tty: add TIOCSTI test suite")
> Link: https://lore.kernel.org/all/2025062327-shady-broadcast-237d@gregkh/
> Link: https://lore.kernel.org/all/20250624.3bb75890f0b0@gnoack.org/
> Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021020106.9417=
4-1-danishkhateeb03@gmail.com?part=3D1

