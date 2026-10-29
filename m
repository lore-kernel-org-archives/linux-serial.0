Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793259764;
	b=tfwqOy7EUIDuQdpLKZ1g0nPycSGmDzHUqMyyZJWkSBWqz7UuOAbhc/TIKwUO5cJPSrSB
	 6T7n5k1Fdp8Z0XkbgmvayunRTUq8B0iEJqPar9VxuQT9p6ZO2J+avZz1DKNmmmpX+xqJ4
	 fZaKGIjqJcKhxp1P3YZDll3Bc52BC+/5avcbJc9+5jm8gadpOFtCqtCCg9obh0reeD/2L
	 JDtwZa2mLC1yIZ3IeHRV6kZbAIhXKflraqLQ0oyTnAH0WjDusLrbQZWWXzVxcKDJUQY07
	 5HB/NFiTswQTSYGzXFeX6LELR2e9nrF5201h9rxPiK++xgckIJNFH1shf/fA6NHxFwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793259764;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bKNoF2+BENaS+GT0hDnAzaVoO7rsgRcGgxLHCs8ZUJk=;
	b=0HlUWwMqsE3HWdFarqI0RgUgVJ/FiDpGtCuXiKd4sk6TbcYcI/i55OM8J99Z/ig6h6lR
	 8AeQpBz+pkiyrvFaymOLmm0TMfjLhWBxtJkyQrZBWhigDhnpxoMhOIi5hr0tLytPXIOKh
	 C1RddVjVc0fQA5zPPZ2WZdU58byFO5TE0yu1OvWw/7EBrJMJqUcaZDb5gK070AsPtXW3v
	 n3RngQ7MQWly8W0vHiK5lJLuygZLYoezcuuV3TWVfqbd3smEvetiiDHv+QrVqQNI5SvaU
	 sMyPylefQWV/WAyWlljz6YTABEswnyBNPfH3ef3cRnj7hqt2sc2g3CsdhP4lyk6S/1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TlgFYXrN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E497606A31A
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 07:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TlgFYXrN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A291F01825;
	Thu, 29 Oct 2026 07:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793259763;
	bh=bKNoF2+BENaS+GT0hDnAzaVoO7rsgRcGgxLHCs8ZUJk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TlgFYXrNQr/Ci1vR9f28Fn1EQILKfc42PwV4ek2P3sf+Q3s8iy8te9ZUPzqzuwf2y
	 VyKtl9UgZP1DXREWcUxCuAhGbXI4ZrE5SPm8VQiSw4VqXOtZfVlYVu9cLS4JvyQXeU
	 Dv4CGV5kA24sWfiZ3PTqVz/lZW84bah+rqP6FSokFimDLTV3GxDaP9cq9ath5haruz
	 /HV7T3CgrLrL88p39XZ4rEFBs8r6Unq/Fq/Z0HpnozQz2KExTVcCE/8y0k6PIRthN/
	 uMY+PfjEFCsnRkhoVn58hqFuTkTUckxClqSrUzqqII2+IPBfWyyhANZeqbWqYK2GVe
	 nh6Gmn20JPlPQ==
Message-ID: <sashiko-outbox-188890@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/6] serial: 8250: retain DMA resources when
 termination fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-submit-serial-8250-dma-cancel-v1-v8-6-3fd56ba352ed@gmail.com>
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
 <20261029-submit-serial-8250-dma-cancel-v1-v8-6-3fd56ba352ed@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 07:42:43 +0000
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
> A permanently failed DMA engine blocks close or removal. This deliberately
> retains the buffers, mappings, channels and callback context until the
> provider can establish that they are no longer in use.
>=20
> Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-submit-ser=
ial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com?part=3D6

