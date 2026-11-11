Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403814;
	b=XzWx7q/j6w6vrbvpnDtw5F6MJDSrDhGqCetSZ0ViF11HMpWwe+ixel452FPMTMU4mVK4
	 wWakKQNWNaLDlada1GXqTuBhbF2f9XZC7EbsmwtK9dJRVXn07D1GSOPO37ELthVXWjmyL
	 8UIRqXfWBhAI3azJnW4BWhxRXX6WMJw9hAwRJPxxnSsnRZHTmTIrltZTqSb2mKHd3oMW7
	 EKCjBpfrk2qUB7XJ9HU0py8LanihViJD7uHc3s7gMnwbEfaa8JVqJy2z2d3JK4UVaJwzP
	 fN6GUdlNB1fByPHHmPthAig5T6GRbZWRPlmTSNsAq7LaHoYvUoCb78XnPOh+6eOL+0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403814;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=F5TTd5Iiwh5j7lSxj42pjzub+W+SZ23Dblb5ymM1U3k=;
	b=Do47T6R+oN3IRHPik7SgTQcjPShHDNHjX+ZBHkHV4m0y2VnW1quS2x9fuCFLC6jQeZkF
	 I4A8U8rJtTiil5FbPAINPVx9okEIibHqmZoL9qEjBAO3uEcN8SKfmj5kjfKpfx2g5eC66
	 i2XcpVVf7thR9DFjB417uUIJpsqwWR+r8c/grHAfHIZkbBfS0+itqGBZpsumU49/0gtd9
	 l9v1RV0NapmHClNljplk619Qr89rvxbbxHjUp3tN1zbtTMBX3USFV7KtNRZzUVO0WtP+q
	 sfoWcmMbJILKQ1YDRZDKfxI9fWpw9Doh+0FdMe7shPQvnxCViV7mYW4eD9/vVNdW6YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DMy/yMWd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E02606A31C
	for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DMy/yMWd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAFD1F00A05;
	Wed, 11 Nov 2026 13:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794403814;
	bh=F5TTd5Iiwh5j7lSxj42pjzub+W+SZ23Dblb5ymM1U3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DMy/yMWdyebX2iDv8xy+lJsN/jr/Ww8mUiQXGahEJsQWFR55k2tofC7Y3oWAAW4v7
	 yDu8NqbCM7VSdZfzBKguQaLaYLMXzjUFOpb6Omfs+Uyu1YLnsENyIQKEsbJBcPxVif
	 hWisj9W/TXk6IURR3B3Ys7OB13/nhbGyw/uTHZ+4whEHL3UYbYjeNTcX/FCD41ovak
	 A6r5D7tpJsPANQ4JJqHFBtjPymTlYaTI6Q4bQqdq6NnmdRqL1gZDIcUKCdn36eqYmo
	 qz9poHoToKSH49rXBT5upLELOtfSwGT9fQRjMVmXgqQGUkOdLJrv097e+af/LhrZWR
	 1Am/n5uYXA4Rg==
Message-ID: <sashiko-outbox-209074@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] serial: max310x: Request the line transceiver per
 port
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261111-serial-transceiver-supply-v1-5-40bad0f912f2@vaisala.com>
References: <20261111-serial-transceiver-supply-v1-0-40bad0f912f2@vaisala.com>
 <20261111-serial-transceiver-supply-v1-5-40bad0f912f2@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 13:30:13 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Serial core requests the transceiver GPIO through the port's device
> when the port is added, which for this driver is the chip: the
> per-port "serial@N" subnodes, where the transceiver of a multi-channel
> part is described, are out of its reach. Request it the way the RS485
> properties are requested, while the device's firmware node is
> temporarily retargeted at the subnode, so each channel gets its own.
> Single-channel variants have no subnode; request it from the chip node
> there, so the transceiver is known before uart_add_one_port() for
> every variant.
>=20
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-serial-tra=
nsceiver-supply-v1-0-40bad0f912f2@vaisala.com?part=3D5

