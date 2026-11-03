Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745092;
	b=5JktezN7rsPwV5FcpuPQJr7hAkUl/xDxyzKFHJ7cEq3lmP9HOX8vu0+/n98QwcKQ1C5q
	 YVcEJ7WvLKKw9TMVP6u1iJjFRnvdZZcBa4BPbS0XfWlxIIhypag2nFXu/OF6Of4y47EeH
	 N5hfIyzkobJJQOBXSuwEh+olm1EAXOFnhBairp0A2vWL7Ea/cHYvx7mrtUboIXOyeT5uA
	 nDhCxR3cMOCqzLRp080YvblUN0FBXvN1VTiG+IGW3MsfR0/dCOC2zGVSfI9SjgyBOioAC
	 ZUSNrG7F0Zmn6Ezzz2Bo48WrXAOeni/HfgGo5Wz4EyvUNiNC8qNUB0s8vCXg1DlK59w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745092;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ms7VphJeaavoqp6TUZIc0jlseRy2iyXBIA0lMvXllD4=;
	b=O5kteUcR0xPX6+qFCtVPBGN6i3pNOCGLCF92TSWvQImn2E68AtLyda7uDFF6CIjVhAqr
	 tAVpWOL2S6ZSJsgAqBNYkuIPh+4fvO06vRI1DRhKmB9Ook72JB/czWO4tY5BZ766A1XyF
	 atYkAgsmG+m0VwZVPrxzbeMgj/7k47YtAmaQsKCYLSRhyFjX+d1Az9lyKhb5VGE4kxZFa
	 gR56Rm5r8eP8ZDKCkJVUyb5gj5sHqqiLQqFZcPs3m5vOpMWmtclvez3dJ8PAKKTUdzYk2
	 bYdRR8hmVPZdQxoflFbCuPjiaAOf6pxqosbAqug/E8WknVf/74faHakroYhVWOl1Wmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g3RL7rbS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB22606A31B
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g3RL7rbS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC32F1F000C1;
	Tue,  3 Nov 2026 22:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793745091;
	bh=Ms7VphJeaavoqp6TUZIc0jlseRy2iyXBIA0lMvXllD4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g3RL7rbSDcnpiF/ptwvy1GOiO/jLN+wPA0yPVWGfztQ+sckS50ZdydiNKbJ6LXX1/
	 UsYy0U6UvoUnRzHeFGp1qX8Npf1cZo6Kn5nfHOk22Yb3wxpItdQB2AM2VytCK4Ru4b
	 +TGX552MLsx/p3Fw3Ed3EhSudkswM41H+f4joUvGrUE5QpFqmrTAQKjcf5/HFzSVIj
	 CwcX2+e8ghtzQLN1ixVDz6W9VSoM/xaqyEMxNZhnQ1+4XVhyHYtZOLmFQDrn+OFi0w
	 S9EDu3CkgxcdRq3hXWUotyYKcgnZRDneAQpQeXDf8HnyUt6kV6DXbmyM5dFKjlULT0
	 bdysHpWejHF6g==
Message-ID: <sashiko-outbox-196118@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/10] dmaengine: dw: serialize error recovery with
 channel termination
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-submit-dw-dma-synchronize-v1-v6-2-2ee0c348224d@gmail.com>
References: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
 <20261103-submit-dw-dma-synchronize-v1-v6-2-2ee0c348224d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 22:31:31 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The tasklet samples RAW.ERROR before taking the channel lock. A
> concurrent termination can empty the active list before dwc_handle_error()
> uses that cached error to select a descriptor. The list head is then
> interpreted as a descriptor. Even with an active descriptor, moving
> queue.next unconditionally can put an empty queue's head on the active
> list and pass it to dwc_dostart().
>=20
> Recheck the error status under the channel lock and stop the channel
> before selecting its failed descriptor. Only one transaction is issued
> at a time, so take that descriptor directly instead of scanning for
> completions first. The scan can otherwise complete it and start queued
> work before the error handler has identified the failed transaction.
>=20
> Detach the failed descriptor under the same lock and use the queued-start
> helper, which leaves an empty queue alone. Clear the software-LLP flag
> before restarting so a failed multiblock transfer does not prevent the
> next transaction from starting. Keep the completion callback outside the
> lock, with the detached descriptor owned by the tasklet.
>=20
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA c=
ontroller")
> Fixes: f336e42f73d9 ("dw_dmac: Move single descriptor from dwc->queue to =
dwc->active_list in dwc_complete_all")
> Cc: stable@vger.kernel.org
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-submit-dw-=
dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com?part=3D2

