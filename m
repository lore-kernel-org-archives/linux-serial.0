Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793863558;
	b=k3Ji/Vrm5YxCK5nk4n+VH7TkvDX3cDqA24SD4Gwv4E5u4it+Fe2nQtCVvL7ULI/ht1At
	 eCtyBkJwlv4SBwPYyNDGO2QcR9gMclPI5tndTJK+6IyNlTt5A4BeIcUivwQ2GSsCH7dn0
	 boDDMg1wPo3dLD72PESg53/3pMJpYNbAqZWdU/Crc/K82mCOI0oaDw9tutOeZ6BwoRhBG
	 KWw0emNQTWBBNW0Y//4GOW3fKAMje6/3otfX+qOgVgeitClDxtes27hHbQBDVjYmRur/D
	 1dkrKm5z4PzutQD65fJoEmkCbLBsngvK5GZ3Bop5a3aLmTcXa+YUfDXGFeGTimClUcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793863558;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KNmdnFWveQhMjvu29D7UXW+avFo1Sl4HYPNCZuU64O8=;
	b=fDoihTAOCmfSiQ9zRMPvGPbiPiokBlXlBzOunMkmfy/xil81bFtDy5CjxDVJ1KUvmev7
	 nuF5tnwd4d9b8uIhfhSkGFSBxGSkN9wwkaAJAz/Lj+iyoOFkQs2gYUO8ZyD0oOI/Mu85e
	 re+xLVBlUnQBDf1wQM9Gw/HYxqeJ7jWtgqxtzswH+WkuEGtt9H8eO8od4Ry+9MhuJlp7s
	 4SUpIUtBgWDgSRs5DWzk/y0xtjcNv+H6MF+5FwsIoU6/CIH3kXdu2GFjAnDomXJV/ZuYM
	 EPWvnA/708ZHFqV2ekbhOhVdomXK4+CrHubCo5TS2ZuK4NcoKwj8vIUYdvnu7cCnulw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3aTn9XC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA75606A328
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3aTn9XC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762731F000C1;
	Thu,  5 Nov 2026 07:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793863557;
	bh=KNmdnFWveQhMjvu29D7UXW+avFo1Sl4HYPNCZuU64O8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S3aTn9XCIyOGapPZB/xUOAqXx/q1mnp1P3aGwDENg5oTzgQPbIpFoD3pSL/KIP6u6
	 k7+eSOnb7NtoAhs/bZyExN3q/NSmQH/1KYIqkOlf2F7trn+hqhFOOlvHCZtUfFgxG3
	 vas8mKHLJolxSICOftpj0AazalVAai/+ath6pIfAnmLOIC7kCFTXllEB5OnCHqd7x+
	 j18cmtqocNrlPZm59g5tEUqet2yb/JkJQaQ9Upz19xvGGFsiplUg4elCYsJ3lPjmEW
	 bXBkJzpYh6soyJV3P0r6YObh5Y24xIhrCAkbeX6ApkMx528tNY0L7X/Iv5a3r0/Oxh
	 MxKJYHXMf/M4A==
Message-ID: <sashiko-outbox-198665@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] serial: core: Forget the RS485 GPIO descriptors
 when a port is removed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261105-serial-rs485-mode-gpio-v2-1-027e5348892f@vaisala.com>
References: <20261105-serial-rs485-mode-gpio-v2-0-027e5348892f@vaisala.com>
 <20261105-serial-rs485-mode-gpio-v2-1-027e5348892f@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:25:57 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The RS485 termination and RX-during-TX GPIO descriptors are acquired
> with devm on behalf of the port's device in uart_get_rs485_mode() and
> stored in struct uart_port, but nothing ever clears them. A uart_port
> can outlive the device it was registered with: the 8250 core keeps its
> ports in a static array, re-adds an unregistered entry as a placeholder
> and hands it to the next device that claims the slot. If that device
> has no RS485 support or no firmware node, uart_get_rs485_mode() returns
> before acquiring anything and the stale descriptors stay in place,
> pointing at lines that devres has already released. Enabling RS485 on
> such a port then drives GPIO lines the port no longer owns. The same
> happens when uart_get_rs485_mode() itself fails after the first
> descriptor was acquired.
>=20
> Forget the descriptors when a port is removed, on entry to
> uart_get_rs485_mode() and on its error paths, so a port only ever
> carries descriptors acquired for its current device.
>=20
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-serial-rs4=
85-mode-gpio-v2-0-027e5348892f@vaisala.com?part=3D1

