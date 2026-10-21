Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792574724;
	b=KXH7JH3RJNMkVUCILTdvRrgp0ZIVTMD2+qPS0Jx/wPXvvCFB6xg8gNFaeso6/nfNTk2U
	 QaDrrpegT0eYBBWMN0J8I/B/xXtkYrBxZW2F0AbRqJwAiKtsT/VA1b4cDBcpmJpHCIfw1
	 oEQ4DOW6BPf/sNu+ffRabzZO+0U6ZSgEZ9Hh/2fUSmtAeo22UyEEnChawE0XmAUqPi70/
	 i3mNQqyO7A2K533yntdtGxFsS0nzePzbjR1J3YbdQTDF90462g2gUD3pq3RT/OHNYFrhP
	 JUDTV8UwB02YYYKPl8DkPlGs8PSaGpNdOZcrugsqJdHPIxESum/PudCyNGnDFS0L9Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792574724;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6yQd8xS1v9u1Q6Lhzzv1RodI4LWOuVG4vnqv2hNvgTw=;
	b=Kyn2ku9RFRvQJvMB9bCjm0jnsUKkz1ZUcKyX/eGhJKUwjHLt3B59lwimVdQO0d161cO6
	 GQQsSzeexJq/m7R5V3Tohoy3xTEqcH7HUyA6E++ndoW+OTVjYkkbIIewCSXilrHRwuftb
	 0yANlNo+erH9CZMmeG9MhG0HxfNfPJcNtMFn9Or8k/IHOntMi+SefvDwLo0pxI26NpbT3
	 K9/yWLWo69mhLBrabjyDRZqt18znODvLgmWUWmunBoyI2Bir+wHUIGqVsPsK1l7Va0k1h
	 0L69Av1ewiKSmR3kpqcslDC2rjET9eFca0uLdnyKXQvkHbciRy+rgBL8qa9AeQejPbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QHCGqx5Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8F0606A31D
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QHCGqx5Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FCF1F000C9;
	Wed, 21 Oct 2026 09:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792574723;
	bh=6yQd8xS1v9u1Q6Lhzzv1RodI4LWOuVG4vnqv2hNvgTw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=QHCGqx5ZokY/fbw48Rmhb+urg0eQpbcgud0SxRH4LNnQKIcFKNxzwELdIQs7ZmAsK
	 PZzNjaCiOITtKTYIXcrd6UNgoEfiPPXcZeTtYD1942tI/sOTlJgwA/T8N/5SnAdS22
	 j0terLYVcRalvWNmMQtgogKMfY8AFY8Wf+jttkkN2AYfRqChDyo4xFnKx4s9YtjOKQ
	 PnOtrdsOoeYSEFWspa4BVDz1B5nTjDlV0HFqVhvgb75kcYutQ/7om8IwSbyNXKbGSe
	 2vTBxDy7UQJCA8MduRlhN3xeoqp8mMKq8ldHAMoTb7tXBuv99ts+0CYl6RSHVxUVE+
	 2Fy8wDYoeiV5g==
Message-ID: <sashiko-outbox-180024@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] serdev: handle devices without an ACPI or device
 tree node
Reply-To: sashiko-reviews@lists.linux.dev
To: "ChunAn Wu" <an.wu@canonical.com>, linux-serial@vger.kernel.org
In-Reply-To: <20261021092124.2306053-1-an.wu@canonical.com>
References: <20261021092124.2306053-1-an.wu@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 09:25:22 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Driver-created serdev clients may lack an ACPI companion or device tree
> node.
>=20
> Add a creator-supplied name for these clients. Use it as a serial
> modalias fallback and to match a serdev driver of the same name. Keep
> returning -ENODEV for unnamed clients.
>=20
> Signed-off-by: ChunAn Wu <an.wu@canonical.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021092124.2306=
053-1-an.wu@canonical.com?part=3D1

