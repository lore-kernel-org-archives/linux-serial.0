Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FD63B0AE1
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 06:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791873964; cv=none; b=dzvYvTULKVq7wAVZdWRM4z6rRkPcQAGD+28kLSFy8UYN6grfZpmIoPVJb7xV22Eg4N4E3ORQXOAkk1o8xNpyaDSja3gjsOKDlEe6NHuC5lxyS4qZYg9CyPjLati6C8dfZysYxOX5m4CNUR0jQN/okXl0Vt1flCKPJEhFc70qymk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791873964; c=relaxed/simple;
	bh=vlAlynKnOYJA+Sa+WRhiBwarDdmhQQSLXLVK3qTGpuI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=g+tIUE6//ftnZWecUBYHazrG3zQKciXCP98q4FKXa73UdNU9ixUDxqD8o0+0J31vFnqvlBoMsIztjI5HjhnmIMWyI5A9AIEcOUa2WQTr4MXgiFVpeJQ9mbHUcyRuuNbFUmcCSNtftqZzreFBdyfydX6BDvPUjR/RsI7C//onXB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uhk+ODPf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uhk+ODPf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E66E1F000FF;
	Tue, 13 Oct 2026 06:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791873963;
	bh=vlAlynKnOYJA+Sa+WRhiBwarDdmhQQSLXLVK3qTGpuI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uhk+ODPfEKX7M6zxCM1L6fZQ9hFtUjH4CNPOyQ/IcP9U8cxNI5ojuVmT4w7zXyhrS
	 NNwQ573gjFa2ij1Aa6OtTJfVbW3Tauc26vZlop2+Cqb9QnL3NQG2ydm5ClU9z9SC9M
	 lSSBtOgsQKA8zfY6FxVL1pp8gkMpjs4/3/Mag5PYSuwOqSzd2sTtR23F9P6W0yFNLs
	 utaweBwuyHSJQUZj3XedgGkklHippYoaJHlilbX7k7CtHlSKq/4EO8L+W75SjGD7Rn
	 fU8vHeREw7kYpdjrCsnXAZ09oiy84g8emtqdfKTR7b1c+/cd/1BtkFaRs5IdJEj7XR
	 g0AAw/oh84ybA==
Message-ID: <sashiko-outbox-169128@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/10] ARM: dts: cortina: Add CS7542 SoC and Securifi
 Almond+ board
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261013-b4-cs75xx-v6-8-37e8f3969b7c@gmail.com>
References: <20261013-b4-cs75xx-v6-0-37e8f3969b7c@gmail.com>
 <20261013-b4-cs75xx-v6-8-37e8f3969b7c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 06:46:02 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Add a minimal description of the Cortina Systems CS7542 SoC: the two
> Cortex-A9 cores, SCU, GIC, global timer, private timer and watchdog,
> PL310 L2 cache controller and the four on-chip UARTs.
>=20
> The peripheral clock (APB) runs at 100, 150 or 170 MHz depending on the
> boot strap pins. Until there is a driver for the global control block
> that reads the straps, model it as a fixed clock whose rate is provided
> by the board.
>=20
> The Securifi Almond+ is a touchscreen Wi-Fi router with 512 MiB of DDR3,
> 512 MiB of NAND flash, a QCA8337 switch, QCA9880 and AR9580 Wi-Fi and an
> ASM1042 USB 3.0 controller behind the SoC PCIe root ports. For now,
> describe the memory, the console UART and a ramoops region, and reserve
> the top 64 MiB of RAM which the vendor firmware hands to the packet
> engine queue manager.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-cs75xx-=
v6-0-37e8f3969b7c@gmail.com?part=3D8

