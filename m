Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793913653;
	b=yesE9zqdekqwm2+ZFngFbNuv8lOaSHfpXe3A3Btpzsl9O/XywgEVW3BKpxMPrkB5sbSh
	 VDzABOLghvB++L2D9I3GzH7849trVs7wrqK2EYazYmlTBhLhTjvtRJB62OvDFmGvYanjm
	 ONfUqjyuzvbNw+PxREYh97iAWur19jkKnMgHhvjVcOPHdhUt1pTSCafOkvP9qnVZFpwEd
	 +NA0zzXGkVHbYBnUlZruEk/p4FKrEL6jpODpmdSMpbRXLvRGVYD4IkNX5TNCBeg359RWc
	 wfni2eQ0I28TFWIGjNSzC0HUR/wEdvrS25BXSSwwnBHQtRaZjyZkzNOAGPrgYJNQt1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793913653;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+Pv8Un1R96nOmGNKBeFCD375e2MnR1JyhGUvrhG7STs=;
	b=BfdNKzgUAmFPSeZ+mOFpyDmRHnTIrUabKqEM5wwOyG9C1DiGud/eY6hJVBgTCF7yi1d6
	 9YT8L8CxmJGYjIDt8Joj5yGMesD4WXOgAQEj9EpJStoVgZk+eV3mzU57wt4aD8TLfT2SL
	 ZcolqQTWmW6mjpZRfNzTLAsG7dysW2qDfHp/EuTdk64jrGA4n/+CIhBd3xQCUpM0DXBrT
	 S/zprhtNqbtAxfgdQQaF+Q1CkLwLH3DO/yH+qbnZuAKGe3LMtypibz3/XuW6ROJ4AMAXd
	 1YzftakmiBbJ9LELMXBgzpq/cGOmXrrnoim4/L7eUZO1UpYo4eRKc/QCfM0ihP/cmpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lHS55/tO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D516E606A326
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 21:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lHS55/tO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572CE1F0089F;
	Thu,  5 Nov 2026 21:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793913652;
	bh=+Pv8Un1R96nOmGNKBeFCD375e2MnR1JyhGUvrhG7STs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lHS55/tOsf/yPIkYyc4dQFN6dA45aXPgDXRI+PYmcrgswKA+v5Gj5LMRQWK1EdPO8
	 adKloigZQbjdnCaStKPtWOFA1nJQjKZHuC/WoU/0At71iENN4CsKcjyycNJITW7aqq
	 hQWF2iT4fYPpNLSMY7WqYnd2NipfoSKS6l0VHOPpMdTsmMNVXDeFlOs9X07nKeP4Fu
	 pbeReJHEUc6ktiVd23An33j3ErwaMgU3qqjUNBlfOfzsgnm8ZCgUycqMAfhHhlWWw/
	 GgDFMqVa5kibFrsMiRqFKF4QQWLVf2tj+pEdwzL9caeRPJCfjhiBcqHlTm1uCnZZh2
	 u1LUjZ5dM8kFw==
Message-ID: <sashiko-outbox-200218@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/11] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner H616
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261105-submit-h616-uart-fifo-v1-v8-7-14024d2b184b@gmail.com>
References: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
 <20261105-submit-h616-uart-fifo-v1-v8-7-14024d2b184b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:20:51 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The H616 UART has 256-byte transmit and receive FIFOs, but its DesignWare
> component parameter register does not report the FIFO depth. Its optional
> register layout also differs from the generic DesignWare integration.
>=20
> Add a specific compatible to identify this fixed configuration, retaining
> snps,dw-apb-uart as a fallback.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-submit-h61=
6-uart-fifo-v1-v8-0-14024d2b184b@gmail.com?part=3D7

