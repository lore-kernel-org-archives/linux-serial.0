Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794197095;
	b=oBIxFU9j0sfIANAJMI2pHQtb4kBtgJQH2/DvRiHnfGG0rTRBwfg6xxxu9ySUvRj17awr
	 nqKmUrpnK+RsVUjFuBqwwK+Jn/kNaj/hrb2PgTZEgr5tDVTWZv1cn9Km69xeEWb/BTyp6
	 w8m2kqw+OE0cyu2B4ab2uCKu/+pJXOwr8zmAGf67kRaSK1KwqXkWv0M/yFmrWed7vJ15A
	 8YtQM7p6pcT2MXJh05G1F0yrKPEHOht8n1f3rS35Zp4/tXI7gudoO0QaOrssswVzN/Ftu
	 0/COdVazZOBq4KPUvUGXOOYb8mccZc6BpZA71Rsw4OSM2yGo8PFI4dmNTsAol/SkXLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794197095;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wQE/AtyKStofCgS3MrgbQv0YdjRs3vBNo9aaQgoJa/s=;
	b=kBYTgDFPradc/DhEsEEzTqx8q2WU6cHGLlFHtynoQi8JUoQyQEHhL/3X/rFe1vO/w9TJ
	 vwfkpBcxJRcFAfJtoRx2iVIqWW3cnNogebawoycGws7tC56yzqsMbekmF5PTtSA5vQQu6
	 uHdCGMic1uePvn5Wh1vS0F2gyZCBZU1XJKLt68KgnFVMw6ivQ5+utubxT1xoiMBWLr87w
	 K1uK7pSvzgjcz/TF/zuAReTpVMQVuFmybuDuQvdFMhbtcnQaXOI2wrxt8VH+2mIgWn1xV
	 g1K/uOPmv/zDV/k0/3eMxmcmXdY5frfIB6HmFGyJvMZpPtb5q+72HReuexAjwlVh5uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NMxXaFLS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80C0606A321
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 04:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NMxXaFLS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553AC1F0089F;
	Mon,  9 Nov 2026 04:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794197094;
	bh=wQE/AtyKStofCgS3MrgbQv0YdjRs3vBNo9aaQgoJa/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NMxXaFLSn0/f0FWZbvJYmdGoV0mFsTRUSGY16A4BNVag/Cd2itvE2QRzHvg08eYre
	 U1Dt27EypeS0Zjyjz0F/NRkhFTGG/CejS0Bsurfa4AhIjDlK4p80mA1x2jSXnKcgMv
	 s7EeNntE/TYV2vEke4HQbBRaxGkljW9dEN4SwzCVSTaf3bFrntq0uiifEZrKuiHUX/
	 OH7XCD1mfBGMYjBOGi2leOb4KshZfPqD58VbPwzs1BkZf7z3OFNprWBoPt8RzqKhdh
	 yrTQTcBaOfM4W3ClC0StK1fjsuZsR39b1stM3aVnIt+JZz8BJNkd6uywm/n9aPzkbg
	 IV6333b+5MdhQ==
Message-ID: <sashiko-outbox-204391@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/8] serial: serialize asynchronous write wakeups
 with the port lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261108-submit-serial-8250-dma-cancel-v1-v10-2-e6227ddb95b1@gmail.com>
References: <20261108-submit-serial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com>
 <20261108-submit-serial-8250-dma-cancel-v1-v10-2-e6227ddb95b1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 04:04:53 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> uart_write_wakeup() expects the UART port lock to be held. Several worker,
> DMA completion and interrupt paths call it without that lock, including
> indirect calls from uart_handle_cts_change() and the transmit helpers.
>=20
> Take the port lock around these notifications or their transmit helper.
> Keep sleeping SPI and regmap accesses outside the locked region, and keep
> the FSL LPUART completion lock held through its wakeup. Acquire the port
> lock after releasing private channel locks to preserve the ordering used
> by UART callbacks. In the MUX timer, publish available FIFO space under
> the port lock and keep the hardware FIFO-drain wait outside it.
>=20
> Use plain port locking in hard-IRQ handlers and in helpers whose callers
> already mask interrupts. Atmel status handling is also called during
> resume, where lock_suspended is acquired with interrupts disabled; JSM
> interrupt processing holds its IRQ-saving board lock. Keep IRQ-saving
> [ ... ]
> the restart worker during shutdown and removal. Release Lantiq's hardware
> lock through the transmit helper's completion hook before notifying the
> line discipline.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-submit-ser=
ial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com?part=3D2

