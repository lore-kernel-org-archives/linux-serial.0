Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795083505;
	b=C8Wo+NbKPpsTZ3I8ygpvkrJjJ+V0zDTglvuiX2f924UuPsYzEPGKyRdl8TYNx3XUVD+q
	 xmUgZigCSCt4pwSoqMvMeBYIHLjWJ7G+qv1IAnzLX9mE8M09wto/QSL3OBJRCcbkD3emg
	 fXz+sai9YSHI5OELBJ36lHiWAoznYtbv7ptWKba3yl5/FbHH/I4/++lE96H2FoBgyEVvO
	 cR7zMjUvYsSKLw4r1frNdjFdeXNnSfRGZGUMLoR5QYl65Q8iFQN2y5zEz5UA4Jgt2EyZ4
	 wrt0q7xkR2sp8KXZ1p8+dhPIEjuxq7a7q+bRvQ2e3XCAizkehiOcSEqhqRVFzDv+9Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795083505;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=59z22h6gumyRoEn1YOoLaJLt46mBUNjVZyaedkF1Xl4=;
	b=tKlWH1WKs90ROsLV/M2Ww5dBRy3bK8L1duTWY6fohZiEyXO1tKYWjSUQdTAzq984ho1O
	 VWkNbY35230xM9GdBW6RV2OgcXOEBF+TVerG7cCRfjg8U7RwL+oHqsAFkq12m862FqI4I
	 FE/Q6FPE5YbARFBqdAUL6zJZTYCCfvN0uPREtZBBu/nfijLSJiO3YN7RinvG3GQgW5Osm
	 yb9oqoegbol1zVuivVbshkjgAq4ZzP8UjXvs5OMzgxUEb8orAgeAshS5ggMctcw1NfznC
	 h5lFfZYjfq9N8LGbnY3wGjvxfDR9EUGBD+IIZ1Cc9k5wE2xo4+a2tA8s/pUv54+HaqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OaEQBrDe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AFC606A324
	for <linux-serial@vger.kernel.org>; Thu, 19 Nov 2026 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OaEQBrDe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F1C1F000C4;
	Thu, 19 Nov 2026 10:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795083504;
	bh=59z22h6gumyRoEn1YOoLaJLt46mBUNjVZyaedkF1Xl4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OaEQBrDeSb6RxWEkKVAIXQtzuipHS4ktpq7ivPzb8tcq+XC7WM8iB78E5uB1pqHwe
	 4RT0IHFZow4V+KBipahgTcwklDUdtu7vE1cglhNrWWdAfXcP4ocBaaI9oygWjNX/AN
	 pahBtg9vEMt7mvzEIJsBVk4nWM6xop8iPNyp3CCFO/wUMRjYlMNxyQKmH6jzm99sWK
	 wCMz4q4JGakZr7wgvgOr8lci2RxLMME7tsX4OFEHvLvZTjUysR9jtv/Lyd7sLuMyeL
	 uYiNYATabNbMYFus3dTK28w9jSzKkXuuKWXydwxAx2eHQjrHwGyElaJFMhdqXS/MZT
	 fWNMpUI9RBTsg==
Message-ID: <sashiko-outbox-222941@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/7] dmaengine: dw: use virt-dma for descriptor and
 callback ownership
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261119-submit-dw-dma-synchronize-v1-v10-4-3a737597a0d1@gmail.com>
References: <20261119-submit-dw-dma-synchronize-v1-v10-0-3a737597a0d1@gmail.com>
 <20261119-submit-dw-dma-synchronize-v1-v10-4-3a737597a0d1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 10:18:24 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The status getter can invoke a client's completion callback while polling
> the hardware. An 8250 RX timeout calls it with the port lock held, and the
> callback takes that same lock. Termination also lacks a synchronization
> hook to wait for callbacks already detached from the channel's queues.
>=20
> Use virt-dma for transaction queues, cookie completion and callback
> delivery. Keep the active transaction and hardware state under vc.lock.
> Polling still processes RAW.XFER and advances software-LLP blocks, so
> clients such as catpt can complete transfers with the controller interrupt
> masked. Client callbacks run only from the per-channel virt-dma tasklet.
>=20
> An 8250 RX timeout consumes the transfer length minus the reported
> residue. On a bus error, source reads do not establish how many bytes
> reached the destination. Credit only whole blocks whose completion the
> driver observed while advancing a software-linked transfer. For a
> [ ... ]
> Fixes: b36f09c3c441 ("dmaengine: Add transfer termination synchronization=
 support")
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Link: https://lore.kernel.org/r/20240911184710.4207-3-fancer.lancer@gmail=
.com
> Link: https://lore.kernel.org/r/avrHOJ-fVZOO32bI@ashevche-desk.local
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-submit-dw-=
dma-synchronize-v1-v10-0-3a737597a0d1@gmail.com?part=3D4

