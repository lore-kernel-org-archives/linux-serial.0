Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793115646;
	b=GRlAAOn3leFSDT11ZA47PMLBdjQIF9xS5hGcxidTHqgOCc74PoHnhr981oWG5EKL7bsP
	 2ldtN86LKnEATzo39U63OhNS+W/v84YRdOCGfUEwq3xIpbJnyQALsaUXw6HHe+nHTAX8Z
	 NHdylc85V0vD8Y3AuqDC1QJ/7QbgukWL5Fx2yy+IVqhxMN2NWfdhp+kftGE3R4uUjMVWd
	 t261bI/jLy5b0772TXKV6kd7L0+0werwRoTXxBswUAp8/lxDwm0oZMCElX4bsYxpCp7zN
	 ng9XelkM6zm33ZEbjcYKXkqMuxaMoyB89HfxP650u0giXyJaG39i6M4Vm+beOMoN4mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115646;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=89a1RDXIKNvp9dGBL4RtjAk4rtOeFGS3AcqB3SX5ZlM=;
	b=LpOaMfZt5rZbG5vY6HaG+ir6dyi8gtw91+4aLcCK0zOIxSVftsovZVdB2QE5PUErCSWi
	 nt5O6tDtCBzM5rxhvwKVngBHYJQIzSpWtydJDo6Ja9rc/Qedw2fQvqiLKhHwFE6T9ScPT
	 8nB/oZpp8mh2B73oBZys+0OnDsSML5WLBz331YCKouwZDPTvkWFL4dF1dGWsSUjHQ4EJR
	 iIWinog7mnxb8ZNKD/o8CFwjAZHu9JR0mEuFd80NxKo0CA805E2BVEOLNr+jl9cisskUD
	 EWnIEVbD/cvic6nTMMVRHI3kcfQtQnWqOnPAShQO15oss7d/zpdn7DUtZxUD2XPkT+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VMTUa7pO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A9E606A31F
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VMTUa7pO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333ED1F01829;
	Tue, 27 Oct 2026 15:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115645;
	bh=89a1RDXIKNvp9dGBL4RtjAk4rtOeFGS3AcqB3SX5ZlM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VMTUa7pOTC5H+P3ukY3yL1+au2RPuPZf2d7Xn364QMsbFvLuM2+Tik7g95hf+RVoR
	 TjUPV2wCuyoGXvOb6jhurJECtb1ceHx0/6HHEozqQ6Pq3RHmEQP06AbvBTbpeblrsd
	 mNcylEmGNpuG+uPunuzU6HKymBjCTXgLPeofbMk7aq92HcfJLW46Jx/TEiCNGn7FuE
	 DSyxlQzCoxQJG3rOfcZHjmFGGrGStLlrQNyqAB30hWLDdtR0D3iSj6D4lk2HN4RaG0
	 SHT6177bNxeaMkxse2/2spBZDk+CFU32pZR9+Xx1Oo/6tzErAHMkmSYTEpljPIzTTi
	 SqdjivhSiaqWA==
Message-ID: <sashiko-outbox-186856@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 01/18] firmware: arm_scmi: Allow SCMI transports on
 RISC-V
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-a210-scmi-v1-1-74d58ce85bd8@iscas.ac.cn>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-1-74d58ce85bd8@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 15:40:44 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> Mailbox and shared-memory SCMI transports do not require ARM execution.
> Allow RISC-V platforms to use the existing SCMI core and protocol drivers;
> architecture-specific transports retain their own dependencies.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-a210-scmi-=
v1-0-74d58ce85bd8@iscas.ac.cn?part=3D1

