Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661733;
	b=j021EGf7C0R8YBTzCqChNA7goyxSlv8crrDdVErbTbpsQSPLiMtP52xY22TCfObKFMUy
	 eb8yekFkXIhEJvuViY4Xp7AkNVOadwyzN7sqCRgYHq3lpzZ1DMPMlJvgIGFOWdC0sH598
	 sBVu8gMCqmyjmKjmztrts94KC7tlgmeoaRGxfYt7GABSXmKvAMMCgfYE2JzzA1a31L7KQ
	 qyM7hi3D55W2aw//z5dw4vaDlh8CBayZhWfl/SZcJKmIrDwe9Hw9dtv9KDxFFl3VDh1+R
	 0uXzjoDXbs1Y2qR95cqonTniQClReCQexq+HIFL6D5yqjG/mKZ/HB65WyfGJodNABMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661733;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EJntW4sE1R6awD6CuX5OdObbrbfpjinSguufJYZ7kd0=;
	b=3jBb6nHfa9j0fvqZ6DumCFvpZq4a/xYsdYwx3iSfsXTpKiXSfmujyDJOIb2HKRFxKlum
	 hI/hTokwqUsa4ouKqHQw9blEZi1w8HiMiVmTL0TfK5OWSZBUp2iJXnm+CocVwtOJKj1sy
	 RkOuK7VX9KWn05KVgG/BT/svzXIDsuashYegOTtmzhhJ4cBFpa/HqiahxdiMcXNSKoTJY
	 Xi31Fug/Pg2j46VM7a6D28NNPTDhtqt+TeCii3B7aiKW45IbDfgTnVdcA3Vv+nEgpXAPx
	 5HCurGmuMNpOucC799vak9Mqnj9tqxb6B4Kjra0c9qu5G2JdwRbWC9n4TV8BKaxxgPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q0VbvgTf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED52C606A324
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 23:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q0VbvgTf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694FA1F00A16;
	Mon,  2 Nov 2026 23:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793661732;
	bh=EJntW4sE1R6awD6CuX5OdObbrbfpjinSguufJYZ7kd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q0VbvgTflBkPM/Xx1miqafD8w2akw0j3k26HUa7o7dncUSYlwiYfq1lO+LA9CezzH
	 hjBjq1Ti7oonLpa5tFgFY0XeI34X29XGmaXtQXWjE/VVr/cAfXiUKLRT6j+ufkOG5N
	 8nuHhrRz9Yqh1he4c8Ko6yQQt6zy3W+2OQW5UTWQNIrhJYxkLO/w1XFsnOcmYSCQtq
	 wIzWV4vj2tNg4EHN3gr/LZOCn9jFJOh8rrQy1+v4my2Rp0cL2gQ3tzr/Baq0bmjlY3
	 EkopYPwEBsVtxxNs2xtw5G0iNm6tUeD+ZZr8SrU8qxL2m247uGHReFt9SA293jWpDi
	 9sNq+jZQboMnw==
Message-ID: <sashiko-outbox-194329@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/8] serial: 8250_omap: quiesce DMA IRQ handling
 before shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-4-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
 <20261102-submit-serial-8250-dma-cancel-v1-v9-4-9159caade148@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 23:22:12 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> disable_irq_nosync() masks the UART interrupt without waiting for a
> running handler. That handler can have observed up->dma and continue
> using it while shutdown releases the DMA channels and clears the pointer.
> Synchronizing the IRQ later in serial core does not protect those accesse=
s.
>=20
> Publish the DMA shutdown gate under the port lock before the final RX
> flush and interrupt masking. Have DMA IRQ handling check the same gate
> under the lock, so a queued interrupt cannot restart receive processing
> after the final flush.
>=20
> Drain the UART IRQ outside the port lock before releasing DMA state.
> The lock excludes competing RX processing during the flush, while
> disable_irq() also waits for a handler that observed up->dma before
> acquiring the lock.
>=20
> Fixes: fef4f600319e ("serial: 8250: omap: Fix life cycle issues for inter=
rupt handlers")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-ser=
ial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com?part=3D4

