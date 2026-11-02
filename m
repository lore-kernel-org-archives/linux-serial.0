Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650792;
	b=LDtHYA+crsHZFwxQXjPsbqEACQtS/vMfLGhBztsiLeYrlxzD89iOeN/2NF8xAgFTYwCW
	 FIPY1wF8zlNJ5JpzQxsqHRb0Z9MfmaBAj257+F3wYsfz92yArfzOuU78cPWK+Yv4cwRPs
	 XKmfknImped1ClDq8L03swPlNsv/G6NLVyUGhdm7Tf9Jn3+MURg2IoelDY6bKQKRA/wPO
	 hxL66aL6niSL1NOohGba1xaKV/xcXhf7CnX1TvkCQlQANn2MZ88bLCWjS+kzeYhyDs9DZ
	 7UCahkO427gaHA57KUymk0JgLjh0Tg6WmhUMJ8TJw6Aipf/IgCZThwJjmp7p6GNoJSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650792;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=C5DLnCLE6C/FrvNJSp/m50bOjNQN2YYEnnHuY+UuDCc=;
	b=e81QlAsOqbhOJLhwZE5xDzPfR117BLky2GrGx8f+tG9480Ft+qJ3iXtYQHFCSdYwHozn
	 k+jKXKfrCI1D0+ehG8m8vN2MgZeo0IwnrxlKE5AgM2a9bEgKZ/HvtxbtfjtYBRTWLQXuL
	 KpwXhH5WF/kU5gkqsFjolPFSWpM093HJhbLb9qeef3SrxiVRQFeBjNilQ7Mh7/O3rluhw
	 jpxGH3X6KGlWSnOxPpUo/gA5vdTC+jTeadqgs5ys/meLrZfLKR9/EnWa4W9T36x2nFDYr
	 6jm+uTpO5Gb7dmDJeKMEdZQAj0SoqacNdlhXkY9kZcudfx3t30WcSkyBsqYGDH8ZoBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gp3HE/Om";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE63606A324
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 20:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gp3HE/Om
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D211F00A16;
	Mon,  2 Nov 2026 20:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793650792;
	bh=C5DLnCLE6C/FrvNJSp/m50bOjNQN2YYEnnHuY+UuDCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gp3HE/Om69/q+C9b8nZkiQz8zfDNVMgl+izQvMNkBw0X7XRUHza+hk/AWhn7NY2vg
	 NTYz/Dk1ddjTrlJqbH4vRkOcOo74rk+/0jNkwRBGr+rCWKILIfzg7cperXmkvQqyfW
	 hIPd5OwVv2mJbgqSRKD5T/Nps3fM9qeH5xxhk9aEtz0/ZEeXj8iqiHVQ0ohC39NsBm
	 lawi8/5/QtGEvtruhsgodTnoyctf/j2aLOA742QiZ0xlA+dhmqLoVwPRkHQIhqk9eq
	 S5PP+qJqJhP0RI9hC/QTefaI4+norJg2DfYPmTvpWZ3nlPZFd5F7tymMk7q++RSbXJ
	 8GKZ9LYxBZ7Yg==
Message-ID: <sashiko-outbox-194093@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] dt-bindings: serial: ingenic: Add the X1600
Reply-To: sashiko-reviews@lists.linux.dev
To: "Olivier Louvignes" <olivier@mgcrea.io>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102201459.49284-1-olivier@mgcrea.io>
References: <20261102201459.49284-1-olivier@mgcrea.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 20:19:51 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The X1600's UARTs have the X1000's registers and 64-byte FIFOs. Add
> ingenic,x1600-uart, with the X1000's as fallback.
>=20
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102201459.4928=
4-1-olivier@mgcrea.io?part=3D1

