Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762896;
	b=0QJ+PtvBQmYaU9IjNM5c2HbKidgnEZJzhdpwZlWQLCwWx9twcOlnfj7cbwIjoTin9G8s
	 JCkmiQdjB1t0zV+6BfkXTKU+JomzIKiFEquGZn2rARJeMYoLbxSWTn0uz/EbRK0mCTwcV
	 YWWmJr1rxETNJ/tHQygimeJTfeCmOiogJneVqhxOzdD2KyxNkLnLowWcBKGmkLJUoMPOZ
	 K7vlwg1nquF4WicEJNLfWkh9SQ20s+PCAQMPQGg+IlvvHzFMpkkfRTcGKam4m2xEr+J6k
	 JeYPvUzgNGrjyLd75iG2NWjSP6NbKCEQpdGTGZIVbYJXDQH+zT583fjS7K6SSFW7eLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762896;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q9nsBLUspqpZh30Ef2Hy2ZUkDmioNQ/pFZqMLgelw4w=;
	b=Z35O3i6h8igOMnromSybdAyNpYKvRUTjtivWngT7xOyfkxmKt1EdOscFvYjUb4gExgan
	 r77uBKb2qzIrUd4jbolmfeYL+VzNcGYgRLsky3b+tJqgOSsGayJ61arm6X1+V72LapRqV
	 m4cc3qrfGcqeFcUb8YsAQYOEQlDKbqx3RBbogHS0w3tDOkppsHjT21KCKYe34U77QONP0
	 bQMOUHtV0lKmpGpJb+rvJaH5K9pxzVYJ14E6HwNiVKvwTU8HX5yeoJXLcJKK4mznsVj7O
	 hyCZv8bouvIiuyaa9HNAbUSH+p9kMlg6CA+0x+/tmuaqACNprgpColOhIm3LANKRZnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LU2Pf/H0";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D50260A2626
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LU2Pf/H0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0074E1F031E3;
	Fri, 23 Oct 2026 13:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792762896;
	bh=Q9nsBLUspqpZh30Ef2Hy2ZUkDmioNQ/pFZqMLgelw4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LU2Pf/H0n2cqdcqx+vppBOydh9gl19x2xAms/+otNzUf4EqmmALTmu05c8SbSNrmo
	 +QjhEY11AWzIn5TMgn+iqvNdTxOYl+NZTMtntfJDxVT9psLDOf47Ypu/Ck1Qz5gjfv
	 aatz+lyqH1TZPpXl/wNQV0m4sJMr12l8bvaJUcMYDaTBqDR6kh5Ri9lNN+MQ6OJ0XX
	 cyhsSYxOvU3frMIzmqEQ+r8f9oDgEz2uqPyAKw7bTCTTk8pYiqDcWy894JUjP9I6wg
	 CkXPLEGSXguZrbNBN4S/McECDUc3+KSXPuAg5s5KLgrXdxBcTVwJjSaQNEyuKrLXsK
	 USrCeYiREncJA==
Message-ID: <sashiko-outbox-182840@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/7] fbcon: Implement struct consw.con_unblank
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261023132448.115747-4-tzimmermann@suse.de>
References: <20261023132448.115747-1-tzimmermann@suse.de>
 <20261023132448.115747-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 13:41:35 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Implement con_unblank from struct consw with the !blank branches from
> fbcon_blank(). The new function is called fbcon_unblank(). Remove the
> duplicated code from fbcon_blank().
>=20
> Fbcon tracks fbdev blank state in par->blank_state using fbdev's FB_BLANK
> constants. In fbcon_unblank() the stored value is always FB_BLANK_UNBLANK.
> In fbcon_blank(), the new blank state is 1 + plus the VESA blank mode
> given in the parameter blank.
>=20
> fbcon_blank() now disables the cursor worker unconditionally.
>=20
> v3:
> - take mode_switch from parameter
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023132448.1157=
47-1-tzimmermann@suse.de?part=3D3

