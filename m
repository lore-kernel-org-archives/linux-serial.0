Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A803248F826
	for <linux-serial@vger.kernel.org>; Mon,  5 Oct 2026 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207574; cv=none; b=mBdwZ3J+PCb+77EF6Bl+BDynVw+VNRRn7mkCZ4oili5TmDR4udLWAzu3rLu+2kbEucW0y8XYgxImhESctheYuV1lWPrYzYmqO3nxkM+sHLA/uauCUTg0ewr9AV3spv3mBOUO0QE838iebQ+cn+apD/h1WxN1MQYp35EOqVepn0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207574; c=relaxed/simple;
	bh=USpi9IxLZSfoYfsR7YoPT5qji1hKnNwWlpXM6lohbwk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JlmYnuxe37jhV4dWS0VNgwsxYM72+vnbgWtDeHCoUhgYc84ZIba5KwDa3QsCmmiITSxa3IbqzrfOBIiKuWXh5uKlnGmrkVNmK9ADp0eAEoNvOFVuLu6n/hd+Kb1odck+LGsfIl01758Nq3W3+gp8Nniem0Z0PcsaDTv3kqVbMbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PII/OzUG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PII/OzUG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A1A1F000FF;
	Mon,  5 Oct 2026 13:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791207572;
	bh=USpi9IxLZSfoYfsR7YoPT5qji1hKnNwWlpXM6lohbwk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PII/OzUGHJpv0VaEk9h/lorlueJZfmDqIKr1awFvscCnjMxTb1Gv7O7CYYHMFqG91
	 HHJong3w0W6YZo75gYR6dt0OQzUYKVQrs1403SJnxQSAHo6Xo8vWxZqVvxsHeZ82KT
	 4Ud9AJhKWp2Go9mkUtsQbucwA+tOTVBW5asSykxftYy2FIvuy3eP3auOUQWjPJJE0T
	 S63SZKyfKYDYShwVw7tIiE3esq7Us34l3qozkbDePfMGVv+2BL4zmVgR//80If6rUS
	 D6oAd2SnDPaEvdPZp94zbOhr1BBlc8DCeqMmIRUlXTpG+JtYVmRUwwJYnr1fARDKOh
	 7v4vq+HJqO4JQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/9] serial: max310x: assert the transceiver during a
 break
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261005-max310x-rs485-sw-delay-v7-2-6ae392eca08c@vaisala.com>
References: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
 <20261005-max310x-rs485-sw-delay-v7-2-6ae392eca08c@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 13:39:31 +0000
Message-Id: <20261005133932.00A1A1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-max310x-rs=
485-sw-delay-v7-0-6ae392eca08c@vaisala.com?part=3D2

