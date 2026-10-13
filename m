Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A25D3E557D
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791873698; cv=none; b=eWnU2CtDEPwQiBdygZeUs/QBgFwq6qAPryycpgiEXjVV9UL3ppEKMAoIsaxMMGENFzcJysbNkOTNlAAvWsVm6/iHGEo624BjIrLXABEUPsUB4sCu94+kSMO86ic2+Z24q4PyJmVcZvVhSxbxTLkcQAewUXl2PHPaDBZe7BwyYwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791873698; c=relaxed/simple;
	bh=vUeTwM9ebc4+3EPNJ1m7IEo86lqGAY6IKAeFy5GQ46s=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=noOgXQ7a905cTjJkfw4jvxzT+Or1PsHA42ZccPh2JvvMVBzah1wY6NyRBPCrrD9XGuYPu+eefIoWuScXLN1zOg9qnz57DWgE/frgWqmwG7jtDxag8nl+GOfqLxhpAeNuQBxMiddh98tGeXVIj7b0lZ0Nr7M0nHBExodf+WoKtWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoT3Y6oq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoT3Y6oq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27941F00893;
	Tue, 13 Oct 2026 06:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791873697;
	bh=vUeTwM9ebc4+3EPNJ1m7IEo86lqGAY6IKAeFy5GQ46s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IoT3Y6oqyd3CFbB9z4BVFx/6vA2nluPqZwDk0d1q5/7LqMjN0Cr0vUqWdTk1hw1IX
	 jCzoDn3UAoEmcwy+aZA4bxp7zOgl9uAdm9FfmccN4miCQV60m+KZooG3Q+T2RfTuE7
	 fbwPZmlO7CyT5YR93EROw43P2qODubeDNevimv3qXufmV4UfVPg50WOCZ33hZLKp5e
	 VjXUMXKMJNKRLDxHFyBKAb57aogvt1vNADWMgtwAl+yen9eJVLejoz+p9yedV+6x3H
	 RW3V8HWdMoeGnuv8v/94fOBq1attzoFxFl/WL/qW1Md0iYv8BDTY/5KvA1diiYfT4l
	 qy8m9Z8gmobEg==
Message-ID: <sashiko-outbox-169118@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/10] tty: serial: Add Cortina UART driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261013-b4-cs75xx-v6-7-37e8f3969b7c@gmail.com>
References: <20261013-b4-cs75xx-v6-0-37e8f3969b7c@gmail.com>
 <20261013-b4-cs75xx-v6-7-37e8f3969b7c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 06:41:35 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Add a driver for the UART found in Cortina SoCs, starting with the
> Cortina Systems CS75xx (Goldengate G2) family such as the CS7542. The
> block has transmit and receive FIFOs with full/empty status, a 24-bit
> baud rate divider clocked from the peripheral (APB) clock, a receive
> sampling point register and one interrupt line per port with per-cause
> enable and write-one-to-clear status registers.
>=20
> The same block, with an additional flow control register and a few more
> interrupt causes, is used in the Cortina Access CAxxxx SoCs, which were
> briefly supported by commit b61c8bf4694b ("tty: serial: Add UART driver
> for Cortina-Access platform") before it was removed again. The driver
> is therefore named after the vendor rather than one SoC, so that those
> parts can be added with their own compatible strings.
>=20
> The driver is a rewrite of the vendor driver shipped with the Linux
> 2.6.36 and 4.9 based vendor kernels, using the current serial core API
> (uart_port_tx(), port lock helpers, deferred sysrq handling) and devm
> resource management. It supports the system console and earlycon.
> Hardware flow control is not supported.
>=20
> The ports are named ttyCS so that the driver can coexist with the 8250
> driver in multiplatform kernels, where the 8250 core registers ttyS0
> and up even without any 8250 hardware, and PORT_GENERIC is used rather
> than allocating a new port type.
>=20
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-cs75xx-=
v6-0-37e8f3969b7c@gmail.com?part=3D7

