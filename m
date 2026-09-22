Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773FB378D8D
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 01:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040687; cv=none; b=P0aWWDCWx8lLeWT94h9FY/l6Itub69b7gs2wwP5B1c7dvGDL9YHXiqwEYYhne2a8ie9G+cnY7SPBKWzv+Wb72cLjl5RKm01bfvIj964lti7OeOb+OBl5HAp8ciR2h5qclV+55ErePNAnaOjwoRTQg+zJeZtdL2cq4xb+2Bxliro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040687; c=relaxed/simple;
	bh=q68ECJU6KNp+9ZsWpzJJAeyKv52zxEsZKmUGnNw5PfY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h3m4PvKIBzDQriLlNvdKjIOjjkVH5k7NV86h5b2tWTUf1QZoIQE96s+Rbxg8WTdkcTo0zQPCLGszTzHgAdBQkvqzmbmXFHdzC0D2IMBTj+X7LbuKmuUyyYWbSqf5ziQHjo+KmipB4fBcUSoOsBMaDvs9WGGVlQVsvGyYTGSzGK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cuadl/YM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cuadl/YM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB6A1F000FF;
	Tue, 22 Sep 2026 01:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790040686;
	bh=psMd2VYbSa+KjWwhprbt7eD56477M06SIEy0g7Nuak8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cuadl/YMlC6yLBgmAokh5Dgol8HbjAPL/m92mSspxETXVnhtHxifmH6EEc7SgNQJv
	 HEr0GwBCtwYJ76wUyTupLdbi15d2/bI9b1/6tFigiA4REpDOMkWSBVitbdidin+Jhb
	 4FFqOzezbF5ne10PsAhmCdFlQkbo5ITkxooFNbp4Y2OtsGhRlbx+PxdDA8NeYuGrh+
	 6fqlOOsDPvgf+h0j4HQ4DOjJep8grigV6Ol0kpmLlaCn96oK5ZTlsjkx8p6EvA0TwL
	 yPTLCW6O2ZzHIOe01Sf6NjwC3AcxMRFUVc9nQibRSqFq3r9fI8DnVmdJ9q59kNT60T
	 2RLDeNw7PMxcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: xilinx_uartps: publish console_port with
 release semantics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jaidev Shastri" <jaidevshastri@vt.edu>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260921-mb-uartps-v1-1-9fc2f3d4b1a5@vt.edu>
References: <20260921-mb-uartps-v1-1-9fc2f3d4b1a5@vt.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 01:31:25 +0000
Message-Id: <20260922013125.EEB6A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] serial: xilinx_uartps: mixed plain and atomic accesses to consol=
e_port
--

commit 6429f77a5af6cf9c0baafae636fbc28eb10cbf3c
Author: Jaidev Shastri <jaidevshastri@vt.edu>
serial: xilinx_uartps: publish console_port with release semantics

cdns_uart_probe() assigns the first probed port to console_port with a plain
store once the port is set up, while cdns_uart_console_write() and
cdns_uart_console_setup() read it with plain loads. This commit stores it
with smp_store_release() and reads it with smp_load_acquire() to address
memory consistency issues.

> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xili=
nx_uartps.c
> index a072b75dbaf23..59e0d388d7c38 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c

[ ... ]

> @@ -1812,7 +1814,8 @@ static int cdns_uart_probe(struct platform_device *=
pdev)
>  	 */
>  	if (!console_port) {
        ^^^^

[Severity: Medium]
Does this plain read of console_port race with concurrent probes, violating=
 the
patch's stated goal of using acquire/release semantics?

>  		cdns_uart_console.index =3D id;
> -		console_port =3D port;
> +		/* Pairs with the smp_load_acquire() in the console callbacks. */
> +		smp_store_release(&console_port, port);
>  	}

Are there other plain accesses to console_port that were left unfixed and c=
ould
cause regressions by breaking the strict release/acquire semantics intended=
 by
this patch?

For example, further down in cdns_uart_probe():

	if (console_port =3D=3D port &&
	    !console_is_registered(cdns_uart_uart_driver.cons)) {
		console_port =3D NULL;
		cdns_uart_console.index =3D -1;
	}

And in cdns_uart_remove():

	if (console_port =3D=3D port)
		console_port =3D NULL;

Could these plain stores and reads race with smp_load_acquire() in the cons=
ole
callbacks, violating the Linux Kernel Memory Model?

Mixing atomic barrier operations with plain C accesses can lead to data rac=
es
or compiler optimizations breaking strict memory ordering. This might happen
during concurrent asynchronous device probes or removals interacting with
console callbacks reading the global state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-mb-uartps-=
v1-1-9fc2f3d4b1a5@vt.edu?part=3D1
