Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA59503918
	for <linux-serial@vger.kernel.org>; Tue, 29 Sep 2026 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675372; cv=none; b=gr2uBCnTIac9QwZp4A67NzCZ0pliyTCR1t9e+ynCqW6ydBnnCCAearRGkJMjD8xoK6FCnLjhWQQAZaWVuVE+NhVb6fBQjn1JsIdhvWaVArVVk0O9RJDkuI6m9rgm9rY8nOMKM5fEH3NDO+dvHaDL5V/OWE7NHDoAsK6rhmMmRzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675372; c=relaxed/simple;
	bh=YImnZZ/rNVbB+6i7gKjSMjVQxXTt/gmbQ35hkGdBO9c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TY7y0tYSSfqliEM4PSnAI4LbgAijkaJwkYNNuu5/Z3XcNHVY3QuLzrwHQek+iqn8b5sL65gdzdc04sVvg2MUD0u0GQsCmRewePyRwOMK1UFqRtZXRYgTMwN6FGbtzKqHr94Onn4UVYBPK5jBmzpT/WSGcISFMcCL+9rBGFdth6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVnlK47x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVnlK47x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660671F000FF;
	Tue, 29 Sep 2026 09:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790675370;
	bh=YImnZZ/rNVbB+6i7gKjSMjVQxXTt/gmbQ35hkGdBO9c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SVnlK47xC+4lep9ztY6qcJljojsZWnZOKLTh1cGrSGg30KR/ghSLoz+HFFnDxOkTw
	 g2w2WmhbAjV5ZrVhOr7mNlkP/Fe/JrWeECyMhR/V+JJ27OxbhjP1oSzZSOPJSby6bg
	 069pK7IN6+tcQ8rlTnqTNQEAqIsOPli3SNXhtL8pJm2321rNr673ybEAnaenEieqf3
	 iIp3l6nITxMfOrozle9Sg9Lrdn3TsNk5wTQscAKSrO80526xMODwqr+upSTeUTjlJR
	 wEjTXXg+zITDKck/BNrtW2+V4kSi0uOkA6Bh/ClVEtJZqws1zvbPpf+gY1xRXaRxF4
	 xM4eVXxMf7ehQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/8] serial: max310x: don't clobber the TX break bit
 in set_termios
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260929-max310x-rs485-sw-delay-v5-1-ae46afa583f2@vaisala.com>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
 <20260929-max310x-rs485-sw-delay-v5-1-ae46afa583f2@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 09:49:29 +0000
Message-Id: <20260929094930.660671F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> max310x_set_termios() writes the LCR register absolutely, but LCR also
> carries the TX break bit that max310x_break_ctl() drives. A break is a
> state, not an event: TIOCSBRK sets the bit and it must stay set until
> TIOCCBRK. Any termios change in between - no concurrency required -
> rewrites LCR from the termios bits alone and silently ends the break
> early.
>=20
> Update only the LCR bits that are derived from termios and leave the
> TX break and RTS pin control bits untouched. Since nothing clears a
> break when a port is closed with the break still asserted - the tty
> core sends no break-off on release, and the absolute write here was
> the accidental recovery - clear TXBREAK in startup(), the same way
> 8250 does.
>=20
> Fixes: f65444187a66 ("serial: New serial driver MAX310X")
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-max310x-rs=
485-sw-delay-v5-0-ae46afa583f2@vaisala.com?part=3D1

