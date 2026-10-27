Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099608;
	b=ntLmQ7EWOXC3bDYRYmezqYQU+ny5VknDWtdT9unVdUa+eK5JF8/Kft04U8ATS3ZCtueQ
	 kqfc6Xm4baF45Q5R3Fa9t/Tv0WmuGMWuwAwI88+KPiO9nqIHd1/2f4UXptIrEX5IMRTdG
	 qTJ/iG7xXSn2H5habWgKFsq+Cyp+PAhH9jOx+VQmtRlLfxADlBnROlXfTY2FPwaD4EFlY
	 hZNcxsl3AQyAV3iNFc8QwONNJIOxYERY3cKkWRSZV3U/MOewSE8KrlUmoIKAgIMuYS086
	 xsCBz7OZLiBYzSrLIeP1ByKflrGYTkNp/q/MK5olSl3+BfJZ/GLJ/3AeawWBn0FsL8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099608;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kngu7u82c1cygvMsBqdoEmnK66+lmuj18bBo6Vf81KY=;
	b=kcnpiahVOBnrEyXIToq71QSfyz3Su1zxf3bxscNHwtmZZL2fwZeL+otiruDIovI1JeoW
	 va6BMJlOaOWtH2DiUavvwZN1CFUxoi4W9cgblk3AhuSwHihoKlUNs4P4XkcYkq5F49/F2
	 pquABMkjxCmuPSmGToxgOyijphmz0OyUN0gW24egdB1aEwjj0UE4KsHV+HKEwWYQpfcbO
	 UHX8kD5011M476Bmk1tW0F1NAzO9RZM1ETG90t+Jf9gyfwuXJwNQ9GBH8KeGwtZbP+V8r
	 zfvMGpSbYa6Diys0I14Ohwe+qrqB8Z5uTXqXs1hs6fCwH2mfYm7zwCXpUi1MsePnETQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KF3NgBPY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA9E606A31A
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KF3NgBPY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EB91F01828;
	Tue, 27 Oct 2026 11:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793099608;
	bh=kngu7u82c1cygvMsBqdoEmnK66+lmuj18bBo6Vf81KY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KF3NgBPYENfg3YRmHweDbl9HMqScK/yjX+0E7Y+p8VAGu2ZGWse17rRLlDlTmBi68
	 Bcv0x91SCKDQdz9oV+tDoWnqdo/Juu6ip3ymyydbwLPZfSisOAU5jBWrbSjH3NN+mF
	 jXMq1isCsJBhaniAIN524TdR1wXjaw8J8YL+JQvCXiZnTY61RxCeH5EKDEeteL5kul
	 rBEt3STzqvL+IA4rBoferfZ24DqE5uOatJUXM5Xpu3oIJ0TTfmeZIDqxS80ap9FQ+X
	 fhPZOK7kyAUl8qeMZBkjbma+alLBBY7g6KxBofN3no+od4zMA8VsWARNPR4L7XhLbj
	 /af86bNi02VCQ==
Message-ID: <sashiko-outbox-186423@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/24] serial: 8250: omap: acquire rx_dma_lock in DMA
 completion callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-tty-llm-v1-15-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-15-99b0202ae546@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 11:13:27 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Joshua Rogers <linux@joshua.hu>
>=20
> The __dma_rx_do_complete() helper requires priv->rx_dma_lock to be held,
> but the DMA completion callback __dma_rx_complete() calls it without
> that lock, only holding the UART port lock. This allows a race between
> the callback and omap_8250_rx_dma_flush() which properly holds
> rx_dma_lock, leading to concurrent tty_insert_flip_string() calls that
> can corrupt flip-buffer state. Acquire rx_dma_lock around the call,
> matching the established lock ordering (port lock then rx_dma_lock).
>=20
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Moteen Shah <m-shah@ti.com>
> Cc: Kendall Willis <k-willis@ti.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: stable <stable@kernel.org>
> Signed-off-by: Joshua Rogers <linux@joshua.hu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-tty-llm-v1=
-0-99b0202ae546@linuxfoundation.org?part=3D15

