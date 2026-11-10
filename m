Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285333;
	b=lSLAug9Dr2skmWRt7KIz59sWfoKKKzQDHyvdmxCMNBHuIx9GsNqoO6M3e90i4aBk3WiS
	 nmBEtO+IQjuE8GL77cMvqhyLOdvcjzh70468wix9mORN6RFunyucTk8q9iI3q1DdX8ePc
	 AHdfaJvrBA/JcZ24lhKO3Z1vYvFZemkpYM8z7fEukl2pUoihttCA+2RJ0NKBu2gp/2eUr
	 cxxS/oWYcHfZd6JCZ2f02jMJWJoMYdMdVwDtIzvocNeBergBryv0v49eCjvLOiA1k8qtQ
	 7aiFx8tBOkALj3DLlylyshhPJ5qTCemKgWp5nXgPsWH+46sMGSNHLaGnQJxbvLYAccQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285333;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xablX5XNkX3QNZMASuar2MHWtpRVbEf7qqw9k7gFIcs=;
	b=UpnykKHc2ILj8WN/tmx1/us6Plf0qfH5pPfHUW7ZVWU2QJqfh1HXlRf8fFrNJXOq8D2v
	 5bZ65ve0SAXxfeu/L5Mx3rCdv9Zm9W8AMAUTpjx8DhWgtNuRwpWHtKEL9gk/ioF3EKhf0
	 6J5t1QqOECn+nq+v11r0BflRCIM86q8YcEHTo3wV2e93DnlIfpNyebJYT+P0sBe9xsBiq
	 d2glW8iXPwF/tiYu6pi32xZlyI8qsOICGq0zssNm2XjqfLQ85qg9ohE5m+5pRidtumY9X
	 B5OQjfodP6B+RkNQKEfcHn/GnoX01F1R66wo2K8qKOXwuok27u+7lDYounXZuHy+vRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KdsxcOP+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA07606A332
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 04:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KdsxcOP+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB53B1F0089F;
	Tue, 10 Nov 2026 04:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794285333;
	bh=xablX5XNkX3QNZMASuar2MHWtpRVbEf7qqw9k7gFIcs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KdsxcOP+Oqlg1+Fnc22Ip7jxWYBQ7KwXodBM8G1bMCCCPvyUQR9W354q6E8gcaPsV
	 bj/HEE1H9y0Mg2duvR0HHx4Sm3j9y9Spg3u2Srh+UIsDIAJs5iG3eYFDBBPy9gRFM7
	 3ewFCFrzU4+oTmx1Kqgz4jGqFlBnuKylC7ZzI7mC517m2DP0ciVKQXXPncEpZuJeoC
	 p4FDmiqhyKbzjZdP3xqU0hZ1AZkF7/HztegI9SrkkONwVlw357EQhXyxeBaCANUNYb
	 UiJRrAwYEKLMl/ZpxnciHtgCM3BxqL7uEg5l2Kgx0LFUFlNMppAshMovrcvpf61EYL
	 xlbZoocgSiI3g==
Message-ID: <sashiko-outbox-206214@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 8/8] serial: 8250: retain DMA resources when
 termination fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261109-submit-serial-8250-dma-cancel-v1-v11-8-6364edca63d6@gmail.com>
References: <20261109-submit-serial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com>
 <20261109-submit-serial-8250-dma-cancel-v1-v11-8-6364edca63d6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:35:32 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> serial8250_release_dma() ignores the return from dmaengine_terminate_sync=
()
> before freeing the coherent RX buffer, unmapping the TX FIFO and releasing
> the channels. If the provider fails to stop a channel, the DMAengine
> wrapper returns the error without synchronizing its callbacks. Hardware
> or a detached callback can then access the released storage and state.
>=20
> Checking the error and returning early would not preserve their lifetime:
> serial core frees the TX FIFO after the driver's shutdown callback return=
s,
> and port removal can then release the callback context as well.
>=20
> Require successful synchronous termination of both channels before
> releasing any DMA resources. Retry failed channels after a sleep outside
> the port lock, leaving channels that have already stopped and drained
> alone. Keep the shutdown gate and storage reservation in place throughout
> the retries.
>=20
> Start retries with a 1 ms sleep and double it up to one second. This
> makes short-lived failures responsive while bounding sustained retry
> activity; neither delay is a hardware timeout. Report the initial failure
> and ongoing failures with the elapsed time and current RX/TX error codes.
> Track the five-second progress-report interval separately for each
> teardown, so failures on different ports are reported independently.
> Report recovery once both channels have stopped and drained.
>=20
> A permanently failed DMA engine blocks close or removal. This deliberately
> retains the buffers, mappings, channels and callback context until the
> provider can establish that they are no longer in use.
>=20
> Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-submit-ser=
ial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com?part=3D8

