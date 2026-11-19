Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082825;
	b=y7CJM+a5c90+zWe3v2JbLwWXqzqP1RwKXGV573kxVPKA+J/DDkhB2A3/BnPVH0MNu14z
	 sO3Clyl5jHgGBetueD0wj2/keZfH9BXj657SWT80eP9IsLz0S5tdgKYjNWyXovLjbQX8A
	 d/qo2T/xIX2in2Wq/p0g1o2r8Nhso7GxFs9rQ7PxhjIzCU1hZVUQ1s2ivQlXFSydJNXiI
	 5px+kYdCw43+Oe6bpHfJFKswDJ1W7O0ll2e7FBx9KT2GZOUbXVli3IQlGxYdV/tDdqXlx
	 TzwG+FgfVJeFTptqOjUpF3cIrK0naJGTayC88NEogVw6n6lXLel5GP1w1WY/l+yNg1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082825;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=W8fXfgv7Dwy+pliGNs2M6HNN1fevlvrvYxGYwwp4g9g=;
	b=DOBUk0AzW3R7nJCR7Kz94mUmpKT9+eOxgdwp5gwxkMSEibNa9C7bF6lO6vhYmOobEf3C
	 COkX44fs4T33tJBXt9XZH+S3ZpQQ3ZivtTpF67FW+ooI8K/EfMU5E0xn2swXCNVdotxtX
	 JIlIdbr8T1xMTpDTqS7TUJWZbKtyIu3JFD+8z1UQEBCeGFRbo+qEBvjNgVKm80oHC93Y9
	 O3u/RYrvgMjxg8JDQgGeBIYIlfh8Uv6Hl2HRWhgfEgNOJ0n5MsRj12l4tkhlYeqzY1G6k
	 PfFDLF8GQiWhFI+BGBRZUccDayG9WiRUoS7O8DTfE4WtRovcJBrylPnwMoW8DrTwCxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JNvJ5ui4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EC360A2604
	for <linux-serial@vger.kernel.org>; Thu, 19 Nov 2026 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JNvJ5ui4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A31F1F000C6;
	Thu, 19 Nov 2026 10:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795082824;
	bh=W8fXfgv7Dwy+pliGNs2M6HNN1fevlvrvYxGYwwp4g9g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JNvJ5ui4r1Wsmop6xF95IB6dCQ+2/Ttis8KLVnTJFpSCrYGA6Fvmm1B1gDr4PK9H+
	 sO0wts/ahv1z+ZMux4IskU7bgsAgyMPA7Ze+2KxyEPJ9kxVfscOiSXQqpKug37yLEv
	 EjZU9WVj7Fjk+dhfbFNWQ6qD/1XqHpwVoQqVF7BgkppHlX86mUIJImVsbTSv40CvJ2
	 BxYtiTYAdXI7uFo82SMXP9cIOmAcYWCUVi2JFVg/rGaGdIlYyWCY/Eiv5Av27qriqv
	 0RbA8JA4aFfp52vToQUEcAjI4yQv2GyHoXEc+0J9cFkoYk17kGGccUiZcsYmAOsBG/
	 dOK3sUfIaFhOA==
Message-ID: <sashiko-outbox-222913@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/7] dmaengine: dw: serialize error recovery with
 channel termination
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261119-submit-dw-dma-synchronize-v1-v10-2-3a737597a0d1@gmail.com>
References: <20261119-submit-dw-dma-synchronize-v1-v10-0-3a737597a0d1@gmail.com>
 <20261119-submit-dw-dma-synchronize-v1-v10-2-3a737597a0d1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 10:07:04 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-submit-dw-=
dma-synchronize-v1-v10-0-3a737597a0d1@gmail.com?part=3D2

