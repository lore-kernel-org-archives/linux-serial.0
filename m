Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793083987;
	b=xdXb9R/bALVBjKRQvaYDa50i5nF4V7ruxgBQP4rctzGQv+nurGglXEyBooY7pWwtiOP6
	 O9UEz3qFvhLebvLKOEDkcHt5qJQhWv8pcPVyxMGxcullILmDcL8DJP5RpHFZAJzu1JQKo
	 3BFsfCh4tDmoAzRpL0SlHaipCD5R+Y1jqFhlnZodq0kau5SvFF4IXuDdKxMaD4a1wQ9KI
	 +ekGLrEDUAJ7Tj68Q6VABRnUCetZBJM6QghL7fgk+nC0F9aFuY9h9IMGd/a05hoc7sqBM
	 dO6ChzwKbGs+WVE0v8c6nJM4fKPV1bCeKsPTtkw5LZg1+/FnhOAPO6LJds+wqsvaV4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793083987;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iBXm7rOWD/rY56+HOonOvPn5fFUJL3WA6Jb2oOwZcXU=;
	b=ybFISO/KZ++S9IFLCLpALENC42/pWwuZ+I4cIxU71WdvEpYgpE6sN772/UOd1uQWqIXG
	 m6+lDCQ/Z33gm2MAwB7MH0kXQG7StwqWRdopj8Qx+tRAMHgnbgQQUznWQnVgPE2INEasY
	 TyDTuf7HsR6uchr3zQMVZCSiSjQlAzOFI5kYsLvYvolWyxWfbwyJwSHLZl3Zdj4zMheWk
	 R5J4VwmlLxfcNf89MklWvnqVZfBp1GjCGozdDFdTs//zk4iS8terP1WeIZgrkdBm2+e/f
	 5NbtVYKLouLPrgZNWg7D8aS4Ta9XwlMs90MIQVmD7BThDoDG8IfqBEa3CxGpKRn67DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLs4ujz9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFF5606A31A
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 06:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLs4ujz9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2561F01825;
	Tue, 27 Oct 2026 06:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793083986;
	bh=iBXm7rOWD/rY56+HOonOvPn5fFUJL3WA6Jb2oOwZcXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DLs4ujz9NrOSQ3mBVBnRsUvZbrBYva2AwTcbvHzjRURl50Bjx8VvItYHwm2HI/cC5
	 h2i48N+AkUS53GmM4Gigfn6Xe29q4T3wK1HFVq7duxwoEhE7/rcXrAFKIYckVDZ5Vb
	 tJl4n2eH2DHwOoQpd+AkNqqsCTDgrrfmi1Ehbvx0K8FJmRkgZ6PaFcXID/7b3qQlpa
	 URLe3GokM5Lkz+Wd7CdknFsmwoy0zFLx3NRrc64TUNsfiqolvqgKkdoMRWxUaP9d0B
	 EnSgoNHbbUwbVZqkz/UakZFqe4Z64D4ou5rkUhscWA3Uc3kaSFjt9mHjZ0KbrP/wBn
	 o5qnJe6irOzhA==
Message-ID: <sashiko-outbox-186171@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: Correct tty_operations @remove description
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Lee" <james@codeconstruct.com.au>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-dev-tty-remove-doc-v1-1-e4272aa01ddc@codeconstruct.com.au>
References: <20261027-dev-tty-remove-doc-v1-1-e4272aa01ddc@codeconstruct.com.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 06:53:05 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Description says that @remove is used in conjunction with itself,
> seemingly an unadjusted copy from the description of @install.
> Replace @remove's reference to itself with @install.
>=20
> Signed-off-by: James Lee <james@codeconstruct.com.au>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-dev-tty-re=
move-doc-v1-1-e4272aa01ddc@codeconstruct.com.au?part=3D1

