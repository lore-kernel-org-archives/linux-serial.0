Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792876759;
	b=wHXWinhsx4JhgRifrsiStVLa/5mjgQvxndy8QPkigFL3xiL4xh6l37rPAnFudWS++xCF
	 aUGX3qQ5jWOftrabtvcPJEDRNOAx64zNjm6+Alnrt9Gva5q0XooinJFK0P5b0Lcm3z5DO
	 5D8Zne3hBjghA211qO4/jM/xmZ+UREVCCqJ3GuRs8NuwEDdES1PEcGBm9Y/IadKm9yDhL
	 5aqb8Mgtg/W2HfAyMkCbSftDjS0ugzrfiOYbANxpPc/0ZpH15QYw7QU6YSOg7Tgciuuo5
	 7fExtkLw4Z2TWtgn9X69tYw/2W+2EXYViH20cY3fhEWiIe5G8VZZM5/UZ/Qr9DjaLEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792876759;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZHkWXUmuY+hjMVTpe5y71IRcF18ZVBLaCElH8pVTlmQ=;
	b=aWHUaSUGXvfJ9CaT9QDTek4U4CXhZkPyD6ot+fHp2gO80xmmwmppIbsfaqzYc1jnNXEZ
	 R9mKDtHs1yZ8WQ6Gx9OmrNvoaIlaNmrMLSZJSgiyJsp2jpv1Snw6rSmEb4G6Stumzs9pV
	 XqXcbip60at3qqhdGUgKwSYr52AV0DaeMtOM6/6vrdzzVCBF3gDRMntM3Rp0u0Vc0jFnS
	 3xvJ/PleZDmuB3VmKwp4rsfJrK9en4+PtZYpjwV1FQ0PfB5d3bs0HLKUADqA8jKdU5ZUB
	 jp8MXSdEU5AI2kxRMqWVCwUjCxbfmHCLHO9MlmqO+LQCO91FskBzzbnL7vTcu7QoI0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GW9dHYqh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B21606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 21:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GW9dHYqh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9934A1F01825;
	Sat, 24 Oct 2026 21:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792876758;
	bh=ZHkWXUmuY+hjMVTpe5y71IRcF18ZVBLaCElH8pVTlmQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GW9dHYqhxA5nn/+8X7zTAW81yKVcbXK31zqqeTR1kaKvAwB+FqAsn+zOYA8jfge3S
	 nVyp+JvmHfPh/L1N2p+/oeTNBMXK7wAq25pgppphqOSiEJJn/f8QovFv8QktZtBWMk
	 w/mdG5NdoBdDgK+zHNDJUibLo4KpaZyXBrUT0DS0CDNE8tQtkbOlkSys4jRZc4+IoT
	 880YEmGfxX9dk+CUdPtvCwrJsfdb0BkjBqqoUAycty1xEc57HuuBgBARehcVZmR5bn
	 OZCs7HErUAK5fpNkS4wbwMXC79ruRnNSHg14/B5cuXkq2BfqXXXuvk5GKvVuq5Eq9O
	 OrDF39XaGqiig==
Message-ID: <sashiko-outbox-183881@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/5] serial: 8250: retire canceled RX DMA before
 reusing the receive buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261024-submit-serial-8250-dma-cancel-v1-v6-5-6f366591f566@gmail.com>
References: <20261024-submit-serial-8250-dma-cancel-v1-v6-0-6f366591f566@gmail.com>
 <20261024-submit-serial-8250-dma-cancel-v1-v6-5-6f366591f566@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 21:19:18 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The RX timeout path pauses a transfer, copies its data and terminates it
> asynchronously. Clearing rx_running at that point lets another receive
> reuse the buffer and cookie while the old callback is still waiting for
> the port lock. Inspecting the new cookie cannot distinguish that callback
> from the completion of a new transfer.
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
> provider still cannot terminate the channel in process context, retain
> its buffer and leave receive interrupts masked.
>=20
> Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-submit-ser=
ial-8250-dma-cancel-v1-v6-0-6f366591f566@gmail.com?part=3D5

