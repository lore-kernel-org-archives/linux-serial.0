Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661916;
	b=BbENw8sZLo8h5kUWd59ZvYGljHkf43Fn3TrILQgh8i5GQ6pbdj8y9l4aMNTuNMo2U6aq
	 U90A0FPb5CLswo8ky/FjwNtKmDNf4y+dc1ZPSfAmweUOklmbK1rVbdZRjYL1PKHFXEbpu
	 3AjOP+VXpc7sqs2EJspahOvnv6WYMYMnBTUOIJOsJQz8Pz9v2efphbmAyDHlcbvXgckkn
	 CeyjODRwHtyCgaqaTee4QzqjHX6Yiv4Rcpx0pYXexheiISrnt/AAavJpQdDYV6gqzupoX
	 Mxs5MlP3HE7hF1ZQj7eIwovX2rEH9WW01E2ffmnD14z13ux0ZS6vwT9vk/DsrSqBaXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661916;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xEcB1RCkWKcbcuWmp4XsYshG8b3DXuMqIT3g3RQ7/kc=;
	b=z7OyZQNpnVUgglDHFjFPOlZPm9lMrfIS9V9J+57M46XefpvBQcFDm9VgC60W4Kr1MyJ0
	 XILeGLtrHwa3Wqr0KvHalMS6txu+P2TT1AUXt6wMJ0ju/KW64lcHQs+6R/zcySiOEJfjZ
	 Aaa7vB+fUfRLJGGRG2qYUTKqm8j+jc55PupkkJQN/1Njte/rFPMUdlE9vsfMe+l/+Nj9D
	 UY6kSekHt83BSuyJj4NP+wRMSX/lDRwiw1qAWloDkXyuqgfx5YbrbWBosjemrhnN5GqEm
	 +5feHNo7jORJEZSXlPyuzVGF25xgGHeBXAuCPbYilF8k1YWel5keVJT6FmcwZl5UU6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kl40H/K9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CEC606A327
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 23:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kl40H/K9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBDD1F00A16;
	Mon,  2 Nov 2026 23:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793661915;
	bh=xEcB1RCkWKcbcuWmp4XsYshG8b3DXuMqIT3g3RQ7/kc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kl40H/K95opbYnQb66skwZQ92h1lf621+HX7Lkkd+pOg0v+3qAnlQtPUUcgoRozfT
	 rfFo6MO1ZmPxbWi/LBOhTmR4viX1p59xvgb6HrL6vdG/E2Pa9lIlv4nE3oJEi9+03S
	 8LDk1+yh7SwuqLpdQNusAvXyyCHV97wCIArjZx4/qwUSI/oXYggXQD2W0nKCpIvh3n
	 tCkGRgxIBePbQ5RB/AeeqxrJuFScg709ArFbGPXjyaBuz5GU2ZDq7ixQbeL0hoVTEg
	 fv0PcqwgyyCN38w/E/EHs/UgvWWo7lRAKWA9M1r/0qP3iaZsVpBhgpFftmyR8EeQzQ
	 PYntyEVC8nhbQ==
Message-ID: <sashiko-outbox-194331@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/8] serial: serialize asynchronous write wakeups
 with the port lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-2-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
 <20261102-submit-serial-8250-dma-cancel-v1-v9-2-9159caade148@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 23:25:14 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-ser=
ial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com?part=3D2

