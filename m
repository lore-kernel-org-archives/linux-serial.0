Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448212;
	b=Cxp/A7cjdQSrkwigtsQOl13wt3FmCT4Xti4zuT6eQnc6+JekuE2orcUphZsvDmE6Ap0n
	 C6VujZJx5kZ4BseoxW3X6x0ht4xdRgSm2JQ6CG7hryDGMBF5dFZseGB561wquhEpobwHU
	 IBoI7IybS28Stb4BGouzn/QSaSBZ16uY7yqPXFuj/FrBHr0/PCUpDRIDv7g/Itb/DXJSg
	 kVuK7GynF4UBcRJlzYDwphzs0lTqM/qE1Aofp6fKdCGPVOixyOJCdGAvAuNhMhiGq6C+S
	 8eqGhTmPtl4KJcpbDCYpmGLrJO097QLCkzbqWpV7dh9zugMyh4cqX4KOac3B4zT0vvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448212;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lk+HoAcUwejdcTZGV+Ml4e4AVI80zBKE+96+aBMiF8M=;
	b=Kr3XmNxmWRiHWI+RjKeVBrTzUdb00NvXoXaHOHuphRjhL4o4T5pLZ+Cnsq4ZhDGCYgzH
	 9uIY2nSL1ZRsAmTPGwo+HGCbAh43kP8mfU2vC0PrRnFaQlYe42eBdpDb8ogAuQyVbxNOc
	 BM+IRqbY8qHjTbExyBK9Ji2KLN4JddOYxejpnmNvb1wUWWxVwcPwca/rIRbAzgtzFuDya
	 2c2PN5Z/5w7tv46ir4zx5ZyBFaIa9i9TVJppw6ZSFZlz80qaS7WrQ9MApsnISpKE0D32+
	 QasGi7pPGvF44O4G8+MbPbhdBFcCDRavN/aHIhbz4Ym6iJC53zdLgN+vrqD8C45u3ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="J/kTnL8Y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173E2606A321
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 01:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J/kTnL8Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA40B1F00A06;
	Thu, 12 Nov 2026 01:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794448211;
	bh=lk+HoAcUwejdcTZGV+Ml4e4AVI80zBKE+96+aBMiF8M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J/kTnL8YTJV7ZJ+1MVqw3+sLJlL6aALSgwoMTPbt/CPX3+EBGNnjkrakwMQ10XRSh
	 QPWWa5MHtx5zYq0Kg3hL/x1Y4GT+6y2wTpC75EcCKay3vaqMJMtIssks9TmWPDWll6
	 mwMJN1aF3eKQ7pCSZkHtqZ5rwJ097exhaqNUA4TRyVXe8eCxBfFZusFnarkZu/4oUT
	 T0X5BHuGTolIKpp4BVDAVLIhhLMqvo94EzdEinA9SlMms3oIofY7u2YPriA+8CySPt
	 Ym5BLguRGoJABrEgRyvRrobmBUp7Qb5owuJBc4vqvUJw3Qbjyz7tyNLLozdMio2hpU
	 X+VdaRqdv1LLQ==
Message-ID: <sashiko-outbox-210099@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 7/8] serial: 8250: retire canceled RX DMA before
 reusing the receive buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261111-submit-serial-8250-dma-cancel-v1-v12-7-9e3456bc2555@gmail.com>
References: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
 <20261111-submit-serial-8250-dma-cancel-v1-v12-7-9e3456bc2555@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:50:11 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The generic RX timeout path pauses a transfer, copies its data and
> terminates it asynchronously. Clearing rx_running at that point lets a
> new receive reuse the buffer and cookie while the old callback has not
> yet run. Inspecting the new cookie cannot distinguish that callback from
> the completion of a new transfer.
>=20
> Reserve the receive buffer until a worker has drained the canceled
> callbacks. Keep FIFO access separate from callback retirement: after a
> successful pause and termination, clear rx_running while rx_terminating
> prevents another descriptor from reusing the buffer. Deliver the paused
> data before allowing the interrupt handler to drain the FIFO through PIO.
> Normal retirement only releases ownership and leaves subsequent receive
> handling to the UART interrupt.
>=20
> Preserve the normal completion-path LSR read and gate DMA resubmission on
> [ ... ]
> Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
> Suggested-by: Raul E Rangel <rrangel@chromium.org>
> Link: https://lore.kernel.org/r/20261109162135.906262-1-rrangel@chromium.=
org/
> Reviewed-by: Raul E Rangel <rrangel@chromium.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-submit-ser=
ial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com?part=3D7

