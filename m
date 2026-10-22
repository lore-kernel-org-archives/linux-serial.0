Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792703843;
	b=m/gr91Mqm3Hhd/TRtbDP3TNsmBHYs0ZzkxpJ1H40Jlz0OUPAgVODmiNCu5giE0T5zko6
	 b5nMVTwbmBStTQYMmasuMW81BCmrf1RtZPdXUk0budwv1Xnhsy7WXpZcu/cYzmgq+JrhF
	 0l5lYUhrh+J1gRNwhOxPT/igPajMnBcva1KnW4mqM5A1hVJbaUbHYDgUxbIjTF90ytfVn
	 fztjv5P8dvSwK78a+LBmAq3m4I+MCcNWno/EfDCYb0Wpvr6XwsHO0pnakDj85Af+STrX6
	 QWActhvgnMrAulAMIDkAQJ47N65BOmtZSAm1oXo0pg2YxUUGEhf8HOoGU9+RNB6Sncw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703843;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PYOH6cVJ9dynfVN50DOsRYNhSHQniHJNjD4K/sNSbpw=;
	b=Fpg02xBaP7g5fGCLptgAEjZgcJ4nqBOGyxdUk6+WgrXv8ba+4GInUg7RC8c67q4eA0Sl
	 C1LiMRgiJ7azPEoOIPMca3jRs7jmXEKVNmlUthBfpOwlFxf2+hI9JS4aptZsDzswhk84M
	 kjCFl8ZLpR65/y8Ez0P6k2JW6VOw2+qqFNF7+EpHjeA0HHqo+YqJfQFRHqokbIVuBZbGE
	 m+NRUTCAZLvIG+BEoafqyvXRT2ddarWyyZR3H9b1qqcho4dSYCHhQ+h/Qitk/fzVmONrf
	 haBeja7NngCfSYfMnVZuiLXBrqFQXWWXS8KvTsFiPCyBLjhxa6d8L37ArIU/EVG/N4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+QWkvkN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2078606A31E
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 21:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+QWkvkN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777441F01825;
	Thu, 22 Oct 2026 21:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792703842;
	bh=PYOH6cVJ9dynfVN50DOsRYNhSHQniHJNjD4K/sNSbpw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B+QWkvkNsJGTKmmptSUR6N64ottJt5Z4ALAWbZuQbeXrQuKxZlEY9Z5ARiok9gzrP
	 +VknyYxYxmFcsIExIsi9UFfSZlSI5nwh62dbpd6JMRS2v+kpoDjouHw6VRql2tsFVE
	 vqX34EooKhhc7ZcA23CfUTUjUlHDQd7VNY0q3rFuEt0G41pUrWFyS+F9SBl2FIr14b
	 4BT0NbLgkqIqaCko/ezXNa52l0XvaopRF0Pm9/ma+rpjXgxp4u9GMMGTYzRXeyd4bc
	 l678N6MROJ/jafg6UxgRsJx9I7t5pbSnMVZK7Tr6RsqKyRBNB6mQnHhHWrcWLMJ5AG
	 SrYeJHQMF1ciQ==
Message-ID: <sashiko-outbox-182054@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] serial: tegra: fix RX DMA descriptor
 use-after-free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Austin Schlegel" <schlegelas@outlook.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261022-serial-tegra-dma-uaf-v3-1-129f6d67f673@outlook.com>
References: <20261022-serial-tegra-dma-uaf-v3-0-129f6d67f673@outlook.com>
 <20261022-serial-tegra-dma-uaf-v3-1-129f6d67f673@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 21:17:22 +0000
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
> tegra_uart_terminate_rx_dma() calls dmaengine_terminate_all() and then
> tegra_uart_rx_buffer_push(), which calls async_tx_ack(tup->rx_dma_desc)
> on the just-terminated descriptor. With the GPC DMA driver,
> dmaengine_terminate_all() frees the active descriptor immediately, so
> the subsequent async_tx_ack() touches freed memory. dmaengine clients
> are not allowed to touch a descriptor once it has been terminated.
>=20
> Move the ack into the two call sites that still own a live descriptor:
> tegra_uart_rx_dma_complete() (before the completion callback hands the
> descriptor back) and tegra_uart_terminate_rx_dma() (before terminating),
> and drop it from tegra_uart_rx_buffer_push() itself, since that function
> no longer has a descriptor it's safe to ack.
>=20
> [ ... ]
>=20
> Fixes: b31245b94207 ("serial: tegra: ack the rx dma desc after transfer t=
erminated")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Austin Schlegel <schlegelas@outlook.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-serial-teg=
ra-dma-uaf-v3-0-129f6d67f673@outlook.com?part=3D1

