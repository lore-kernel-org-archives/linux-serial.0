Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745499;
	b=1ykrJXvEnIqKBPHjb3dSxxn94w/UQh+NZRukCa6+Q2svUSKLq6DMraHg7Pvg9qo5aGdo
	 oynXsARPdnOfuUDw5hrfQOi1FOiw71ZrwJwiru9C5XFJmE84yDdFvTOU7PUh6Zy20ZHRN
	 esPZzUFXFo9sOYQXCtbMfmVny+hl8YO/rhazlkic/WpvhyJlOob3bsqrSfPhIyKqmnARU
	 /RZQ02XFms1DADymsTnVKLss85aI7JvNo3nfbabsc0Ss/8OBgkDuB4fv+T/IdvvXxrllc
	 nFH25/xAxMYXIzTiSFduOJletvAD69vt2X1eymSiybnNj1Im9Rimn/O2bqCJ9GjiCjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745499;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QtYr21SmfZ7lklgut93O07WItXjCC9YPpS+SZfo3umE=;
	b=nlMRtXNCD5HifsRdOxRVKS6X9qJL7LBn7b4dk19QYSljAz3vn0FcG+cg6J1CYry7dUdK
	 xEGC2dV5Rj639D6IMIeOKZVVxdU1/jz8TWzjgsBcsbiUfOaSzT24bau+/KgifwPKvfuf5
	 KUPDjVg8LS+F5yF+n+KWlCZhvG62ApdfnUT7Bnp1r2o0gDJEiQWQ96FsaTJBYHTIgD6YJ
	 1q6BkQ/XCms+q9rxMdqwrTqjy2hz/0Z8JzFefJz4JraX0Vayl2gNldItWm6+qoauCr5fV
	 Cmz82fvfzqMttoWUzVZqapZIVsSJoS4AusJLYUr/6yOJWYhiUWkAzA1IojU6QBilLVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D5m36DrF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F15606A326
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D5m36DrF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDB71F000C1;
	Tue,  3 Nov 2026 22:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793745498;
	bh=QtYr21SmfZ7lklgut93O07WItXjCC9YPpS+SZfo3umE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D5m36DrFwzmUzjlWvmYXZd1LS7gxO3og9zrv5hY7UsJBDtHHaMK0UUsdBnXm0rDBN
	 NyE24MGhsxj5r7VkwMkqDJng9OnyNfA0N50V4MZZAF9GEGnVyACAOE3dvJc+zTycW7
	 SdvZq623Hifb8eoXHu9ILck5QXOFGDEB2/S4slVEfTgdpasJDQihJv46E92goXaDti
	 WgOojVJpdEzJSFyMdxHkp/HUenH4hW7/iQXeSASKypGoc2r3x4gysUn22kmscAef5c
	 5/z87HHH+1Gu7Tb2xNa1cQHiyUt1oVhh5Cy+Cogzfj5mSbJtM2hwF/DYi6a7yOkUSV
	 Mznc/0mAZpx1g==
Message-ID: <sashiko-outbox-196144@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/10] dmaengine: dw: Fix XFER bit set, but channel
 not idle error
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-submit-dw-dma-synchronize-v1-v6-1-2ee0c348224d@gmail.com>
References: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
 <20261103-submit-dw-dma-synchronize-v1-v6-1-2ee0c348224d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 22:38:17 +0000
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
> Cc: stable@vger.kernel.org
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: require a locked XFER event and handle an empty active list]
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-submit-dw-=
dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com?part=3D1

