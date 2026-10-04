Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0963722126C
	for <linux-serial@vger.kernel.org>; Sun,  4 Oct 2026 12:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791117185; cv=none; b=FpdE54m3/SfEPZltvcMV18YreVDPpfEtc/igmdvvoqXRxuKr73xvOOqMjb7FPYfPoHQYLm2TnoTehEaag73blGuSYndDJv5A34U/Y2thWZUFRY5B/cw9i5/AYtyTlOGyMO+kLfFn9unu8dwWko4Z0xdPZaLjBQ30TGnDSVoCnfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791117185; c=relaxed/simple;
	bh=ho8ybZ8fPtjQ63QHM9C8rYjsQ5ZNMNwEhKHmOaKfGx4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QIR4VBvhXMRWJFcBGvpJQgfoASJpISP4wFwb6yGhwIGgHTCplvILhU2e/f2xd1Vmb2kwfZvEk4SSU6ei2esJ77CZSw82bq3AdNUFYArFOKNbxqCcQzzKxYzE0tKDw2EoZWNcfOqQ5W+PjPWFaTXNPq1j/JpGwMg/J0jFx3dXyHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWHpIYWt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWHpIYWt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90CD11F000FF;
	Sun,  4 Oct 2026 12:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791117183;
	bh=ho8ybZ8fPtjQ63QHM9C8rYjsQ5ZNMNwEhKHmOaKfGx4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jWHpIYWtPM6iclUFhZf88xm/52sXDJFVEhi7CKhGrvZMmqsRiHRV1MN4eSu8Xtrmy
	 t3DDNbsU8eSh0h6FOwl89pyZW7imdbR6sJ1Xtm9bj7AAzZQK6Uemg5vi3t39OUHdl2
	 4A1mY7Es48k1w1MWaQfH+9hx/JU75M1jpz1EMeZ7xNTTnawYHX3QsBGJWb/s1ZOWlG
	 5cMLJ9PtAWi3hdnXDR6+QAOvF8kKAOBBv7/EP6GhmBStFLhaMc2O5k+e4Lwor6VtUr
	 Cm5qYcsxNhD46FZTiE/T0KVU7qKO3S5QVXG4tLSavvPrLokHg9ziz57LKsWuCmIQ/Q
	 7aidWKYfqsXSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/9] serial: max310x: assert the transceiver during a
 break
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261004-max310x-rs485-sw-delay-v6-2-3a0ef13ed9e3@vaisala.com>
References: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
 <20261004-max310x-rs485-sw-delay-v6-2-3a0ef13ed9e3@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:33:03 +0000
Message-Id: <20261004123303.90CD11F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004-max310x-rs=
485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com?part=3D2

