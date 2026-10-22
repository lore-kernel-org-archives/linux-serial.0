Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685599;
	b=05xkT4bMFHYc4ZTEiuZUARRJqIojRK6ildszPEalHBTWUUT/gvyeGa+MZhO6sd1J1Dgb
	 32GX2odZ7My+V+fZ+L8kB2KP+c5/JGkXKgY4iQPJkh70h8v3kl5sWPiJAzN7QwDDH+MQH
	 +q01F2dQ6tmWE1lI6AAAxWCT18U2FBuWqm1319MCByp/2zBEmibHplLXmSHFqVXe0Hqhz
	 hy6QUmryeU5AbSjCKHJs3Xymyni3AmxfxorWiEpaUrz8ZT+RwWruMKf/JDNZDkWyH+1pZ
	 LAGffQACozYAvX6SkZIbUp6DpwuN4KD3ZPTbsLCk693q1u53OFNn7YOdiOkqbeI29vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685599;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4qLXXO/8KqSaI45aIOzt5pAHoRDnfEDFghfcKxoYn1c=;
	b=UrnqYmce/gqLTIx4sOhRWKq0llOoGywlKuYt2fsuXPqz45uwh/+Wt5HxTKawQ4rGEPOv
	 BtP4mzSElNxx+QfZoZ9CyVcWKKEA2qFkCAm7xPs8QdZaUB9PzaOYfBkiAqqUbLhDUz+UR
	 fkrQbs7oLRnCdrxBfskar2X5Q2lbHDfetSP+oNaya0y+qVJXtfl0tjjykcoW6RrBBko0x
	 p8n31GftEjzjbZ+N/HsYWcpkvd6orj23NdmqEXilXtSpYeOIDWww0s/vUFCgQHXvpeR+9
	 79hFQDMv0fMvi7Ir1jm6SMA95eqR1b6TeJVDos2bBd845xKXC0tB29eSin8OukwAbmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQkE3W0O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEA3606A339;
	Thu, 22 Oct 2026 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQkE3W0O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0E81F01825;
	Thu, 22 Oct 2026 16:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685598;
	bh=4qLXXO/8KqSaI45aIOzt5pAHoRDnfEDFghfcKxoYn1c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TQkE3W0OTuoMsLJi/Jme/b/+Z5MQ5L7GeoEPA014WWiuc65pg88x024Kxvx6nj68w
	 wpcokyeAcB2k1k7pY8x548ntfqEkPsJoMP93LlBDCcJf/HeOZAr03vmqsA12Dw2Y85
	 h6ycsaZFny2MptKs1tYJS5xYSBb5uvrgTV2aWpQEvNo6dZz1+tqqtdoKAhZx7hxvvU
	 CJlzQGRRzgoHSymSHh+LBTYJfGI7FEQtrH2aPF5+f8cnPuvo3REBy4kxde2I3NOrNA
	 cNMdu57tv5xDP4ZOPERwCDK8BlKl6t40OIbdr89lOxkSvbaTh7Ghy2ZWs4V3fCWpna
	 oF2Woe0oirN/A==
Message-ID: <sashiko-outbox-181783@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 19/27] dt-bindings: phy: rockchip-naneng-combphy: Add
 RK3572
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: mfd@lists.linux.dev, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-19-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-19-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:13:17 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Cunhao Lu <1579567540@qq.com>
>=20
> The RK3572 combo PHY uses two input clocks and one reset.
>=20
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D19

