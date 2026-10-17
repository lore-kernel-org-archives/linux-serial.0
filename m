Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E5535674A
	for <linux-serial@vger.kernel.org>; Sat, 17 Oct 2026 06:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792219322; cv=none; b=NIVmdH5WVDPEwjYBv+ZaY6AZrCc8IImHLVhzUzXbq3nIXUQCIjypCSj+CQE0s08LyJaidTR9PyEXFQHexrDjMI1w2xAz5M75TUkkpxuxEUUvF7PiJjta7thCQazDFfpYEMLHjtWYiDrH2fbLqjCQMEsxHgz9GNL9BN4X5qGErEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792219322; c=relaxed/simple;
	bh=tk0QyFEiqB1Js3FMKNPuHtmPsVFQ6XpVfO9E8bFwNy4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=o79yzsFPimD56Hm059AodQOtc0q2Omdox0mvU6H7Ro57gMFaNTXaGlEa3m6GjLQDu/1GxzHDYgQ3nuMDrk+WNF2w6BiFO9h1iPocydOiyRZw9KLcxgGUPz5VIBCOUsEXoBN45cx3r9PC1e1irqpHvZWbYO6DyAPTZhK7C8VTwHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cw3XW7pf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cw3XW7pf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2C01F000C4;
	Sat, 17 Oct 2026 06:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792219321;
	bh=tk0QyFEiqB1Js3FMKNPuHtmPsVFQ6XpVfO9E8bFwNy4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cw3XW7pfcsenc8pa/rdjye57LNNrvtSBUck4BUh9qfGgoJFuhJKW5k4v92Wgaj2iC
	 1m9T2kOYHrNjplNb1/zLaMrkQz1V4wmZ6lL/Z9h0ACHAVdAh2U9eDWOrvFI6nrhN3L
	 eMdugxzzOWsgW66vbUQxviEw7fdq+OCvukJ4M/fc2kqOs6SIhsv14sekTJMqCJon9p
	 Ak+36tqiyyYqAL5za6CKFbneGWfIXmq1AecqsuQ51H0h7gClxFRKCRdlc0GfhUqxk3
	 vswmgz8IEISq4SUpzHz/+D+eOQEyOwPdPGUZgqPrhUqAORhSTa7YKVvvY6ll6+um63
	 EsEperDTUDc0g==
Message-ID: <sashiko-outbox-175336@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] serial: amba-pl011: finish a transmission still
 running when RS485 is enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261017-devel-nbuchwitz-pl011-rs485-reconfig-stall-v2-1-6f457a1ee527@tipi-net.de>
References: <20261017-devel-nbuchwitz-pl011-rs485-reconfig-stall-v2-0-6f457a1ee527@tipi-net.de>
 <20261017-devel-nbuchwitz-pl011-rs485-reconfig-stall-v2-1-6f457a1ee527@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 06:42:00 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Disabling RS485 during a transmission keeps it running. If RS485 is
> enabled again before it ends, the state is OFF while data is still going
> out. The TX path does not end a transmission in state OFF, so nothing
> sets the idle RTS level afterwards and the transceiver keeps driving the
> bus.
>=20
> Hand such a transmission back to RS485 when it is enabled on an open
> port. Assert RTS and mark it as sending, so that the TX path ends it
> like any other. With only the FIFO left or output stopped, the TX path
> won't run again, so drain the FIFO from trigger_stop_tx instead. Data
> queued while output is stopped is not part of the transmission. Pause
> DMA first, as output is marked stopped before the driver pauses it.
>=20
> Fixes: 97f85204275a ("serial: amba-pl011: keep transmitter enabled when d=
isabling RS485")
> Cc: stable@vger.kernel.org # 6.18.x: 1b6d660e038b: serial: amba-pl011: dr=
ive the bus during break in RS485 mode
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017-devel-nbuc=
hwitz-pl011-rs485-reconfig-stall-v2-0-6f457a1ee527@tipi-net.de?part=3D1

