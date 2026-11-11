Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404514;
	b=MOUQWHX0ciS/mk/HZIMnEI1gW288M9fQG74F2Rdv3yHhzzNn0InT4/66//6Ml2EaPDjx
	 HldZR9mZKHHQrfMitJDHU597DvwXr04bx+H1y30Pu/iKWyKMNeO0kH1cRyJbWvk7R2Qsn
	 KEG35QFKa821jnxqidDYTQL5iWqRxQ8r0TtMpJEQfhrk+TKLTThjqCpW1603rIJwvacd/
	 NxXMLvFq6w4ZUMGkduddARzR0OogQ3rVHAnqCOV2KVFmmW67pGi5IMXDTQjI3xPn5r7qD
	 3AsHeatNP36GdHIaFgUgxkTS6FpODkvWX0AqYx1sARM+rATISsh6N/KSJcF2gwUqxkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404514;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=peVhtf4XfYHkW4k+nb45IGPeZdoa9Je+MSIYyAMzxPg=;
	b=LOBCKUFgu+xwlvyfAnbUgdO/rcUholwpz/liBZVGT2l7we+fHtjVBzQ54u9ilEtzDKNv
	 C9EXeUy+6JOCOBZCcMwZ5TiwomssV7orO63Hzoh+Alku9qzc5FsbXyoLF0bn38KjSFfFV
	 Xv+5pvSYoUrCbGf4evtKFDEr6k0MTEVqyM1MxM6MWewC7dRlNgbEn323yqsvlyzmzcSXU
	 MKT6CD90WppBC79mQLdZJyYXTVl/kJmCHPD7uqkE7hQc/C8GBGNr7X/YgUEZB1hG17ZAp
	 pULYPmJ1qXsRX8sUgu/qjCCdZLlGw/JiSVlDq578C0ubyptkl1kDXR7qBx0oiu1kjsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F6gF+t9V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863D6606A31C
	for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 13:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F6gF+t9V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1821F00A05;
	Wed, 11 Nov 2026 13:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794404514;
	bh=peVhtf4XfYHkW4k+nb45IGPeZdoa9Je+MSIYyAMzxPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F6gF+t9VRy4LmGHHupXgbFbTqkSi/j9IWfBAH/jKRr26n07Vif2wB7dhDx7j2yr1M
	 v96FUdXmBiaKR2q/rxudkP1C9jTvmSjMY0Pzg5KtLNB44nrjkjaRi4j0upuoelnogv
	 Gju+Bapnmv8LemUW4PIiLGnqZGDo9Tt2xB39SMalSc6uZEB5zEoAyEH6E7AViZ7qyK
	 dNOLg/1n4pCexYedjJ7Z7z5Ye1vTiL/fZhL250MQSNyk0m8JXZ5nz+Jh/w4z6OdWMr
	 Q/QK4FH+RkPw+CI1FjK5jEIIpMpLVqJN53pMYj+66LHsDKaGW2CCdNCnvJZKB/nSsy
	 n6Xnodognmxwg==
Message-ID: <sashiko-outbox-209082@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] dt-bindings: serial: max310x: Add
 maxim,tristate-when-closed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261111-serial-transceiver-supply-v1-6-40bad0f912f2@vaisala.com>
References: <20261111-serial-transceiver-supply-v1-0-40bad0f912f2@vaisala.com>
 <20261111-serial-transceiver-supply-v1-6-40bad0f912f2@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 13:41:53 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The MAX310x UARTs can three-state TX and RTS per channel. Add a
> per-channel flag asking for that whenever the port is not open, for
> boards where the outputs must stay undriven then: a driven output
> would back-feed an unpowered part behind the pins, or fight another
> device driving the line.
>=20
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-serial-tra=
nsceiver-supply-v1-0-40bad0f912f2@vaisala.com?part=3D6

