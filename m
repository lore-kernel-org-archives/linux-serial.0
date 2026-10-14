Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A22414A27
	for <linux-serial@vger.kernel.org>; Wed, 14 Oct 2026 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960563; cv=none; b=YrPlFQQN1ToIdoIVgN/T2i6nPGX34xZO0sriRWsWJD517soPtY67rKttl36c+MLSyiecVjbbgGWe7j9BWO2HGMn/n2s44nmCqpTeRguf1iArGbYUWSEJSJOgNAlSCjCEHmYX5Lo4mLoqwD5+I4nJwMlT00aAmA6gZSOAjAv3g1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960563; c=relaxed/simple;
	bh=locxSIYKzevzcRsYsVwXkMpCxHPurStnzU/h05ueKkg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=M1kKtAWXAKwAjIZZH2SVS56S1me+Lc+OMkBqGpGj5cm0pSufpJEL5QaXoqZqg9V2EO6R7f+JWwY2bwOokK9Qx7IaVC4CnDtQyZUCFyXCsOgp0uiax+tIdZ6Fjg+GdhovkMKgbyBVNZpOHQMRExtuBDvpidLYXVwbzE0nt2DykfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7jSE0nM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7jSE0nM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F043D1F00898;
	Wed, 14 Oct 2026 06:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791960562;
	bh=locxSIYKzevzcRsYsVwXkMpCxHPurStnzU/h05ueKkg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H7jSE0nMVKaIY/pIWjkSOzISq063kQ5a4ma+VG0JsvG6xg3jiv/CD21WCmiQuc43m
	 4YJLRlX7re6HxobmUYKUUoAXJ/nZ7bZey94XORt93OL4tJxhnOXYjSHT4fko0nLU7S
	 o+HiT5F9lRusYMatP6RWM+rEsM9scw8D+4PR3+r9o9aVOe/QUTPZVefQm94OHRKslz
	 z0cG8w8p/txIGjBrYUDxEC6ID7TYijFdEVFkpqmvIMcjEct2ya9AyeFTkjY3mR6ttp
	 i8Aui5sAiPdX0hy7Mv8QKLOQAy0rk3Hfj//yvDld/kAZ/c+ZdTdxiZwQc8EezX1iuL
	 DAAUnhqR8qmrA==
Message-ID: <sashiko-outbox-170893@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] serial: 8250_lpss: do not touch uninitialized
 line in ehl_serial_exit()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmlyaSBTbGFieSAoU1VTRSk=?= <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <f389df34aaa538270313ebd4cea75c2baaf46b95.1791873876.git.jirislaby@kernel.org>
References: <cover.1791873876.git.jirislaby@kernel.org>
 <f389df34aaa538270313ebd4cea75c2baaf46b95.1791873876.git.jirislaby@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 06:49:21 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> lpss8250_probe() calls lpss->board->exit() on its error path. For the
> EHL board, that is ehl_serial_exit() and it does:
> serial8250_get_port(lpss->data.line)->dma =3D NULL;
>=20
> But when lpss8250_dma_setup() or serial8250_register_8250_port() fails,
> lpss->data.line was never assigned. As lpss is kzalloc()ed, line is 0
> and ehl_serial_exit() clears the dma pointer of an unrelated port --
> serial8250_ports[0], i.e. ttyS0, which is often the console.
>=20
> Initialize lpss->data.line to -1 in probe and skip the clearing in
> ehl_serial_exit() if no port was registered.
>=20
> Fixes: 5318f70da7e8 ("serial: 8250_lpss: Balance reference count for PCI =
DMA device")
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791873876.gi=
t.jirislaby@kernel.org?part=3D4

