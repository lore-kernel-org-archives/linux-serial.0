Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792560490;
	b=xULRDTaxxIY4UwFRhvig3i+Z43020VIqQgMFwoUfovPeJo1OLr8wR5yeOAzMg/l8A9hs
	 9k9u3BQd2DTmFJ46wWqhLNPKg8yc30SJw38kFupT10XYF3ReovyuZqULNvljDMl8FTPQb
	 lp4heFb9k1gaZP3A/kGxZMst4K77ojLV5A2MPsfLISce6KwBV68dvqbabpCu2PQnhh0ML
	 edsEmRHshgUMhtdhcdOLraHPtc952mL3v4JdxVrk0zLksoyJeFTzGVlrTm4T5Y7ms6oax
	 rxV5TQKDrGsqEUmL+aFn080lOZOanV9w/+bgSt9xLnLzdXfN7Rz8t0h0gOYsOr0A9qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792560490;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SrC1k8V3ADDAbS/snMcTZFJpiYgM+OsY+COulVPb9/I=;
	b=A0fJNMySnihLL6/W1MR2p4Ltz1oUAB/zJmGIolIRU0fwlKsXdRvWY7MWwmGr7BxFsBLq
	 8rilMJb3H279V+Xl9MDbOJv4gtpopXpqxahOE8LbyQkrwtfUIJ1H3TfoPmDoF6AnrhKMO
	 KV2R4P3FZ+rwJnQJ6r74HYM+dGHzQlw7lh/sqs0KFjjcunjC0tS1r47TlgDKVqWX2Zx3I
	 +iB/RfG6sH0hTDbc2NBQ90tVbgeEJZfojoppGVvrzyrLt9OjN+xtMmMvMl1Se/yXYJWjz
	 GfXczgbfAcZzGjnQIPx8sbLdOw/XzFXLdsVVeot1HQX1/VJGKXAGIfXOi88gPxkmvxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AP/iRHmw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95F9606A31A
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 05:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AP/iRHmw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B3A1F000C9;
	Wed, 21 Oct 2026 05:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792560489;
	bh=SrC1k8V3ADDAbS/snMcTZFJpiYgM+OsY+COulVPb9/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AP/iRHmwNFXBnrY5OkL36w+8P2H3Jw5CquLViUYZsqJAHt4EoyPxs1ggZsxaFrNZC
	 QJgJVPkKhzd0gO+QF+BxC3JTN5aeCCFcSoOi3Z4ZmTfBmImBAwiUameo5HrjscqX/Q
	 Td/CBNzC8yqtHObZAFcrAc7lZLHFuRyVa9a3qrPxRCNvDFO6EwbgUqvnUp4s4pim8S
	 svb8sZs9pa5ieYDjvJU9FLwqzD5DwUkjil4PhyQ3CAXgF1xDnK1v4eOXIop9aMk088
	 WlHnZ7VY7YI8PxKWw6bgzJXLSQtT3hKy6YpFBSfiV5HvodHvH/RayQPLsWPgPeIgvE
	 d3Ec1mVRofQgg==
Message-ID: <sashiko-outbox-179800@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: serial: rs485: Add transceiver
 interface select GPIO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261021-serial-rs485-mode-gpio-v1-1-80d7b0903d93@vaisala.com>
References: <20261021-serial-rs485-mode-gpio-v1-0-80d7b0903d93@vaisala.com>
 <20261021-serial-rs485-mode-gpio-v1-1-80d7b0903d93@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 05:28:08 +0000
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
> Assisted-by: LLM
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-serial-rs4=
85-mode-gpio-v1-0-80d7b0903d93@vaisala.com?part=3D1

