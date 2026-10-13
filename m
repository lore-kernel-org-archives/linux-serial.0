Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8249344D8C
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 06:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872969; cv=none; b=ncjub+y8exfK6LvgQ7mLsELLWfPI+ab+G8sWuOUbgPqyoFPDa5Inn0rs5y5AXle5r57fdmWvjDaxYcbVwxF598+Rwf95hJPFiZuBKDknPI9aNEGScce5tUhwlbu7ZzbIo7KFhTykfsAZrXt/RsOQHsWTV3CtFTR+ZcHw7IvpP6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872969; c=relaxed/simple;
	bh=yJT5dP2rTzh1WgMXVuzUb9AopqfrJCoHKRySNuZc+Z0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=nHUjf+nYsZHBVPhnxLWbcJaI0eQ/TTSzrYxYvO8NDmS7MlaiE6PxiKP5LXJ20JdHo0yxGnJK/0SMtU+9suS+F2GYuyzWGs0bJ0WcAO8uP+5s1AyAi+vebw9R9EnnbDYw3OxFXFFKw/1M5P45Yc67SvgIkJK0s0CnhUbq6xEUjvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Br6obXVQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Br6obXVQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634601F000FF;
	Tue, 13 Oct 2026 06:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791872968;
	bh=yJT5dP2rTzh1WgMXVuzUb9AopqfrJCoHKRySNuZc+Z0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Br6obXVQmO+dCzkS5m3gOgpMYd3RI51y6BUiANK89m1ahcQJPYt9AM6NBHUY1c/Yq
	 oQtktvERLLUmuEj2JhF424B9a6LekHyHpfAOsISWdeLtXqAE9PeQh7kL3mGgjL4ksx
	 KWsq2nVmV8pG5lL2FgU4Lyxhu3HxIverA74XYwdwZZBM9GjQRDKrcjt50hhdRmXck6
	 ps50Wq5E/OfrdvNBnjP6TEEwtFGbVfdnRrPfj8oGC+Cg9uS//5z7JF05T/D10faySG
	 A/8WcFACz44znIa3Sclj9OglC7x3IrDmlmJevvNZH966hpw3ImbR4LUrQ+T8MvYcr1
	 fFbPpUhU9wqgg==
Message-ID: <sashiko-outbox-169093@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/10] ARM: debug: Add Cortina Systems CS75xx UART0
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261013-b4-cs75xx-v6-5-37e8f3969b7c@gmail.com>
References: <20261013-b4-cs75xx-v6-0-37e8f3969b7c@gmail.com>
 <20261013-b4-cs75xx-v6-5-37e8f3969b7c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 06:29:27 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Add low-level debug output through UART0 of the Cortina Systems CS75xx
> SoCs. The UART is mapped at a fixed virtual address by the generic
> debug_ll_io_init(), so no platform map_io is needed.
>=20
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-cs75xx-=
v6-0-37e8f3969b7c@gmail.com?part=3D5

