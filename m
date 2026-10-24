Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792821468;
	b=rtG7kiO8IC1Et12SUZQ/odFizD0M9DuvAJ3JaDrKhspLhQ04FF1e8A6S3TtVAVPamUWQ
	 +d6QFpX+p4n9gejgAsmeLnvHljlbzKbp1x4FZtSYIS49XiLdFFnOPPqS1n8w9N4X04VRl
	 o4biCQH4/HicfDDZOH0Gr6T2+RvdBWLKc3KAC03BbH0CJGvFKH7Bf4xDuGPka5hY5STZq
	 hrIy03uU78SM0rY+bcyPH8dgIlu2aNCZsI+toibYfT6nJqcByv/ryHO1q5pOhe27SIp1Q
	 HR0Dw7qfuCzL9drSVkNcX0Omoyx0Jl0hytnCKbxRt4e3OWaktD8dK/Uvu/+rVXcQsJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792821468;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bOQjfnOqEO0vdNcHx0bOWlgK9aVHH/nHX7+pCef+BYQ=;
	b=SBoykQJlrdofbXsj0wovqjv6njMYE2X67enJvgO0MsB8q6SLjZvfgnRi6i7Bcs4ZMOkc
	 gtfEdRX8VVWk27JhdP7zQqn69tEmccaEfvwHa9ZPR3hcYy2LWpe6OJDNYiJVIPu2J5lLp
	 F/6DNHENskIqC1DWapRI2rNqeh6OnOpSg2OWOHFajYyEM+aSVAgbPF9kWMUyNzcNQDJhv
	 Uv2zFMXAFjWw+BNuJcOVzdFNaWOgZLQYobK4RcdxgRAIjac6S5kqHVoWxzzwEkQ/zQkYX
	 3GHbUmC89wYonuatiWfAJZavMm/Ebi3jwUJ0X2DjICvIDpAw0Do8XFTNB2Y0hmIev0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GUn8sUw0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAECA606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 05:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GUn8sUw0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDEA1F01825;
	Sat, 24 Oct 2026 05:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792821467;
	bh=bOQjfnOqEO0vdNcHx0bOWlgK9aVHH/nHX7+pCef+BYQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GUn8sUw0lBm4EWwpg1KNCDG9PU20INsSPyTdSMW74QWjY1oijYGKMXfrYdxRQWawi
	 mHaFa4CFF7iHS21bIjAmyv3gU6PmSsAfGZusbDQ91iYyFi6oGtb9GgFXDeOP3Av/Jn
	 MP9Q3klvPqLvozkVX9ldAJH7T5G1IYqUAWQhsHSE8Nxev9Fnr3l0G3g5E62VjmRj/P
	 drra3hJbwe+QXPIntJoZVKhJ5UTdCDm5rFWOPN4oURLnULalLVW46ZMtync25nA0CB
	 OO8UpXmB4722vzytkLbaDSowQUkZ0yuqCicJC3CoxAyGUI9sTIhm49JWTwtqaVMMa0
	 NYs+5rJgSXhvQ==
Message-ID: <sashiko-outbox-183561@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250_dw: preserve BUSY-safe fractional divisor
 programming
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261023-submit-serial-8250-dw-divisor-v1-v1-1-f452d4bb1b1f@gmail.com>
References: <20261023-submit-serial-8250-dw-divisor-v1-v1-1-f452d4bb1b1f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 05:57:46 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> dw8250_probe() installs a divisor setter that makes the UART idle and
> checks DLAB before writing DLL and DLH. When dw8250_setup_port() detects
> fractional-divisor support, it replaces that setter with the library's
> callback. The replacement writes DLF and uses serial8250_do_set_divisor(),
> bypassing the divisor setter's idle sequence and DLAB readback.
>=20
> If the LCR update fails to set DLAB, the subsequent divisor writes can
> reach TX and IER instead of DLL and DLH.
>=20
> Install the BUSY-safe setter after hardware discovery and extend it to
> write DLF when fractional divisors are supported. Program both divisor
> fields only after DLAB has been confirmed, retaining the fractional
> divisor calculation selected by dw8250_setup_port().
>=20
> Fixes: a7b9ce39fbe4 ("serial: 8250_dw: Ensure BUSY is deasserted")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-submit-ser=
ial-8250-dw-divisor-v1-v1-1-f452d4bb1b1f@gmail.com?part=3D1

