Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794698151;
	b=by4JNCDAani6M6FZUpASpskYSv3PJ0bkX5g/sexqkHmFVOZ3UTeBlbydBwHEJg4l8zTO
	 jUzIS2OgaWp1Scc+btaVMreO8RfpWl5mbEwKo9O0DoZ7pXTvyYmwHDC4r9arffSiky5Ck
	 4JihMXf9JNb6GQiL66s3Tn3TSzJaDwzwKGRqyzmgN3rMXPPDh6644Z0BLFql47hnKQGoK
	 S7x/+2QMATUYhYzF/D43D4kl8SXnfwGYLvAMVS5QQ/4KplytYViSiz/Eg/NdGSz3w+WIx
	 NMjb0xAPCHQkKJXYzFPTtBt6HM12pLOgapKQvzly8dZawbt6EfltVvc+3nSxXyoiiOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794698151;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kZ6OuBFjQkEIkcQjFOkRNn5ABiDPk3wWWlfiTaMdlMM=;
	b=AGeVbVKmvpMU79Uye5Wlvx3S8e+dmhZM/n0oE+mMgIDrfoHbyJQQoK+61/8EzqisquVg
	 2yF2L9FCm7vd5N5TykI2mEr9l9cfIYC/kYzTR1CCa5fn/qTRnjP9dPpXFFmXFYpk81/GK
	 oGG8JZv/gWyvue9jNRzZixLPFOS8kI3Ydflz5tcyt21mAYWzLIxOs+/KPlT14QZQjJsoh
	 X5aWbR89tvxU4jtm4BgEDdTZmmKxC9xAAGEjdekL5sEKkCV0ki+mXl7VO+7biety9xaWy
	 OXUv2KLpVOOW53yKIksko4/3nLCEIqacsWkUOTYzCyIm/H8tkZtHMRicZD4V+YVZRWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gc5Sgda0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD60A606A327
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gc5Sgda0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C331F000C4;
	Sat, 14 Nov 2026 23:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794698151;
	bh=kZ6OuBFjQkEIkcQjFOkRNn5ABiDPk3wWWlfiTaMdlMM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gc5Sgda0H/9gtYhr+q3GYTbLzD+M5dliiVD3hnY10r6F7CdBp+a7IV23+Ox/JTIdM
	 x/eRAs+s+9yWNBfZ/jSwGzdjTlQHY92XVh8A8U12T5XTq80uxTr5AHjIvXVjmXx9Dl
	 jqy5bpvzJU3d+jheMi/yonPHzGcyDG8HxkY0ETOji2Do0Ood6BjJSAEBB7U+gCEev4
	 9RrNg8Vktyt8x1Mzfltp4oUsWNmzPAqkSv9oCO1MAc0hWnucL+KyHm0AOFzbNiXO9b
	 TZwaWtwFBTrquzSMQb4n9J6ZkIHo06vp2LPCCxhPT+LauQ/Qf9zOURyMQPMjuHp5D2
	 sHEdFW9Px13WA==
Message-ID: <sashiko-outbox-215094@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/16] HID: ft260: i2c: fix i2c_reset sysfs store
 return value
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261114230800.1344401-15-michael.zaidman@gmail.com>
References: <20261114230800.1344401-1-michael.zaidman@gmail.com>
 <20261114230800.1344401-15-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 23:15:50 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> A sysfs store must return the number of bytes it consumed. kernfs
> hands that value straight to write(2). i2c_reset_store() returns
> whatever ft260_i2c_reset() returns, which is the length of the
> feature report it sent, 2, not 0. The "return count" below it never
> runs, so every write to i2c_reset returns 2 whatever its size.
>=20
> A write of two bytes is right by coincidence, because the report is
> two bytes long. A caller that leaves out the newline, as C and Python
> code usually does, writes one byte and gets 2 back, which is more
> than it asked for:
>=20
>   echo -n 1 > i2c_reset   1 byte, write() returns 2, bash ignores it
>   printf 1  > i2c_reset   1 byte, dash reports an I/O error
>   echo 1    > i2c_reset   2 bytes, correct by coincidence
>=20
> Return 0 from ft260_i2c_reset() on success. The value is discarded by
> its other callers, ft260_hid_output_report_check_status(),
> ft260_i2c_probe() and ft260_i2c_abort(), whose own four callers
> discard it as well.
>=20
> Fixes: 6a82582d9fa4 ("HID: ft260: add usb hid to i2c host bridge driver")
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114230800.1344=
401-1-michael.zaidman@gmail.com?part=3D14

