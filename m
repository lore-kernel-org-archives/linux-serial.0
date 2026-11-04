Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778562;
	b=q/cnMitFR0/+MGSybywAyNpC7mbo+1DuTayA4uRqidmxf0bBg3Im0UMGBBbNmrB4S+rE
	 npOvU7FoWncL35O+Vlu5EMghAS7+7kvve7boSGwy06iSry6Wao3p82QVhgzC+APyzomRO
	 UoQQajWBaENWvD1/azuJMOtqDyC8T0MstJNHmcK/FhgzpgiZuNZvFg0NKkeLi+dgGEwaH
	 G0Ke/Ii9UhEUHOVNeKPZhoJRr/zVKE/9BH3POEmDEX5leSY9u/iwblUDiIc0RX1FKWFlg
	 tjcIVoOBVRpa1TgkXKk9euFztx/e/vBc9BlvlPhfC2SNCs47+Na2/iiprKkrU4BVNow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778562;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=183XKUv62isEReAe8b2vYpq9AReRfUIbMSTtechX0eo=;
	b=4Jsopseb474+jj/mVlB+2Qri/wYBCrNyKYcwCJxSPZ/BhJNNQGVvX8D/laZtNRzRVa+D
	 xl5WFXq/F1IQAa1PgkzCQtHmbzscl8qcxsqpVpt7GyDEqrn41rof5klXn6sOy6gljx9nw
	 yHVqK47zpu/7WQg0A1hQZVPV5Inj+o50GEUtZtiavqvy/Q+UMMzXD1z9pLiwG0ugfc4Z6
	 XDE7dd3IPOyOxQ8GEHoiapbgvD+Ffy4ZbbF69CFQJFC7zU1UVH1lf1qBLu11thES6er6f
	 vbvUnn4ip58o0BhPbQ5umQ0znkDHPKsDZX4JHlYtIbaKoAKzkmbqR7McmY71PcHHypw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I5+DN0QA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4535606A31B
	for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2026 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I5+DN0QA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505431F000C1;
	Wed,  4 Nov 2026 07:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793778561;
	bh=183XKUv62isEReAe8b2vYpq9AReRfUIbMSTtechX0eo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I5+DN0QAGRdSr/E2SPYubBMgeHDbmnAb7ug3XdTXT0q2T03glz+JD3G2VoX2C1Eaq
	 fo0dJVfkueVsY6n9o102Czuru2sKnbEYv0DQj3wrfcotNcfyFp9fD2jzXeaO2wJRTw
	 ZBBhgLK8VAMwXOTv84jJh7gSVxsWoanYeWjuP+pqVipj296OT2VHu23blowN0BRSqF
	 v1P1R/L1WV1WuucIfkC2CYpHv5XDKmtnJ0vI/iduAw/qeHUTvDqu7xxFNl2WH9Vm6+
	 sVdg1tw8TS56RRkqU10RPgj8vBQt+kaLG3rSHd/M6AT92RBMQlrRcflMFyX7oLr+gp
	 bNkGnGapS1k8w==
Message-ID: <sashiko-outbox-196823@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: serial: 8250: Document Loongson-2K0300
 UART compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Zhou" <zhoubinbin@loongson.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <cf76d5d46eaba55b832287d1193111c369bcf548.1793776192.git.zhoubinbin@loongson.cn>
References: <cover.1793776192.git.zhoubinbin@loongson.cn>
 <cf76d5d46eaba55b832287d1193111c369bcf548.1793776192.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 07:49:20 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The UART on the Loongson-2K0300 SoC is identical to the Loongson-2K1500
> UART. Document the SoC-specific compatible `loongson,ls2k0300-uart`
> with fallback to `loongson,ls2k1500-uart` and then `ns16550a`.
>=20
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793776192.gi=
t.zhoubinbin@loongson.cn?part=3D1

