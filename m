Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099436;
	b=oOtK0BgCxpISZlRJcVcwzu/vKSl9M1XHTTI5QVYxtkvKAZpALDfyW19CTif03HQ/nMCI
	 PiqZeMYlpMFt914eplVI9iLaPusy35r+L0+NSKhhSS60xhG+V37rFAW9RHS+yie3DhQkG
	 oDjrJVgc83oWBqtfj1ZuHNZJRrQ32hjv+wEctyfUtui6w0kdvB3m2t2Ezhu2mWNE06Jgr
	 H1Uaa4lJLkwY2rMH3qu4B+3bqpaabiLsGqitmhrYe/h3l3sFy3CAnv+164i1Vi/B6CpEI
	 a3NkEEIDXBYeZYWqVzY04z3sXB77cRHWgEEUP+SNtLHtpTym07UWEMMGUKn/dClBo8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099436;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GaI/AWCP3GGtpNnI8+paEZfER2evw1y8OtVQ2DAfXi0=;
	b=BQURMpk00EV50E6DCY/014Cv5FWJOmIy/usV6kNzUPnt2hZoRxDsW447pnIiQTDDPQrt
	 kD7KzQNJ1nJpbzljb6ykcUFv3PdgZkiHm+1Zlf4Qg+VQ1BudNhsVtA6CKgtphmdXvvT7x
	 8+8Xs87Ae3S81S3X3H0J3fKrTHOj0Tc0WkO9YeOWQbiuAlH1a8ws4taWkSjl7LyPngGdM
	 KtORS1F/BlWq6c4WEcVoHQCA+MKcysHCe1ehJzVB1XR+502hDbqgnkEh50hnPjWqO+Zex
	 VzYIgqmcIef+Fhf1lrAdsIQJ0yD3yomR3ZOZviCXjrk2wbZRQX0AM7U8vPivyLHN4cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nXAue2Ff;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C3C606A31A
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nXAue2Ff
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FAE81F01825;
	Tue, 27 Oct 2026 11:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793099435;
	bh=GaI/AWCP3GGtpNnI8+paEZfER2evw1y8OtVQ2DAfXi0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nXAue2Ffv/Yvz4sBHEm0+joVMord0sj7as2anFdJb4ubsRQp7WVGxOQKhAocAAkDi
	 JA0/ttLan0lnXW8Q+DO+GZKMvbgthDZ53jo57J1vEtgh5t2y+ZjRVIV48G3/VDaWAv
	 y4iapkcyXLG8afqWrC9ZXPpLl/fjijimwxNwpgQGA2J6slShRjqvQVqnKKOf4p50Ge
	 QbltxW35PkZPkmAFjqKyW9vMhpSknjOBvAqURvni6q7MEnvrOE+7StNcGuHuPzOCza
	 EqlZJ7CQC5x8xWfv6ch72hF5tbTTYywzya8IcwWxXaVc/3M9yBmS7Z8kjh4OuovBQC
	 64AbcOQqwPjwg==
Message-ID: <sashiko-outbox-186412@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/24] serial: 8250: 8250_bcm7271: fix DMA address
 truncation to 32 bits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-tty-llm-v1-9-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-9-99b0202ae546@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 11:10:35 +0000
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
> The local variable daddr is declared as u32 but assigned from dma_addr_t
> fields (priv->rx_addr and priv->tx_addr), which are 64-bit on ARM64.
> This silently truncates the upper 32 bits, causing upper_32_bits(daddr)
> to always produce zero when programming the UART DMA descriptor high
> address registers.  Change the type to dma_addr_t to preserve the full
> DMA address.
>=20
> Cc: Al Cooper <alcooperx@gmail.com>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: stable <stable@kernel.org>
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadc=
om.com>
> Signed-off-by: Joshua Rogers <linux@joshua.hu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-tty-llm-v1=
-0-99b0202ae546@linuxfoundation.org?part=3D9

