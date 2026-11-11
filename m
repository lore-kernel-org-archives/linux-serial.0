Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401742;
	b=EqvXjY01FsN7supEuXKUNnuScjgFIgwXbsdypRB7Z+jhD76/WmQSCzA6IAWs+r09am5H
	 iK08gkWne8p5ulhoupTK5LmbXMgdwwNN494kHoHSm8sXvkb4v4LJnC0k/t9mPfzr7eWg8
	 4JF2zO+o7iNgT+Lz1YXgHaK+g/hsEPy/zfvaQMfrFlBQavibSN6bujd5aUo2rJLTHNyrM
	 Y7kyk/wxoyDtvPvkdvFTWrRutTIXAo+kqblvAFYohDYjYP8GFAo6y4Ageg5jCFA61JSLO
	 4XiVh8zwF00RCA/ttmC8hlACf4ZW4IQT44wFghu9gVohATTPXhlntrJjcnSwjc+Xdjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401742;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+pblwYSJLKxBTIRGJkAt9nYpTpjvt2/HTCvGVRa40wY=;
	b=XfRcdrONOgIdaLiOGjOalfa8fXPpg9MuxqYBu2lBQFmwyoOB3Tv2R4gJDqF+SzsrqOv9
	 Fv2mGAY+fpEBIhYor+PuaiyTAeIvRfZZTbLsHLqV3JsduMnF4c16sGfC0BQCLcI/15CMc
	 MF4ab7fe9OW+oOtZ84s2fQuvhYM1LdK2JNbilcntmPdawQLMDvl8YhJcyCRMcjmHrkoL+
	 ULym9PCBntNYjZSihdy6Xo5uM2EEQjPnM2lf2hYtBfCkhPn117Ci1z4eOqWQ08lnzMFWX
	 PQnJN7zpWXqNdd1Jxtjq6oTpKPmEMl6xy9n+QhWlUEkOkkvByFbOSxKIpIYOryFSHKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DxFY+JH7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CE6606A31C
	for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 12:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DxFY+JH7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20FA1F00A05;
	Wed, 11 Nov 2026 12:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794401742;
	bh=+pblwYSJLKxBTIRGJkAt9nYpTpjvt2/HTCvGVRa40wY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DxFY+JH7wC92mMypWGNAqKWoAY7pW8MlYwWD6IBN+gBEuwy59gCIzzrGDOZM7dMAF
	 KYBSZVzX7RoFXQAgbWBQR5BeF58jmfpnktgxZi5CjjnRTLq7dy4siE0fQis/QdtqUE
	 eUecfu/g1BOUQsHETe1GfAZE5I3LzQ393GkEPETgAVjIbT3nS25Tl/8BlJ6Ieht3di
	 F1VbAMFDH8HkX9kfSndL8z6KJqIA6QBTWZc8j90NIctKgVCsU0nZWG9fDwXnbP2+fj
	 6ZyJaozLH3DL1lmIuMIZWZSyr2qgj+iD5LKttryYULTxMpyHZeGbv9UmJG+4KFS6/K
	 JlkAN67Hq8MDw==
Message-ID: <sashiko-outbox-209025@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] dt-bindings: serial: sc16is7xx: Disallow
 transceiver GPIO on dual parts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261111-serial-transceiver-supply-v1-3-40bad0f912f2@vaisala.com>
References: <20261111-serial-transceiver-supply-v1-0-40bad0f912f2@vaisala.com>
 <20261111-serial-transceiver-supply-v1-3-40bad0f912f2@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 12:55:41 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The SC16IS752 and SC16IS762 describe both of their channels in the one
> node that references serial.yaml, so transceiver-enable-gpios validates
> on it, while the GPIO belongs to one port: the driver gives both ports
> the same device, serial core requests the line once per port, and the
> second request fails with -EBUSY, which fails the probe of the whole
> chip. Reject the transceiver properties on these parts until their
> channels have nodes of their own.
>=20
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-serial-tra=
nsceiver-supply-v1-0-40bad0f912f2@vaisala.com?part=3D3

