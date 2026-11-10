Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285710;
	b=222KJ6v7L00Mj/j8NoZfy1OGt8fBRVY8jmq4b0nIHLNEx8mAujHEaYLTmNZ5ujROXVqP
	 XibuMUF3wLRi88dRUIYVJ3q84VMmigf7LYtwUkLOfLH0oe7Vcx7lXCQT3VTJn8x6poVDk
	 C14MNeO3daYkWKSd34kKuCUYW1uUUmjEeGr6ujQlNmxI0vFP3N8seU5xBFf/5PKN25T/B
	 lSG9D4hAnJ/Gy7TwYy7111jEbk/ZrYHsIYmc6GF3dG3V7QBk2O4zOstXO11ECMjExVD+E
	 ofps3AuyWsO0xaS28mvsnIBwXcXedlmoaerf3cQi6xKiMUUIw71ESxrAmlXf3nUJ7Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285710;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kp0qzGIpoyCBQ+vvu74/lv//+xmyo6umbN3ZGpjVg/w=;
	b=zBcXXNUeJnDsj2Je6XbBaYlhLW/2W2x2QpGykQmnbh0Lm9gScKmR4RyXfH0d0ay2yBlL
	 7qlwvN6DjXc1xukN343iyk3V+/PdILL71XOPRAuL1aerHtjNQ8uXRAuEkIYiUgUsShJmP
	 h+pxkzX1DueZ8dziUb8gBVWfcj1j76oExAgVwByfNMmI7S8eGp8ycpzLO0JuSx0wU3fcZ
	 zC4NiUEqyZGIwMXJtBhUKtozmVGqT0PA2UYq8mgb2a//1Ib/IQMXB6qYtxvRI9FR6CG9c
	 0ad6WlCo7Ut28NOQeYmEJ0l3TNMmp9KGGRU0JsDAdZXTP68A0nf74Mxfgg8KEe2l8PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vw1q5b3L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFBC606A321
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 04:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vw1q5b3L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A551F0089F;
	Tue, 10 Nov 2026 04:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794285710;
	bh=kp0qzGIpoyCBQ+vvu74/lv//+xmyo6umbN3ZGpjVg/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vw1q5b3L4zrMXy0shuC09eHc9x0ZaBDosPc+BWJm1HqVc9kB6DllYygDDJN9pC2gV
	 hPbBkkl55wlqQK6azdZkC51H1b7L1zFHAh0Iag0E8XzVO37RqEcDYIDYRbe98MFCva
	 f6n/HizibZisGTUO21y6JtXlnjbjFzV+eHcpKccG7xw3jyXcPmvlhUglnYU0QD9b9u
	 NvoM5Cv5CdtQllex6VlrtEH3yqDdT96RHIZSK5eW4j84KzB+/u/i8taDT+F8S6s8Ct
	 aq3CVK/9zivJU13pDz6Olh92ik+UkHVcSwXkk42rS786OOys0iyz9BS2JiOvRQGQEA
	 ewp+ckNRASkkw==
Message-ID: <sashiko-outbox-206229@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 7/8] serial: 8250: retire canceled RX DMA before
 reusing the receive buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261109-submit-serial-8250-dma-cancel-v1-v11-7-6364edca63d6@gmail.com>
References: <20261109-submit-serial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com>
 <20261109-submit-serial-8250-dma-cancel-v1-v11-7-6364edca63d6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:41:49 +0000
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
>=20
> Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
> Suggested-by: Raul E Rangel <rrangel@chromium.org>
> Link: https://lore.kernel.org/r/20261109162135.906262-1-rrangel@chromium.=
org/
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-submit-ser=
ial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com?part=3D7

