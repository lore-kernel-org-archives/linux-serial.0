Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794766086;
	b=tFjNWA98BP2IYC6XEBgatR1y9QqET4CzsgnNgDj13zhnX/ej7fhFKahjHrYEbNOls1Lq
	 JAX1CqlzyTVKdPv4xfD/u9YZnx97PkBo1DT1J7/Aj3doR+MEf6v/pOu4xOwBBmoYetLCm
	 1xBhtpqeRpkbXTFGUfrTV0ejKzMhe7LLUm7dRyK7co/37296348Ik+gXpi052a4kOIg6A
	 DgmRiVbRj3Kd2tQUkLY+AmCytb/yp/kycQ1BqBrtNUfyfMPcxeB8cRVkVEt96PqLrIWs7
	 hSm+RBT+6rBLYOg0WBshIPWSSDXkTBbL08UEgfc6q9Z0vnw2h16U3xYMqjwzlJGY0XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794766086;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KLoGpol9HUrWuIRj8cxVoEpWUB+yRjQ504El70X2we4=;
	b=RE+XlJRm2BULOZ+5H/zg/qmRfMG/Jbay38hoKTu0y+sc5QP1jN3omnAOYADjajqzajps
	 U3oq53AJneZPM19dBETdqbRX2NbYnCxwEGcrA18HUEq8MQSxXvSjDQeWeJNI2r5CXLAxl
	 umOqGpXenSzQUZfPp4vBezPb5QHnMFabqzmZbpU8LQ6+YuFyyuaKQ+AX7XgPrix9mBHD5
	 2XhAvJg7EodA5ZQIzmUKgp2Y2lXfxFTEaVSXd2QbRGn4q4vokhhiCMfnqWt7yArkBBU7f
	 qE0i4GQLUKcS9oddjubqWSWlIB7TMVIpD8b0zEaUBf1HOHlj0z2yzMIJs9TImhRUDDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjVT6OJK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0790C606A31A
	for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 18:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjVT6OJK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D48B1F000C6;
	Sun, 15 Nov 2026 18:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794766085;
	bh=KLoGpol9HUrWuIRj8cxVoEpWUB+yRjQ504El70X2we4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cjVT6OJKAS/LJNiSuW1pcZIS2ddPRm2xbk6HkIptshSIQHthQRb2iihfD7aOpoZjI
	 ftMZUZl5cyvxBnMY9ATXPKdtcWASR63DngJoKJ8IHJmNrMcwQpIWG0eJ4SSfDBrjuR
	 8FwcLv5PASxO4EbtZDzzaIpgfzXBVK/lFPHAnu/Fjh3C3aGbh1hdU3EOx79LdhCXzP
	 lRwY5C4dA16TwY5K06Gp0drt9o7kCOB685ATwaRN3AtOKCTXLFPb0vde2kPqNFZOMv
	 ZFDJeNW7osEfoJC0cvCsq4iueo+2g+rTTdAlp4UfiBpEznGGqHlE2RAJMMRf5Zh89/
	 ghR1blyR3MzYg==
Message-ID: <sashiko-outbox-215702@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] serial: fsl_lpuart: Enable break detection in 8-bit
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jonas Juffinger" <jonas.juffinger@liebherr.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261115-fsl_lpuart_8_bit_break_detection-v1-1-b7ac2307dd55@liebherr.com>
References: <20261115-fsl_lpuart_8_bit_break_detection-v1-0-b7ac2307dd55@liebherr.com>
 <20261115-fsl_lpuart_8_bit_break_detection-v1-1-b7ac2307dd55@liebherr.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 18:08:05 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Jonas Juffinger <jonas.juffinger@liebherr.com>
>=20
> Add break detection in the code for the 8-bit LPUART.
>=20
> The driver contains the code for the 8-bit and 32-bit LPUART device
> but only the 32-bit part has working break detection. Add break
> detection to the 8-bit LPUART driver.
>=20
> Break detection in the 32-bit part was added with commit 5541a9bacfe5
> ("serial: fsl_lpuart: handle break and make sysrq work") and later fixed
> with commit 707f816f2559 ("tty: serial: fsl_lpuart: correct the count of
> break characters"). This patch is practically identical.
>=20
> Signed-off-by: Jonas Juffinger <jonas.juffinger@liebherr.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-fsl_lpuart=
_8_bit_break_detection-v1-0-b7ac2307dd55@liebherr.com?part=3D1

