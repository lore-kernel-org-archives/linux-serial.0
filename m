Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794947703;
	b=D5GuKiYAyWqXlRjWr5ND08IHTLOijHvQBnHjvDk9I44hk3BqX3xbnj6BlsUEBfNr4UhW
	 pr3VLMBAVxTMTUNA5N8CKHQMitJTi5U0St5sowI8brCfwVXP8c24U2OCesutOfFliMikK
	 22IG/vAsoMbPzXQ1gemVT4H87hrIstJB1oB4qOwCZxb1z4ka9C8heae4BpGUWblnu1D12
	 0WUzlOtmb+ZOFUyvfWDQB4o++9fdeASFyGRdNdqdnWVtkOFqDWsZzo76Y6x3NFVZOPJ9k
	 53OPNrdXz8Gk3GION9FgH8ouccnZyoVeHqaoqfSoEigO2/0L5BWD0NMhZeM2ufigcgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947703;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qZKUXBawudzK9zLRU/bf4NKyOeZ2yuY3e5m40Rg5ZYA=;
	b=ww2j8daN2G3q9Xwhli6maolps2zc9iR/O0XPidhAA/YM0/mkKEqwnVwLpzDeaY0uCZkz
	 2ga8dM0J5Lj/WoOd5G2S8VIJBuDuHQHTTkjUcweU4blW2Ty94paT+ywPsYLWZ1X2hpDvL
	 rSP90HsIycXHmq4sqQOXfJcCVaZ+dVxHIP7RjZx6RNX/K+KnyBlUhXVvm99ldy7sUk2C4
	 fF8YBTHizQSgzqH94laQaK6Scm3EUTnzRc+Vv+d1dwMMcXKfbj046RtdnAezfHDyyPWee
	 6z1pAutIYBf5YxZEIQtrwkJlLjgnHFmoZxYrG2jFeWI+LZy0a3kFioWOKisLK0E0HuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i6BXJvwC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7112606A31C
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 20:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i6BXJvwC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F0A1F000C9;
	Tue, 17 Nov 2026 20:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794947703;
	bh=qZKUXBawudzK9zLRU/bf4NKyOeZ2yuY3e5m40Rg5ZYA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i6BXJvwCXNaudidmLeHi7kUZgGNX+KMu+09llLuqhPjB48F+RYHyYXndLKQrtoSyT
	 OLvVLEjQFBBuRi+grnO6y7v28DuI9BjyPJppwoKnnc5WbyJr/PA9IdW64tuSCrC4uO
	 TXhmjfrjPlzcx5W9B4zpzD/Y54R3zh2lpW2nhLxN7BmUbznIbxmIJqCn9r1r2knFKC
	 wBfripO6lY/vtCfKGgYeWTqJhAnQ8cOSj48kw42WQnFS1VQ8l409k5mxjChj8BVbG4
	 BGQoQ+81TvXBdo+MCrtmOEIloAgJr22UgwxDbFD2imejFxU6dEN5EwY4SsKWI1t53d
	 XZiTU6UstOv/Q==
Message-ID: <sashiko-outbox-219627@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/16] HID: ft260: i2c: fix i2c_reset sysfs store
 return value
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117200423.19561-15-michael.zaidman@gmail.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
 <20261117200423.19561-15-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:35:02 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200423.1956=
1-1-michael.zaidman@gmail.com?part=3D14

