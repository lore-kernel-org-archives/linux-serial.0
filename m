Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792843867;
	b=qIzRktQH/Q9Q3EZM6BiK7pi11xwVmBEJ3JfjfvH9txVYlrn5OwtnhJmLjascdNsV442j
	 uYAKoy5i/qTiAsF+fV6h/8kha9u8uzNsb8BFArzLf6PCDuu5YKo2a48Qx36k4K9jibU6r
	 SVVqVUNzsfBTWYlJsvTRzCPYNaDN1GCBBi0soifdNOEdDtIV6Oe0QyMwCtp98ElHC+Sq2
	 UhxuciiddP5gvqZQCg/VoTouYK3kvm9Fi2jxCvPBOV8U8PEfZIAccNed9Kfv+/5cMIZ31
	 Sj/fby8BGHtb7IwsmhbOC4JAUHVdPMxG75/y7gm0Ogi/9dcrUmU/8XyUCtzQDdxzgEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792843867;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=k9pufUDwGPhpSWQnakqCkkdFQxUrbEi6N4k/sYx40Gc=;
	b=38A+ajMaKrMnqgsYu7UY2EYXgCWebMXVY5wT5FoJwunaMYF2tmxJNOwOIIrwilpMIp+x
	 gHILqjgnYxfv/4//ZrRSCnNkSYAWH0QQFFaspxfSPVljsQqrPDnn+BEbxWKNIS2sCL/az
	 ugwU1H6mwbyAuUQhc/BB7XdlIK5fDshp8djONQSgGR+UN2PbosyXMgt6Jp956y6cKfknR
	 Lm5S6ZjSZQ0Ki5Z7n8pE13Nfdheg7X9Nb6lNuVWsmkb9V7Uq6bqnjgd/YEI2lsFCTeh+J
	 fHUjny6s+HZVA4WxpvtTuZ4Ac9CLvGGX6k68wyfQPNXa812o4nJT2BeH80TRG3pqurw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DsIdy8hV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AC0606A31B
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 12:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DsIdy8hV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC951F01825;
	Sat, 24 Oct 2026 12:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792843867;
	bh=k9pufUDwGPhpSWQnakqCkkdFQxUrbEi6N4k/sYx40Gc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DsIdy8hV6IxUOXBLEwdwDjsJVwdaS4/ReszhFOhYjmJn6CVktnWby596CffVNC5k/
	 bZ46JT/viK8ox0wO25nEnH4gIAr2IzmJ+s6/eTDYBl6kI4pzMwMKNS9MBGIlDqI6qQ
	 OSvXUfZTUwyrcIJZhXJ/Pr/S8AQh9PWi2R8XqmujBtAzv4yMbdwmAU6pBYYLmM5m75
	 TmXYisfsV9YwJIiNoK+DVuRcjS9Gzcuq3W+A6QyjN2lBdnGu+QPeN3aSfZThvO7PCu
	 0X17AM1ZBZ8Jv3R9wZvKzbxauUzI4odkh2E1ZhdJTQDmltThsvrQwpqIbfjugysEv7
	 D1wQX+vhtIVqQ==
Message-ID: <sashiko-outbox-183704@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] platform/x86: dell-uart-backlight: Bind through
 normal serdev matching
Reply-To: sashiko-reviews@lists.linux.dev
To: "ChunAn Wu" <an.wu@canonical.com>, linux-serial@vger.kernel.org
In-Reply-To: <4ac249174a529766e8fd69c39fc08dfa1572a650.1792831564.git.an.wu@canonical.com>
References: <cover.1792831564.git.an.wu@canonical.com>
 <4ac249174a529766e8fd69c39fc08dfa1572a650.1792831564.git.an.wu@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 12:11:06 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The driver creates a serdev client without firmware metadata and
> force-attaches its driver to it.
>=20
> Pass the modalias to serdev_device_add() and give the serdev driver a
> matching id_table, so that the serdev core binds the two through normal
> matching, then drop the manual attachment.
>=20
> The client now also reports a "serial:dell_uart_backlight" modalias to
> userspace instead of failing with -ENODEV. A failing serdev probe no
> longer propagates out of the platform probe; as for any other bus, the
> client is simply left unbound.
>=20
> Signed-off-by: ChunAn Wu <an.wu@canonical.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792831564.gi=
t.an.wu@canonical.com?part=3D2

