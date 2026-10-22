Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685594;
	b=bMBMo5dEJI0/iUH2wDiBEOeaKcFKVVzsSbM7mmL31t+DFKti1i4AOKdrRPj/3rijN1O4
	 ZTNKZh8MODgeRvutPGTYsgCgEOBGWDHyZpdUbw9aws7yptQ/N+/6aXcj/eHeZ6IaS+8MX
	 nsI32EOf1/FMKvp6Vabotub0m9VWssAvOfntV77pmTBKe3chnZsTsW+R9BTeqGk0Hj8CJ
	 dn70gt03V98Fz23PvEIkrJ6teyC+lSGub/k6UCKYANKROqVcHuzDtVrDmvY/5zN78k17v
	 fRBoQW8fL/lfZq9EVG/sLlvqrcpbKyHbDxcV5CO6y3O7B74g4aPwi04l6t9Ye7xqy7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685594;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JcbJrMwo/8k3kbS0tFEw0+h4GrLaoNONDxjlaNwqCts=;
	b=3X/tZ2JZ90KB8Q8BYeZkMWf/RiTZrY5aO2Phse5WVcWhDGyk8HZ0N30PusAphCYJ4CH1
	 KuGhxr5jsmPCaWQqZXYLwz5q+iYa3RxIPIttAEmhhylk4vtve4qGHiV3He6d8Fsw5BI+m
	 ejUgomICpdCyC2C1PvK+x83ODBxlAC6GScNi4M6rDtdbSWhIB0RlVQw2EdeKbkKU18MNi
	 /3hWQvrqDbH46y8EFT4DcHfudlDf+4d4VTdJJVZH2YnzXm8UkxL9W60Sglmg6iFR0j6kY
	 FuKQE7WQcwmXep9GBpqmW+ohLS+4EIIOBxWHv5UuDNi4qpNYW2VjTIOyB0oqpzOb/YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W85J3VPQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0F8606A334;
	Thu, 22 Oct 2026 16:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W85J3VPQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E311F01828;
	Thu, 22 Oct 2026 16:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685594;
	bh=JcbJrMwo/8k3kbS0tFEw0+h4GrLaoNONDxjlaNwqCts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W85J3VPQua4wUxtCE7UOR4s479VNoghTTFc134Ix3GavoJBG85Nw2Dzd3K//cugh6
	 ikYI8W8lekMyQzWj3yezTHei69LCGqxPC9M9FTqKVsXU6ncO+IeOoQa8ORDSo5CSNI
	 XswfnqBG3bdD3kMupRQvOdcN6qi3L5zY3r/wAEVFEibpDGg/ebff7RJGKH+kfJKUVp
	 2+aMG4RQvKySLV9jrOEoaihy5M6PXA+sZRlnlhb084LP9v+m3rNfoJl033lWCTic9v
	 yCS19o+qQEYTBbHU2fs5YKVvczpFLjLllAqGpBewk7cOhme2xNlLNfx5nze0eOohbu
	 GCMkjw9lZYw6w==
Message-ID: <sashiko-outbox-181779@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/27] dt-bindings: thermal: rockchip: Add RK3572
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: mfd@lists.linux.dev, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-15-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-15-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:13:13 +0000
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
> Add the RK3572 thermal sensor compatible.
>=20
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D15

