Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427214;
	b=5m5V+6Xf3dsHeGT7/wZaBWDrMLeOZ4wdnkjFyUIiE+3hPn8iEdNZdg8xalduxn/tl9Qp
	 L9R3/Xi4vlnctFsMEovslOH9aQwXRJHaLoIcQ+TLkaK7lGMfudo/mOUwf/C+FJm6I7v7J
	 0K0jNdJYDUCaO5k3Uuk3M4vnHZjWxxKB6D0a5mgZYTwpnTT1TWW63+XCl9hQhGlhV+DBA
	 RK8j0/aMkkhG4Ln5c5YcMTdfw2ISi9Lu7IW1uQPYglZX8VPEd5MCIx1ElpO4VSbKFWbnN
	 tunY+rT87syVJdM1BXMzCpCXdt2n/azTsIUY+KI9DOiHMhkaeMmWa4/p4kVveVsVkzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427214;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GWw5LeA7+CcqIOX0ikU+NCGK5sBgz2t/JGK5sxIXn3o=;
	b=2hY88c1ZNeAJxTPJcR22KyL/bQiyEI9K89WHqqv+mfc7SirMm2FUJTrgwS+O7/TGRy6I
	 IVQHU14Vawaudle2K80CAfivWRVTFTRoWis0b5aOuEKcmt+yuePL6ALTLSHoFZ+9Y5Pr0
	 rfeKBtGq2sSNBPV8a10mX8PK1LihBb410ulMvwCVf8zZuEPQmYXpoDliTa4Jbscchc3EV
	 7C0JBXObQ4/gzNxDws2tZKa6a7g1St0y2CwWgMHhQi8tTSqHYPpyjgz+eIlFCU7xuHu3n
	 1wjHyee1jdlbpl2WrLxZRlNcHo7ZRt5AmHNV758fqjKlZOHPHXm6kfXnWW/IeWcBQ2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OE4WtPEM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF7B606A321
	for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OE4WtPEM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3991D1F00A05;
	Wed, 11 Nov 2026 20:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794427214;
	bh=GWw5LeA7+CcqIOX0ikU+NCGK5sBgz2t/JGK5sxIXn3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OE4WtPEM9Wycq6dSx3GUV5QJPODiXzS7h+l3ot01WrCzmqodo3/H6BcV4oJZIobKC
	 wp3e3wB8s3BzLlkvY6FFu6/lIfxla6MxXmqV6SgWsv4GJ4TXJ4AIo0AcaNw2IRvKSS
	 VYGB8m92CpKhylN8NFgsiAT3dAcs8SOO28wnlXO8XxHPh7+Dqpg4jrgQynQgaCsibF
	 ovAhsgCPgnjavwveKoZGYzFxwlgPbApVlLKQBTI3ZU9ZcYGmz2kccFjRZ0skU0rI38
	 JKh0zBKWvZAql043u78NlBW4azbrxob2pDjZO/fjJvwq5FckeiLw/yvDl+AqEEjCGz
	 bT1cHp+HNdLsQ==
Message-ID: <sashiko-outbox-209600@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] serial: vt8500: Handle uart_add_one_port() failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexey Charkov" <alchark@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261111-vt8500-serial-cleanup-v1-3-b33594a25f87@gmail.com>
References: <20261111-vt8500-serial-cleanup-v1-0-b33594a25f87@gmail.com>
 <20261111-vt8500-serial-cleanup-v1-3-b33594a25f87@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:00:13 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Return the error from uart_add_one_port() instead of reporting a bound
> device for a port that never registered, which would keep its clock
> running for nothing. Let devres release the clock and the remaining
> resources on that path.
>=20
> Set the driver data before adding the port, so that the probe can end
> on the registration call.
>=20
> Fixes: 304e12665a4a ("serial: Add support for UART on VIA VT8500 and comp=
atibles")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-ce64cdae-9faa-4109-b7da-29b8a8c99=
e76
> Signed-off-by: Alexey Charkov <alchark@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-vt8500-ser=
ial-cleanup-v1-0-b33594a25f87@gmail.com?part=3D3

