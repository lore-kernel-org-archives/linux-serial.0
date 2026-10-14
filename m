Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6142D5632A9
	for <linux-serial@vger.kernel.org>; Wed, 14 Oct 2026 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791997080; cv=none; b=hCJ5+AqZhDWKDr/RB5N8szzCoS8gb7B461gdpAQHRmrf2ZGkYN6rt8BGRtXPMmmivg6N4e4esZIWW3yz9hC366lp5hlxs8q7vh1ew8iDT4KqdCDBRF9DBT0ALN9tggU/zLISqLXS224CM08yxCoaSZvcpwiab+p343pLU9Deq1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791997080; c=relaxed/simple;
	bh=PMPqHerMFXBdZXnck6aA8UeqbZcObfOps1Exyo+fA+4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=UwKsSVhuI6/DMjLwROCr1j2NaxLcj/A5Kxx5seDQsOcjmnE5xMHNohjHhiyxz7xbGvjSSiX24eV+woCcErYWUvtXp1hBgTe+9+3hMhRHdSz3uszLCl5zZmNjOQ/TaMSj2JTEx01h0gHn4K0av3vNL065T/kmM7sc/u2gmMQcSds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdwkVdtY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdwkVdtY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A811F000C4;
	Wed, 14 Oct 2026 16:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791997079;
	bh=R4FrWp0VHmyOodwyu4u5wNKthLz5zQQ40iGXnH9uKLI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kdwkVdtYexOiismdplVKrWVvP1eQl9OsG232E48WSrob6i//UDT7tSQQ/sJMci5y1
	 XA3aeRRn1pEFNh+BZnRibI9cBrxmj+BaGImfLPSP+vMyUJf2iSdSS1BxSSLjRjjBPM
	 bPvF4X+1IFLRdLUHzR88X0x/flXNLRrGS5xW1Pm119L+VTWL0nL2MDgSK2c7umkCV2
	 3AAwyPQ3F7+4kmnZTMK02TvZrXBkvX6Z/WAyO3ocCNQ74nd0QXhVHsJ6lsk2EBiIh1
	 SfvwrT5gAygOzmCkZO1r5wE/lzhBeCEeBKpC2oisJgEV0R/xG5OgLRan2ZrsIz/HzV
	 T5Tv4ixICgIpQ==
Message-ID: <sashiko-outbox-171558@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: core: Shut down a suspended port on removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Phil Rosenthal" <phil@phil.gs>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261014-serial-remove-suspended-v1-1-fda644ab5f89@phil.gs>
References: <20261014-serial-remove-suspended-v1-1-fda644ab5f89@phil.gs>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 16:57:58 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Phil Rosenthal <phil@phil.gs>
>=20
> Commit 810d467c11f0 ("serial: core: shut down initialized port on
> removal") calls uart_shutdown() from serial_core_remove_one_port() only
> if the port is initialized.  A port that is removed while suspended is
> not: uart_suspend_port() clears its initialized flag, sets its suspended
> flag and keeps its transmit buffer.  Nothing clears the flag or frees
> the buffer on removal, so both stay in the line's uart_state.
>=20
> If the line is reused, the next uart_resume_port() for the new port
> finds the suspended flag set and starts the port up although nobody has
> opened it.  If the uart_driver is unregistered instead, the buffer is
> leaked, as uart_unregister_driver() does not free it.
>=20
> Call uart_shutdown() whether or not the port is initialized.  For a port
> that is not initialized it leaves the hardware alone, and it always
> clears the suspended flag and frees the transmit buffer.
>=20
> Fixes: 810d467c11f0 ("serial: core: shut down initialized port on removal=
")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/sashiko-outbox-164404@kernel.org
> Assisted-by: LLM sparse
> Signed-off-by: Phil Rosenthal <phil@phil.gs>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-serial-rem=
ove-suspended-v1-1-fda644ab5f89@phil.gs?part=3D1

