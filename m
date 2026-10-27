Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099487;
	b=QQosoIpEYM3dT+GlYBzdCV5PSAHSt4iGZ2c33PEGjXEpHH2POZNkIeCzGVX8VczVKbFI
	 KA7Yc/vgsLpHdJS/5c1fmIx+KJHBTimkpFAODi/me8FvoU13VDCsNlt4tz5vPS1bvu7Eh
	 0LklrkPX4aQ05M1FMiNdRP6DwIiTuPP0dY9Aa/iUY31dlZBqzOS53M/UpoR8KreElmSR9
	 ZVq7iBbiqDCdHn9XPA5bYMUwD9OsKheOqRkEkbe4+icqLBQzKeKBfGgeaN+Gyb0RESUlp
	 owHuHsOhByciDXExT0sD6KrrugAG6qSGEb9FAaYqc+j0Bhm7JU3QoncDzMLfcHJCWNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099487;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wsHuNi7BPUr/RMmQajG6NVRmwkwu4ieyato3bgAeXww=;
	b=WHj6Jt22k6qMDg2GD53SaJNqWpEkKqv2BfiPZCmS6Bj5Cc+K1UztI9FiAG6N/y8I8xIw
	 uEY4dZF60Hh0ghMquvD272rsUbHGy9UwMTFWdYtnMtknbmM3dlQid6r9Xcrqz9V5C2SJK
	 WRftSRtp6Othh3Oh5G+WUBjbhSeFOIfYruAm2PvY0esdfQhb9vAZ8vzMkkSA424P5Uzo6
	 7iGEkmp+UioSXnYp27aM6Tm76EKThqJpO9ihydcZcCpFH9kmVgDzX+mklVcMY56XiWs84
	 bEBDV6DV2gbRhShik9RLEnq7QckOXYV7k/flTupxh8CgAn4wfC5RWpOZ/c+vX013xfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHSXA5uq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546A3606A31D
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 11:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHSXA5uq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06F71F01825;
	Tue, 27 Oct 2026 11:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793099487;
	bh=wsHuNi7BPUr/RMmQajG6NVRmwkwu4ieyato3bgAeXww=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YHSXA5uqD4Ddh6sKiKllPNxZYTWONtbG+hdOhCenVwpgT15bOx4CP1NxR1scHo5T8
	 TGFxWkUHNEGjyFfILkHBCSL63EnRArvCRRpiS3jjyD+iIUf6WbPrXffYlJanXPU4qP
	 sJb5rbxcwvqzR1CzqqIE/V49w2GcfDHU5vHh5S4d1bVRm2wBGbuz14baumQgSvmzyZ
	 6Br6jTsQpgGFlSfL6pV+JSDaR6WSlY5UYv0ksECouKX7/BK5cFETf021LFR8D+4MzL
	 6vOsUxaYbB3CRCZcUXbzGMc+n71byFV5s5E4pTmznl2TpvsuCpxp3brJMv4mFXpZqT
	 gPtSCqh8McFCQ==
Message-ID: <sashiko-outbox-186414@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/24] serial: 8250: ioc3: store registered line number
 in driver data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-tty-llm-v1-14-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-14-99b0202ae546@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 11:11:26 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] serial: 8250: ioc3: undeclared identifiers in serial8250_ioc3_probe=
()
--

commit 42c7c91e0766573099398067e430ef38776baba0
Author: Joshua Rogers <linux@joshua.hu>

serial: 8250: ioc3: store registered line number in driver data

This commit attempts to save the registered line number into data->line in
serial8250_ioc3_probe() so the remove path unregisters the proper port.

> diff --git a/drivers/tty/serial/8250/8250_ioc3.c b/drivers/tty/serial/825=
0/8250_ioc3.c
> index 088242de2eff9..3ab50e04be451 100644
> --- a/drivers/tty/serial/8250/8250_ioc3.c
> +++ b/drivers/tty/serial/8250/8250_ioc3.c
> @@ -63,6 +63,7 @@ static int serial8250_ioc3_probe(struct platform_device=
 *pdev)
>  	if (IS_ERR(uport))
>  		return PTR_ERR(uport);
> =20
> +	data->line =3D line;

[Severity: Low]
Does this break compilation when CONFIG_SERIAL_8250_IOC3 is enabled because
neither data nor line is declared in serial8250_ioc3_probe()?

Prior commit d6a0791098bede ("serial: 8250: make port operations work on
struct uart_8250_port") refactored drivers/tty/serial/8250/8250_ioc3.c to
remove struct ioc3_8250_data, data, and line:

drivers/tty/serial/8250/8250_ioc3.c:serial8250_ioc3_probe() {
	struct uart_8250_port *uport, up;
	struct resource *r;
	void __iomem *membase;
	int irq;
	...
	uport =3D serial8250_register_8250_port(&up);
	if (IS_ERR(uport))
		return PTR_ERR(uport);

	platform_set_drvdata(pdev, uport);
	return 0;
}

and updated serial8250_ioc3_remove() to pass uport directly to
serial8250_unregister_port():

drivers/tty/serial/8250/8250_ioc3.c:serial8250_ioc3_remove() {
	struct uart_8250_port *uport =3D platform_get_drvdata(pdev);

	serial8250_unregister_port(uport);
}

Since the driver now stores and unregisters uport directly rather than
tracking a line number in data->line, is this change obsolete on top of
commit d6a0791098bede?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-tty-llm-v1=
-0-99b0202ae546@linuxfoundation.org?part=3D14
