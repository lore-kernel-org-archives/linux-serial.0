Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795083092;
	b=GkCKDZ/3kReEZDu0vLHPGpRrpao8r3gy3/rKEXJGcF7b3w4+xjlNpQU3e4tN3Rs3OupT
	 /dTSrw0JtsGTYLJxFrwbxob18XeCRFvv+T5QlEvX4qyXa6/Q2l9Nl+Rm2a/JeD3aHe3BE
	 GMNGO8kzfKCi9UrHGYwtR3YpWJSsWnz+LuS62v7SpTx/cbO3wOcS1njBrm8iD0H3F9RK/
	 9R8D32eOXD3v/GZQPu8a0XXq1CVBliQbcJTnByNVkFkJ4iANilJJJc/HZhXe75ychYSLM
	 oAjh9554Rox0cMwJOUd4ZnSdYwJEOOzpHG2L75h52oKDelBIrkPfTkUdhjEAi72llLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795083092;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Oy8ZzpQ2Kc8TGrKxk3pqeZSQikz6B2+27h07OiWfYEk=;
	b=TGoYySZSj3YFSy+kIXg9ix2fG6PLJghi6GcNE71RmgFzzlNxdm3VXbBlENUwt4X1qjEO
	 8T5I8Ze4Fq7kHA2RGwL56EzGf4Mg9wyszM3g6H94r4qCT2wFS38UShuWtS3Jbq+Ky1NyR
	 eNYYXTWxgQiCpoCahNZdf2SlxFieaj8S0sUvux88VWdsPoqbtEMP57eN+b2doD36ejd6x
	 fhYYXSgAsQPXW8FA3QCjqnlVVzDA502oOBfrzAKuDf6lQCvUtKqtoBom2hwESN7Q56wdT
	 GEPzIYzRFYZNMi0Hz+BleoXfF5wpoXkjULPiNwIMYX3FGjwz9JaalK3oKUlbACWJBlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mniENV3g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25FD606A320
	for <linux-serial@vger.kernel.org>; Thu, 19 Nov 2026 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mniENV3g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA701F000C7;
	Thu, 19 Nov 2026 10:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795083092;
	bh=Oy8ZzpQ2Kc8TGrKxk3pqeZSQikz6B2+27h07OiWfYEk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mniENV3gzJrydrC2lAm/G/q8wveWJZMU2vwY39qJKJE4fU2noYARt4HDxd36IWOUk
	 6meqms4OkiHtJhbL2vzdT7Tp351zQ5oC2USfy3WAvEuvqvJ5XhC4m+86O7PpgFUlVZ
	 q0wf+Q0NsO/FP0CnO2UMgJP3DQMoREcDO51u1VbI59BjpEnj1KVlBI/6VwoNK196lp
	 bEfEdGFHAt2ScQP2W/GXSpBaCCiOmGi5KR+u5w9c0oV9M7hVEInY9GMxDt9cNwqzL5
	 +YX1p1qNsQMjN9RUJQqJ91X2c4TC+V9Cqfs98PDT0rldVqkdNzjO/4RGy/uNTHpK2s
	 uUt/iR03j2JgA==
Message-ID: <sashiko-outbox-222921@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 6/7] dmaengine: dw: calculate residue in the status
 getter
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261119-submit-dw-dma-synchronize-v1-v10-6-3a737597a0d1@gmail.com>
References: <20261119-submit-dw-dma-synchronize-v1-v10-0-3a737597a0d1@gmail.com>
 <20261119-submit-dw-dma-synchronize-v1-v10-6-3a737597a0d1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 10:11:31 +0000
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
> Calculate hardware-LLP residue while looking up the requested cookie under
> the channel lock. The descriptor scanner updates cached residue only when
> no transfer-complete event is pending. If a status query completes the
> current transaction and starts the next one, that new transaction's cached
> residue has not been initialized and a query for its cookie reports zero.
>=20
> Have dwc_get_hard_llp_desc_residue() return a local residue value from a
> fresh LLP snapshot. Keep the persistent residue field for software-LLP
> block accounting, subtracting the current block's progress when reporting
> status. The descriptor scanner continues to advance software-LLP blocks
> and complete cookies from RAW.XFER, including for polled transfers.
>=20
> Fixes: 4702d5244ca9 ("dw_dmac: return proper residue value")
> Cc: stable@vger.kernel.org
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: retain polled completion and software-LLP progress]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-submit-dw-=
dma-synchronize-v1-v10-0-3a737597a0d1@gmail.com?part=3D6

