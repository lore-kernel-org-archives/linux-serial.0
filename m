Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793651167;
	b=GGzPur81XOJk9pVP42ZUN2+Elmy3wefW5CLOKZTGqR+ujZ9WXsvt1rTGMQ6ZVCVYWf26
	 r8dIrL0u6wqCVqCTIN41hOnUTgEY92ymPoi6M5WNfvDu//WR4/G2ze+5GvBbLeBxG0XwJ
	 7AC2zDYTER4hG5xcO3BUQEJkHNkE+ZUIWyFEgktfeJqjtotDHrsabgi4MQbE5v3aYMLgY
	 qhOXmqBxaDnnc/hz1IBAfx+CDOdJpj4GN6PYbgeSrtSvKAkKySKyhA+y8R5hCMmTFgZ0d
	 DXRfBtTid/q33jgOppVv2Hh+PGVHkD/qY8DHVoIY5qZbk66fiV1tZrw8hZuIrVC27ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793651167;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vPa6YmL08ngz8/VawgUuiO5lKf6vR8RZLeYJcWwhhOk=;
	b=eJoU62CTdxghTzaPUIvlPeTwMhwCUhaoe3laSjq8DYbJpkgQri/wGL7mV0nIrUwaN1d1
	 1u7HeDzVRN97S0AqsKnZvjsYly/HYtE6aLQq+YMXqoO14lZUn0OIoYa/5Y0GGBYC4FJjO
	 s1uoFY4l2PkuQtgLoOA/+2HRysTsOHcbGsEUaibrqr1LD3y9RUR8NZeEfO79snP2PWAtY
	 uTWyVHiTJqTtXfaUIguAFkVmVtSdhWFVNfV8QVk1nJp/phYHA+N2MnLTK5UJt6WLaZz9c
	 xCkpc8LoIRR8CD7NWivRpCXaHMsatxGQ2h5hSKRDC4l1y7qOzifVDO3a59YnmHrZBSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ButK9SXG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E173606A324
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ButK9SXG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9FE1F00A16;
	Mon,  2 Nov 2026 20:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793651167;
	bh=vPa6YmL08ngz8/VawgUuiO5lKf6vR8RZLeYJcWwhhOk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ButK9SXGEkBtcj2DjcCR+BLKS3a4FVjkt/dy1JPKZCl/NianR7DKAJdBNqvjiNIn1
	 1oQCVmUERC9ctnHybBR4jripeEyZm+lRd3Jx2LwT0HltVYxEho93Jvxg8BRb9oKOQP
	 BtXWnhyknqpCrQ29ftZ8OiYq0tVrUCt3fajfKtm4yRuMv24Lieb2QNYrCDQ5j0Qhnf
	 RHH7xZmN7EWmetIqANoXy4s6IOkrY8fWrAW5KkMJsbQWdtZ6isJF6bAkYFtUcFsxUr
	 Va9Hp8Qhqgybl/pExTNsp1Xpms7DE7oczz3EVK//8/y4aFXiyJ2Urse+p5Qm5wC67n
	 wsiN6fH5S0aYw==
Message-ID: <sashiko-outbox-194113@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/8] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner A523
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102-submit-h616-uart-fifo-v1-v6-6-25afcb346b0c@gmail.com>
References: <20261102-submit-h616-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com>
 <20261102-submit-h616-uart-fifo-v1-v6-6-25afcb346b0c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 20:26:06 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The A523 UART integration has different FIFO depths across its controllers
> and reports each controller's depth in the FIFO Clock Control register.
> Its receive thresholds are fractions of that depth, and its optional
> register layout differs from the generic DesignWare integration.
>=20
> Add a compatible for this integration, also used by A527 and T527, with
> snps,dw-apb-uart as a fallback.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-h61=
6-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com?part=3D6

