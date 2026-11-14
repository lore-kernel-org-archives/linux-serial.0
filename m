Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794698370;
	b=fXETVJC0zNCoRE7PmXVn8gswSNPUImqsjPDl/fo9ghmSIYOoJnTmTF6pay8x/RVg1gdB
	 SrIRqkIRTJBqW9lD/Y+vjrqLG/vwZOkh8q6F3QX4/+cxiawoyEc9nyImmm05miQRMwOVo
	 mdyrTIy0HK7c2q8OVJYBt7lnR291EPaP/T4RQZ3PQ8aQ/2MfhZ88PlNi1g67hiEbArmRQ
	 QvzS7vB2t56l2sUFF+tddc16zSBXYn3PwP0f9TeDzWTi7r24p12PBElSh7KB6wepzsOfJ
	 Pvb2tzcAcVS72dCZF5/5QU50GtWBDZSckVokJjdA9JRcc9TpK2e9DsVRlHOTQEpYhZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794698370;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DtiJ4tUetvvkVw/s3l29998t2LFQA1Se9SbpNdtHBLk=;
	b=vVVerozM/0dx2K5UM/jG7twmVBZQRPqfnasXGNVNu67Sk2GsYQNrmWGz8yHq2b/oCXei
	 xdlY1CXpGeoSahZcgqJjM3xszc+XQWgEJvnsfOJ+LqEgJ9sSEprKmuhjbRur59x3C9Y3T
	 9vvCbb99w5H6TDu4+oJfCmmOFJXk+AR3o/NJDlGzOE+QlNC40L0xnA1AkS+2uVqRj6vgw
	 MdlnOj/pJx1jc+eu0NV1TuijEjRZyQVVfszcn46qJqeafXIIoSXR/ebdv8IlypejBxGbW
	 XP29trhlThloMiQrHa4ze3ymWset/7rT7sGF1nf0Adeu6lb9wclw2Bt/ucXWK7FnISQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dyRVbvC6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D38606A323
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dyRVbvC6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF9E1F000C4;
	Sat, 14 Nov 2026 23:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794698369;
	bh=DtiJ4tUetvvkVw/s3l29998t2LFQA1Se9SbpNdtHBLk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dyRVbvC66vfTWnvZQaKnt2COIVzG0cccXAepDVJI2RrzSb2UrkSYP+xVZQLaj2mMN
	 73T/E0o/jn7k1fzte2rz9V92mddYGsyxJUeE+WU8Lbil8qLQCG49suCEY6uZC6tP1O
	 p5pQLFzTY8roS0yFAazTasJkCiN8Npq0IjGcGI7ssjjrgKioj8g7EG7PrD1Dt2c95c
	 Q3tt7euusRNIRmW/c32FwUPt9mAIpYVU2m+hWHjuXoNafvleVsvFZLAuFst+8vHo0R
	 KegGQEfooMGahDpVSIhv9QWmHIMmDW/8gACXD8JAYFnh/9GS5lugHUNmGDh+mRAcWb
	 hujCr9iskh+Kw==
Message-ID: <sashiko-outbox-215098@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/16] HID: ft260: uart: enable flow control
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261114230800.1344401-8-michael.zaidman@gmail.com>
References: <20261114230800.1344401-1-michael.zaidman@gmail.com>
 <20261114230800.1344401-8-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 23:19:29 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The FT260 is a full-speed USB device. Interrupt transfers poll at 1 ms
> with a 64-byte max packet size, so the theoretical UART payload ceiling
> is about 60 kB/s (~600 kbaud in 8N1). The chip advertises baud rates
> above 1M and small transfers can work there, but large transfers are not
> reliable above 460800 baud without flow control.
>=20
> Stop forcing FT260_UART_CFG_FLOW_CTRL_NONE after termios setup. Honor
> CRTSCTS (RTS/CTS) and IXON/IXOFF (XON/XOFF) when configuring the UART.
>=20
> Tested at 1500000 baud both directions against an FT2232H with XON/XOFF
> and with RTS/CTS (~2.9 MB transfers, no data corruption).
>=20
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114230800.1344=
401-1-michael.zaidman@gmail.com?part=3D7

