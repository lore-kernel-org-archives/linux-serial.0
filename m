Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737171;
	b=rSaW5XptlzbMAJCzDuEvcQNliIT8c9F3a44DLSSaiTrLmC2wO9LOiQ2cGMjLyiutlSde
	 NHM98GKnBu5zQtPKlvae/mOwWocEOSC/7T/+1nUemT2MfA04fRfqeJfvvggVE6YHjSMj+
	 dWuRKcCSOmN9CC1VKqOeEg09TQrlLuMyIFwbZvSpr2RYm2Vtr1LW43+bpvD8QN7raL9YP
	 boxHTGbs8W452ID7bobU4ipVR0iqmlxYKFbgOBS9AOXLojNiLlcGmiNMWtJMFFZuoPxOK
	 vA9fLofWGNDmKnWtm2TvDUXIYJk2oFHLcSjjGwlQ/sGAdCvRLLWSJgsdcERumfzPt+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737171;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RVCtWO0v1mOQRZAR5I59WtOkGgcCm2Ul1JJbz/xKv2U=;
	b=sdtqefiOTP13gWkdLl9aAFFfh9FeRZUH81Ain2oSQPUujbKeHaq6CcLv69U5jHu/tkx3
	 hQeVwqybZLr+CmUlBM5E7l/NWhAtpWVRdvleK/IBLd+a0tcdoADHSqasiyRvUo6VrTG3V
	 7pD6Ctdic0Hramkc50V2/WPU2iBoODk+Yxo78VSz+9bb2PFjSRQa2ZmGjxPlzEnSxJiie
	 SIEvn4xdDhaL2QU/fK5i/sjPV+rKUJwgDTcLguObA1g4nt19LWAeqHmSNrVcu10SU/ZGD
	 QGG0+4/ygt+Et8spggtYcCuy+NqABo+3btgT4bEwmgcVQzvYwXsM7+U5LwJrLYFUBAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U5G6xmve;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D23606A31B
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 20:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U5G6xmve
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12151F000C1;
	Tue,  3 Nov 2026 20:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793737171;
	bh=RVCtWO0v1mOQRZAR5I59WtOkGgcCm2Ul1JJbz/xKv2U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U5G6xmvept9nU3+YTlgGXuU8VrDDLeizRTA+4f1wwfI8h4tDsG/9QfhCyy86bhRS1
	 ntfoxJMUU4AAGU8cg8X/CZiKW7o61Z3JN9MlyKc88DHOBEb1JcUqPEFWwhZK8lQB6z
	 j4sutapIOSBF+b2MVgTI1OlFt3AzcmgjWrzQeylb3364fNJLt3QlLQcac85goRjW93
	 AfWZeLJFzKjREXSLeuYRqFQiGz6L3G3S4bp2RCNM9853EngI0IIavQyR1nvt2UKmsI
	 cv6xYQfzMq3852XjvzkVsZvWXegYAe+ZwjKRfyVG13WtZcyLXziAG1Y26M9BEl5nnx
	 Owx2bH/lPc2kg==
Message-ID: <sashiko-outbox-195981@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] tty: serial: mvebu-uart: use device_get_match_data()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bramwel Barack" <bramwelbarack89@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103201305.18963-1-bramwelbarack89@gmail.com>
References: <20261103201305.18963-1-bramwelbarack89@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 20:19:30 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Modernize the driver by replacing the legacy of_match_device() call
> with the modern device_get_match_data() helper API. This cleans up
> the boilerplate code by extracting the match driver data configuration
> directly.
>=20
> Consequently, drop the explicit inclusions of <linux/of_device.h> and
> <linux/of_platform.h> as they are no longer required by the driver.
> This allows us to also remove a now-redundant forward declaration and
>  drop the problematic of_match_ptr() macro wrapper.
>=20
> Signed-off-by: Bramwel Barack <bramwelbarack89@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103201305.1896=
3-1-bramwelbarack89@gmail.com?part=3D1

