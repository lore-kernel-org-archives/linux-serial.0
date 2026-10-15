Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1091119BC8
	for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 03:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035812; cv=none; b=ol8z1o83cgt+K0KRj0djAirWWrM2RmM/aFlZeq7XstGB/UpQsw7oAx4ioA6HIkgvLcTLaqOOXp69zNlZ1AkKUYsFD88OAOvfHP3/OazuNqC7fFAcdAOhhz5tD7TOqkd7zq6l9D32AglKarFN9b0tu+ZdxPz6Q8elAfo51Yb3FIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035812; c=relaxed/simple;
	bh=CQ+V+wkiDxNY7THQKBjZ+K+jNjd8zzTw1ce4gjFqXEI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=r4mXLfbLn/BDvSwdo4kw3hNJu01YuL1ZNfSbkRtXz2d4RwdP/o0fgqmdzAcSFi7mutlbXsfKBp0/yUzckMJZPC5ZtMCG8gaZwG6Xj6BzRvPeYhg98t0Hhux30M1HfVCLd9OdRYYxZsFeVyJCyxcmJQaBuYj026jxZygP2Bkj4/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQOaH0hA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQOaH0hA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C3F1F000C4;
	Thu, 15 Oct 2026 03:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792035810;
	bh=TNIpbgehaFjot9ZdYm40L/ddgY4SzYdkSSCh8xhWcHs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aQOaH0hAQioPetbN7Ja1PgGVGVHBmilmlQ5eyjliQKUU1x64YqzrkYoedMxhONrOH
	 RLISXw2vjm1BH20cEAaN4fu3+xjAZL60B8FM3i095db6u1RBk41qQgvLOvAcZbLfCQ
	 c7NdSkfh/66d/8LFmCoq7yOu1R113uKwQNwiCWmOBSHtASiVrWjIy1ElKnjaEdiMdF
	 6cQUk8etEZW1sCa3sFHQdGoFTRyb89s+mWGEi1uhtlekWginQ3DTHvN8Cy0JcHHA+S
	 /Zwy4SowNNCpJDMwWXVz9BaeA16RTDaDDIjDiRVFy/vicCml6tF3KfMCJKzaW8/pg4
	 VJRaUE3r+4zEQ==
Message-ID: <sashiko-outbox-172217@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] serial: tegra: fix RX DMA descriptor
 use-after-free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Austin Schlegel" <schlegelas@outlook.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261014-serial-tegra-dma-uaf-v2-1-b142b31b67e3@outlook.com>
References: <20261014-serial-tegra-dma-uaf-v2-0-b142b31b67e3@outlook.com>
 <20261014-serial-tegra-dma-uaf-v2-1-b142b31b67e3@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 03:43:30 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tty: serial: tegra: DMA tasklets race with termination causing cor=
ruption
--

commit 829540ff4c493e2669ac25a22f37fd2da4f2c018
Author: Austin Schlegel <schlegelas@outlook.com>

serial: tegra: fix RX DMA descriptor use-after-free

This commit fixes a use-after-free by moving the async_tx_ack() call to
tegra_uart_rx_dma_complete() and tegra_uart_terminate_rx_dma() before the
descriptors are freed. It removes the ack from tegra_uart_rx_buffer_push()
where the descriptor is no longer safe to access.

Link: https://lore.kernel.org/all/20261001-tty-linus-v1-1-ecb8576c802d@arth=
rex.com/

> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c

[ ... ]

> @@ -761,6 +760,7 @@ static void tegra_uart_rx_dma_complete(void *args)
>  		set_rts(tup, false);
> =20
>  	tup->rx_dma_active =3D false;
> +	async_tx_ack(tup->rx_dma_desc);
>  	tegra_uart_rx_buffer_push(tup, 0);
>  	tegra_uart_start_rx_dma(tup);
> =20

[Severity: High]
Can this callback race with concurrent DMA termination?

If tegra_uart_stop_rx() or tegra_uart_terminate_rx_dma() is called
concurrently (for instance, when userspace calls tcsetattr() or closes
the port while data is transferring), CPU 0 might terminate the DMA,
acknowledge the descriptor, and update the state. Meanwhile, CPU 1's DMA
completion tasklet could be spinning on the uart_port_lock.

Once CPU 1 acquires the lock, it appears to unconditionally execute this
block without checking if the channel was already intentionally terminated
(e.g., by checking if tup->rx_dma_active is still true). Could this
redundantly push buffers, erroneously access the potentially freed
descriptor via async_tx_ack(), and incorrectly restart the DMA?

Additionally, does a similar race condition exist in the TX path? In
tegra_uart_tx_dma_complete(), the callback accesses the descriptor outside
the lock and unconditionally advances the TX ring, which seems like it could
race destructively with tegra_uart_stop_tx().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-serial-teg=
ra-dma-uaf-v2-0-b142b31b67e3@outlook.com?part=3D1
