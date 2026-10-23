Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762662;
	b=iSrA6MJ6MdaSDuy1ADuyElNm3RBPjLAOecUvgQgRHgrSmlqkqYgQlRNdIfD+2XE110RS
	 ZPPdkeGX48Aew+BZJP73GtLslMrZiPwPX2xlhgIAu9QnyuKpQ6xRdTMgBVJHhqYeZ9vjf
	 cGpFHb4N0Ngz/2cqXNddWlJShOmLy3aXrZ+YEV2a033SI43NDIpFC/8pHfCEBtKXHqRI7
	 fZNyUEZFUX2H2fu8Af/KoxG3FK5LCgPhQDiv3RVAWER15FMpIJEEO444P5/UCUQIy8oFT
	 /+4v9KTIMTvcQKAU3Oj/33iAfqcqWYB83YXoHZYwqFLHyEyRoFumw7q9c52prINe2vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762662;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CETb8YGjh9ciXDIMH3jO0s1/QP1PiTVjjZIgBIcAxfY=;
	b=k72pDhK0k+ez2QtmBzb9+7MIAHmvWAX9BzF6JHcU/hSDvweILU2ood5HsLyfLot1DLQB
	 O7EEu4xZ/64/lDdPav+rkNv9ZUdJdMQiYkHAXR9+8GmAZpHt7QtTKXNmSGbDDVLoYpUqL
	 Dd/YNBhCDbmivpQl9fYTa6WdSAyNmcFJUCTHzQlJZje9cz6ffsvpZL6qufjoLEj2rG2tx
	 Uy8i3zIVMd1R+Pj+fQNIMQIBlM4FsydcTSQd0cPxfwxR3bSLMCeLqVILyEff5uUvvhEVy
	 RYM3FAbdfy87AebE/VtQCQpcqXy8/KnrYDbSpWxM+VSmnVCyPcdWpt94aizceQcfJFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PNiz5TtY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A325B606A31E
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PNiz5TtY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AE51F01828;
	Fri, 23 Oct 2026 13:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792762662;
	bh=CETb8YGjh9ciXDIMH3jO0s1/QP1PiTVjjZIgBIcAxfY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PNiz5TtYYeeevA45jUGKZYjUtGwE+8kgANfDJjC2L6QNYlQkfbz3QjNsl4jfw69Ir
	 GyNti8LMyD7VxD/FPw72kuhKGZxZOrVZ24y7gDjrsbnTsWmCI3eV+EUskiKBhEbBmW
	 lWNyR46LGJwWMXATO/5z9mg8WE7a7OxngDJMqm1IhXnlb7nqjd+XS1Lyda8WTggSM8
	 mJxkwIUUtk9s6ourX82SL5w4+9rr6xBhmUMonrV8q2XesZSt0QmlNj4TcJ4gK1Dpfw
	 vZh3P1QuYPGmd3dwCoHq8JX/ZI5zkClsrRRo/U0uiXKte87w2qhDbFTHmaTWoADLSa
	 kq3bJZPl43akg==
Message-ID: <sashiko-outbox-182833@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/7] vt: Remove old-style con_blank
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261023132448.115747-8-tzimmermann@suse.de>
References: <20261023132448.115747-1-tzimmermann@suse.de>
 <20261023132448.115747-8-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 13:37:41 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> All consoles implement the new con_blank plus con_unblank. Remove
> the old semantics from con_blank. Always pass a VESA blank mode to
> the blank parameter.
>=20
> v3:
> - keep con_blank's mode_switch parameter
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023132448.1157=
47-1-tzimmermann@suse.de?part=3D7

