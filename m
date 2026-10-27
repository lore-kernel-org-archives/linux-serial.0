Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099556;
	b=qv/RqEH95fe7VkM8L+A3To0BEk9UjO1IW6R+2sQypyxc2tf5qUptCNhKNEAdFf+isDjF
	 RDY9L/LaDAvMUIqqN/lmAYI/GfHjquD5aDJjXZtZug3ith+DufRBbF6rYqPeYnmhnRASn
	 ax4A6CxFaG0Ha9rezJukmKKeysh6DjSsI8SMylcHtvT5VrDwHJJbggjkefzxA90Yd2EWJ
	 Xx2P0/XS+QeWX7uJJ9M5Y7clcLQGDUnXtV3Rv0nFZ+Yv19NQZSHYNzZVIQ4n63IEWPTXP
	 qWSOFAO0ueTZEJ8yB6afzufM/r3ecodofTYLjO19mam3yHGrHC6KEodXtgHa6pYQI3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099556;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fzGk55pHYeb70Zkag3HL2/cxFIj8E6DbdPTV+l7Q2zU=;
	b=HCNTxM+/sIfpJh5TtyR4Oz00CvzM93f5dqpBjOXFfAccyhDADtUKchMpbqiow7i4w4FB
	 4JJpvoeYBF+qxL8A2GXvSygDccpRyMTu0no7cIokty0sclNSGy9lvOisx9kawUjld3gQz
	 CSXsBPsXaYqw+fPGvQaoiH3E5uSHxtANYg+j+Tna25x4sBTqnfsOeO0n+RDm8RLgPMWqU
	 hp0ENoNdVuxDak2f3WnhWNoHtbNC0pD7FutF4LwxJsFfr8lehlbfeLLc3xIJTLXg+aPAA
	 ASsmadVyPMRYs9AqUNRoDcpZez+49qsOzCOQ7mqlI0XH0NhidqmkDq+22Zj9Y/ckJSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m66LNe+7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F150A606A31B
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m66LNe+7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7231F01828;
	Tue, 27 Oct 2026 11:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793099555;
	bh=fzGk55pHYeb70Zkag3HL2/cxFIj8E6DbdPTV+l7Q2zU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m66LNe+7/MhDGnJIA3VMXZzZ3sh9KpdaDWXKyhk0js3FJgOcdQdiGBdLEzqFxpzWQ
	 NyykGwVGLWBZ0RLMvbNqISeWRvZJ66SF9EUoJ/osbPU2RPbdE1KMZFTlf8hLpT1Com
	 ClwsiKU8LG+7Pw2VKg2s3d8E91nLG4mQTEi+Avv0yfF2PA9+94gYdSwujhjbNiytNi
	 8yxDdk4zr/LDjHL8cIGzC/0ZR0DD3mLce4FioLDx1bvWyvOCuq0L5mNsDQEbgWVLzd
	 M6hI9mXODTa7PFtfw7+D0eaAgUm4ZS+Xq45dcOaLacpcFalKLgzFbUUnPyh/l/EqXN
	 Wj6nf80A1gVkQ==
Message-ID: <sashiko-outbox-186419@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/24] serial: 8250: pericom: validate port offset
 against BAR length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-tty-llm-v1-10-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-10-99b0202ae546@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 11:12:35 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Joshua Rogers <linux@joshua.hu>
>=20
> The fourth port on 4-port Pericom devices uses offset 0x38 instead of
> the linear 0x18, but maxnr is computed assuming uniform 8-byte spacing.
> A malicious PCI device with an undersized BAR could cause I/O access
> outside the assigned resource. Check that offset + 8 fits within the BAR
> before registering each port.
>=20
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: stable <stable@kernel.org>
> Signed-off-by: Joshua Rogers <linux@joshua.hu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-tty-llm-v1=
-0-99b0202ae546@linuxfoundation.org?part=3D10

