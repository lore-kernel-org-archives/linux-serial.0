Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532074369A
	for <linux-serial@vger.kernel.org>; Mon, 21 Sep 2026 01:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789954588; cv=none; b=Ohk3GuLdmH1ccoY4+mctx4pco/Aoem/KxO+KBjyjTSMNupq8k+BBDFNGqbLIHPBmvQrRONLvkKIrC9zklpvoKRzu8Ix5BwYzGeWN+yXtcuAuT78jmiG6iTGLbLUKQgRm07hjtB26q97ESJlovNYs032v2Wq93R3YaR4y44rGyK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789954588; c=relaxed/simple;
	bh=uxGFmX3FZo4UMsIrDHhbdmn3kgKgyNfNqzWD9EPxVsA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H+uIvz1wngspcXEjEC86efTeTxLMEt1pm09fz0pVCZgoT7vlRbNmGPAjDYZ/UNw0igkEPX1fixEu2MCCnr6oYsjRdNQSHxEHjLUmd6Bo3CJBom4AOdKsKS4Dv36o4CHfLQ3Nkzsk7hKskOsQesnG0bhI8LDGdKGSSfl5hO1XNMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSvyXSla; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSvyXSla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5731F000FF;
	Mon, 21 Sep 2026 01:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789954585;
	bh=uxGFmX3FZo4UMsIrDHhbdmn3kgKgyNfNqzWD9EPxVsA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gSvyXSlaNoNpdw5o0qpto+kO9mef3JIVDUsFIK5LLrwNK9sTGbfNvAHqu+wBEMNrI
	 337/XYPBOTBVBRXXWp82QSLN3PZe95h7AcuO0P2ryUS9hB0q1wJ/4pzfd1u69yRdER
	 f0t3Yx1slqqwJ75KVobMMhBoSCK4hT9dmJ+qrOaZegCZMzpj6I/fQLZjyMB3sWq8RB
	 6E6U5CJ2LxlWJ5VDkc2ee9yhViAIaB8iBtbpNMugultfTe42igB809/nltHaALvACj
	 NTchYFjML5wPU+YpL1rZmN+X4c0veyk4H12jTVFi8ytslXRXXtrtLaQikx4kDkEH1J
	 j92x0/M86U/lQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] serial: 8250: hold hash_mutex across IRQ chain
 linking in serial_link_irq_chain()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Peng" <benquike@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260921013027.659965-1-benquike@gmail.com>
References: <20260919222627.3797854-1-benquike@gmail.com>
 <20260921013027.659965-1-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 01:36:24 +0000
Message-Id: <20260921013625.6E5731F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> In serial_link_irq_chain(), serial_get_or_create_irq_info() acquires and
> releases hash_mutex before returning struct irq_info *i to the caller.
> Before serial_link_irq_chain() links the port into i->head, a concurrent
> serial_unlink_irq_chain() on the same shared IRQ line can observe a
> single-port i->head under hash_mutex, remove i from irq_lists, and
> kfree(i), causing a use-after-free when serial_link_irq_chain() accesses
> i->lock and i->head. In addition, if request_irq() fails at the end of
> serial_link_irq_chain(), serial_do_unlink(i, up) calls hlist_del(&i->node)
> and kfree(i) without holding hash_mutex.
>=20
> Move guard(mutex)(&hash_mutex) from serial_get_or_create_irq_info() to its
> sole caller serial_link_irq_chain() so that hash_mutex is held across the
> lookup/allocation of struct irq_info, the insertion into i->head, and any
> error-path serial_do_unlink() cleanup.
>=20
> Tested in QEMU against Linux 7.3.0-rc3 by configuring /dev/ttyS1 and
> /dev/ttyS2 to share IRQ 3 with ASYNC_SHARE_IRQ via TIOCSSERIAL and
> concurrently opening and closing both ports from two threads in a tight
> loop with KASAN enabled, verifying 0 KASAN faults or warnings.
>=20
> Fixes: 25db8ad5c567 ("serial, 8250: remove NR_IRQ usage")
> Fixes: 99fc860fae83 ("serial: 8250: extract serial_get_or_create_irq_info=
()")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921013027.6599=
65-1-benquike@gmail.com?part=3D1

