Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CF3353A72
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 04:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790741973; cv=none; b=H5xSzZ62f8KCotD9UvWhGcVjlYliAK6ST7a7D8xlVEkvHHk5me61+Lj9z6hX+KZHh1E3eaBgkoT7WoBFJ39aiXX1WRDyIp6aAEyLLHPTGTQZA/tkhXP/GdmyT5M1GPPvDmfKhqOp6c+GOG7kkjnYPaSKj6WK7EZX+0jH+fw3mTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790741973; c=relaxed/simple;
	bh=6vq5cfdJubL+u6w/ssDGEJJolCDBUJb/KVBRAOC1WLc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XUJF+1owiCga7mn3CZqseJms9rK4EM542UXvcSSH/TWTr8LuKKmFaySkrGNUBR89m4v3JOjj9gvxaOK9ia9yzmosaTdtpL8iNwWKxPlik6MP9kY0WB1wCPZe/7xFiYGIi6V7pNZuckCP6bnGpA9k6VAMmYQfYezcIkAwTZGDFrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnvSIP2Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnvSIP2Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AC61F000FF;
	Wed, 30 Sep 2026 04:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790741971;
	bh=6vq5cfdJubL+u6w/ssDGEJJolCDBUJb/KVBRAOC1WLc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KnvSIP2ZUELYd4bnC/89R3ztbJfA6Di0cq8uxxGtWL1oekzR9T4JVVoe0vzFR6bU5
	 1pbLkJ0XVFLJesXwbI6sUPJJJVnaNx/ywq8QMGettqJT7103UMa9ZiZgzHvwTPOFJx
	 MawUF6f5LkAUyuU/B/FbR4oFIpKKxAIJZjPn3efxLSFM2crYiDeHPTVc/1k7ovr3LO
	 YBjHR96fPfuT13Ou67RNFdjXnKp/wz7mw8vHjFIPoxlZSatIXOu+ld8w+q7yGONDna
	 esGySHuN8baXiyCTsZHOB9bOBPIRYK0oSrlDfVrGq5VLmLD5xNC4Ijf6A6x9PrKtKT
	 aip4w4Qt387XA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] serial: 8250: hold hash_mutex across IRQ chain
 linking in serial_link_irq_chain()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Peng" <benquike@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260930041216.155911-2-benquike@gmail.com>
References: <20260930041216.155911-1-benquike@gmail.com>
 <20260930041216.155911-2-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 04:19:31 +0000
Message-Id: <20260930041931.C4AC61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> In serial_link_irq_chain(), serial_get_or_create_irq_info() acquires
> hash_mutex to search or allocate a chain instance and drops hash_mutex
> before returning.
>=20
> If a concurrent call to serial_unlink_irq_chain() runs immediately after
> serial_get_or_create_irq_info() returns while i->head is still NULL,
> serial_unlink_irq_chain() acquires hash_mutex, finds i with
> i->head =3D=3D NULL, frees the chain structure via free_irq() / kfree(),
> and removes it from the hashtable. serial_link_irq_chain() then
> proceeds to scoped_guard(spinlock_irq, &i->lock), dereferencing the freed
> chain pointer i and causing a slab use-after-free.
>=20
> Move guard(mutex)(&hash_mutex) to the beginning of
> serial_link_irq_chain() and rename serial_get_or_create_irq_info() to
> serial_get_or_create_irq_info_locked() so hash_mutex is held across the
> entire lookup, linking, and error-path unlinking sequence.
>=20
> Tested in QEMU against tip of mainline (62f4c998b297, "Merge tag
> 'parisc-for-7.3-rc5' of git://git.kernel.org/.../parisc-linux")
> with KASAN enabled by concurrently opening/closing 8250 serial ports
> sharing IRQ 4 (ttyS0 and ttyS2): on the unfixed kernel KASAN detects
> slab-use-after-free in serial_link_irq_chain(); whereas with this fix
> applied, port registration and unregistration run cleanly with 0 KASAN
> warnings.
>=20
> Fixes: e91f1ed6c24f ("serial: 8250: fix use-after-free in serial_link_irq=
_chain")
> Cc: stable@vger.kernel.org
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930041216.1559=
11-1-benquike@gmail.com?part=3D1

