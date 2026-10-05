Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB5148640A
	for <linux-serial@vger.kernel.org>; Mon,  5 Oct 2026 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207604; cv=none; b=hXTuTg2aMxaWzmSb+CZJCKbULBiwasYE71ObQ/7GbvfA6y/bPEmpAFwO5xmlE0hyiOVrcqygMzBnMnQTQmwXh4ruh4xX/4nOZxy8OT7sge9uzOYrmO6yk8lkGnVFjsEIdQSw4IzaoRGi6TFiiZYWCA7K/MDSMp0woDD2kBuMU/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207604; c=relaxed/simple;
	bh=hCBUKDYe/BAtWrWlgMNdrjnDYuz57gZSHT1MwaT1Mp0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RrkKzOaRkg2PgAROVrgVu9FPkYbo4pcWWPYVaZR/8mYT9AX972Jd1r7ApAeUCEuHJB9Py0UyyvKW+JmznAHajT0NmqHbCeQDftIEhbInnMBdRc1x531P3sjqPBbdDy0FQO1t9lT8mvQS39GVBRRSraHBQN1QFKLrCbKf7e3EouQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9c0CVH7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9c0CVH7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EB41F000FF;
	Mon,  5 Oct 2026 13:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791207602;
	bh=hCBUKDYe/BAtWrWlgMNdrjnDYuz57gZSHT1MwaT1Mp0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E9c0CVH76x5r68XKaVhg4UTKY+5hy8cDH1FTRC6eeHHopf0lrP2JuNBkWvel8RzSf
	 +S508A/kt0s7O92UE4zjkMyJ9mTX8a08p9PVIF2mN1CFk+OQluaLYhpR6fdXqFlj+e
	 vpK5ixYqAY7DAjsiEut6fFwG9fS0hMcDEGVbIMiPriyvgDzpH9dLUihOnkFQj4L5dt
	 /6Tp9Ekpi4zxm9gEdTQWwPMz3U+24HBIfBvYQzMuYOm5EihqUBDB+7z4MUD+Ao5ezV
	 3qaAmsS+2Ka0+FHSZxZH2KUpYcg4QUzZdFn/aLv1VK+jdnhDpti6NA5EvP/L86sFxi
	 RSsL+l3Q4vFSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 8/9] serial: max310x: drive RTS in software when
 hardware delays are too short
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261005-max310x-rs485-sw-delay-v7-8-6ae392eca08c@vaisala.com>
References: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
 <20261005-max310x-rs485-sw-delay-v7-8-6ae392eca08c@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 13:40:02 +0000
Message-Id: <20261005134002.B5EB41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The chip's auto-RTS path can express at most 15 bit-times of RTS setup
> and hold delay - a fraction of a millisecond at typical baud rates -
> while the uapi expresses the delays in milliseconds up to the UART
> core's RS485_MAX_RTS_DELAY. Requests beyond the field were rejected
> with -ERANGE, which makes the core silently wipe port->rs485 and
> disable RS485; a device tree asking for a 20 ms setup delay ends up
> with no RS485 at all and an unusable bus.
>=20
> Add a software-driven RTS path that takes over whenever the hardware
> cannot represent the requested timing, and clamp the delays to
> RS485_MAX_RTS_DELAY instead of rejecting them.
>=20
> max310x_set_rts_ctl_params() picks the path: software if either delay
> exceeds what 15 bit-times encode at the current baud rate, or if the
> requested RTS polarity combination cannot be produced by the auto-RTS
> [ ... ]
> there.
>=20
> Fixes: 55367c620aed ("serial: max310x: Add support for RS-485 mode")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-max310x-rs=
485-sw-delay-v7-0-6ae392eca08c@vaisala.com?part=3D8

