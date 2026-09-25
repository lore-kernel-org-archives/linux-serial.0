Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2B03FFAA4
	for <linux-serial@vger.kernel.org>; Fri, 25 Sep 2026 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790360524; cv=none; b=EvRRJPtwVqezilBxZj5S+GCyDsBZfoox1TNiVoo8FXZzVmnKLY2FHonFLlMjV5c2GqGMw0AhwlNRYaF7NY0QmgBdGVWHosgBezHCjoueX/Yo6ihs22scmQXfjUg7/dAKNeAWai+/rofWinvCB5AV4Zov388GjsqhPdjcBhnqTw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790360524; c=relaxed/simple;
	bh=sVGOahfP700CDyCeKr0HLQXOUPBMk8+J7B9Rah3OXQc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oq7ge1V5sUXDa5iUmffhMNAT1Bf/Oimhn9TX8czLOuKNJsFBuYSz9NKobs3jchIsrBCZzi/eo86VMACwziWYA/Qyy6qYveX6tHCbVNmO4IVmKztXVnW0M4kVrkUpFn5skh9ySLDfXhb27iSriuNBFx2cMfikJmPyG7eG8t1m94A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1Q8+p/r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1Q8+p/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B2B1F000FF;
	Fri, 25 Sep 2026 18:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790360521;
	bh=sVGOahfP700CDyCeKr0HLQXOUPBMk8+J7B9Rah3OXQc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G1Q8+p/reUC+IsAVerZ5oWWaPsw1g/FAwMqz/dHyzN+qWsAasPCcw8I1re5CCSytl
	 sP7VUxdgcQB8IfSh6Md79WwcYFbOqKDAOOjB1ySvZlNTjmghKIsK/c6SNvqw02UUs5
	 /EyddX+RwNPTvhF4w6S160izZ3uPuA7gsjzkSyu1KbKgsVMOtMmfmCqcbdzYA66os8
	 a96eBCDfG3mbbKxX2T1K+/IKmTxXIdLldULFqXB7qII3iPJNo7BiwPbxaYWGimJGdi
	 tuIRH9Dxb0kuv/yic/flEkNXwFJCARGU6EFivTDjmb0qJZ9bIzlRkaOBpsUzFazYpC
	 EuKM177skuASg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: cpm_uart: use irq variable for
 platform_get_irq()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260925181530.52953-1-rosenp@gmail.com>
References: <20260925181530.52953-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 18:22:01 +0000
Message-Id: <20260925182201.B3B2B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> struct uart_port has its irq member as an unsigned int, which does not
> work when platform_get_irq() returns an error.
>=20
> Use a local irq variable to handle this and write to struct uart_port's
> irq member when platform_get_irq() succeeds. On success, it returns an
> IRQ >=3D 0, which is representable by unsigned int.
>=20
> Fixes: 831603b3e8aa ("serial: cpm_uart: replace irq_of_parse_and_map with=
 platform_get_irq")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202609251916.1XlVHLwd-lkp@i=
ntel.com/
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925181530.5295=
3-1-rosenp@gmail.com?part=3D1

