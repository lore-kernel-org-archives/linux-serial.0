Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA10A4E0B68
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066310; cv=none; b=WHoWDng4/wf4HrxIdj9nQUIkCq4m5cbHy1l28rQ1u+VLcVtWi6lKj+le1xhebTcwh4cFw5CQE9lyngaT/KHNVPnINVfATY9bTehXsy1FIWIa7VIpndoBxeDW6Qqj4eSehPxdCirvvccnOtgfJqhBQ7UYl/nDUz06UJnh3N13md8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066310; c=relaxed/simple;
	bh=EgY15g0WJoLSiLHMrx0ECLdZ/5L7qVQIq5DBAb7QWjQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PL3qKdG08QaLe6Fr/LCSBUXj5VhthTFIRIR2n4iGuGaemM5cMAqF4CacYZomQy22trDODIjtN/FvyiMgtSwwMTUhjUOoozSMg/PXzL3gmnF+0QnyPG5hHMGZwlCB/HSdDceel8YSFb2yFflxEHf952KPLwkrmAats5DoJEDYDD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ei5he4Jv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ei5he4Jv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD97B1F00899;
	Tue, 22 Sep 2026 08:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790066308;
	bh=EgY15g0WJoLSiLHMrx0ECLdZ/5L7qVQIq5DBAb7QWjQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ei5he4JvmaM0KanXNd5EYHSk5cXXytlAvaLYL/0SPDNJKUJ//BhXwlTZFrg4Y5Yua
	 IVoeRf1NL1vSdmIwGqwWVN0lRSlYGJOgG5YVAxfdx7w+p6D2GQuHjUO56riEPldv5V
	 Tlgv9QthuBO0QEvuG7Zr8HsjP+cKjqz+efleBpJTShTCoCOXVtZTNNzflw86QDiHFQ
	 3sItycKDfCuzLHEE9veQw0yOroG68RTE31Hn2y1/p4AFe/uFaUg1QOo2y8yEmdGoAb
	 FqDZ5AK1hFl/LjBPnu87KZgUGzZqEHpBidQKzYvNJpOZwWpJr++1nc7s5RYuKG4NTd
	 1oeAKvUE8ZqjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] serial: 8250: hold hash_mutex across IRQ chain
 linking in serial_link_irq_chain()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Peng" <benquike@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260922083152.4055969-2-benquike@gmail.com>
References: <20260922083152.4055969-1-benquike@gmail.com>
 <20260922083152.4055969-2-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:38:28 +0000
Message-Id: <20260922083828.AD97B1F00899@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922083152.4055=
969-1-benquike@gmail.com?part=3D1

