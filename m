Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793863091;
	b=KmoLdarT/QFSqviw82IWPxfyxo4831rhMnFZRhJJliv/oir0v7SA9YqdbtazDo2i0MqY
	 UnfEfHqtt9C13NjMjgfHxIzPfEJzhHNG8wJ2Wyf8D61kEJ2A7dnEdQkpiHRrxA6eT9Lcb
	 fhjqSSi15K3WD71SulWMBkGzQHXsUhTdZC9ZVxTDhV3Vo8MNpODk0MeQd6RF/S9VS9NwT
	 OGkrma8SgdsQb2QNNFF6bbwEcQ8cCksoEj9BJkkmyVI1YODoNm2wDiwIaCrJVdMs5BDGB
	 8/x13JVg7O2tRi2EmuwI4d01iacbcWG+OA1dRXWIDhquszuF/4mYumu3q/Rq3xVJ50Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793863091;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n05j93FJW3Q7op50uz3o+8e31j2vL7lTerCZsbVOaUs=;
	b=cvzuYsfStlQsbfMVdMZWcH/+ZEmwKpwnhP9D9VsIK70CJf+pexshmjwsfbq+38v6Qnt1
	 w614Cpml3aKDK/QBLwnx/yd5FqM4mCXrhdDmaHcEsYUbUiiAe/ObVfrbL1r8xCZpcZOuP
	 B57hLN4R26bz1rgF29e9Rjxit89XcfwvrP9nXGNuqRJdbkP3vs2Yby0AXOSesDbNcvFzC
	 txySsEFQARoQ9O+OTh6ybyWTe7Xabx8TE/FjqAYq9LdDXdsG6xnbTAoIm3WcippCYMCZv
	 tk2/Dou6JRsTgSGjXjdUskBJE7ChCTKTREej2CR9wF7/p+gACSpvr2oFAUW7gj+ze+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vp3saqUw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B824606A31B
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 07:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vp3saqUw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9416D1F000C1;
	Thu,  5 Nov 2026 07:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793863090;
	bh=n05j93FJW3Q7op50uz3o+8e31j2vL7lTerCZsbVOaUs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vp3saqUwhpnOsyCk4V/6MnLw9pGcKuo/DlvGzMzUdKbaHR+g7xgRAP92ZVwjHQUXO
	 emkv3H45Wax8jYdUsByXXIB3CaWO/SgJwIC63d2tw6aB3GqT/pRF1HVBz3ZKlP2kc+
	 ztn535e/KRBNdsC9cYiY6BmDxc5Y/HK6Sqww95hchhrRTbKclXuFAIGfcUXGhAW1bl
	 bJVo9QG4Ui4YO50BTpZQl5rQxtZomdhLbFftTIUFEABP+Oywegg4t0IvfZpfz23UwK
	 ncGzhxTHHcbpBSMlDzvTwpyxg0WXI5ptGRryxFBCm8eltrUtqWGI4gWAlcs0wA3efG
	 U83xol7iKSVsA==
Message-ID: <sashiko-outbox-198657@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: serial: rs485: Add transceiver
 interface select GPIO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261105-serial-rs485-mode-gpio-v2-2-027e5348892f@vaisala.com>
References: <20261105-serial-rs485-mode-gpio-v2-0-027e5348892f@vaisala.com>
 <20261105-serial-rs485-mode-gpio-v2-2-027e5348892f@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:18:10 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Multiprotocol transceivers such as the LTC2873 provide both an RS232
> and an RS485 interface on the same bus pins and choose between them
> with an interface select input: on the LTC2873 a logic low on the
> 485/232 pin enables RS232 mode and a high enables RS485 mode.
>=20
> Add an optional rs485-select-gpios property for that input, next to
> the existing rs485-term-gpios and rs485-rx-during-tx-gpios. The active
> state selects the RS485 interface, the inactive state selects the
> transceiver's alternative interface, RS232 on the LTC2873.
>=20
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-serial-rs4=
85-mode-gpio-v2-0-027e5348892f@vaisala.com?part=3D2

