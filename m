Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77808490BFE
	for <linux-serial@vger.kernel.org>; Thu,  8 Oct 2026 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453768; cv=none; b=beNWdPARpdQSSXeE023QtQsHyKCY0CRsHTLg0KbpyxlH8HNX3k7i7CpODKkf3t5dJejSxGh7s4n1BlWJBMiBrzzsSGqlHW1nQb8gU3nEitu3vjozYai5PaK2EpPzkmNRywLrIPEA9W4ugmQepGYLz0KBw+a188NqbT2C/SZ4JLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453768; c=relaxed/simple;
	bh=gqkf04PnDzWfbmQXmJ3MIHhtFgLlSop40SKfWIH/F5k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=aP/oxPvDDWXwjZuQg6B7d/aBB78FNzdV4YFr8R1v+l7gf+iGNwBaxbbOKd80kEER6/dd9/f0udEXRwTfFnNI2DZNPxiBNyjg33ahR8q90WGHH5l2P1uO8mZr4m0oKLGPH3OVDqa1/wHKx5YkJaqFTtqN7eMrRfl8qrhn0U4G+ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOBWGpdM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOBWGpdM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1006E1F000FF;
	Thu,  8 Oct 2026 10:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791453765;
	bh=gqkf04PnDzWfbmQXmJ3MIHhtFgLlSop40SKfWIH/F5k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jOBWGpdMSAtf/wzx19B7PSQ86t13UsUnT4R91LZqoDPd8IQNckJu/3FWXjFcIGTwu
	 korJidN7d2HE69yfPxmMuAS+S/9rKy+/faQJlc4ts+Iu8+Y+/RbA8VwPWPR8MCIIbF
	 uhfUUAuk1rP6cY7VdMfgSToCJWnGytkvoaXNx4ZdzQMpXIw7dm4X/I1q1EIgrFNoBm
	 FeFdBM+/6F58IgMs4QPLXm9qgOCmwVrMVcXz1trclvpu6MQm9dgQbrw1Ji4db95jXa
	 nGXxiMfCgrD7J+/ko4UAV9gp0yY9ArnZW73d+kNtUD1mbTnmReOQzyYhSz6Ym8nkLX
	 YD46JhpD3MJzA==
Message-ID: <sashiko-outbox-163979@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/9] serial: max310x: fix breaks not reaching the
 wire in RS485 mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261008-max310x-rs485-sw-delay-v8-2-6ba881f81e1f@vaisala.com>
References: <20261008-max310x-rs485-sw-delay-v8-0-6ba881f81e1f@vaisala.com>
 <20261008-max310x-rs485-sw-delay-v8-2-6ba881f81e1f@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 10:02:44 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The chip's auto-RTS (MODE1.TRNSCVCTRL) asserts the RS485 transceiver
> only while FIFO data is shifting out, and a break is not FIFO data: on
> an RS485 port a requested break sets the TX break bit but the
> transceiver is never enabled, so the break never reaches the wire.
> Break-led protocols cannot work at all.
>=20
> Disable auto-RTS for the break duration and drive RTS manually via the
> LCR RTS bit, then restore auto-RTS when the break ends. Track the break
> in tx_break and leave MODE1 alone in the rs485-config worker while it
> is set - a TIOCSRS485 arriving mid-break would otherwise re-enable
> auto-RTS on top of the manual RTS and release the transceiver before
> the break ends; break_ctl() restores auto-RTS from the then-current
> configuration when the break completes. The worker runs under
> port->mutex - break_ctl() and set_termios() already do - so the
> tx_break test and the MODE1 write cannot straddle a break starting or
> ending, and startup() clears tx_break alongside the latched TXBREAK
> bit, since a port can be closed with a break still asserted.
>=20
> Only the break assertion is gated on RS485 being enabled; the restore
> at break end runs unconditionally and derives MODE1 from the current
> configuration. Returning early for a port whose RS485 was disabled
> mid-break - that reconfigure is deferred like any other - would leak
> the manually driven RTS and leave the transceiver holding the bus
> indefinitely after the break ends. On a non-RS485 port the restore is
> a no-op: nothing else writes the LCR RTS bit.
>=20
> Fixes: 55367c620aed ("serial: max310x: Add support for RS-485 mode")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-max310x-rs=
485-sw-delay-v8-0-6ba881f81e1f@vaisala.com?part=3D2

