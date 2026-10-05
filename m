Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A34F2AD35
	for <linux-serial@vger.kernel.org>; Mon,  5 Oct 2026 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207256; cv=none; b=UFXM1GjuvCVUGySMajPVR46U1sMnhl4cpwnbEIVSooOr14fy45d25rQ7x8nBzDn7goQoohRslpZ4beyPasnk7XjeL8VfLjZ8hgRVYiTUBY6GEtMJjv1/KsqOzGH+nbZxhYyas9fRc8de5ThMcMxV7nd4NZdQBo5kmPe8IPVv6Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207256; c=relaxed/simple;
	bh=r+Wxe1HgecqmWJ6QSEUzTBZMpmwmm2Wmkow5p+3Aa+g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=beKedEjmK/LsxJGT026Vm05TM1jZWchAaTFlTfAf9aycpmhClAZzPoK4dZahKbPRdw8jTFc9+jc9+Qkq0DiT5vKTRIz2cI0gItZdSw0m08OxDvs0Brv8HLebGLuy9BSSQxI7yuzhHFAa+LDhcfoo0RgJZ1mil1oLv6epCErfY+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aU9KyP1Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aU9KyP1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11641F000FF;
	Mon,  5 Oct 2026 13:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791207255;
	bh=r+Wxe1HgecqmWJ6QSEUzTBZMpmwmm2Wmkow5p+3Aa+g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aU9KyP1Q+q2xh1RZov3Y3QEEX7awHLeC6LbysVGKzPqI4bCIDA27/i+jt7a73h8RB
	 Y/g1px8r8QO+AXx6azCAoKpYEfALAfF+LBf78lAdh5m9os7bRG+s4p/nhN8N8+E8ZU
	 lVjrFa5/demJxHKvKzaT+I8j8LzMEKpBWYbIj4W1t/CQ3IIdS55USVSQwY36raS0XW
	 FIGzEbumuuJRnREnorJIFQs2s0Va8/MH1qud3RKGaSJxhJjpxGRCU/Ccdt92bvHZPr
	 1RqS/T7z4MP/Gn+SX3mPNRbGxobCDNCtHp+Z515qRUINShgiiE3Vct1kMBSwijTDuP
	 FOtJKMr1vzC2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/9] serial: max310x: support active-low RTS on the
 hardware path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261005-max310x-rs485-sw-delay-v7-6-6ae392eca08c@vaisala.com>
References: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
 <20261005-max310x-rs485-sw-delay-v7-6-6ae392eca08c@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 13:34:14 +0000
Message-Id: <20261005133414.E11641F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The chip's auto-RTS engine asserts the RTS_ pin high while data is
> shifting out, so a transceiver with an active-low driver-enable could
> not use the hardware RS485 path at all: SER_RS485_RTS_AFTER_SEND is
> not in the supported flags and the core normalizes it away with
> "invalid RTS setting, using RTS_ON_SEND instead".
>=20
> The output stage is invertible: program IRDA.RTSINVERT when the
> requested polarity is active-low and advertise SER_RS485_RTS_AFTER_SEND
> in rs485_supported. A break already drives break_state onto the RTS
> bit unadjusted, which remains correct because RTSINVERT inverts the
> output stage itself, not the register value.
>=20
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-max310x-rs=
485-sw-delay-v7-0-6ae392eca08c@vaisala.com?part=3D6

