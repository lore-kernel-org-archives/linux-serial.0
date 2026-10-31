Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793467041;
	b=lVwMZ6wygoAZjDfws2z2alIEG+N19C4eyrhjOtbtSj7X9VASvzgVdvWkT+nmiaaeRDFU
	 v9Y1xwTQPGRYN85u5d1HP3z5wyLN9hvrm8XdZbjFnfcSoUtfRvJdzgz+MOBnwT/C3wS/d
	 FcnDwAlRRfpxLmkR89QhVZ3HPWTI6a6q12uaeBeMu8jfZLpsqJ56rMC50bUZv2SYQ8UYJ
	 YvLD6itTYZI6ht20KMp1r6m5tTuUG9aY5M53MzQ/8q655Ebhmcc4/qbet/BGOI7bl/PZe
	 7eD2JiMteVi4beV/WzoR9qVCw/clZKNIGqGSDPPU8nXfxNJLPMMs6ykAD3IFOQ4Qt4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793467041;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+zayi3HgNSPVSNb3fBcSzqgWTRBq4igUe7aqJl2AjLc=;
	b=fM+R9sSR6l83ow6/sirbqm4p0NPnrW8eb6S7ymGrX8+oDKzFsaULIxwy9RVBShAZGmnA
	 1Z2ZwKyG0K8MICWMcxVtIUaXiIz6bpXGsxeABDt7K6ky+Ap9bHK00P+1Id2EKlUhF59Zx
	 OK/HLoIz0TimJqFNLIKkXMwomB6GuikKWik+SQEWJNGVGLcTrqhvpYuw6b3oyYfksuHF5
	 p8UU6PHj/NRvqRdLEDI6Q/1wALLHcCd0cCzQOuiqEF2Lko53NU3ZC0EzKfdonCrB4Q6vN
	 VID7VIiRsi6+uPFPMDFAwbb7Zeax+29twZ4rlIqUQygr3ix2B7t7HA6TzhjKU9FJxPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJwuRVsa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127CD606A31A
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJwuRVsa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED251F000C1;
	Sat, 31 Oct 2026 17:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793467040;
	bh=+zayi3HgNSPVSNb3fBcSzqgWTRBq4igUe7aqJl2AjLc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PJwuRVsahK49mih6LkuSpYhY9UJ5/FEhp5vpLHk8w27HwxdLC7kSmt372J+QERiCF
	 2jVJL57e5ULeDRs/yDTN2kud0fDFjfsIt9rPv95a8fQiwE8sWaaZnrWelN9OTl/wGK
	 L3VRHxx4B17tAGco4Kt46uks1FRIs7Y4nvdaruyi/wLVPPQsDo8LfTYIlYp3zCdyGL
	 W/HtQb1nDvAqyGSoNF7EuNV0QxCT5PmHFOitpDUvWISim29plUO+CdNlZjPIdu26Wb
	 toi6aXokWnSngng+x3NFl7MAWZHUOhDlzeQEouf4c0PL08yFW6Wog6b3eOVrmc9cm2
	 wiULErtKwD59A==
Message-ID: <sashiko-outbox-192060@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] serial: uartlite: remove redundant
 pm_runtime_dont_use_autosuspend() calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joshua Crofts" <crofts@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261031-tty-dont-use-autosuspend-removal-v1-5-7bdadcadc4dd@kernel.org>
References: <20261031-tty-dont-use-autosuspend-removal-v1-0-7bdadcadc4dd@kernel.org>
 <20261031-tty-dont-use-autosuspend-removal-v1-5-7bdadcadc4dd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 17:17:20 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosus=
pend() on reinit()"),
> driver core is now responsible for undoing any
> pm_runtime_use_autosuspend() calls on driver exit.
>=20
> Remove the redundant function call.
>=20
> Signed-off-by: Joshua Crofts <crofts@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031-tty-dont-u=
se-autosuspend-removal-v1-0-7bdadcadc4dd@kernel.org?part=3D5

