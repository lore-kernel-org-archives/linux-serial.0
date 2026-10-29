Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313592;
	b=5fy1h5fhN1f1B3U/Dq7RK2mPih42r/f8rGKm3L7QoeH2kCiE8D4euInTfcZ0wie8yVIH
	 9cUxGHj8+DWVxKPzd1TAjLcQ6V2YPGvcQiZAeiJq0BRuCSzCZipLoHT9si8WgDsju32KJ
	 X4wPLcudastIWZi8jb8Gwy6zGeFSRTfqaHCf10f+NJZMG5mcAS7KmYl0atIQrv/S8uToz
	 He7Xmc3fg0q+1NP6GdmhhCtEk7NGrAjnXMTGhYVK0YACryUwSu/8SY3+SyHOJWjiMpGLV
	 x9QrBkcYMuZ1juOV5biXXuB/tCD6Pktpf/HUfNtUn2uutalrHnyj5fxPksGF5I15XPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313592;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zQ6uNo89nejCaAU7k5tj/9f4wgEOYJASxK8zmXwc9nE=;
	b=HHFxuW5CHSkRd9HQJoo2vPT+ScDZj3WzJ7FH+SowygBjFQE8JuwRVlG9b+DXBSGQXuRh
	 9BlPc2UlMHifjiU0MjH9QMkl6cxIY1dg3qVorKRFr4Ot5GnMTPpRdvwIcHwjEcMjNOCIX
	 cpR4K9Bia0UdUBkWTgQkt5sEU9XnPv0fKFGlE06CQZ+319mtbzB3efIxtEouMC2IbNGd8
	 lxH7/pPde78jg0hMsi5RVhoE7dpIZFVni3qwvpKjaK8ozOuuP6mnvKZxjhD4QoDNRZpDa
	 DrQ/RaoG34dNS2yXfMoVf5Rrfky7jiIPeNZ4l3wkrkOhdZ1OOLS5QpAsHSk79dE1cfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HEeICKi1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD9A606A31A
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 22:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HEeICKi1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89DEE1F01816;
	Thu, 29 Oct 2026 22:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793313591;
	bh=zQ6uNo89nejCaAU7k5tj/9f4wgEOYJASxK8zmXwc9nE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HEeICKi1KAbTQJ38DCGz6ambIK5AMfL9ZGgREySTEy4nLdQhh00fXxiGrAirtykW9
	 LDPmotpdUSgW3Ddtp1BZn/cJdOiHh7xPRclpEwZFrdhYHpIbsjzztnpt/9k6gNYX2A
	 Mbgr60Kp5vibfSBF7BWdiJCLCos8lxjHMgJCHen84DQglBHj6UXw8UItc/AAfhI+iF
	 ST4MfCH0rqQwZPpXVduSJ9CVIRRdjC7t8ktilkCwThOctIETOquNzHpjH0O7qGo6QG
	 0BbcmkwHoVty+GJKepgxOlxAiKiQZDJnJ6uaz3D7qOs/OwzVMsLm+GLf0uNG6rItMY
	 Fa4EjKRVA8K2Q==
Message-ID: <sashiko-outbox-190091@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/7] dmaengine: dw: Fix XFER bit set, but channel not
 idle error
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-submit-dw-dma-synchronize-v1-v4-1-fea447d9f285@gmail.com>
References: <20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com>
 <20261029-submit-dw-dma-synchronize-v1-v4-1-fea447d9f285@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 22:39:51 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Serge Semin <fancer.lancer@gmail.com>
>=20
> If a client driver gets to use the DW DMAC engine device tougher
> than usual, with occasional DMA-transfers termination and restart, then
> the next error can be randomly spotted in the system log:
>=20
> > dma dma0chan0: BUG: XFER bit set, but channel not idle!
>=20
> For instance that happens in case of the 8250 UART port driver handling
> the looped back high-speed traffic (in my case > 1.5Mbaud) by means of the
> DMA-engine interface.
>=20
> The error happens due to the two-staged nature of the DW DMAC IRQs
> handling procedure and due to the critical section break in the meantime.
> In particular in case if the DMA-transfer is terminated and restarted:
> [ ... ]
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA c=
ontroller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: require a locked XFER event and handle an empty active list]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-submit-dw-=
dma-synchronize-v1-v4-0-fea447d9f285@gmail.com?part=3D1

