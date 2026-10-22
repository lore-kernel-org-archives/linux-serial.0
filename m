Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792703914;
	b=nW7tlguIsfJyHi3crSuJPwUsLJA3YS9GMTF6eQxSiflzc+L/Tmxnko+A/Pq8GR2HQzkh
	 zJz3ydjNtFHhTMU3o93UNbCrSvh3kiWESsrZL72FYFjQ8BwHyeSEGv5vsxnA8iTk1KsSA
	 DGbLftCOPnpIuOUAEpUfPKkHQvBu6FTdpTmOSQPsFEWxjF+QWZjwfUMdHyMnkcrXyb7We
	 ejEpnun4UlLTMnWyasgQrSWDSJl16NOysCHB/81O7a/MQXBLoeYxu07hwEtqOZiG++XWs
	 iM30CRbinxRCENTtSTJzrEV2sxUQiQgVanxngQYQEllWfMex1jF7wByvpjArlZDz1Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703914;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tnSBSKTyrhgXFTYVRvaz33EK2l0zMxtrFeoVm+YjZ9M=;
	b=AvtFBhomCZa1+3L8taleRqqyxk2rPoCcUhwYPXIyG5GYAp3JAnMBTArK974iGrhFoLCK
	 VNxNK7U8chkkvSUVV/6H61bV9T/vx5JLhxuy3izRo+awISNONKQFBa/Ih9JzfYHDyB3II
	 gh5YcC7YCRGoWo6T3N7n+UhS4ygg4QeDlbnwD0wZu7l2LnLSeX8eWhYDndgX2RNU3mEhZ
	 56UMl9nddV+wVO5lPo4ccLCTsIVlv/mUYjyoqIrUVB9WX2dT5q+0AihSJN9pgHd6SLqvU
	 bSRaZns0kEO49PZm9/33yV+LvYlYB1bFW6u99QXFw0GE3RSSNoE/Dq9sFcs9TDs1lmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jrlk9cV6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A48606A319
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 21:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jrlk9cV6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630D81F031E2;
	Thu, 22 Oct 2026 21:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792703913;
	bh=tnSBSKTyrhgXFTYVRvaz33EK2l0zMxtrFeoVm+YjZ9M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jrlk9cV6xLDLtLw1pT43zCd9gcNQ7EQeH1IXYoWEwbfxy8jKK5I4q25k6PlIZR/mD
	 X1aoNSDELVhC7q4iaqv6zJhtCOFZZs9xyAn30PdSryhjCARt2unyz7aAlJnOBM4Hj4
	 6XHLECfweFIDnnTYVurhm2SKmk41TIOyF5rTrlJD7rj7xjHHiN0OLcUTH6EeBtqviO
	 tPJBcxGvSm4VgI6sBTHaf0VxCSyZq21oyYDrqrfdYAAM7l0/qLbZHqnjGBLBzwEwGI
	 cYoweCrQnU6gIOMrZQJK/EBG8xjWX3XbBLa+vFmtTF0TmYeKzV3TsSKcQP91Ov1IQE
	 uL6kdeuJvz9cA==
Message-ID: <sashiko-outbox-182055@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] serial: tegra: ignore stale DMA completion
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Austin Schlegel" <schlegelas@outlook.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261022-serial-tegra-dma-uaf-v3-3-129f6d67f673@outlook.com>
References: <20261022-serial-tegra-dma-uaf-v3-0-129f6d67f673@outlook.com>
 <20261022-serial-tegra-dma-uaf-v3-3-129f6d67f673@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 21:18:32 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Austin Schlegel <schlegelas@outlook.com>
>=20
> The TX and RX DMA completion callbacks run from the DMA engine's
> tasklet. tegra_uart_stop_tx(), tegra_uart_flush_buffer() and
> tegra_uart_terminate_rx_dma() can stop the same transfer under the port
> lock, and dmaengine_terminate_all() does not wait for a callback that
> is already running. A callback can therefore be waiting on the port
> lock for a transfer that the driver has already stopped and accounted
> for.
>=20
> tegra_uart_tx_dma_complete() reads the DMA status and acks the
> descriptor before it takes the port lock, then advances the xmit FIFO
> by the whole transfer and starts the next one unconditionally. If
> tegra_uart_stop_tx() got there first, the bytes it already accounted
> for are advanced a second time, skipping data that was never sent.
> [ ... ]
> Fixes: e9ea096dd225 ("serial: tegra: add serial driver")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/sashiko-outbox-172211@kernel.org/
> Assisted-by: LLM
> Signed-off-by: Austin Schlegel <schlegelas@outlook.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-serial-teg=
ra-dma-uaf-v3-0-129f6d67f673@outlook.com?part=3D3

