Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794298043;
	b=g4M0oNIOEWtpYFoq+R5WhQKQsH+TtCtwOE5qV1SxeWR8P92k7XF7RhIlq7y0CmUqw1fW
	 eYAw9RLrq5QwCGx4U5nApGkXMpMNMKy0orc+aULGMlDticiwgejyTuMTcgBGp9znpS2vi
	 I4SEqCpJAESVREl9AN7dbG2Fsf/I8K8ICtTnBESkvhxS59RQnedXy+Df+HJSO66o26NBE
	 JuDnEyuTWeINLu+VpGPh0h6kHwWDrj8JIttxYJr0fQlLtL62Sx1xV4AHw81KxYacactzE
	 X0eUIidF4Ot3LZOdJAV+uCr2D1Hw42t+T0M9RyiZFVoLqReSt9Px+gIIhU7YA6+C1mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794298043;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ssZ5ZpeiZtpdKzbE7XYTTS4fUSE3EFid30ljwHqv5y8=;
	b=NqPowGtRYbT6QHhO7bWkC8F3irsav/rahoEvcQvcsTmt1dNpEMVwtE8xDuw7Vac0XFHM
	 K0SdVQAG3Qm70enLIFW4h2F6jYWwM5CtuNK8rTIyQ9TUrHR3tcuCUt4vTd0xW8ya3t3eV
	 CE7lm8gxotya5Zs6mMfx4FrKSip3TEirL0f638LY1InHUespF4YenowkDRLZOkwxojhI/
	 lXBNOnKwhYYnBaC4HW6/r+y3y28ICLzNS1NZlTlbyJmglRKc2+k9u5J0C18tvdce2nvpS
	 6O34LJSjt+H3b1WirU0EAN6uI4GgobeT3CDt19Ri3N6Y5LMdXK3SE8/fU83BAz5qVGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IzcndXgW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC95606A31C
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 08:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IzcndXgW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7C61F0089F;
	Tue, 10 Nov 2026 08:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794298043;
	bh=ssZ5ZpeiZtpdKzbE7XYTTS4fUSE3EFid30ljwHqv5y8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IzcndXgWTjO9vOLE1czEoQ2ka44Nt2AKhX1zjjyocW3KSMOjXg2pXdbzbroLfpecV
	 PvuBllGDtcdWvTPzl+tnUbVaoaUDLNEec+i/9ajGBjpEZ0BuqjPvljx/ht86jXYiNR
	 4E96JxH3tfrI/+zjjIEyRB69lYjgNONOEIrsa8W6Quphqxuho+RyN8Li6orSexN1fe
	 A7JhBXsrmsK3rNUBP+vEC9nCX7f7uScYIIkhl5Yo5zbOtf12mEgsB0gTYilsedflIp
	 Ut7S9ynQRiiP852VgcZAOf3ce3tY1xmD+wq4N0G4Xc9OssLChP/+s3IA/6tcPYsEHD
	 jOEGHYEtaaQYQ==
Message-ID: <sashiko-outbox-206566@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: n_gsm: serialize mux configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Artem Novikov" <novart962@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261110075538.51452-1-novart962@gmail.com>
References: <20261110075538.51452-1-novart962@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 08:07:22 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Artem Novikov <naa@amicon.ru>
>=20
> Concurrent GSMIOC_SETCONF calls can both decide to restart the same mux.
> gsm_cleanup_mux() releases gsm->mutex before gsm_config() calls
> gsm_activate_mux(), so cleanup and activation from different calls can
> overlap. The activation paths can register the same gsmtty minors, and
> registration rollback can race with another registration or cleanup.
> GSMIOC_SETCONF_EXT can restart the mux through the same paths.
>=20
> A 5.10.246-syzkaller report shows a NULL dereference in the unregister
> path:
>=20
>  KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
>  RIP: 0010:cdev_del+0x22/0x90 fs/char_dev.c:596
>  Call Trace:
> [ ... ]
> finish; independent muxes retain separate locks.
>=20
> Fixes: 01aecd917114 ("tty: n_gsm: fix tty registration before control cha=
nnel open")
> Cc: stable@vger.kernel.org
> Signed-off-by: Artem Novikov <naa@amicon.ru>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110075538.5145=
2-1-novart962@gmail.com?part=3D1

