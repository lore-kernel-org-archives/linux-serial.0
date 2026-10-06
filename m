Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B564A3D2C;
	Tue,  6 Oct 2026 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310850; cv=none; b=Hgxc8cufhe8w94YA/eHGfJZlU/EXH57fubMfCHTZkV1Khm5A+ZO8CW4oVolxZ3RxKaUb3h2FbNFwhfLfahwnAANyV9appPXteXehqNrFPAOqLKTBWf4iPwJey+9maLLc3aDILNiAmURT7Io6bsrBDRGKP9S1jJUrFJyVhOKmWUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310850; c=relaxed/simple;
	bh=5aTARTmtbHkrPzqisHtX6g8Lf1/siFIwxtD4ROQVuYU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=B83V+tRwB8u4r9uJh79E1A2L4fpM+DSeKT/zKErAo/bKiGnIul+NuQ0s0bikzxu8JD0nkJacElxJgEtW6Hv+HviFMsjdxm2NcMte2jFAzCRYxTEbccg0qEpbw13bVlkjSvUyZDtyZwXgsQMGQ7wAZGAueCyWnweDmQTRKpTmO1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7fmAIr1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7fmAIr1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E20A1F0089B;
	Tue,  6 Oct 2026 18:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791310849;
	bh=5aTARTmtbHkrPzqisHtX6g8Lf1/siFIwxtD4ROQVuYU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D7fmAIr1FSwoFHDIYvuwF+twCZzrSuN8aATjVfYHsEqUcF/iT2VZCWNU9IUZBInoO
	 I3TcRuNNe8wXN4m6kJg6XY3WH0Wbkl6uherDu3F6tXAwhv/V/dZdQiioOZD2eAjeok
	 cyFVa5xPyELgTG6ztx1tyfbm1ZKeUR6TbGW5Z63esMD4zsjTB+fw9ilh3PjTJamH4Z
	 eQZdh98Yo3y7e4I1lArPL1ghQ9DgQ/B74lhibB2elXQxZEI2YTC62Y+iR3Ngf/7WWT
	 bx1evRvCOQKssg+C4q81sE1s6cIJgUc6HLBBg4vaxIP2D9PcIofFqlAHg0XJomzA4g
	 /U1X/QWQzBNPQ==
Message-ID: <sashiko-outbox-162334@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 02/10] dt-bindings: arm: Add Cortina Systems
 CS7542 and Securifi Almond+
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, linux-serial@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20261006-b4-cs75xx-v2-2-b7d6e1e24d44@gmail.com>
References: <20261006-b4-cs75xx-v2-0-b7d6e1e24d44@gmail.com>
 <20261006-b4-cs75xx-v2-2-b7d6e1e24d44@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 18:20:48 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-b4-cs75xx-=
v2-0-b7d6e1e24d44@gmail.com?part=3D2

