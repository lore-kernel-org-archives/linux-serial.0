Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650046;
	b=FGJVdHt8iQuaF4KkSBbJ2gjZUc3NnRNx/znhtwimZ8y1GNWGAQI10ZNNpqyacfcG36cR
	 uV5LQ9/v1WwoiDJbqcTM8jWdrhy3OdbCPTcpqjuoVfx3AJXiEsQ3O4b4KQ2a+NDlJRr2O
	 zehfRLP3qnW5QNJ2U5vrlbdjRLKIIF1C+yYSE2D/y+gEMlIpgLRd6Dn3VkLfxdjlqRppp
	 RhQJUdtSbGwwCVPbDjpRPVZ7oOgSTcZ3Gh3UX2xmArjBA7T2c6RgiDW50bGeVqSQYwjrp
	 EcnX2okiWGheBrcHXh+4k+DoBt15tNOVxAV/VVrp23LVUXxDW1yMj75UEUDzK0O3Oxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650046;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nEhTZlnYvnXrA4rWODkRDbGpmna9s3elf/mLQ5LGWnI=;
	b=DMXdVQqqGH3U8Oi6vp4JGt/TXpcalDYLKf/aOZJ2l+fnjfGqrGqKgkrpNpfaIhFKGQpD
	 g7ZcZ0ZZig0OBbyfCoqn1weUvvASvNCqfFVRHDlLWAoRLf033nT9mvz+74LAez5OZn2Hn
	 Xi3/XecoELfsV264c0495AwFKPSSdsySjy+BHxfpJmUmAaoNuhmddAYsdPPp0uG3zScMF
	 2njepPSZsjE+HmtW+Uwqk12MgIRV6zacBcWpdNlY2t4hlGJMqTUI70Lytvuod5doAgpeP
	 ySNSQXSbzgKNwBfad7Wo5a+YFpZC4maAKdOG3yunA7Ukcp4piBfLyIdyxwZhhXcNS8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gW0Gd8B1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AEA606A326
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 20:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gW0Gd8B1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FF91F00A17;
	Mon,  2 Nov 2026 20:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793650046;
	bh=nEhTZlnYvnXrA4rWODkRDbGpmna9s3elf/mLQ5LGWnI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gW0Gd8B1+rc+Vrp9lYxZqygCQo1dagQgNWmJzLbk9UvIMM1IWDTrFFhlOYcnJUD2s
	 0gvWwfu2j4G158h/GGpt6LoZXABu3eE/yen0WZJtQcqRGEYMSVlD2QpICjL9rtgGl2
	 XloCNnIM6cDGmGOO8MIVVnBXagBeE2dNfYP7vy4m6sDUJkfx2bc4NLvYQlaNWK9jgJ
	 1CrX+bav/VUJvktkvQC+lIUExz5xrmkCy5eM6k5MEN0DTvAYzTkwW0y4Q6BgMO603+
	 Bwqw/4a08xm6zPO0tbBgcFkrCuvPCJF8NJAiJ16spNW12eHz8XTdZIGrBMV/MJpxaM
	 QVBsplhCFPCCw==
Message-ID: <sashiko-outbox-194064@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 12/17] riscv: dts: zhihe: add A210 core support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-a210-scmi-v3-12-ee6b31580808@iscas.ac.cn>
References: <20261103-a210-scmi-v3-0-ee6b31580808@iscas.ac.cn>
 <20261103-a210-scmi-v3-12-ee6b31580808@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 20:07:25 +0000
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
> Describe the CPU clusters, interrupt controllers and pad controllers.
> Use SCMI clock and reset services through the E902 mailbox, with a
> second mailbox channel for firmware notifications.
>=20
> The SCMI clock and reset IDs are assigned by the E902 firmware, so they
> live in headers next to the DTS rather than in dt-bindings.
>=20
> Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-a210-scmi-=
v3-0-ee6b31580808@iscas.ac.cn?part=3D12

