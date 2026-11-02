Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793662189;
	b=gN4v6Jka6PzM3ophe+ZHG4kja+EAxkErZRtxmUJuj9YL2R/4JvC8PKXt6gjhJkU+nn7t
	 NAjlXzVGmZlZj3901fJKtXN8bEVHWwBjvh3zJEfNipQKb9+3KdFA9dXaZbKQMEuuPdCKC
	 YS89BJY34lk86pf7lKkO8/COMk4t+nH4cHKwlFIV/aiCJzUcwVeMkiarANkPcBLbFWAtN
	 gPRZhGyf/UFPjb73gckFvS+Cg798XafgMYFzqqRzHZ6rJUE01PORtUFpfUmgufYRB2KSq
	 ogiEAj9NYQAqfNYvallHUKUMNuQFgUN2ayL3L7Dqf2IxCBfQwneeGaqIOiEPWk1eGNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793662189;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NoQ3QYyT0Si272Jege0kgtumq+j3DGhnhRC+npiuFTY=;
	b=1gxlR+5Y49QCSbTXSiUljOASr5Z4/giH1C0qQ264sVUBUzgtHJap+J7uFBy7yI5Iwooy
	 FuPwbXJvdE/LmJOYzAUbHfyvCRPpO1k6aGGSCtg2qYkdKVJAtkqpOhkJ7wen37c6A+RIA
	 b4tAx0UKDOwp46SZGbzW5hx2oxs0kiT7M731ysSL7pI9TdB+SbCbHrE4y4+QG5EcwcMX4
	 ywFG6HS/CNKfSwQOB8jQsscvO139v3e/NFy2gT3y7J1mMmhTGqteTbsHVjhqKXpYZ8tCq
	 1k2ehm2AGT4dMCnBqjFmPsIgVXNob/ETpbtU8mA1+mo0ExfLK5HamNy3ILTQ1WLzL6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kM9GaC64;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD24C606A326
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 23:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kM9GaC64
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9299C1F00A16;
	Mon,  2 Nov 2026 23:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793662188;
	bh=NoQ3QYyT0Si272Jege0kgtumq+j3DGhnhRC+npiuFTY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kM9GaC64v60scMSHNjaFVM3wShx2HJy2Bvu2dbMvXkhG6vbhSiclxCRanKtPzD2Tm
	 NYcFzaYKyruBRztzfO07YuDXsjpU3yRKmjYL6rkRxa7w76z+GffI0cAlAMAjXkFzV5
	 cMymTtX8aPpJK7zEtTuFpovMaqKa/wOtL9LVL3C9t6InjA0z7Nf8WDpQIlA38hdqpU
	 RLvfomLzzszhMSMiftph0YBaVbTLEYe4SuAd7Fy70IFf9EMB/++NXmZWvSUHJXzaWm
	 0i6t4Ej4jI4fKrbFVv+EsWWgJSk9tYMz4xTxNRWh+51eS/XQM4I8TBKGfvR4ZCgBki
	 0eyXF58j4rAyw==
Message-ID: <sashiko-outbox-194334@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 8/8] serial: 8250: retain DMA resources when
 termination fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-8-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
 <20261102-submit-serial-8250-dma-cancel-v1-v9-8-9159caade148@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 23:29:48 +0000
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
> activity; neither delay is a hardware timeout. Report the initial failure,
> rate-limit ongoing failures with the elapsed time and current RX/TX error
> codes, and report recovery once both channels have stopped and drained.
>=20
> A permanently failed DMA engine blocks close or removal. This deliberately
> retains the buffers, mappings, channels and callback context until the
> provider can establish that they are no longer in use.
>=20
> Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-ser=
ial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com?part=3D8

