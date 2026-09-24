Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF71432D0EE
	for <linux-serial@vger.kernel.org>; Thu, 24 Sep 2026 06:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230398; cv=none; b=UeZhS9AmxNUU1+7Mf759i/rbOP2S9vOQNhBLYeNGRVBPEXT7JbB/CY7weQq3H1/OrPRh5IP+ODeMdezNn3RWDcO3GMhhAMGmq9Hx5YM+Fx7/XMPh3ZNMgCsw7Fq5ey5//yWBAystlwRCtBRijBwNNy/eJOV8hkuhLqHJHiUQ9b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230398; c=relaxed/simple;
	bh=5P5/9G41m6VpLbhMd3xipifGxjWJTCNkbwZthKcxky4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pb2VhBBgv8WHfL9zFi7FitUhc3Qygj4/jDoaxjPDI698X//yfBjWxgPVpl8R22CwgHsUADD1Ae4to4ZGkpVfKYDnsy7n8D6IZeomskZlvbYSJ5eWOIfZTehj4GIkyKu0AWj3Fyt6kWoiYkNmnsDL6SEqIncZIZQcnDjhQVtYZTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DE/xCdNp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DE/xCdNp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F361F000FF;
	Thu, 24 Sep 2026 06:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790230397;
	bh=5P5/9G41m6VpLbhMd3xipifGxjWJTCNkbwZthKcxky4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DE/xCdNpLAdEdGZ2NGEv4isA5FtW9BVRiJvgAE5WUZ5Lih2uZ1+hB7mt2gApa7pEw
	 SqEybQoQ0WNnEWuTN2nVpD0d4/wwOFk7iV2Ve7tAzIGyZnfGzjsqlqUePV97ahilZs
	 c287nC6m7r5IMKy/eAX/+QHGNGUlBBGoaflxLCHsQMwz4u5JHYq3Mo5CaLCoLkxuGS
	 vXIb4Q4Vj8icCil9Dy3wRj+9lnRD3VQwhPPJCiNJLf7DmXV+6DpmIMKpWUxCwEJ4/a
	 j2CkmLi8epWrKU54uccqIraPVUcKgEpW3sguaLqDj4FrF94LMMLM492DYovU5lUtCZ
	 gtA9LdDJwT4YA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] serial: 8250: hold hash_mutex across IRQ chain
 linking in serial_link_irq_chain()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Peng" <benquike@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260924060511.2364717-2-benquike@gmail.com>
References: <20260924060511.2364717-1-benquike@gmail.com>
 <20260924060511.2364717-2-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 06:13:16 +0000
Message-Id: <20260924061317.46F361F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924060511.2364=
717-1-benquike@gmail.com?part=3D1

