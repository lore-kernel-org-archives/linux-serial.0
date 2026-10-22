Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792689902;
	b=qXoQ6ylg1jBfCz+KUlXXVZ+5zgmzKJukupi2MPufbVwXVl4wN34tDk8ImVLFRJOjBI8h
	 lXj4tP5I0OHXYiZnbn/My8nmwU/kyykOCPweIEa5Q8A4aqooYHxRBJG6HbkOlG839Q+kJ
	 ggQkOsjMMLjsXILFxRNNj2/2wvoCNeBGRhorcktFZoeXoWlpXVUHWHSb4Ic/01s0tlL01
	 fS2p/qbfja03L/qZn09MjvLZOsuLJmwIFXkes7CLdN0LOmFnkzKT07yxynIOew1dIiitt
	 O+Z+pIXJF1ch7ije738J6pGT5jUz3C5vLhHO1vMxTLzbOXFq6tt/+CLPHWseJK63+TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689902;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kqmNiBHxEcbEugkEHjnjyQ07ZL0xxgfd91FSZ3m1uaw=;
	b=xU7VbrjLw5Yzc5xLzBi2tqY1ZNccdAbOfn5Tu6DOrefeg60CmxuPutJ/ASocD7Ap0RDp
	 vcpwWzxBaRVSt0YvLsfv/TaJEtoPxeqmgu3iHtLq69qigwDxp8YOkfcUh3Q+aBl5Ac/Ux
	 mVAlDB+HTLZcCvjkxpKiqjMRo/2e9fK8DNsU+oRbwKQqrl+K1fvhXMoHdbSwxEDPGk/LL
	 RZMBkq4yf94+JPrySPGSMkhCHkdHt0+8yEBdLYd0lmII/3lebH02fw7HqenHBxxU6Uwq/
	 t31V5QhFb9HgN9kqHMDnYn+QbzY4iLDlws2KNEcwPoAOHiH3PZPDs6CUQcEqc1yUb+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hsqR/Et1";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4ED606A319
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 17:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hsqR/Et1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76461F01828;
	Thu, 22 Oct 2026 17:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792689901;
	bh=kqmNiBHxEcbEugkEHjnjyQ07ZL0xxgfd91FSZ3m1uaw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hsqR/Et19WV0e5gGmcFkeZYjJ5d7GzCA9nfMVqRrCjLkrbyF5f4GL2qXdnHSbnw+/
	 PuR1qA6Q0rhpKAis9eQonmMqgfwMOBO3uhPgffmPhmDySdkgEdw3NvaQdPhkPudsfG
	 Lohxuw74tOg1Ttf9aCTW3APSoXBQRyyrh9a/fYwHkPX4hfBpSf55o0AzaJr7Iqz8i3
	 0uXW1qR7shhz06Gr1bH7KVD9Z60bBylZpPgj54rEvY7iD2L+j/+ucvoIy1vnDJcT1y
	 2GHToi421AFIlfU6PnQtZi0cmOUJbM1sFCJsQHGYvQvH7mK0QZCbJK97gXsPfTB82A
	 N1l9EaFcrqt/A==
Message-ID: <sashiko-outbox-181856@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250: release the transmit PM reference on
 shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261022-submit-serial-8250-tx-pm-shutdown-v1-v1-1-0e894afa3bb8@gmail.com>
References: <20261022-submit-serial-8250-tx-pm-shutdown-v1-v1-1-0e894afa3bb8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 17:25:01 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Transmit holds a runtime PM reference until the transmitter-empty path
> clears THRI. A hangup can shut down the port while that reference is still
> held. Shutdown clears the interrupt enables and stops DMA, leaving no TX
> interrupt to release rpm_tx_active. A suppressed DMA completion cannot
> release it either.
>=20
> Drop the transmit reference after shutting down TX in both the generic
> and OMAP shutdown paths. Their separate shutdown PM references keep the
> UART accessible throughout cleanup. The exchange in the helper also
> handles shutdown after the normal TX path already released its reference.
>=20
> Fixes: d74d5d1b7288 ("tty: serial: 8250_core: add run time pm")
> Reported-by: Raul E Rangel <rrangel@chromium.org>
> Closes: https://lore.kernel.org/r/20261022152019.1621716-1-rrangel@chromi=
um.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-submit-ser=
ial-8250-tx-pm-shutdown-v1-v1-1-0e894afa3bb8@gmail.com?part=3D1

