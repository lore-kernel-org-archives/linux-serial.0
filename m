Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959281;
	b=nh7scyQngqgZKyyFqvYFI5iS9Yng/8DvTMcNMTpjSSh2zFGS33ejMp6lYtmcmEuloG+s
	 EpnY4TU80raLQy5mGoxPjcUXisC0YGhj9s4PzOmYFDRZdyyQdYuruFUFbdNzex1ie3wWU
	 Q4XU3FiCnEPNEYrY+BFU4CBRYK5GTEoUI3PXJxyS8QO4tpCblJNygoki1I8Rm1Fur4N5j
	 ok+gulIFCub9jabtREOwwglZjAbyCxg2m6bd3vHgipFmotl5wZtMcOEStQEN+6fMgxPnq
	 jKJakA7zVjP7cc9iSkZj3GKneNjBvm9n1xBRUxEsudmf0e1XbkkhI/QvKsCPEH2wVog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959281;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iCcV29iEgGM3NJgU/XR9XdJljzYUhe2mKN+RX2pX6uk=;
	b=mSyMVqPvCp6Ny/izztKvSLpGW1r4BcWnVuD8JdCZCqn7xKHfOdgwWsERtoRb5FvhkKrz
	 RIrNhY6o0BMJSswzvDYDTg1o4HHVhYJdgBsgOBMOsbLFAA/qERRqSe8vTP5UEmOTXfEIn
	 ax5e++GciaaTnZf2VNjCE6rB9VNpLZ7pzch8CdVQKKD3pUah1KkO2JdvZeKdQocZSl9K1
	 TL56eGlPTru6RBLjqitthxIFcBxpev49TUuY3Okc+eaTMjs6mC1Kl6IyvyxgI1fPL8j2p
	 MbE+dcWrFYSDqtKCGXQhYdMNrwyqphhu96BLmnXstISApjmAyfZBw1C0y7Y/ylc6WiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SqWg1+SY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ED2606A31C
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 23:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SqWg1+SY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619861F000C4;
	Tue, 17 Nov 2026 23:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794959281;
	bh=iCcV29iEgGM3NJgU/XR9XdJljzYUhe2mKN+RX2pX6uk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SqWg1+SYEtlq0VChUhY0C/Cy24TGLw8O88R2PWeasq3xQfMyvBA4tsYsISFUW8x51
	 r9hhQvasQm42qQVhDj4GDxFgF6gXoOB0wxMwmsIJwk6Pzg8svUj6+/QdeXR6CFD92+
	 xTlqSsyixN7NWFo3nAxM3M/DWGSlQCQ9rVDFz+vHnZyFjew8DPMhuRKu1WRW/o/5FB
	 APWl2hhAt26/m3P6WAv5cTQJWBvGWJeejLbNjSow2RBEz03JaBoOEsLCo4gS+gyGI2
	 ZKwxBtYZja5AzvfKSRkPlDVO85ioIuwuBE0MkpI9JeVhqJepfyzEv2AcMqTwiqdcuC
	 6Rtn+wHx3oYcQ==
Message-ID: <sashiko-outbox-219807@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/7] serial: sh-sci: Do not kick TX from
 sci_er_interrupt() on RSCI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Diogo Ivo" <diogo.ivo.sx@renesas.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117-g2ul_sci-v5-4-30b58ea18923@renesas.com>
References: <20261117-g2ul_sci-v5-0-30b58ea18923@renesas.com>
 <20261117-g2ul_sci-v5-4-30b58ea18923@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 23:48:01 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> On RSCI, the receive error interrupt (ERI) has its own dedicated
> interrupt line and status flags cleared via the write-only CFCLR
> register, with no hardware interaction with transmission.
>=20
> Calling sci_tx_interrupt() from sci_er_interrupt() on RSCI is
> unnecessary and causes rsci_transmit_chars() to run in invalid TX
> states:
> - If an RX error occurs while TX is idle (CCR0.TE =3D=3D 0 and CSR.TDRE =
=3D=3D 1)
>   and xmit_fifo is empty, rsci_transmit_chars() sets CCR0.TEIE while
>   CSR.TEND is 1, triggering a spurious TEI interrupt.
> - If an RX error occurs while the hardware TX FIFO is draining
>   (CSR.TDRE =3D=3D 0) after xmit_fifo was flushed, rsci_transmit_chars()
>   clears CCR0.TIE without setting CCR0.TEIE, leaving CCR0.TE set after
>   the hardware FIFO drains and stalling subsequent transmissions.
>=20
> Skip calling sci_tx_interrupt() in sci_er_interrupt() for RSCI ports.
>=20
> Fixes: 0666e3fe95ab ("serial: sh-sci: Add support for RZ/T2H SCI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-g2ul_sci-v=
5-0-30b58ea18923@renesas.com?part=3D4

