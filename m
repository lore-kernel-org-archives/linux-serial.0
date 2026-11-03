Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742297;
	b=21SFAGpCSsu08Q4ntytivKGBlQXfyj2MBpONxHlKRdyTlT+EoK+VnbDwzAMELI3lbIj4
	 2rx2cJPc0P5U2NtivRkAIrslulaGLDMsuXcs6aCs16AtQ6lKmLal7Sozk3iNijydNyNJm
	 WJCWfJfi4fipCy5zwcYpr/bfzG8AR7afQDo0UK8IiaXRsYYBNKOPygTfJ+lhrY2ss9FmZ
	 V3UfeVOr++rg5uNWPm9T1BchrIoS8kWLtDBecbTwKa+jd3MoObpdR3Ib8MT9cYUUOp65n
	 frqjp8Sa9dVa/7keLdSfi60vhrTfnnIKu99RRVxvqINjWTVP9VYiid9UZxSD15Ms1sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742297;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=99aBa0yyhT0H7dza9yBFQbvOXQpgCQ2OdA2EpZbO1bg=;
	b=k0YpW21Av/x+yS41+6I/Oz3PIvr9CZPh3Nj9av2nVeNIMXFuCyqHrMaEeUASKeNAC/UF
	 G64iYcYbLfOYQw0ppmKbDuGIW5UWU7nFsLy5wrn9aMbDvVvM4D985fEz7NxRmRy4yhQlY
	 o4LttQE0DhMe73ggi/XKWu1iE4RMo3uZo7pkDsfEoQ9ucopZW1eOCjRE1y2EMB3dnF64t
	 hezpjqYL2c3cTwKnjCHaDG9+LB0ueaQEQ1ux+J+LAFFggt1YL79imPWZ6GN6NQAfPxFN1
	 9wGN3BcnYOAW2Ikbk37ATeIbxv/NWcliPnZDv2JiSFItL9FqCBmqb/2xTbduzPfue/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KjaBkxLp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597DC606A324
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 21:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KjaBkxLp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186671F000C1;
	Tue,  3 Nov 2026 21:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793742297;
	bh=99aBa0yyhT0H7dza9yBFQbvOXQpgCQ2OdA2EpZbO1bg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KjaBkxLpIkw3ypIJ2YxtlM4EPvXFV6IA1qailoBSlCTw7wZFhehH/mZS6oSL9Cxzg
	 Nqsb7hPSBXVONpkmSOhg9R9WChxZ3m1/apKju9nZg7pdMC5uCEYVQjHpXKdEgMgUQD
	 pmynb5eTrFXQ5eNR2EmQ/FvGay8hHrT6fhqMum+U2EMrv7mlqADVgV5JwMkVfBK6b1
	 Yu7fqphVhMUoWn9imp+bDiiB/yFxcuRc/4C2diPWRQ5LEkeMDBVcajwnmAxZAFxSql
	 AUeIivaSBjVZlQY9ZONW7sz3iHxv6OFG6293sNurjvBgkouOJmfI73Om6DyD1KN0Xk
	 4IcnKtri+Agsw==
Message-ID: <sashiko-outbox-196071@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/12] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner A523
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-submit-h616-uart-fifo-v1-v7-9-c9e248d685c1@gmail.com>
References: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
 <20261103-submit-h616-uart-fifo-v1-v7-9-c9e248d685c1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 21:44:56 +0000
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
> The receive thresholds follow the standard DesignWare FIFO-relative
> mapping, while the optional-register layout differs from the generic
> DesignWare integration.
>=20
> Add a compatible for this integration, also used by A527 and T527, with
> snps,dw-apb-uart as a fallback.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-submit-h61=
6-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com?part=3D9

