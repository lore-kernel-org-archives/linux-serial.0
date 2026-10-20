Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522279;
	b=FYky9zd35WqaRnktUJpfFdm6l8I0iXuO9ctRcqPh/d647FYLUTUp5ChyrNCJqBZuB4QL
	 /N0F6cVtegsio0xgH+MQk+5Y2/xZixBe62aEQJiTTXmqHLdXyiuc5oESsRZCwzP7R0vSa
	 dFIncFZuKyT42VYdXFIRptILyMdc87LaPmaCvCTkEjO6Y4yHuMKeHHcEcFjPx3PoQhI1Q
	 s5KPXlF9/xRGJZIyojmy655G7L3wp23Gr00RL79Iu/BjcuSknE3Tp621MpXBajEjxfwpY
	 OKJfzu9PXFaMRkQ2nmzjcxpGVaBhQgcP65d+K6yiFjHKokSw0cB60qUB8t7/oj3KpdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522279;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zzvEzY2mXOGL2cSZAHKs9wxyfDXmtfpvyOhSYTe9x1A=;
	b=W17XT6ENMdAV/HmyGyULSx9LcJjt55R52tY/8P49jorj03Czik4ShvUbytD21qkcc9k0
	 IpIS/8+JlO0IkhFH0x8guCV+ukHVLNvN2rIAu+jFfbmqiLJsbG+LH2ov6I6qG9tuIIfzd
	 xIm0pzIZKn+cqxXzc6uF3mFdX1PsswffZi+Ldep2P3lExzZIbARzRdb2AtA9BxoB47vJp
	 P93auLUPwYB6KE/bISO5wwX53FMGt7emsBgRKqyDHj6TlDIveLQ67xBUAha79u6GgJTjg
	 NvwsmE7TKFpzMTtyvvwjn7w1LWYKyHNbezPWfhkYvVlBBv9C2cdnUtVm63J9KbyHBpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZMSoQsh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60F3606A319
	for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZMSoQsh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC7B1F000C9;
	Tue, 20 Oct 2026 18:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792522279;
	bh=zzvEzY2mXOGL2cSZAHKs9wxyfDXmtfpvyOhSYTe9x1A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RZMSoQsh00J1aOkr4VuM1+T+FDuz9qqTHeCRvVZfW/11ya5zegiCwNyP5Dj3Wehey
	 rx/UfzS00dDnufmHlAWM9/epSq3NAVz2QMqxkHvVSdWlEOIbgz+QjzJk/qlm8H64OB
	 bd4N5AeRpMXFrFDZLnrLuOZR/jKKaxgMmI0HeJ2mvfvwCI3fXrZG3gXep9u7BvtCYN
	 JJQa+ygGROwR3KN4viLDN/l+bF9FFXCOsx5fafgsJeQHtQwDKE1bWHDjAjT+9FuFG4
	 L3+69HZl2jZtQlIlT2tijhMo4wJNhh+yvCckWHnBOlVMVHoDqLdE5lRbjdLlF1BPVY
	 4tC+6HweHk82A==
Message-ID: <sashiko-outbox-179495@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] serial: core: refactor uart_get_baud_rate() for
 readability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hugo Villeneuve" <hugo@hugovil.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261020184131.2893575-6-hugo@hugovil.com>
References: <20261020184131.2893575-1-hugo@hugovil.com>
 <20261020184131.2893575-6-hugo@hugovil.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 18:51:18 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>=20
> The current loop makes it hard to properly understand the code flow,
> so replace it with more linear code using a validation function to
> improve readability.
>=20
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020184131.2893=
575-1-hugo@hugovil.com?part=3D5

