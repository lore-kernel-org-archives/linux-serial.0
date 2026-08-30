Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339AF7082D
	for <linux-serial@vger.kernel.org>; Sun, 30 Aug 2026 08:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788077260; cv=none; b=R1TYcRQWOgEAiMsAGp6GO8mRFlXS2qaYPBWkWK/DmlnmLEqUs2jKFKW2xDLIKITJ9DgqAEgzMJAzMkN2fUjG/9AE1rSMIb7K5uEjAVrj3iEbPJzJVdi3I1Awquxgj6VTjMVhcj8089IFey/b8BZExq7uyQNZ4k0oRnVMVEirhX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788077260; c=relaxed/simple;
	bh=VMdSqeqMzSLopuxJCxUo5uhnArHnjRCr5Y3coZEm8T8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kVA7NDHGFEO8bt7YXqGv9UFlaagRQ7JVt8VCI/NvAZkesrR5fg5nu1iBeYKlui9Iy4peUQiyg6TF+HJQ7+g6ZL5z3YPq3CIFAvAgS5XyhjsMXipzmyibd3xnldb72SPDfKcgwRuubJ9C8QwipuxkRkoemMcorUivOTb9fzYbojo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoU7uNyd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoU7uNyd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90B41F000E9;
	Sun, 30 Aug 2026 08:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788077258;
	bh=VMdSqeqMzSLopuxJCxUo5uhnArHnjRCr5Y3coZEm8T8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SoU7uNydHL4vi66qbSqpaI77ebLifbfgaiP2bzVTi+EI4tII4UszzGI9yISgatatm
	 K0qSResUMSRKl/kQ2TqRXrKJvFEI1iXM1aSsEESVwUbm+56Bl3NwZU9wrypIIm7jwh
	 hEe+kAFYoiD92FqSx+2qEdx6ppOXSDX1PYSNC6501+leYFvnqLMHbuRxdcQajXtGQ/
	 rOkKjU8za42iJ0wFduU4MCRE/4qfBBt8rw4IvmS79jDWmy2mCKqLJV8zLn/aRDJwcB
	 ZPxHNpKF2rEPbyW0wmipABC2qeSrbGIxwJms9pqBnTlfDi4uK8qYksWNKmINjVYDqU
	 o0wjYHeLAphMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] tty: port: replace get_zeroed_page() with kzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260830-tty-v1-1-0cbe6170649b@kernel.org>
References: <20260830-tty-v1-0-0cbe6170649b@kernel.org>
 <20260830-tty-v1-1-0cbe6170649b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 08:07:38 +0000
Message-Id: <20260830080738.B90B41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> tty_port_alloc_xmit_buf() allocates the transmit buffer of a tty port. The
> buffer only backs the port's kfifo, the data being sent is copied in and
> out of it.
>=20
> This buffer can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
>=20
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
>=20
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
>=20
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
>=20
> Replace use of get_zeroed_page() with kzalloc() and free_page() with
> kfree().
>=20
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Assisted-by: copilot:claude-opus
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830-tty-v1-0-0=
cbe6170649b@kernel.org?part=3D1

