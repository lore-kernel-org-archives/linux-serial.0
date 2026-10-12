Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE493B7B9D;
	Mon, 12 Oct 2026 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791788424; cv=none; b=TTqL0ePTwRBLinzp39uBMhfVOW3jNc7U/R1Vt+UmXqBFW7lxwbrHuzuPzloyRcrQTW5HSs1ZkaBq/5wawXoGcMf+eSfK+uwuXLQ1YLid08Q1PTIGIJJd3Ke8eUiRiSySoTpg8ckzakaOBQg7GXMT0EpvvEnICTBx/aFepk/gKXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791788424; c=relaxed/simple;
	bh=USiXHekjYM40stkYIKfJqmpKRR///MSzARJueAoHoUg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=geYCKjVxtcg6uh3vNlFvrAj2PK5d0Ap1ByOfOMFpA+2WvBrd8GszKWFAzyhZnfy6swcTh85zL3zQV/lWw6aesuJPz/iSpqzBSvKSc1YRiO8PI/cWCnYwwMIerFo08NnLo2VHT2tMJmnS3VJQWAIuCX5+zp5NojiZdiENNN88p+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlC5RhGQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlC5RhGQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E871F0089B;
	Mon, 12 Oct 2026 07:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791788422;
	bh=USiXHekjYM40stkYIKfJqmpKRR///MSzARJueAoHoUg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZlC5RhGQm1wnJIBS8CdCgWyqlm/eu2r2LFXm7ZfZT0iJFBjvQ0idkvmICXsQfIBRA
	 tJ7AjDXCao/99gScgwXdBAXGz9T4OA/zIzcz/wgfIHWFTL5AP66V/xtqk7y8TLZ30U
	 hAKPBZL1eFe3qfOa8Sv1jweZgYisJ8ASTGbgXvBawwAlNGOGiwurhWNmK0Am9zyI5c
	 1uSJZ+Np2jvn4DGZinR0Rru1AXoG/RUeoQifooohzAoc9661PLGDIRmH70+b8YOpz5
	 kX/xY1opKLqivq41W99C3lMB8SDh2yElZpvAW/qXnMUuG0PrWGInxyj+UOPU++IfbZ
	 utwAZEQIjt4GA==
Message-ID: <sashiko-outbox-167762@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 02/10] dt-bindings: arm: Add Cortina Systems
 CS7542 and Securifi Almond+
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-serial@vger.kernel.org, robh@kernel.org
In-Reply-To: <20261012-b4-cs75xx-v3-2-0e0d17a098cf@gmail.com>
References: <20261012-b4-cs75xx-v3-0-0e0d17a098cf@gmail.com>
 <20261012-b4-cs75xx-v3-2-0e0d17a098cf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 07:00:22 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Add the top-level binding for boards built around the Cortina Systems
> CS7542 ("Goldengate G2") network processor, a dual Cortex-A9 SoC, and
> the first such board, the Securifi Almond+ touchscreen router.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-b4-cs75xx-=
v3-0-0e0d17a098cf@gmail.com?part=3D2

