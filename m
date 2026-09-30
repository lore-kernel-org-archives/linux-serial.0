Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777F830D401
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790783122; cv=none; b=gClxzkUOz91sQSeOEyR7qhITOYkl96ZoamPxQyZ+anihUA/13ntQikidMInPwkYrAv3vhV+e9wrkuY0pq+r+cWWAf4JiXNeJ1oWMAay1YJc5NSzsiC0CjkW2/UL43tVMsQF75a3cHWxcPJeXd4XwmQS0plp0LeXf4Te2MjqXtDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790783122; c=relaxed/simple;
	bh=Aeebg/nP2NJ4DlsAVtFcGp1JBxuJjlZi39XoGLyuCx0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KoyVZ/jvjK4lXw9yXCtHvu+I40miKvuyUFXL5hjqZHOhQfRWwQM1l5Wr01G6lCXbcGZOYshBB8AojM544OaY8Uwq/lCG5biwKFXwNMccuot1JhQ/GEH+fJ74+0dJj95vst6dgTuNMeZjAYzDEtiVpX/wdUxJZurbhdAQJM/4fRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAL+nxjv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAL+nxjv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E6B1F00898;
	Wed, 30 Sep 2026 15:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790783117;
	bh=Dbt0/TVeKc4vJYVUYlVrvcK/EWtvFfuiMinVEYWTliQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JAL+nxjvd5J6HjvRfvTngv5atMtJsOllHOT0KjId6RXnObDKjvcyNIRb8b01DkAfY
	 HHYVZC7OzMvK01ziuDTaRZYg7/x612KPWAx4+EQUW+RYOad4XAtr2Fe72eIkvo+2oJ
	 rxkAaRbavYBSOLILmGCk/JQaxSNb7GUavPPkk4vyjgamH/kYxQsNNKKahWSMqCEjaC
	 N99zl5X8Zhmc1YY8rTD1V0qFkS1srZyNLSLmwo8qzkUDMevHCS/Q1/k+dLHe52TkAw
	 uKt0KZY5F8mA4qPOLiqJigggsj7zQV3CFldvE5dx1ihqOsNe3tny5oFh+gbdgXmseW
	 G2zlGdJ0LYUBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v4] ACPI: SPCR: Support UART clock frequency
 field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260930-acpi_spcr-v4-1-ab649aa1f09c@posteo.de>
References: <20260930-acpi_spcr-v4-1-ab649aa1f09c@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 15:45:17 +0000
Message-Id: <20260930154517.97E6B1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] acpi: out-of-bounds read of SPCR uart_clk_freq field
--

commit 541ea063ef44d64e511d2deae13a8adcab45ebc7
Author: Markus Probst <markus.probst@posteo.de>

ACPI: SPCR: Support UART clock frequency field

This commit adds support for the UART Clock Frequency field introduced in t=
he
Microsoft SPCR specification revision 1.08. It introduces a new function
setup_earlycon_with_uartclk() to configure the serial port with the correct
clock frequency from the SPCR table if available.

Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/s=
erial-port-console-redirection-table

> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index 73cb933fdc89b..c79c809f49d46 100644
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
Does this code risk an out-of-bounds memory read when accessing
table->uart_clk_freq?

In acpi_parse_spcr(), the table is mapped using acpi_get_table(), which
only maps the number of bytes specified by table->header.length.

If a malformed ACPI SPCR table is provided by system firmware where
table->header.revision >=3D 3 but the length is too small to contain
uart_clk_freq, could this access read past the mapped length?

This could result in unmapped memory accesses leading to an early boot kern=
el
panic, or silently reading garbage data which results in an incorrect early
console UART clock frequency.

Should there be a validation of table->header.length against the expected
size containing the uart_clk_freq field before accessing it?

> =20
>  	if (enable_console)
>  		err =3D add_preferred_console(uart, 0, opts + strlen(uart) + 1);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-acpi_spcr-=
v4-1-ab649aa1f09c@posteo.de?part=3D1
