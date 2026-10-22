Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685581;
	b=aTUQumSzTM7VJxPvlcrOC9U0UsCixSv9EVBOUuRHCOvDS4tDf4cFhNoKmvUHgPVDG3/8
	 jhbkgdGdbo5ogxMNlDapE88gNbDKASaRgh/+ZLQ3dXKR2+bqKrGZAzxQ3C9UFaX3CO4pZ
	 ocfnv5BkgMtYvKtGgL/QLMwhe/DOeoZ7syEs3Ag6zv08GloZ2UNxqIniWAUUrI+L9r/fO
	 DseKYM+6ZChuVpgejle5OWJt8AGtYcNVFEdc//ZiItcKVPinPiJxH1RHiv0bMWu3v+97k
	 86gpyikLE0IsmcF9KtAv3PnNC+/BTvwk2bL3Z3zPOEDmRG9krKj5wRTGhZ6fzcNN4YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685581;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qOxYU8LiAy25noU6ALOUDyaeUrh1X7W+kUN39MJgcug=;
	b=vPQ5/SZI7M6yFQ+dgdpRMX8yrYS7DaAHB6FzZ2ytmGHYLzFeLtAHOKBi7+ip+khDJQ3F
	 HddumtiYY24Gb3ELrH2rvkNrxgCyhS8jmk0HtubTlnOuZ5WPQliX2xcImn3yotvzFXIiW
	 auXrtCXIdVE5zN2/qXLNCQIe+2PODfDpCtx01fbom76Rmug6+qZO1hHu1A0JJ3Ffc+kLE
	 QutfFtOWxrEgyNwfXdMAZ+UTuIUAxeog23hsG4Ntue97m+0NYdKIlYlEqczNLNZEVTk0V
	 7DouLIiZIpsZrGHfKOpQ2ir34IDq+tjtP2Jv4xYwJSLluw3w2XnUEU4zWiOp+Y+Xo0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNL8+tYn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831A5606A321;
	Thu, 22 Oct 2026 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNL8+tYn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034951F01829;
	Thu, 22 Oct 2026 16:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685581;
	bh=qOxYU8LiAy25noU6ALOUDyaeUrh1X7W+kUN39MJgcug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gNL8+tYnFKhpRuDPHuEH2VPxzlehOGzs3/2bYDtE8NMZKaykRm8BXvKWobHsuQzgG
	 PulvmH5DJA4KFGQ7OH1+ugMOniJxp6JR7gpJ8VYwc7CcHciTLKxryeq5kySgfEkNrf
	 wInQHHjpCK8X13j3wpd3gGCeRt310IhtAmV37DQW5NPWJN+Q7j7axnMKYl5cYxv43d
	 nY5VKiISPN5DhetgmK7D0AV7ZOz8Ciry1MEtQzc/9NRXMfBWEz8Do9X8DmX51nm8ga
	 whbjXmV8eqcEhvaP1raFoyWT9NBI7Zy8D49uMA9npqIHFIEFaiRHRKD9lzpHFiRfre
	 OUusELstn3WOA==
Message-ID: <sashiko-outbox-181768@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/27] dt-bindings: mfd: syscon: Add RK3572 QoS register
 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: mfd@lists.linux.dev, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-4-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-4-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:13:00 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Cunhao Lu <1579567540@qq.com>
>=20
> Add rockchip,rk3572-qos to the syscon compatible list.
>=20
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D4

