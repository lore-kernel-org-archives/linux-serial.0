Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584605;
	b=ETK5DqQxct+DwbnLCwaeGEXZn9Mfx9b3PdOPGIxd0JrXWpqo7WNqSEpVsZfy17Tq8jlq
	 kPlYy6zq59s+0IAqaLSunX7XMNaPKCpUY6UoEj93tXEqlOrXsV7SYPr5EW7/KYeUfX9M2
	 99oAod4SmUJbNA6loY4opSSMoaxoyQlUKrklbVOGpxyXhKTk0D3EbVtHHbGtUSw6QK5zg
	 Qv9SRcafLhTv/Wv14RXiBcJ5EOUX4/yx3RRZYWNPAqVFLBqMjUIZvIq39RqNMH+EBB1ne
	 MzLpxuvgNmdxNhcVcc5X8UZOkZlSXT/El0vrzJVk2NG1fOWQTTmUWK42dBTHh0DV5MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584605;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aYiLCy1vy02akCaPg7UzvSOavmvcpqfYV0QYf2DHuWo=;
	b=SDPvipY65mpx7STGhh2BNFAWOCVcs/umWrilisnfJj7DPkrcuXGguUN/zKXghguWaO3G
	 FtNF8MJ7zh3mw8mPMGBP5fYiUDuNsIOfjlGw0xe+fAyeKWpWLYoS3j+rxr1Jo19hZDYc1
	 3NkTFvLJGuLgQH3PKzNqhQZwLp/rGw/vXe9aq/yGa90RXM1psbYjnY1DOdT0dy8cJDGoQ
	 bV44Gnd+O5Dw5QdvuLorc2tI+2WJBK6qn8s5/QJrxgvlSHEJi/s9RXy6OFLhercYwYs+P
	 oFAguqP1uX1j0JAfSv8ag5ZZ8ER8xmFTbPAUFIxf7TvsPsw6q/4YE12BIlzEIsfCvRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ThZXIFGb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D92606A31A
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ThZXIFGb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAAB1F000C4;
	Wed, 21 Oct 2026 12:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792584604;
	bh=aYiLCy1vy02akCaPg7UzvSOavmvcpqfYV0QYf2DHuWo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ThZXIFGbS9A5HirxhOzVbE1mZdzQbKrs2zZDlNVtxVghIDy6m5s2D3qJFAyDl8Glu
	 zpdwxC1+D7mKe1FigSsCLfTb8/a1oqnA7959vNxWr9rn1ZWHmk4EqK+/zXiGrAFI3Y
	 crtb7BV2PXiKAua9ATnAMDuquFNlbOBd1Km+dxiSY7UUYTp8fdgDMBSjEAJw8uAzgS
	 EofoeEcD+X3rMFZof7TAgPonBXqiPxOHk/cUjj8TuisRqcZD3TAJEjqUfTfWYIesdY
	 3XGwK96A70wwnaJqg7yCZrkmWE772wYjUvKMrjxlZ3Tnp7xs0P5fPMWu+bDoilfFkn
	 Bxi/wkL/EohUg==
Message-ID: <sashiko-outbox-180209@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] serial: amba-pl011: finish a transmission still
 running when RS485 is enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261021-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-1-ed10e219159a@tipi-net.de>
References: <20261021-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-0-ed10e219159a@tipi-net.de>
 <20261021-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-1-ed10e219159a@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 12:10:04 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Disabling RS485 during a transmission keeps it running. If RS485 is
> enabled again before it ends, the state is OFF while data is still going
> out. The TX path does not end a transmission in state OFF, so nothing
> sets the idle RTS level afterwards and the transceiver keeps driving the
> bus.
>=20
> Hand such a transmission back to RS485 when it is enabled on an open
> port. While PIO or DMA still feeds the FIFO, assert RTS and mark it as
> sending, so that the TX path ends it like any other. With only the FIFO
> left, drain it from trigger_stop_tx instead. Data that is queued but not
> started yet, for example while output is stopped, is not part of the
> transmission.
>=20
> Fixes: 97f85204275a ("serial: amba-pl011: keep transmitter enabled when d=
isabling RS485")
> Cc: stable@vger.kernel.org # 6.18.x: 1b6d660e038b: serial: amba-pl011: dr=
ive the bus during break in RS485 mode
> Cc: stable@vger.kernel.org # 6.18.x
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-devel-nbuc=
hwitz-pl011-rs485-reconfig-stall-v4-0-ed10e219159a@tipi-net.de?part=3D1

