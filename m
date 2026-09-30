Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA13E3B27C3;
	Wed, 30 Sep 2026 07:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752189; cv=none; b=Y4PHQO0uBN92isIuyV+2i9DDidb8zdCk60BHbXcXvVNKeIErClPI2lEYVrsf2Tgnov6juy13UujLMDp5TUxNlHQuCj22aMVyl8vwKrO8okWt52G0wlkcD1HwWXe/yKml8DcSq8lFZnFiB/PH6+QwiAqcAlRxR97SZXqw7VbQBlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752189; c=relaxed/simple;
	bh=U2HkwzAeA9HDd22YjG3HGZXDM0yeMiaH8dJOaS9pIro=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JOC+wFmIko1hsSSQ0YB7LFEDbM6zoi7vQq/vwAJF4T2v5cMx51b9czJqsdwTXG2xgt5JJaL7h7i3WNKkhtVWqB4sFKQFPO+GVmesbG4BqptQQ0U6xZR9QCmwOtsL9C+sbWnE0YJpdgqaN7D94BXO2A7LraTqMkJhVD05ZTzexJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AS7AdUBL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AS7AdUBL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4EC1F000FF;
	Wed, 30 Sep 2026 07:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790752188;
	bh=U2HkwzAeA9HDd22YjG3HGZXDM0yeMiaH8dJOaS9pIro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AS7AdUBLexTOKB5DWXqNwa/GG7iN5K33bhEDkDfZ5FdJ1KMIHakDrddfnYrvj8NNx
	 h3PRNq7lhaHAq65DYxuAh9kvDEEx3xpB2P/wi4SFWczsaDYHzNVY+z/j/X0YPLqoVn
	 gZccSuYVoauBDarOSD89e1ZWeWLL6vzmK6fwQhi1y45xtvBxbPAYCF/XFUuyrvTaHG
	 NkdSgxMrV3YuStMAHRpT7OsP4rPjPkC/1Ez0UNeM8UC1FNZKSnmHUUzQdewwol6KEh
	 x80/Ok63G4QcA2a+ztlmfXXgdUSb8qiqvu2a+mXzS2ZxlSnEHrBkEIObS6peElvlmI
	 hBoRzwJJ8vgkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 08/10] ARM: dts: cortina: Add CS7542 SoC and
 Securifi Almond+ board
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260930-b4-cs75xx-v1-8-4617c4463529@gmail.com>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
 <20260930-b4-cs75xx-v1-8-4617c4463529@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 07:09:47 +0000
Message-Id: <20260930070947.ED4EC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Add a minimal description of the Cortina Systems CS7542 SoC: the two
> Cortex-A9 cores, SCU, GIC, global timer, private timer and watchdog,
> PL310 L2 cache controller and the four on-chip UARTs.
>=20
> The peripheral clock (APB) runs at 100, 150 or 170 MHz depending on the
> boot strap pins. Until there is a driver for the global control block
> that reads the straps, model it as a fixed clock whose rate is provided
> by the board.
>=20
> The Securifi Almond+ is a touchscreen Wi-Fi router with 512 MiB of DDR3,
> 512 MiB of NAND flash, a QCA8337 switch, QCA9880 and AR9580 Wi-Fi and an
> ASM1042 USB 3.0 controller behind the SoC PCIe root ports. For now,
> describe the memory, the console UART and a ramoops region, and reserve
> the top 64 MiB of RAM which the vendor firmware hands to the packet
> engine queue manager.
>=20
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-b4-cs75xx-=
v1-0-4617c4463529@gmail.com?part=3D8

