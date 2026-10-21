Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618329;
	b=w6JZbV509vtWs38L5xJzc9HCugk6G07A5ZR7tvNT8i+jEqwSjNUlN3/DAX1K1thicNGo
	 iu6Xldq0BB0co7NZ9JK1VVK616oL4mUpmTrzxaagqxNlKikIphboIDZmr2sPJsyXP0aIl
	 DmzF2IF3nGAFW4uDyHnnRCWx9oy820K/M4Dmh5026V/nTZrFel8wkRggBFHJoyTCLBzmJ
	 WirOQIZbJUDGhOeRKdklBSs8CA16nVz4wUkI2gnRbqG3d2/i8rDRrLKmheJhLNak+mh4Z
	 sY3NtoaVbT45HmNsflZy8G5k5s7lUZcKNlxgsFeWezCJOa0jZfmBtofCi3TvJzXf1dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618329;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VzWL3a/TR5aD2VHa18S3DtQQXlb3jj6RMWVCC/3TwoI=;
	b=gmkTaaU7I6wPJ7WB9krkYgrxUFCk6T0a+JOCHSB/lVVvak13x0s/rsu2Qt4qVXsbFNK3
	 4Zpz1/3FR6J5t+kdzIS2hieICh14AEU6YbSwEobJ5hAFhX1dTLnV/STbi8CG9lCJeVd5b
	 NsUAOtnpVjbJxJpw9QNGOlGxYAc0Eh0Z1IqGwXPYtSNf6f8brDw4pHq7t21pyfUHgTrKO
	 tKfknCfRctYmbT8HJxu+INXtEmNehNY8rv6B77D0FRYLUxtE7imlr5Hfbvdp7XZMErfky
	 JsshUi/+u2SLhI+Ir694gMdz38M1GHqJOoq1uIsyk2A9J28qBPcyuosHzYkcsZfbWQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i5Ap8wUz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96450606A319
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i5Ap8wUz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0356E1F000C1;
	Wed, 21 Oct 2026 21:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792618329;
	bh=VzWL3a/TR5aD2VHa18S3DtQQXlb3jj6RMWVCC/3TwoI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i5Ap8wUzRVWJubwx0XmmWEexoz0E/k0WlEKZf2q6TWm809YIKIDxexg1pTMJ5W91Q
	 aeGAT12bRo4AdvLdCYx4h1Gw2wq5Q1JWtzMGHl37DAWgFUbBnARGIN3MDwFl8u9sWQ
	 muPtr+KGjDiz3ulNWmgldV7Ks56ZqP7dXgCy/QNRLpnCAg/Xj8Cod7DRWcWi2V2hHt
	 C7V+Uhe+Me63A9wBX3n+qHAvzQm3ctaJeH5jqXSCxYnztvV2OSBmTQdu3kJMfJXKYT
	 BmtWNqY5Ev0hW2MTk0CGtPNDFZoHgtf86mOpItI00q0+OHUIdbhgwuwBH2jRaev/i/
	 AbgPxDtxrXIUQ==
Message-ID: <sashiko-outbox-180708@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250: prevent DMA callbacks from restarting a
 closing port
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261021-submit-serial-8250-dma-shutdown-v1-v1-1-3d3ce383c614@gmail.com>
References: <20261021-submit-serial-8250-dma-shutdown-v1-v1-1-3d3ce383c614@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 21:32:08 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Disabling UART interrupts does not prevent a DMA completion callback from
> running. A TX callback can submit more data or enable THRI after shutdown
> has cleared IER. An RX callback can also submit a new receive if data is
> still present. A callback already running when terminate_sync() starts
> can therefore restart the channel whose buffers are about to be freed.
>=20
> Mark DMA as shutting down under the port lock when disabling interrupts.
> Check that state under the same lock in the completion callbacks and
> submission paths, so callbacks either finish before the shutdown boundary
> or leave the channel stopped. The DMA provider's synchronization still
> has to drain callbacks before release_dma() frees their resources.
>=20
> Apply the same boundary to OMAP, which has its own shutdown and DMA
> callbacks but shares the channel-request and release helpers. Check it
> in MediaTek's receive callback after taking the port lock as well: its
> earlier private shutdown check cannot serialize a callback that has
> already passed that check. Reset the state after requesting channels
> on the next open. Leave the Broadcom integrated DMA path, which manages
> its own shutdown state, unchanged.
>=20
> Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-submit-ser=
ial-8250-dma-shutdown-v1-v1-1-3d3ce383c614@gmail.com?part=3D1

