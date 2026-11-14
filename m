Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697966;
	b=bcZqT/XZce6jaRH+ql6hItxJgquCvnAdvAB8VZGBjveBD7xYSdxvIWcp4l481YJ9ikfh
	 VfjQT46mLEqiWxTst2KIYIVUh1qS8D3icQeZBa8Kr/Ueu5bD9Bg5MKdSR49sF9/iNRhxz
	 O1pRmFNHdZ0gGiy4474626VYQkE3S3K7LVoqgCd8OAM8O/vy2LUxsQMn+RURwjO5fiiS0
	 eOawmSz3PEDkXKt4TVk7F9kuScov+NRCDl9Jh+puRnwdY3HCSth1CcPX/1H5witqkDb9i
	 3aRC9xsFTFFOs6idvB9Dk9nxd4Ry2eV6b2RcSsRFFgT0p2Un+uQwO/BJ4xjsLq+8Ejg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697966;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=i+DHAunV0YlPhP6zeF3kKuUL8FM4Yh4BVpukvANMQgA=;
	b=Bkg85iHDGk81csK+21+8s1qq7Abxga7FtcrmHo6VIGCL7iyZ3uNDT22QDtdWBX4EiQU9
	 SxLhEwLh1W/mt/oFZTy7pz/fv+O+09mzLH8M4ziKKvkkMAwazr1G/llfZbOyuTvQNUp6p
	 w4Q1NU25tGUwtiH7JGAumEAYb2vZqTdBYFTwuznfI7nxvGJ0TO305+rvGbRn2itzSVFa6
	 Vv8vtcMpjughdhQss7S9NSWx0FMkw+8+PQvajdN1MtF6q38cWVkzggBQuJxMoB59Vf9aa
	 Co4KXjK+0nvu35Jgb5/5OTZ6EAIPlBUZuGXjIWOjtxgSoINtewRiOqI1JCJ8/vxSRBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=At78uJpQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07514606A323
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=At78uJpQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F861F000C4;
	Sat, 14 Nov 2026 23:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794697965;
	bh=i+DHAunV0YlPhP6zeF3kKuUL8FM4Yh4BVpukvANMQgA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=At78uJpQxfPw+B7AJt4qlBYoHIhi9kOcJTn99lhu3vqnQk3uqZF2WZ1gra5dg9ZA4
	 QE4CCxdWP7r/tzE7PXKcXPo8w6U+QHsffaPGSRf9UfchrWu3Tuc240gyHCPU3YBR2q
	 IYYUaGWRXLFh5sowp9B2JX2rE7bCioHh2hP4nQLFt7YTFS4hjG8W5UUzf2M2T5obkL
	 vc5LXlDQ1eUC047/f9yc9MHKH6FFCuSBmi1dbMlJv4Al3x/gF6WXIj5DOSLkxS+RZl
	 AyOE438SDQ7mzCVnzqYwoy+ltt1WrHArgeV3BCB1HyaDhoKMMzcVHqu1CLOkH639cq
	 vXK3a2AwMwXUA==
Message-ID: <sashiko-outbox-215090@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/16] HID: ft260: i2c: reduce driver module loading
 time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261114230800.1344401-5-michael.zaidman@gmail.com>
References: <20261114230800.1344401-1-michael.zaidman@gmail.com>
 <20261114230800.1344401-5-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 23:12:45 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The HWMON class I2C client drivers register the address range to scan
> during the I2C master module probing. For example, the lm75 module
> registers eight bus addresses scanned during the ft260 module loading.
>=20
> In the case of ft260, the bus is scanned by ft260_i2c_read, but due to
> an excessive read completion timeout, it took about 40 seconds for the
> ft260 driver to scan the lm75 address range before exiting the probe
> function.
>=20
> Adjust the i2c_read timeout so it depends on the amount of data to
> read, reducing the lm75 address range scan time to about 200ms.
>=20
> The 25 ms per-report budget was checked on a UMFT260EV1A with a 24LC512
> EEPROM by shrinking the timeout until reads began to fail: a 60-byte
> read still completes at 9 ms and times out at 7 ms, against 5.4 ms of
> wire time at 100 kHz, so the fixed USB, HID and scheduling overhead
> costs a few milliseconds. At the chip's slowest 60 kHz clock that chunk
> needs about 9 ms on the wire and a 180-byte chunk about 27 ms. Scale
> the wait by 25 ms per 60-byte HID payload so a last chunk of 61..180
> bytes gets 50..75 ms, not the single-report 25 ms budget.
>=20
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114230800.1344=
401-1-michael.zaidman@gmail.com?part=3D4

