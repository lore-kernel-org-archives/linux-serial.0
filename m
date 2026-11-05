Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889093;
	b=QXBjKErdeVQS5dLiqBRAQaLXRIsFDGG5DdAgfeCSZw57brtS9euSx/RGgqTj2z8OJG7j
	 ejembKxW1aTKmQViNsyI4esnXk8Imrfcrp/BV37v91++h5VTzZfC7AbYTiah7vSkCHx/H
	 YmqlPdq/lb1DVkrwjoxp7/2zpi98wbX5jqUhV/cZy4nomqhrLzMaKfbs8k9DAt8I63LMn
	 oVYqcvtEuVR1y7XnKBNZECnuz00SBXQL3AKmTaaOVIn/PXXN3SghYg4dXUMhB5ZjH/g5S
	 W56nMbwGYLvBx0tmkG275WTliBAdmrNt7RhIgJLI0/nfvz0p7C7cSLHSkMlYpHKrUxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889093;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qoMxeRjxg+iT8xSiLpr4ACRlor1f7Cy5loVI3BGzrCM=;
	b=NX6ZDL4EwC4prppOXqOSP56XP7i8H1z9jQBo/vlA2KaBQdMPHBNLPt5pMrS6y25797e1
	 3oaOxxrIv/q1YqsP7sOmq7N8+sLGZ9fPZebr5y/2JLGRy2lwIhfWVD5RNWxw687jImcbd
	 FhvZD72IXNcp88U9e4qZIxl66Q63ce/y3lHlaH1WPHMuP8PhXFFmM1m4fe4fyBP1EdQRV
	 IOYLcyHF9sgnahJN/fn2lFCT7fCcHnYd/KQqbSC1pqgiJC0bkjYtjEsxJjIgsQgkdk+oL
	 ll57aAy+38Br7pBhzqnQ+0XAIGqQhwKt8PY1np6fDmGTYxo9HFwgXv/vLoI5fxJJdRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EyI+/6nS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74DC606A326
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EyI+/6nS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6071F000C1;
	Thu,  5 Nov 2026 14:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793889092;
	bh=qoMxeRjxg+iT8xSiLpr4ACRlor1f7Cy5loVI3BGzrCM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EyI+/6nSH4aXGbAY7WXRg/fdUTcnZPGKL19uF7qoVcTrL5CGxVCeFPeKe7HGl1936
	 PJqbwbf8VCbzYlrV9D3dTXqUUKMO7tJZf4PiObH/TigyjMUM9PnXWDMhuHDoro9I+J
	 gfVGqqCdEmqRdf3ySkqxw7agqK9fls+jd2CiYVI9ziWvrqnFQKv4zTsPuu1Ym5Mdrn
	 7P0JRfakTm5Xy8unniQzZpFLtCC0Nk1/fK0627ISt7PzOqF0SRm1MOQLexUuaHAsVu
	 ETRU68oXN5kjxzyqGoBbbuEzSmiHDRKLy8ypY+rohYGZaP30B7Pox3qIl+I87uNOJ+
	 l+tC2WAhHu0ig==
Message-ID: <sashiko-outbox-199247@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] dt-bindings: timer: mediatek,timer: Add MT8163
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Grisdale" <bengris32@protonmail.ch>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-3-e68d7d428f99@protonmail.ch>
References: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-0-e68d7d428f99@protonmail.ch>
 <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-3-e68d7d428f99@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 14:31:31 +0000
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
> Add a compatible string for the general purpose timer (GPT) on the
> MediaTek MT8163 SoC, which is compatible with the MT6577 timer.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-arm64-init=
ial-support-for-mediatek-mt8163-soc-v2-0-e68d7d428f99@protonmail.ch?part=3D3

