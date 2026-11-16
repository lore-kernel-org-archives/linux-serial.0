Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826975;
	b=JHQVtu3jhxwGJL8KkyloPor3WgIrVta1O9Yjx9y9hNfGJli6doh7lENSpKcio+LWEdg7
	 h+I/D6MxtHsbIEu5WL/Rfq9NDNosLJQb/GdpqZvDVFf1CpLcLkUf7veTQwdGZceQOQHkd
	 7indsZfGUHksZK7KzwL3SUJrGGO7T577KSZJFVgmL31vV9pTq7QiYk90kr4Kdw48Q8Go8
	 CCbZ6LejiTgzIuUwiW7EPWGOBefGhk/T9DBYwdMHnD9nkF4W4M/aXCp6DNVFS16pHElEA
	 vGd+fE1+BC1glKfkcvG7coyyzlmbXk6UfIECg4UaXCubIdjgihTDJeCStBqolokeb9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826975;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vjJe6HxJYIXWabe7j7mAT0YzlnQM7+LAf23TbFN8cWg=;
	b=vJUMauFNWg4eqdBq+G2ZVTrcCYPCf0ySTxZxM63k7/Rkz9fcFX/ISHgPmh9g5stz9TAz
	 PXUaqs1Pj1OghZtzc6OVNWo0+0gYdf6UloMNe/4hxgKu38OYrUBV6U4+yOSeirsLe/YIy
	 GLPPF81pYEiqPLv7mVDc+AplWoovXyieFBoXmZUlfecmorMsPJkaed/crhc+dlb68gja3
	 8TlIFJq3sE5DamQx4NoL+VrMsC7SGcxqXJIlO1SxBJy6lYzoDV6tKE12Ped8pTyCpD3Kz
	 ztI+pC6Imu+L2cJSWRzjOA+dvgb6gx7BtBwgHj613K0SxKGnlejDWiyKx43yaRil2IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jGPnmKp4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE907606A32C
	for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 11:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jGPnmKp4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0BC1F000C5;
	Mon, 16 Nov 2026 11:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794826975;
	bh=vjJe6HxJYIXWabe7j7mAT0YzlnQM7+LAf23TbFN8cWg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jGPnmKp4e4UvGmmD7LQmdwUazBmOAxpSNkD5e5HZAxMAMMEdhjVWHOFWYCKddb8Gq
	 b+pYmGrAk0fYwGYxfZCsOGbQEg272DPhr9jgNBZPoHOKdwE/MOS9ke5jIg9OfAGzq4
	 0dtqI0Z0Lye7KWSnkgmRSvblANPc6hPTlzxjDy5P5rE/MrIsjls2aoajYIXVEI87y3
	 KnJ18QYKojPoambMZQd89u0crNo6Csg7TMZhYKsJoZTzov0NX7QxJBrcfME4dEzI+b
	 eHX4Ma5k8HxbsrzUFhl6ZuMo3lS6ca5FnI5RxjPzhDTNmaKA4zeYHFEeBfaa43qJY9
	 uscfhwrDY91SA==
Message-ID: <sashiko-outbox-216829@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/6] dmaengine: dw: extract hardware-LLP residue
 calculation
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261116-submit-dw-dma-synchronize-v1-v8-4-4a82d64fcd1a@gmail.com>
References: <20261116-submit-dw-dma-synchronize-v1-v8-0-4a82d64fcd1a@gmail.com>
 <20261116-submit-dw-dma-synchronize-v1-v8-4-4a82d64fcd1a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:02:54 +0000
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
> Move the hardware-LLP residue calculation into
> dwc_get_hard_llp_desc_residue() so it can be reused independently of
> completion handling.
>=20
> Keep the scanner's LLP snapshot, descriptor updates and early returns
> unchanged. Only one transaction is active, so the helper updates its
> cached residue directly without reporting a completion indication.
>=20
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: extract the calculation for the single active virt-dma transactio=
n]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-submit-dw-=
dma-synchronize-v1-v8-0-4a82d64fcd1a@gmail.com?part=3D4

