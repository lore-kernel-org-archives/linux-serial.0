Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793115630;
	b=AteGuodf68Cm2BNH0xbRUPLojdm7ydzlQ1s/xZIUT7M2/sJ35Z4Y4f6tgWik+Y9YMpow
	 McBTVc8YiVpYzZri5hZJsrAGVaBy4UPH0NGrr4rAlhJj1mBb7eXQAogQ1yTLRz7er1DBE
	 Xuk8t+2Y56DRTSifUNRQjYvC5yXrQYBnAD6KQzcvCLWhpM6rOEX/tOZGrcFMNv8zVSh91
	 C/zGg5uezvyeI0SGWnBcg0iDjPplczZg5BvIjhGA9kqSfzhfvlxMwBiXFieP877E2jSQ+
	 AaWPSM8rgFEQ+JpwUS600C6b70r6iqLfquD0NhHi8nC3acdGUq8OS6+JF5rbnU6w2pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115630;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vlXBwk0gQBlukAaX+Yl9r7idzSj877xHssPDdjS3ALA=;
	b=5GLgyS4O+pDeHog4PjnwsudJ341igIfLVFYXfInKsxb0ygzr6SkIzfD99uXjsACGzOzb
	 VFXgxcv7Xmt+9Xn0vDRCq7kHQ5V+/vxGsicxC6dH74Qh+tIyq5bnTUBNYHUH3YyLcZGmL
	 dT9sjZRqRrHfbT/DCiQ8Kbwo+hjPXEmDf2Zi3tzZ7hQpNccn3/jq/nWDTTxiiZ29LKV/X
	 ibpGwlbEO2mWPHjD0DwqjmyPLCyvxt25/yoWTKJbh3kjRV275RG6BB++taXmpaa8AmvHw
	 IIVApuEZtV3PohW2+jxc3WCLKxTquQwL4NEqbpHg4L9ahNN+wIUwjRDnRcMehcwEkDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWthJRGk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263E6606A31D
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWthJRGk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872F91F01825;
	Tue, 27 Oct 2026 15:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115629;
	bh=vlXBwk0gQBlukAaX+Yl9r7idzSj877xHssPDdjS3ALA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MWthJRGkrffb9DFI54/25/s6FMfV7IcwQ2wSdrVHGSF0/L3g8MDog+NcJPUZTPClf
	 n52NaNmYb/+AM85mmoNuLMYx271yK6n2rSuaTk853IcRGfTADO7pHpnKZ8xqtrB5Bp
	 OFmwGFXSk4peU7e4umQhKMlnkjfNPR5TUBdVWvZl4CZezkc/Djy9IlM4+Qo4nSKNgC
	 tSa+XUm1IAy+lH58jBI6oGhSg5chcPsUe3foukNcZXsOHY38dmEsjq4spSLWC+FnFd
	 iALTV+fRP57tkIBXBPJdDZVXGdmyUKegXXJgcHkgopVRluKATBUbel5df+q+38/jL+
	 P7E1CCxa3gHkA==
Message-ID: <sashiko-outbox-186855@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 09/18] dt-bindings: riscv: add Melon Pi V1 and V2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-a210-scmi-v1-9-74d58ce85bd8@iscas.ac.cn>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-9-74d58ce85bd8@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 15:40:29 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
>=20
> Add bindings for Melon Pi V1 and V2 with the A210 module. V3 uses the
> same board compatible as V2.
>=20
> Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
> Co-developed-by: Han Gao <gaohan@iscas.ac.cn>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-a210-scmi-=
v1-0-74d58ce85bd8@iscas.ac.cn?part=3D9

