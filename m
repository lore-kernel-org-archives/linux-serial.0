Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099720;
	b=oJTpI9lVPRMM78wkmcH3O4Ht4w9HrHEZBKPWdhiNexfRcxuch8AfaxYN3TOehmmmfJDa
	 gX0JS3bG4iWAAcwbvD1QTpoxLDcr+wU7eVvgfCQVOcN5XeaCDmW+ONb3akNWFwC/TGve3
	 woDLMsVnE98c0egfZ39v4H3aHsqUnRg9AWz0nx8xeEyWeG0oFwyKvanrkBJUTW3nvt7Hq
	 qPUmXtPg8k9M9yBJmUWnTs3LJceha7qIa5Blqlyp0ZoTT24YWPh2FYA5SZdD5bSWxuZaL
	 nb1ZoL8y08hTIVfq+fNWdZITyOk8fkhuGgyrkiDcjhFJtFc6XCc4iquafyOzpaNJozg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099720;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MH423UwXdAqEsnpXLHTBnszbXo8DxGVVLP5S2416StY=;
	b=jDfS2kqEbXf+Q1bqkwKPOzshUxx1SbCI9ikk25oLvLq8vSBYP0nqltFFEV5YdgHSttOe
	 i9idBeBqZLGwaTxNvdG2pijyDlm3qmAUYmd4qtbZFADXWGYbU/KMMhZ5R+N5YKZKUtTgv
	 /buzlZT9/FsTkmz+gt69qzyM4yjbYMJcxmqKsscPe78FO53w5RlT+n4n9bvQhL76qa3fn
	 Ry6hsmrlwqHoZlJo+Q7+jcc12Up3AkrXedgQyK8hk1U7WYFHsDtna93RGnvk/+9Z4T0oc
	 5yluhwLFacXK5ynrbSz3Lc7HUcpNp22BfkQv0r2YcV1JJfIMGNOffhGMtMdJKrhowag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oz1cZqZT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC57606A31B
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oz1cZqZT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38E41F01825;
	Tue, 27 Oct 2026 11:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793099720;
	bh=MH423UwXdAqEsnpXLHTBnszbXo8DxGVVLP5S2416StY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oz1cZqZTc0WCD9m/K9qn3GCQOCBsifb+jLkx1L/NJYjhmRdTxtk3JbLG+6QaI7L83
	 6fQxeZD7K/uWUXywNk/4AKW8jKvIxetgwK4m+yyJT8hBOtcPFNXrChp+5TQbv8Uw02
	 kw+ZxaG0bSXiGjK3u8rDVzICoAD3uvxW+yEN/v77Y2U39X4Stx14xUxQ/VtRNHSCMw
	 AnbiitgC32FSv5ZKVFiHGR7ac9Rz7FiWa5aWB8aP7WIAWtxPtdqrdMvEHj+Mj84RPK
	 4wgkVJvIGlzUY+Z0BdDLMITR3K87F1ogG14L8LQJPD3lX4QErAKToRdh9x435PV4lA
	 Z0eag9V9UHa7A==
Message-ID: <sashiko-outbox-186428@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 24/24] serial: stm32: don't report a wakeup to a closed
 tty
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-tty-llm-v1-24-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-24-99b0202ae546@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 11:15:19 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Josef Bacik <josef@toxicpanda.com>
>=20
> stm32_usart_interrupt() reports a wakeup interrupt as a wakeup event of
> tport->tty->dev.  That pointer is only set while the port is open.  The
> port of a console is not shut down by the last close: it stays
> initialized, so the wakeup interrupt is still enabled on suspend.  If
> the system is then woken up by the console, the handler dereferences a
> NULL pointer.
>=20
> Take a reference to the tty, and leave the event out if there is none.
>=20
> Fixes: 48a6092fb41f ("serial: stm32-usart: Add STM32 USART Driver")
> Cc: stable <stable@kernel.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> Cc: Peter Hurley <peter@hurleysoftware.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-tty-llm-v1=
-0-99b0202ae546@linuxfoundation.org?part=3D24

