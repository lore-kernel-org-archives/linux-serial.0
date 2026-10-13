Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7D23BBFD0
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901015; cv=none; b=lKDqVu5Po8neEPNXYjFME8X5LsWma5rXq7MaixL0JAtCX0N2CatKN4wyPulvJtsyU1+xrNMTSIQmbnS4upMCDIH4Zag8GLkslT0PULitzwbKrwzCh5ovhvZYC0OcwvGlDRLGHzI3R1wfhZhqGILZCOsKTQrZBkyngcOcT8vy4hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901015; c=relaxed/simple;
	bh=yjzoDNyfV5ibg6LT/xKvKj15g2aeE1sCH6vT6cNWO+w=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=enTjP+h0pUSfdrYXMFcy9JAOZKc/1uVOFAIyQ5Eftu8wWUFjCxNmMQqmlsABnHVmeT3F9n/8Q55nEphqhfvEedFi5qlqxJoXS3diwery9BRQSKAfU40uNbxd+BXwi5DAEKVixPmiNaEWlktfFokV9YuuDWoj5iE32sJEDvLrfFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XErtFwaE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XErtFwaE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FD41F000FF;
	Tue, 13 Oct 2026 14:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791901013;
	bh=yEgx1cVrKyBoT+Oc9EQF0J58dMoMq2PPDu1OwjjB/Ag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XErtFwaEvyyu3Zqklj3k1jawLlUl7AycB+fq19tqu1ZjdQ3SmU+TR3xD8yITtrA57
	 Q/ckI4U3cMnWi3lwxCUWlRufdaQ3EZMKqbCB9tB+qm7Q5EVTDhYWdpe1sxe6yUPm9m
	 OUZaQzRZoMH8q62FTYsZ4NtRBgwmHtgY6+2ciIMiID5GwZiceS6bqJmjqUd04zgBAy
	 9LC3+/LbktghgMJOj78FvzEEN6KT+g7sitPJjrtmHH6Ckzfa4WdlAXfBymfjx+9V9k
	 /JxKAPeurH7Wh8Jj4aayI01qwh+F/ClhdC09Cf85CQY2w5hCNvcfNUzZrQ0LZ9B6xq
	 mMcsTeYn5l0KA==
Message-ID: <sashiko-outbox-169894@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: core: Shut down a running console port
 before removing it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Phil Rosenthal" <phil@phil.gs>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261013-serial-console-remove-v2-1-2eca1a92c10d@phil.gs>
References: <20261013-serial-console-remove-v2-1-2eca1a92c10d@phil.gs>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 14:16:53 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Phil Rosenthal <phil@phil.gs>
>=20
> A console port is not shut down when its last user closes it:
> tty_port_shutdown() returns early when tty_port::console is set, so the
> port stays initialized.  For an 8250 port this leaves its interrupt
> requested or, for a port without an interrupt, its poll timer armed.
>=20
> serial_core_remove_one_port() relies on tty_port_tty_vhangup() to shut
> the port down before releasing its resources, but the hangup reaches
> uart_hangup() -> uart_shutdown() only when a tty is attached.  For a
> console that was opened and closed, for example a serial console whose
> getty has been stopped, nothing shuts the port down.  The console is
> unregistered, ->release_port() releases the registers and the core frees
> uport->name while the port is still running.  On tty-next with 8250
> ports:
> [ ... ]
>=20
> Fixes: 761ed4a94582 ("tty: serial_core: convert uart_close to use tty_por=
t_close")
> Cc: stable@vger.kernel.org # 6.6.x
> Assisted-by: LLM sparse
> Signed-off-by: Phil Rosenthal <phil@phil.gs>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-serial-con=
sole-remove-v2-1-2eca1a92c10d@phil.gs?part=3D1

