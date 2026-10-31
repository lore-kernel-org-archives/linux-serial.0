Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793407509;
	b=LScdoxyBTUGqeGWwUnZ8CZhvKMvmq/kU+TmSlKjDkaZA6gNdRFP265vNGInh0OBaD4nK
	 lfgzf9Nka6ONTHBF1bIUBmi4eWKrZCyqc6Gqt1UgFcG7Y+dgjKEPV8+qJG2wvsqbpKvdg
	 EsyQsyOg3p99/+Xi4qmaSrt/14cBtPZU6B5tpBJGG6HUXlERu4l4330CKeou5Izh/9LfT
	 qlodJHZcSp+tjXVmJ6asGgOatW062eD2io8T1ypQ4y7eDFC8wmIGcofYfZniflcB5fM6l
	 JfKV7MWX2x70szZ7JUO4ddbsDYLNoZzz96YtRiJNyDqUcnoKpLghxx30qdp9lNV0ovw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793407509;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pGnyp9wvcdE5hO3D9U9xIXN5sQPiIdKmpc61qDpHicc=;
	b=QC33++aJep2NqYTgNypzuv+7z+jF6W7Y7K1f8qL5JDlb7ig19gDlibRl8VDvqdkCptSA
	 SJxa9DglKKKTwpncKW1plurtfCxegrKlcCuprhWUjlhn6dSci399QiHX8e2ctoVwmKuSo
	 RqZTRSpjcTLy4bXLV5vQnhWFVcnUzhPbvZbk5dfdqKuiYrT/GWTgqzuiUAEgpAhYYBLqW
	 ZZ29LC0LLVs5aNUx2BuHB0TSHu0OHlsTUUt42PmXNJMJKnWuWNpzG+apQskID5SB+5/nC
	 1k8D7yeP88JIUjI1hRnSwaWvQiogkUUZvK7C2e5Up8xQ8rr61ruG2g9cA2VhPY9JCKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BWZu09Ai;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87780606A323
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 00:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BWZu09Ai
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEECA1F0093A;
	Sat, 31 Oct 2026 00:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793407509;
	bh=pGnyp9wvcdE5hO3D9U9xIXN5sQPiIdKmpc61qDpHicc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BWZu09AimZiUW6MWe3NvjDLNcsMqYByUs4f+zYFd37LA5V6KFL5qR2H4ndahGjkb6
	 mKASbMlpfet+X3NlBoDE5wNr2YtMqbmorxzHBENqho3XnUwCveWY36tT1vYdix1ACP
	 IocMAg1UxH39OnFF0bVFGF0XAfuFDNR0/vHgHnqQHlfjCyTIlmGJcMpGR0toO6HdDj
	 Z+gjuyno4vskmONB97evEeyVHMYcIen/qqchpSbXVrS2TLmQlQjlBRSCN7h4SjnQt2
	 8XXx7xKelvLtt36u+xiX6DERDxBiF3Q1H3bMBzy4pNrAy0OafWrEze4/aljZwan7DI
	 z3knKT8HEQW0w==
Message-ID: <sashiko-outbox-191683@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] tty: serial: samsung: pause the RX DMA channel in
 stop_rx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Samarth Narang" <samarth.colleges@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261031004217.3340610-2-samarth.colleges@gmail.com>
References: <20261031004217.3340610-1-samarth.colleges@gmail.com>
 <20261031004217.3340610-2-samarth.colleges@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 00:45:08 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> In s3c24xx_serial_stop_rx(), the driver pauses dma->tx_chan before
> reading the residue of the RX transfer on dma->rx_chan to determine how
> many bytes have been received. Since pausing the TX channel does not
> stop RX DMA, additional bytes may arrive before the RX channel is
> terminated, causing them to be omitted from the data passed to the tty.
> This also unnecessarily pauses an active TX transfer, which the driver
> does not subsequently resume.
>=20
> Pause the RX channel instead, following the existing handling in
> s3c24xx_serial_rx_chars_dma() on the RX timeout path.
>=20
> Fixes: b543c301c2c5 ("serial: samsung: add DMA support for RX")
> Link: https://lore.kernel.org/r/20261030162334.3000737-1-samarth.colleges=
@gmail.com
> Assisted-by: LLM
> Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031004217.3340=
610-1-samarth.colleges@gmail.com?part=3D1

