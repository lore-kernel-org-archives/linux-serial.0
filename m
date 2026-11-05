Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889066;
	b=HufwR5n4xi1z7mf6gdpmZQFeSfbIA5jcG6wiZTT8qpl6ETB1utZEV6RjFq0ODacl8Tv0
	 rKNMsjO4G1z2mhiOJ2pKV37MAZVWLmu5DFmEYDcCrzOj0pr+o5xGQe4j2Jut2KPGj43o2
	 6j/j54dsXqAqKucJoJ7JPZg3jt02rbNZtqtuZ48o0IHT6Pzl0JAYupO03uuyhRumViXGU
	 EiOhf0JuJIDv0Rf8gcOWEp7KJ7HkOCBIW1GO3rYws40dtn1ep9MOSYx8hqlPrAEfXZx8Y
	 KO8szydsqM04CBAfvsWnVtn9GNN0PqKnRanGXHGtoC5XIwmkiXoC/CigOQ7sN8cXhdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889066;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=g9B8hwKi4rryCZzUZrkBDQZYP2IUh23WE+VUumccbGE=;
	b=fEVgEkHqNwoY/qUcGAGkIMJi5Weho1Xkn6ngJDWQnRCFvFDlMQvgK7s2oJxdWmrf4lAa
	 8OJEWEQPWMwrqCt9bEKOki54RoJkrcQcA/zkNCKUwKSaP8kNGnC6LYhMDx5x7Pjy2fVab
	 jCfiWZh204q4rZba8Y3RD3gqfjkUzXbYKFc9GzY8dpdq+YSoSpLQMinpkP5GdtcCokGkN
	 WeGs7hcuhsfORx6QFCLwyA0aDMstNwix693sbaQTQlC3P8SX8AMkcO72VmSJnF9sD5EGD
	 0CkmM6ezy2Pi260ElcsGTzw7NkmbO0H6AS+SidVZ1EbIC79XGGV+Kh5JVXE382qgcmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j3DqrcbU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59625606A31B
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j3DqrcbU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED531F000C1;
	Thu,  5 Nov 2026 14:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793889066;
	bh=g9B8hwKi4rryCZzUZrkBDQZYP2IUh23WE+VUumccbGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j3DqrcbUxzHga6FD++hfmJnJ1rqhEThXL4iheivMPYTsw2YBbo6yoi/q1AkZtzCJH
	 Qov3l5/J+rtxaGvlpGIrQb4Pif7wQPt3vxWaRro8PkkltVUYsktebAQyF2zMATh21l
	 SBKnPtWI62U8JfKbxAli4qQ4Kok/IslIVnIyOeJ0N9gZwEbvNObQSbq1BijE1AdiJ/
	 jO86p6U8vH8PVTkLv/6d3e9gfFZxP+B9EaHdhVDY2tWsWrxi9LIln6LtFs6VISkXzp
	 bdNewfExyX7Hwb9Bcc9tfMgSGCxU+ZFXygR6rIGSETO9vUTdSKTSK0nE+dTIdJSDcb
	 /txSPASsHphPg==
Message-ID: <sashiko-outbox-199245@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: arm: mediatek: Add MT8163 Amazon
 Echo Dot (2016)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Grisdale" <bengris32@protonmail.ch>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-1-e68d7d428f99@protonmail.ch>
References: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-0-e68d7d428f99@protonmail.ch>
 <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-1-e68d7d428f99@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 14:31:05 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Ben Grisdale <bengris32@protonmail.ch>
>=20
> Add compatible strings for the MediaTek MT8163 SoC and the Amazon Echo
> Dot (2nd generation, 2016), codenamed "biscuit".
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-arm64-init=
ial-support-for-mediatek-mt8163-soc-v2-0-e68d7d428f99@protonmail.ch?part=3D1

