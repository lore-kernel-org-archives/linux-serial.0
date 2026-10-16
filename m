Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA2A48DB3F
	for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 18:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174633; cv=none; b=NZlfnKPMw18fYNpdpnkeLLHqvMIz3RetHgdpjRJKSou+2kq8FpCeeUDzzhno6yNg3AhSXM5J07aPS4HQkaYCreKql6vPWbj2vXYHrevqTr/vA7nHjx8B2a1ozsWQ3F+v2aoZuKVI6Dz42+hxq73GyO7qPgGJ8P0aV1TW3U3slLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174633; c=relaxed/simple;
	bh=mBg9lyEkqG+O6Y39i2vk9pNWe7ovuHgSGsrmnh1JfNI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=b6tpja46QYoIzS1N+S/kSJ4HDpFmAGjaEgU5OtotIyIFgICUDEYzy+M5WpNEk+Ic/un/CflcpBhT5KinnUQbEM6nEnZW9QwEKZAWelbqnZcT1mB1Hzg7MqBqd2/UQHgqbbxsVRh8mFbSjS2AZKfSLO+3Dv+iaVCbIOCzLXrL7Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLWzIilM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLWzIilM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06381F000C4;
	Fri, 16 Oct 2026 18:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792174632;
	bh=e7hEgyCQ1Hj/jXZABJTrSnS7rrrD/PiImlFN29mqZb0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VLWzIilMjIxddsOu3VbLyilczM250o3A7tAzVeXDaFjY1K0IsZCDPDitAPEUF+w5Q
	 gje9m/rf+cVNJahlk6wyxPOPagEvbehAOL/gZh7Ap+0cmJK5L6jtxR+pJRgNExZqxR
	 ywa7u2K4yBvp4I0yvpU014Rr3HZdjMtfn59KypuszdAVQYLw3u+/WTbKTE2He+koC9
	 1Iu9X3Gm2Tp6mrSbqFoaBJVUznvtT5cDQsgHcvcJh2WYoIaEYJ3Qhkp3Gtq5DrwfTV
	 3/pZFtJ9unvO59760JtxIPZaKGDK/VqXuqZJvhPawG910nDZjiCEGA0TUcyG4vqUj5
	 RHr0LxhR1x5Pg==
Message-ID: <sashiko-outbox-174763@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v4] ACPI: SPCR: Support UART clock frequency
 field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261016-acpi_spcr-v4-1-f9a96fe016af@posteo.de>
References: <20261016-acpi_spcr-v4-1-f9a96fe016af@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 18:17:12 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] acpi: spcr: out-of-bounds read of uart_clk_freq
--

commit 4417c1e28359b400b5ff86436180ed471e8b7aca
Author: Markus Probst <markus.probst@posteo.de>

ACPI: SPCR: Support UART clock frequency field

This commit adds support for the UART Clock Frequency field from the Micros=
oft
SPCR specification revision 1.08. If present, it uses the field to configure
the serial port with the correct uart clock frequency.

Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/s=
erial-port-console-redirection-table

> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -228,7 +228,8 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool=
 enable_console)
>  	pr_info("console: %s\n", opts);
> =20
>  	if (enable_earlycon)
> -		setup_earlycon(opts);
> +		setup_earlycon_with_uartclk(opts,
> +					    table->header.revision >=3D 3 ? table->uart_clk_freq : 0);

[Severity: Medium]
Could this result in an out-of-bounds memory read?

In acpi_parse_spcr(), the code accesses table->uart_clk_freq based solely on
table->header.revision >=3D 3 without validating that the mapped table leng=
th
(table->header.length) actually covers the uart_clk_freq field.

If a malformed ACPI SPCR table has a high revision but a length shorter than
the required size (at least 80 bytes for uart_clk_freq), the access could r=
ead
past the bounds of the table mapped by acpi_get_table(). This could
potentially lead to a kernel panic if it crosses an unmapped page boundary.

Should this also check table->header.length before accessing uart_clk_freq?

> =20
>  	if (enable_console)
>  		err =3D add_preferred_console(uart, 0, opts + strlen(uart) + 1);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-acpi_spcr-=
v4-1-f9a96fe016af@posteo.de?part=3D1
