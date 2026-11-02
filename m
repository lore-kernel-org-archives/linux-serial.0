Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648335;
	b=gWKEYUSLoeJlzV6VwtcGRw0dyauF6d4wb0trg4G4szZbutycYhE3RIKhWJpvF+UvcbOj
	 U3qGPkeGe7g6yhgKZoSr6gnlDbpvIiBdCLO3/X7n6M4kKgWTvUEKQCCYE73N4UF+XiMGt
	 4rp3qJQ4hra3KmscY3/ojXgv6aHeRaftcffCpF63F5BlUHLP8HYGEQ8SQq07T0Nyt/bWk
	 dThE3yj4PVJaP3QKyVb/z2UaFlZXvm2gP3TAvavpCgSX+lM/r/3WW4UbZxbOHV7czVcGx
	 Vl8s/rYRknomZnt+gNeO+F7+QiQF73EwB1VLiuik5t2dpugdGbHyJpd/bJiPYmY/wsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648335;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=O/OqNbLX9+jw9T3WqKEU4QIQdcFJec6hPH8Oue23n80=;
	b=cQlGtKAop6Cna77Ts9yW5WTS6qEPaUPTN8yzXEMtPRwOf1y8cRxJjvF3snP1qF6Fho+F
	 2wo+izvlmUJTZPlEdW4fzUeH+H862HSWdgEDMMGYBNxLM/ShyVJKSS5LSVC8WNq8c9k88
	 tuGnGKaL4vfXAOCAncaILhfIHL+vrcu5hL12o847h8vvQ8F2lTCFWZsfwIlEvLunLUsEG
	 HqZsie0A4oMJUdY/CeVnEQU5dVtAwH03R1CcYJ5fbhSxMRsVJYFh0NEuuIndZJNFuYm90
	 iGhCsARQNS78zObNvKXiujWRhKpbRP5dze5EShbNApMnuxn9scIl+I8bT3UYjfzivVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azKrTitf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E01606A326
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azKrTitf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EF61F00A16;
	Mon,  2 Nov 2026 19:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793648335;
	bh=O/OqNbLX9+jw9T3WqKEU4QIQdcFJec6hPH8Oue23n80=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=azKrTitfpuy7gIel4cxxAc+XxH0WY4/bAzvpGoPnBEluikObDYd47QJC3h+Qn+Mim
	 //WrObZRtRK9LwJQnTrVpbXTGZ1Q8NvVZVknWqQacntKrm2KrSs/pSrmxnRdqcFLc3
	 5gbMkoBldsBE09cS/wOLJ+3Xvh4fz+gtVLCeV0u0IvbOW40FB3wmMorEsAdebyq2nC
	 APw3soXX8bIZr1KpTj9uvNXbEtWKklgH4S0lCBBvlmW5g6N86SQxqOd693c05WKnyo
	 aXyNlTQHQjtNFUmqAAtauzQ7TPRTnZPn1EbzEFYGNunEpqGFjIrlaMozpEYu5e7F9k
	 8amI3ZcQ4XvCA==
Message-ID: <sashiko-outbox-194012@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/10] dmaengine: dw: complete cookies before
 releasing the channel lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102-submit-dw-dma-synchronize-v1-v5-3-d3207758fbf9@gmail.com>
References: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
 <20261102-submit-dw-dma-synchronize-v1-v5-3-d3207758fbf9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 19:38:54 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Completion detaches a descriptor from the active list under the channel
> lock, but updates its cookie later when freeing it. Termination can take
> the lock in between and complete newer descriptors. Completing the older
> cookie afterwards moves completed_cookie backwards and makes an already
> terminated transfer appear outstanding again.
>=20
> Complete cookies while detaching descriptors in the completion, error
> recovery and termination paths. Keep the active-before-queued ordering
> when terminating so completed_cookie advances in submission order.
> Descriptor freeing and client notification no longer update cookies.
>=20
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA c=
ontroller")
> Cc: stable@vger.kernel.org
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-dw-=
dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com?part=3D3

