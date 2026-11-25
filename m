Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596231;
	b=t3JUkUCZy72IlMWoc9SlsvnTQ7YBxzMyUK9w+rv4FoHX6xbUa8GwT94NfkLVerS/8DyB
	 CissKBUktLI87LNDwRD6ngWx7L7nebHu9/5gYDWAo4ouUj17an1bSXVXi66nqnNSv24vh
	 2utfXI6mADc3BSaER3hlIh1/OQzxtbPtmXsti3IuqSWvI211Y/57ecZvic23v7uksWjAw
	 x2Y5wvhAjqVz/CGFwseFbBsV0Xi60q7VG4v7T1y9QuKy8td6uq8LBweX8ESoMd18DBVwB
	 v35uG09/S1RXADEtOmJvL1flaNZSuZTVzxy2PmWvxqv4fnbsPHa9wS6tYBAitamsb8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596231;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nT/x+VoS+76b/zY5NVj16vrg6LSQq3M14MJt1hMfpjE=;
	b=C/U47kft14Ln/Ty4tvycpAODItgDqP4+U3Nqss+r8iapQ9MU6FxO5TKbEfU5nqo84FuZ
	 y/hxqTQnWe7k+1QSX6Znr6Dco+esHxPEikwQ+DFPuHj1QqVERPVtBXW6Ky6M9Gm6AlZE0
	 +lXWKMx9narRaLJK/rEmxLLqiI/C6vAMEi+Y6YzGywWQT/sdxliCfJm7uPrw42eSuSxb1
	 QsoTEJqpUU6r6h+PxCPljRnBb50VfJriA2pjpYek5muXK65KddDmqdroGV2Atib3TxerP
	 l9Q7vJx5SPY3YohEy2ZUWJwIpx9Zl5osk2HgP2ShjGllYrLQz2rxAAe9nUBcY+qCrKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OotSlT0a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BC8606A31E
	for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2026 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OotSlT0a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E085A1F000C6;
	Wed, 25 Nov 2026 08:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795596231;
	bh=nT/x+VoS+76b/zY5NVj16vrg6LSQq3M14MJt1hMfpjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OotSlT0aXjoGl+gUoMKcof2UDALCNmQQNBlBPRMBdArGTvFibREGnjlQWFt7/EOiE
	 B2y42ZcWFktjXLMaYuDVoCP8r5NvqOfy9iGmTddu3kr3DRLOlvisGHn4nOgmzKHVHi
	 hoK0H3YsFOEVN0iSG8G3FBlJ22X5rGJYfwHwX8Wdrx8/T49afAmup/uCnX4HgzwxQp
	 nCg92PVN5UXkJcpbhYyYmypIuhxUI9jk5fqk/DHrp7nd6+gJ6yOzDzQTCJiR8i3Ex4
	 RAl18vn1veGhIWq7VieD/WiBDmzBF26Us2fSsC+N7G9dPdJc8tQBHHbtJJAiXNphV1
	 uhtst8D+gnKew==
Message-ID: <sashiko-outbox-232932@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: rp2: remove ports on IRQ request failure in
 probe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmlyaSBTbGFieSAoU1VTRSk=?= <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261125084059.84951-1-jirislaby@kernel.org>
References: <20261125084059.84951-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 08:43:50 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Since commit 016002848c82 ("serial: rp2: use 'request_firmware' instead
> of 'request_firmware_nowait'"), rp2_probe() loads the firmware and
> registers all the UART ports (via rp2_load_firmware()) before requesting
> the IRQ. But if devm_request_irq() fails, probe just returns the error
> and leaves the ports registered with the serial core.
>=20
> rp2_remove() is not called for a failed probe, so the ports stay
> registered, pointing to a card whose devm-managed memory (card->ports
> included) and iomaps are freed. Any later access to the tty devices
> then results in a use-after-free.
>=20
> Call rp2_remove_ports() when the IRQ request fails.
>=20
> Fixes: 016002848c82 ("serial: rp2: use 'request_firmware' instead of 'req=
uest_firmware_nowait'")
> Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125084059.8495=
1-1-jirislaby@kernel.org?part=3D1
