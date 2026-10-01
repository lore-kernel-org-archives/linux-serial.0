Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDD844F546
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 06:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790836032; cv=none; b=Eewi8N38J1sztpa7BT4Fsa1u3wLZngPHBeOPSTzvNSVZ8+WWZzpK30os9hVOf2nnB54KUOGTBHFphPrJb/k9NMwAMWReG0iPwnXgIlwYhrFzD++py/vtMudWbwlPTEbPPjljHVHcx6M9miCFmE1ygLEb/M/Ck+4bcv/hIoL1t3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790836032; c=relaxed/simple;
	bh=YOfOLaEKGlGQcuzn9ksy53v+A5bZ6lcgbEtiK8BbdLU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vr0eL06lLfcLikl3N3fF+ISf23qsb8gZKlDeK3ZoyVNr4RVNJopmz0GoIoTwwMjkFoQP3kCofXbxZYBWyvyA2YISlIYA2yWOm256YR1BejfSBBL8JyVl1m/kOc6fOVgP0He9WavB6OocTubr/97Lvm2wAtY57Bfv3XJ7+UND0pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHqxH2Mm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHqxH2Mm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7DF1F000FF;
	Thu,  1 Oct 2026 06:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790836031;
	bh=RT5QTywxEI8osqMjUKfqdlh+WFPPs8FQjOUndTk8YII=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EHqxH2MmHTJbfhIJjp7wLhV+DqbUdx/9oN8/o45r7cunRjTwOzP/oh/KKr+fhwgoB
	 XVMqBbrZEwEoJ+gZRflKQeMlfJ8fmtCGaRoofDHtAUhCpGBKSOm8+o2LnWSHHPQ/Gr
	 CB8k5E/VfKQAu2LvtclQdtSttYSZV5WH6n9x9xvWCWeoY0yYWIGIWa2IRBxkgzkjLk
	 jesf9xgT1xytQIZT45v9PdLgBkPxEzurGT0I967lKdJ6FD2D7LEZ1Y9VGCqQ4lL2Ll
	 impE/c4xvFWWFTco1r5jV3frEr9/6xl/6QI0FqdeoNE1161dnIqX0sVcnzICvur6SC
	 88wtcUiSgUr0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: tegra: don't clear the Tx FIFO on an Rx-only
 reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Gassner" <simon.gassner@noxsystems.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261001060539.32659-1-simon.gassner@noxsystems.com>
References: <20261001060539.32659-1-simon.gassner@noxsystems.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 06:27:10 +0000
Message-Id: <20261001062710.CB7DF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> tegra_uart_fifo_reset() applies the Tegra30 workaround for
> "cannot clear the Tx FIFO while FIFO mode is enabled"
> unconditionally: it leaves FIFO mode, writes the requested FCR
> clear bits, and re-enters FIFO mode. Leaving FIFO mode empties
> both FIFOs, so an Rx-only reset discards queued Tx data as well.
>=20
> The break handler in tegra_uart_decode_rx_error() calls it with
> UART_FCR_CLEAR_RCVR only. On a half-duplex RS485 board whose Rx
> line is pulled low while the transceiver drives the bus, every
> transmission raises a spurious break, and all but the first
> character of the frame is lost.
>=20
> Only take the FIFO-mode path when the caller actually asked for
> CLEAR_XMIT. Likewise only wait for TEMT in that case: with the Tx
> FIFO deliberately left intact, that loop would otherwise spin for
> a full frame time in hard IRQ context with the port lock held.
>=20
> Tested on a Colibri T30 (Tegra30) with Rx DMA:
>=20
>  - Break during transmission: the reset still fires from
>    tegra_uart_decode_rx_error(), and the complete frame now
>    reaches the peer. Before this change only the character in
>    the shift register was sent.
>  - Internal loopback with a generated break: the Rx FIFO is
>    correctly cleared by the plain FCR write, and subsequent
>    receive works with no frame, parity or overrun errors.
>=20
> Fixes: e9ea096dd225 ("serial: tegra: add serial driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Simon Gassner <simon.gassner@noxsystems.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001060539.3265=
9-1-simon.gassner@noxsystems.com?part=3D1

