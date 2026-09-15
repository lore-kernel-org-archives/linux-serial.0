Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5CB3AE1BC
	for <linux-serial@vger.kernel.org>; Tue, 15 Sep 2026 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789479193; cv=none; b=aTFGE3/vDNQzCQP6dqu9dwuSZhebqtk9IMdRZYVMfn6RtwXXdI3nyU852eCElj2J+An4h2c8EeP4S+F5ZqZpJqEYeAbjrxaoBZN6TLAHceQzP6DG4J7/OQQxy63Nfa3ku1+CrYncoBIMwaLJCoMMLrWCJYJhZxwCuWAjZ80NUW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789479193; c=relaxed/simple;
	bh=WE3Nk+YhNF/gUoesGynCAiQsNWSC6EB21R1Y93hWP08=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vCHusxj0nR/aF4cYSMQaHPcLJiXz7yt3zLJDbtmfTM7QGoLEm0XHrZEsVyCd4MlAK4SYEL6QQ2oIx507p7NoFpQ9U4B3HQd0Wx/KA7zP9acypFQRFqoxfaZihmwN8/amq9Qn4KP2Lk+NJZuwKlGdSp34F/u9UybRamWKXQTgSyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwZPhGor; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwZPhGor"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7AA1F00893;
	Tue, 15 Sep 2026 13:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789479191;
	bh=WE3Nk+YhNF/gUoesGynCAiQsNWSC6EB21R1Y93hWP08=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gwZPhGorR2ApqR2ycXGaVEvB63afmiw5V90s3WRwiD2k0guM+LyEwfg+Ci7w3woPM
	 fyAKz2UkWz3vZeUiIFqI8tsKToQ68hhK8fjsVMoBAk2VqteIFlVz1DTUoefIsYO9mf
	 FRczwC5n7nbuqcbuKykT6H0WhNpkDXhRhLsGGJ+RJ+LHY420Sj7ts5qEIs5U+M+4cT
	 eE1kRlRR6yJbASWuBCqLDqq+HFObutWNKT+3CnFJS8u4mVBEGcY8St4QQinUvN1o0T
	 6K2Rce6WIlU1N3Oz4oPioSJucnIG4uZ1KBOMx7Q5v1xAZ89dmi9N9WA09lE+0dpxIC
	 RlC9OV0lF9sGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] soc: qcom: geni-se: Correct QUP Core ICC vote
 constants
Reply-To: sashiko-reviews@lists.linux.dev
To: "Viken Dadhaniya" <viken.dadhaniya@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260915-correct-icc-bandwidth-vote-constants-v2-1-f78eb611204e@oss.qualcomm.com>
References: <20260915-correct-icc-bandwidth-vote-constants-v2-0-f78eb611204e@oss.qualcomm.com>
 <20260915-correct-icc-bandwidth-vote-constants-v2-1-f78eb611204e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 13:33:11 +0000
Message-Id: <20260915133311.9B7AA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The GENI_TO_CORE ("qup-core") ICC vote selects the QUP Core 2X clock
> rate. The CORE_2X_*_MHZ constants are expressed in Bps, but their
> values are several orders of magnitude too small. For example, the
> 50 MHz threshold is represented by 2500 rather than 25000000 Bps.
>=20
> As a result, clients using these constants can severely under-vote the
> QUP Core clock.
>=20
> Correct the constants to their intended Bps thresholds so that the ICC
> provider selects the corresponding QUP Core 2X clock rate. Drop the unused
> definitions.
>=20
> Fixes: 58ffbba6a399 ("soc: qcom: geni: Support for ICC voting")
> Cc: stable@vger.kernel.org
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-correct-ic=
c-bandwidth-vote-constants-v2-0-f78eb611204e@oss.qualcomm.com?part=3D1

