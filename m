Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792441584;
	b=yOI4Odh/7ln9he4aSmyFK9xnzHKFYLV1Y3Bvfzl6PPOqk2B6YgnJtO2Kb2P65RtD+ktA
	 R9rlPUmXQTx0vAbSDTlFrpzAzP7RdGkvf5yDOPR9YqwGnnZXlj+YX4GfrLXmk7nvbyW51
	 +n8/ZqyD2Zrkey00FMEYXDkQOBEDlJP5PYWa9qps5cJmniHASD1k4u6xyheM6m/E98XyK
	 WfXYHkU4Np/qTHxpuEPAkqPDkmWdug8xb3MGuu+sLAAawzZCo5w0yBeA3i1R8g+VNldfN
	 KBKwUxPIx9BgoVuXGbKDD7/tddbWfsK5veJjwXU07FOrs3wqz1Q+jMoTfTmhCGYbhgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792441584;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pWc+eHnhxqikpjTSUtzTpLmIuW7+z++MKij+gttnLWs=;
	b=kb5+DFTA1X6zVdao499IoQI+SeNSVyjfgxj1vCnRGGd2DWf2iTRkIvqrLkv4j0/N2wEd
	 ApW0uQhutyuP9+eFxJ/MzeNO+9GJlDlUbGRP6A+b0o4vIWFtG+6q/nEfitPIBFloLsUTA
	 L94iQsghLS57np1trXm/lOml3D1/Ct6fITp+svpeNjK66WtNBSpjlpKHycTf9pgbcuHuM
	 BOy8l+vEgv6tLFsNPLNcsVvPVfWiDFsTnspmQvRkO6HT5+H7jHTy4pgm6Q7RPxTzKu4H0
	 Ia538Uz81nb+dF43HrLzVzSl9XB5/7pH0j3fIrjO9xCaCg2YYTY4dCWcd7PUrMyHh8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AwRoPw57;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A2A606A323
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AwRoPw57
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1E51F000C4;
	Mon, 19 Oct 2026 20:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792441584;
	bh=pWc+eHnhxqikpjTSUtzTpLmIuW7+z++MKij+gttnLWs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=AwRoPw5718RcpaQyaRcR3H+WVNQmSs9RER9H+aHjpBppp2glyoTxf9fUZNcKJiU0j
	 O3nWURIbkvRHJL1sHONofhi6PQvFeR4As/FtNVa/cvOb0glAh2YhpDlu4z0Z+5zfCu
	 Iosm4pVNfuKrEXYPrhsTP6uluOxlpmVJP5bCRIUfcUSdEvP8hQFfCN92ARYrAUYzhd
	 HDbdHscyLRRPH8eI5nIbaGYB6y6uOOdHaBR6AoPUYN1nBdA3bCiofTuUN9gWjgrJF1
	 fa5HyEXJD1N4tgi+5iMNSsNIxU2Y5iS1qNKIg8GTL0bKmTnP6vlhsB/J1e5zIEfMsA
	 g5W8bbKjFshng==
Message-ID: <sashiko-outbox-178171@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] serial: 8250_dw: Keep the BUSY-safe divisor hook
 when DLF is present
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vinicius Pedrosa" <vinicius.eduardo.pedrosa@gmail.com>, linux-serial@vger.kernel.org
In-Reply-To: <cc358c2be6b0b4ea0323e4f694a581ffb667112d.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
 <cc358c2be6b0b4ea0323e4f694a581ffb667112d.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 20:26:23 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> dw8250_probe() installs dw8250_set_divisor(), which brackets the
> DLAB/DLL/DLH sequence with dw8250_idle_enter() and dw8250_idle_exit()
> so a BUSY UART cannot drop the divisor LCR write.
>=20
> dw8250_setup_port() runs afterwards and replaces that hook with the
> dwlib divisor hook whenever it detects DLF. The dwlib hook programs the
> divisor through serial8250_do_set_divisor() without entering idle,
> leaving the LCR|DLAB write exposed to BUSY.
>=20
> When termios changes while the UART is transmitting, that LCR|DLAB
> write can be ignored and dw8250_check_lcr() retries it between
> dw8250_idle_enter() and dw8250_idle_exit(). dw8250_idle_exit() then
> restores IER while DLAB is still set, so the value lands in DLH. The
> real IER stays at the zero written by dw8250_idle_enter(), and the port
> gets no further TX or RX interrupts while up->ier says they're enabled.
>=20
> Do not replace a divisor hook the driver has already installed. Program
> DLF from the BUSY-safe hook, inside the idle section, through a dwlib
> helper that checks dlf_size.
>=20
> Observed on an Allwinner A733 (Radxa Cubie A7Z), where
> dw8250_setup_port() mistakes the RS485 control register for DLF (see the
> next patch): the first interactive tcsetattr() during console output
> left hardware IER at 0 and up->ier at 0x07. The shell never printed its
> prompt or read input. With this change alone the same boot reached the
> prompt and echoed input, and hardware IER matched up->ier afterwards.
>=20
> Fixes: a7b9ce39fbe4 ("serial: 8250_dw: Ensure BUSY is deasserted")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792439398.gi=
t.vinicius.eduardo.pedrosa@gmail.com?part=3D1

