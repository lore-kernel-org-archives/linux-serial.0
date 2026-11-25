Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601500;
	b=fOsF+9oAMMGVoopqLF5VAMFFKFDEHY9n9cuT7f7JPMVPKDAwJCbdkcGjFB0LXVSrzP0a
	 R9Dc5oXHBt3OG+tFBfKOXdlFUKHdXF4e/L17xU33MXecYfhIxO2BkQLXBm2iZOOAPrQ4G
	 xpTJBhYRxLjslMeerAedBpHlsZNhp9M/a7QryaXgx7QDzdjL0efM4tY2ZlDB0ruUw4Xoc
	 Ey/BOvy/2Nc6avFvQ93loFdd90lAoQNvDX78seFHJkPQDByo8Q8H9UaDn1JH8hUIuHq5g
	 EKlvRjKMqoFJsyS1qS8LBMPEkZMx20vntqMHCqNYlyVo7nLaXboVtOAfR737+g1L9hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601500;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HYAYtOYMaBSk4p+2V8I3erFLWQoFrZDMpz0cJ1P63PY=;
	b=qH4HZWUBEg2xPAU93KEZYZzQxl+3z1J4VEsmDEi+VrrZDhWZL8SOD9B9QkEZnoDENWDh
	 zoKAt1e+IrSgDQgzpN8Vi1oXIl3YoCdIoIjCRW7quXn/ZYMqnMCvzuBOpOGXQFs3bKzNP
	 WWthpciRtV1VVfFlG0oSLSDCkhIad9X5CnTLCs/ggod2irHkPG2wBTJOS2CImmjOGO1xt
	 Jj93UEW1BRCvZU0ONCHtyTzk/ykNOS6lLr/4aWp6J0Jf9OYaBTJVvvnLnyywSpjGVkEwG
	 UNwFHiz2XT2a3w2G3Qwf1C490HdfZaJmtpzO02nkzkBpTE/UNSd7Zo/HBSfNa/cexFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fvolju3p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AB4606A323
	for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2026 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fvolju3p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6D81F000D1;
	Wed, 25 Nov 2026 10:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795601500;
	bh=HYAYtOYMaBSk4p+2V8I3erFLWQoFrZDMpz0cJ1P63PY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fvolju3p1i7/7zRO0/SSY02Sca5ay1u/67OsYvRBJL/SsGdP+BwD8Z4H0b1cj2nWR
	 FYJo73dB0AzFA/pNXHoUKpiys0fspJDbwuphs7/mphNzT3nLfvkXeFvefWcB3MDMVo
	 rwbbBvOym6foIz/crNmW30aZJNDG/nMVqnFzUp9AKv/E7HJtXNrUEN2MHjIcKIqwh1
	 yA4bI+rvXCcZ6CkFFrCdZYOGe0rm6R5ex2qbZi54M+rxqNk7ZjLYJUxji4L9sHnG8k
	 xVn/DD6X0bHX8U+KPQq+9YhPdjm3fGaFXOnCjCrQImMPN0m3CuhuTQUW1jASKoybRe
	 nZKC3hO4ZIspQ==
Message-ID: <sashiko-outbox-233093@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 0/2] serial: sc16is7xx: Two simplifications
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@baylibre.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <cover.1795601260.git.u.kleine-koenig@baylibre.com>
References: <cover.1795601260.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 10:11:40 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 2-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795601260.gi=
t.u.kleine-koenig@baylibre.com
