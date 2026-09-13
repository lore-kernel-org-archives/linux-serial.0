Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60172381EBD
	for <linux-serial@vger.kernel.org>; Sun, 13 Sep 2026 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789316637; cv=none; b=tubP9/1ZSFKR5SPI0xR4GPuDfWsN5mqbjxP3Bquqf8aSJ+sc4f75q9eG0kJqQQH8xtFLs+cFYRgo9DUEkAwDj+ROI1+nUQXUwPZENAyWoaLzzoAKT/N2D48gTWcYrQPY8hHqvKxa20oBfiqG1z8cFSLymHKqhGTltsNYPHGKUvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789316637; c=relaxed/simple;
	bh=gBP4TlMPEPF59P1GxU47Vt8vQMTZ+IYq6gKQHZAgQ48=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b5shEroT7yH+Jk0HEm0h2bXdHxYHXwGlf+dWidHBGSry2J8sfp63fEdD5jkg2blCEB/Z1kfzkuesNLiRYz4lrEl4+4KXMUTXl8JFmWZtKbZ0TqMY6r1T3BjXmtV9fZvO+QDb2HIyu1Y8eEb33dogR14Tl18abHTHPqsVrRvf0Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeMaoiOC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeMaoiOC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6491F000FF;
	Sun, 13 Sep 2026 16:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789316634;
	bh=gBP4TlMPEPF59P1GxU47Vt8vQMTZ+IYq6gKQHZAgQ48=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eeMaoiOCsZ3oyaZXVNY9zGV9fPsBvzu0xz6YWAwBG2gkqR/ZRMJ9aj5ZiDfNFsFu5
	 /D2ihH6MTDg2i9XrAt9ypOsX5I1pus1i/4lxbfjcIz3LXAMTyCRvUoA/xL68wps73q
	 rmaEq8NN5Hv4xZ/Jw36sZ9DHwh6Y6zie8PdORby+iefgrq+DqD10IYP3OGaek8k7CO
	 I55oR8GR+j4I2EvZn0Iz8HzLzeWYX1gr4eTLU/xmbSYhm4R32g4xIOdB289izag807
	 ScQNcaOWnA52quRbFVX7yvaCCJDDh20raTa29e/rNek4rpvP7/5SOOfvZBmc+ong9c
	 2bwY9o5G+AtDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v4] ACPI: SPCR: Support UART clock frequency
 field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260913-acpi_spcr-v4-1-965654188e67@posteo.de>
References: <20260913-acpi_spcr-v4-1-965654188e67@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 16:23:53 +0000
Message-Id: <20260913162354.0D6491F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Prior to this patch, we assume the uart clock frequency is 1843200 Hz in
> the early console. This behaviour results in garbage console output if the
> actual uart clock frequency differs.
>=20
> The UART Clock Frequency field was added in the Microsoft Serial Port
> Console Redirection (SPCR) specification revision 1.08. If present, use it
> to configure the serial port with the correct uart clock frequency.
> Fallback to old behaviour if missing.
>=20
> Add function `setup_earlycon_with_uartclk` to set uart clock frequency
> while still allowing to reuse the same console string with
> `add_preferred_console`.
>=20
> Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports=
/serial-port-console-redirection-table
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913-acpi_spcr-=
v4-1-965654188e67@posteo.de?part=3D1

