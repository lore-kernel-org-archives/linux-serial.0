Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648336;
	b=irTLJcDmK+L8rmXNdoK+JIz/paSN5zrB6y8YzY8IBdGZqfZSDxXHfHm3/3bH2Ibj/Tlm
	 bj2trQf//zLUxtkMPP/9VSnQJwr90BxfCQmqDtDTvQD6kuu01K1/4Sxl+VM+oxrGO7/09
	 8K34r3SOYrVboMxkwjfWJ1MU7zjZC7neUwsTnHr6riNhSy6Nc1lO2Ki2SLegymUo3A1bR
	 onlrIDfkGw3EXmzs7ndyPdR7QDDcw6a6SLKcuKOKY+scRck0xW16uZbkz6PwpU6oy1lib
	 5G18UtcPhxqOr7rmbU64Ce3+314ISXSWdhYAHxDhJkR9fQCb9P3bVBzAH1PIKeViCww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648336;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d98gETK2kJjJSNJIUAYjVAHdjccsGYaGtyNfxh5g0Sg=;
	b=xhnDxdSWEa2yAuuIn7z7LtTuWBW7qDJlgJwgAQxahH0vzH8YfXwE0T3iuNsSo2DRzdWv
	 izdZ4v7HTksyNqsDFdJfU2QhEnN4TByl/eQs20nrApLlDeAMkiEq3PGoL+cPsypZ8OlIG
	 kwMZsF95q3tDCj2ERKzUI5ei9VzeiCwV3rd/CryBs1Q0Be77bBEODi5yM7/kJX5y7qxfn
	 kKwUXbfguntQYOO9G98f1r/tbNwQjSYT9hh0RAB4e1Z/nBFAgY9rDiZES6aByH8JiZQH6
	 pZEEi4OLw1B45IuVEniekwsTatZvHtOZD77TCliJAvqmpRZwz/GvupsFM7LW9uAfNEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMbjRec9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262FA606A329
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMbjRec9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8941F00A17;
	Mon,  2 Nov 2026 19:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793648335;
	bh=d98gETK2kJjJSNJIUAYjVAHdjccsGYaGtyNfxh5g0Sg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OMbjRec9r4KitVBRcaiONFYY5Ulb0K5PJrkiZpUxk37+uEY1sdI6UKSG46AJcy/IR
	 mc277vwFrMlrWsf6S9AER4crCdWSAYRFp1jz3nT8599jhVYMqGYztmiJJflQKj2XW2
	 7OfO9SOFH2XZzEN5c6oTECIB+OKiHopJxKILmHsaZ1efrbZvGBgTPNysOD9RtKv2dw
	 vn3fnvGqaXS+ft7PQBK3dc9OWZBJuKjQ3+rZqFNwG3iW0si52IPxkCoxWZORnN68kW
	 9WNsAOIY/DDc/Xzab6q5HcBEUGO446l4SQt9ziKFmsLIoTwKN0XCEzqfCfJ+7iGeSC
	 p+PUtU6y0mylg==
Message-ID: <sashiko-outbox-194013@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/10] dmaengine: dw: extract hardware-LLP residue
 calculation
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102-submit-dw-dma-synchronize-v1-v5-4-d3207758fbf9@gmail.com>
References: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
 <20261102-submit-dw-dma-synchronize-v1-v5-4-d3207758fbf9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 19:38:55 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Serge Semin <fancer.lancer@gmail.com>
>=20
> Move the hardware-LLP residue calculation into
> dwc_get_hard_llp_desc_residue() so it can be reused independently of
> completion handling.
>=20
> Keep the scanner's LLP snapshot, descriptor updates and early returns
> unchanged. The helper reports whether it found the current descriptor,
> including when that descriptor has zero residue, rather than using the
> residue value as a completion indication.
>=20
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: extract the calculation without changing scanner behavior]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-dw-=
dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com?part=3D4

