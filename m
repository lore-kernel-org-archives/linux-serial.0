Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794698243;
	b=GY8PJf/RH4bgtZzq9T2Rd4xu7t0a1IwT1/F0LG0hwLHWzMa0GYWvKWpVkZoUHhkK82Zw
	 mOW+c4OTyzQ2h62tPGeFd2ja17+g+SAx7R8AxW4Vw95P/4gRlJMW97prm8BnPwuDz4eMq
	 aJBkFTy6EaNxz5MfsbAky8roRq6fdSiHasOHvgUBc9D7oQ9GLU9suNUvUysHujjmDaWj0
	 XOZO/evyX2NIvKvK2++1AR7c9whvu9xo5bvRztp0BAWLcEiTKNuwduwKAtijERTFQgVOn
	 xpcOP503I/2f2KaGr8o7zkAX0XqYCHL0HOzE24LqK8hRcJxHd9MRAJ+JgzDQo4zM3iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794698243;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UsM2K77gt7DM7L2tIuJayjurVp7kUUqXEcLjqaYPmdA=;
	b=bMeYQn/u7Rem1/LUjCdFskILIIipzIdDZlKTUucX4NkskfNA7x3gxlOBxxRubt3WcIht
	 Du8A3lay/K79MdFpPD/hUqfERCTuHQgC6HxJA2/KdF86nThSi539VIfYNKhwS5+JuKI2A
	 d8Dnq962WIQ+Vq+hKbk3ORQh4McdiGBTvz8jrTKTQLiIDhnqyMYIFJfjDPws32PXTHpg+
	 P7WDFpqCY1MeRVoLa4cPHlAPRv6ayuy33dmrR5XQHx904EM/VpVRJ/Ot4yZJ7k6qC7iso
	 I6JO4gal6ujnC02GhEsI40Y28OCT5URWCZh+nY6FOULY7yeiojWjgdSVjEIOYH+jEFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NGiO2Yxo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8E5606A327
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NGiO2Yxo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A42A1F000C4;
	Sat, 14 Nov 2026 23:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794698242;
	bh=UsM2K77gt7DM7L2tIuJayjurVp7kUUqXEcLjqaYPmdA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NGiO2Yxo6cWYNFkSZ0HaNj88oQtCP79880S+iQGrJfcnszk8pMdR6kk1kI6thsNXW
	 /PkVDAuY4KqOWxDBHOob/bE0pnuQaYisHBpNnHFDs0z+29xJeFJh1kdStt4zMcN0bO
	 sRt5PpRHNz7VOV2WTAGfMbE1E4HYBmQiHFS5rPIbqSgI/SCY3MNi7dL6Jt2ZhdK82w
	 Nm6UKfnZCtARjZM03ahr85hnE+M0xLBhv0s9L49jgNGCcsoxmsYwB1q0TOyV4OxEYp
	 OiPn0+h0xkdsbPWMQ29v7TDoGzLfGs+yBqzbKWjg+lIhFsjWaJm1SsD99cEX5wuvsV
	 5Fi8lnNUghwAQ==
Message-ID: <sashiko-outbox-215097@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/16] HID: ft260: fix sysfs store failure notice for
 big numbers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261114230800.1344401-6-michael.zaidman@gmail.com>
References: <20261114230800.1344401-1-michael.zaidman@gmail.com>
 <20261114230800.1344401-6-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 23:17:22 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> FT260_ATTR_STORE returned the feature-report transfer length from
> ft260_hid_feature_report_set() instead of the sysfs write size. For
> values like 1000, userspace writes more bytes than the HID report
> length, so the VFS retries the remainder and reports "Invalid argument"
> even though the attribute was applied correctly:
>=20
>   $ echo 1000 > .../clock
>   bash: line 1: echo: write error: Invalid argument
>   $ cat .../clock
>   1000
>=20
> Return count when the feature report succeeds, so the full write is
> consumed, and the error when it fails.
>=20
> Parse a 16-bit attribute, such as clock, into a u16 and convert it with
> cpu_to_le16(), because the report field is little endian. Before, the
> value was parsed straight into the __le16 field, which is wrong on a
> big-endian CPU.
>=20
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114230800.1344=
401-1-michael.zaidman@gmail.com?part=3D5

