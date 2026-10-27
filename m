Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793115608;
	b=Zs7nLWXRkjIa3pJ2JhXv6oaa9dVJ1um7TeKGsEhFRBQVx86ERrTbjzymKsfYal/0USDi
	 3WBF5Gm/z2Gl0O37IDax308grytBhjudQKZ7v0HriHlNco7ZKpyqdMXeIwzoGBf6ujyYr
	 qL+U+4JzkQiklpCnX3GFEE/iR76P8boOtaFsu0Y2uySeSxckNc8nyn0ZCZJR2Ij7PvLmP
	 Fbfk3FwKOzE8ksfbwETwhPFAvT9FGjCrBcPFL0PNF2jpaFO8UOo3i0liPPO9xxCcros9z
	 Qr4gqS6j8cKDZ9O9SkPb3pXHv+DnZhJ+MZoN7M4hMZu4e3OyETjgKAx+MjdlqjHv55A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115608;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n8r1mEA5gJEteqL6HDq0eLAJcnt15V/kOVzbzwh7wpM=;
	b=3UsxkMn4UG0zx8KqzUFFrTZHySv4Wiv6Qzkwt8bum4U5u7yXqxcCFGyc71Vp4bGzpGfC
	 0UElEKKbxSFNOUFEx5dih60vhPzRXaJ8btIeav7D9C9+NKS4+Q0qm1J/ppk/Egez04RnA
	 E4UKFQ7OWoRZ03FV1nXzYeOoNT7gHbtRkZLkOQY6EVcZTYWyZicoa3rhKDLGYB3jk6y1n
	 9mUOaJ3OtdYrrYouosp8TLy8/SNNB/VglscmkK7RWOUsmARRBml7pokaxYzWI+KoUW71I
	 PMRRggICNwP677EkIRZvwR47WWl9r9FW594xfuVilW9mPtuQJzsI9ktaFnsRSmWtA6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJ6a3vaS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44423606A321
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJ6a3vaS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BB61F01825;
	Tue, 27 Oct 2026 15:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115608;
	bh=n8r1mEA5gJEteqL6HDq0eLAJcnt15V/kOVzbzwh7wpM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QJ6a3vaSuStniYbV5ag8AvKl8oCjTKNWo2hB1nMyO9NIh/P5Mqu4PrvxJoqyiGgqC
	 zyr7VDdoREEo8W+5K0apFGMJYRgt8ayezu4jG4tdW4DpUjwdJ0KLPXBHROBqgZ4wHe
	 xlxbbRRzic+L/hzwcMkLKa59O3q+dS/a6nCkHa7DoTP8HaIE/iUDqfDdITcCpiQhIC
	 lj27UJNqUa2M86zFSFmN6QFk69xLmEUDgeMXMtcQvCPLut69HGfSpL1VA0MZcO3doN
	 Ap81bgAJJRq35kSOjnwQesZrxKXf6IG4x0s9rgCJjqhFKEMehEgN4PRmfFRZI1pSIM
	 YzJwi/RFu3ToA==
Message-ID: <sashiko-outbox-186853@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 03/18] riscv: add Zhihe A210 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-a210-scmi-v1-3-74d58ce85bd8@iscas.ac.cn>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-3-74d58ce85bd8@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 15:40:07 +0000
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
> Add the ARCH_ZHIHE option for the Zhihe A210 SoC.
>=20
> Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
> Co-developed-by: Han Gao <gaohan@iscas.ac.cn>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-a210-scmi-=
v1-0-74d58ce85bd8@iscas.ac.cn?part=3D3

