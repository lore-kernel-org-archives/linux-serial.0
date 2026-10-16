Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830C733F5AA
	for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136968; cv=none; b=QZrdLzP5gMH/zyCbxH9hGnJPZTcSpcXWz83wm7nGrjt2rtCi/1QeMXniqhrvL2Wqd9LXwDg7OcTmWoFC8qp7WhrVqo0vo+j/GVGiQ1/NoH4lC6K1rN0TzrF/r7APMdOEFnxyubOwYMDVOl+OwznjantoVNzc8SQHyg9q8fEWy3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136968; c=relaxed/simple;
	bh=2j/bo9B9UDuHy2Bt9tDCrAGgyhOWoq8J+j7/pBYuXe0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=r7fkkCEu6egH81JBgX+FoBq0XNcXNVbXtMH7mw3/hLywAhdGBOrdRDRjntYLd9OpSFO5YnmRiRZVUd3jTqONR9RDR/wvdJUkUqFFj2BPe/BF5d9oGtSvsMv00YbhV4lkN4He4OqjpjkQbuKTqn/HAE/FKAqlTofjLhRbW40Z1Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVE0ky0t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVE0ky0t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F331F000C4;
	Fri, 16 Oct 2026 07:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792136967;
	bh=2j/bo9B9UDuHy2Bt9tDCrAGgyhOWoq8J+j7/pBYuXe0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jVE0ky0tX+9mURxMll0NqkEarJvQwe/O+2Sd5kqXfYVgCSWR3/bc/X/yofTXB49pg
	 HxAr3wQ2CUDFWZZadfLU0E/rVFDLF8TMvyhfVvPTEPb3+W3STRUWY+/7UG6u+QVt3G
	 Hp2oCWri2YPVkH8uLZvofi8b8AS7MlJrV44dkeRN45rPhWXfM5Iu+oBwTRcXxuBof8
	 POqJ6KaqnUx10h/HB+Ya86X4Dmd1m/s0NXlUmWj6C10rvFfc2IxLPiHJRnF3DdyjfL
	 NeOpIhgmCzCv2KIvuVDI7Dk4UdKxJu77F05jpiZfsjgKGUHi5TLudlfUPbizxEH6PJ
	 fznWbqZB7scZw==
Message-ID: <sashiko-outbox-173968@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] serial: amba-pl011: keep RS485 transmission running
 on reconfiguration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261016-devel-nbuchwitz-pl011-rs485-reconfig-stall-v1-2-f07d4da714be@tipi-net.de>
References: <20261016-devel-nbuchwitz-pl011-rs485-reconfig-stall-v1-0-f07d4da714be@tipi-net.de>
 <20261016-devel-nbuchwitz-pl011-rs485-reconfig-stall-v1-2-f07d4da714be@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:49:26 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Changing the RS485 settings while RS485 stays enabled calls
> pl011_rs485_tx_stop(), also while a transmission is in progress. Unlike
> pl011_stop_tx() it leaves the TX interrupt enabled, so the remaining
> data is still pushed into the FIFO after the drain turned off the
> transmitter. The FIFO never empties, the port stalls, and closing it
> hangs in pl011_dma_shutdown() waiting for the transmitter to go idle.
> A start still waiting for delay_rts_before_send is dropped as well.
>=20
> Only stop the transmitter when no transmission is in progress. The
> call is still needed there, it sets the idle RTS level when the port
> is configured or resumed. A transmission in progress sets that level
> when it ends.
>=20
> An active break counts as a transmission too. Forget it only when
> leaving RS485 mode, so that pl011_break_ctl() still ends the
> transmission when the break ends.
>=20
> Fixes: 8d479237727c ("serial: amba-pl011: add RS485 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-devel-nbuc=
hwitz-pl011-rs485-reconfig-stall-v1-0-f07d4da714be@tipi-net.de?part=3D2

