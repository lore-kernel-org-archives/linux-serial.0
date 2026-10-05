Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237A84DA9A0;
	Mon,  5 Oct 2026 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791221653; cv=none; b=lu5zedtQGbPBj7Jpi2wqgSNOXqviA1H/kcmrc5prMVbYLti0ZUARoP1IBlSvQvp2XgKwIpR/IXAR+Q2JjRH8gqA/7Sil72kU7p/552BX8igCpllKXr71yHgilqClk8O7MfroCdcO9L1mbLKccHGug4zsRAGVNwI8FsTMiU6xMy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791221653; c=relaxed/simple;
	bh=NhqrkiSA02ITxm2xbuelRY8j0rmrvR6e0kC7iHqyrZQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PDno2S6Od1aMqc7q4Rrgz0DlYBCcDjNva9fqco9eIfPnAaqtWSsFcWuVuLJKzSZdI2lmEUTkwauC1vIqruOZV9B3UItexeSGbg1a/wrKUt2Jr4bbKGxMAf7b20YNE47eZEMVB8Wn02lqgDSVaqQzp5dQQVGSHfpsYIMmhd7TQlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjX1PLwe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjX1PLwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4D11F000FF;
	Mon,  5 Oct 2026 17:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791221651;
	bh=NhqrkiSA02ITxm2xbuelRY8j0rmrvR6e0kC7iHqyrZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VjX1PLwe/qS8Z3PUvMjLvZ7DM3tQ09LVvX4M0BxCoOi1hUajcLE/s2+TolRx5oOx1
	 vy0EPMftpPtGSdqHzr9h8+McV5Ec29U2kYIc9HqoTLfDvDecjNGYAj/gxxcWpqICm9
	 4JNPyrmT/V0o25/n+RTszkLqIKhnyvIFH5RBt9znEfUYWp1fBPY5PZ4YaMRJXPqgAP
	 +n/0XbgwDutck/Bm51k2gBGRjw1M6oSIydzjAC5Z7JZs+vljsm1Q+JfCsXh3dRAwUP
	 On0BJ7d1/bSBCM5YZj7OwWv6AhUgm8aKozk41DdVWIy2qtl5VT6CVzwchOhfii5y2q
	 28tnzjjpflLbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] serial: 8250_dw: Keep the BUSY-safe divisor hook
 when DLF is present
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vinicius Pedrosa" <vinicius.eduardo.pedrosa@gmail.com>
Cc: linux-sunxi@lists.linux.dev, robh@kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20261005172538.398522-2-vinicius.eduardo.pedrosa@gmail.com>
References: <20261005172538.398522-1-vinicius.eduardo.pedrosa@gmail.com>
 <20261005172538.398522-2-vinicius.eduardo.pedrosa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 17:34:11 +0000
Message-Id: <20261005173411.9A4D11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> dw8250_probe() installs dw8250_set_divisor(), which brackets the
> DLAB/DLL/DLH sequence with dw8250_idle_enter()/dw8250_idle_exit() so that
> a BUSY UART cannot drop the divisor LCR write. dw8250_setup_port() runs
> afterwards and replaces that hook with the dwlib one whenever it detects
> a DLF register. The dwlib hook programs the divisor through
> serial8250_do_set_divisor() without entering idle.
>=20
> When termios changes while the UART is transmitting, the LCR|DLAB write
> is ignored and dw8250_check_lcr() retries it between
> dw8250_idle_enter() and dw8250_idle_exit(). dw8250_idle_exit() restores
> IER while DLAB is still set, so the value lands in DLH. The real IER
> keeps the zero written by dw8250_idle_enter(), and the port gets no
> further TX or RX interrupts while up->ier says they're enabled.
>=20
> Program DLF from dw8250_set_divisor() inside the idle section and keep
> that hook after dw8250_setup_port().
>=20
> Observed on an Allwinner A733 (Radxa Cubie A7Z): the first interactive
> tcsetattr() during console output left hardware IER at 0 and up->ier at
> 0x07. The shell never printed its prompt or read input. With this change
> alone the same boot reached the prompt and echoed input, and hardware
> IER matched up->ier afterwards.
>=20
> Fixes: a7b9ce39fbe4 ("serial: 8250_dw: Ensure BUSY is deasserted")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005172538.3985=
22-1-vinicius.eduardo.pedrosa@gmail.com?part=3D1

