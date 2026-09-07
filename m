Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B5B2D8DD0
	for <linux-serial@vger.kernel.org>; Mon,  7 Sep 2026 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767398; cv=none; b=dtWNWRiMpmo0jQY0CtDd8QIfqNjRxn3qhj6gExJuekoK5ux164HG2+688JP0rCQqK8KiMrNPefNQHztzo7RhhpkbYIz4gb0z1Dx/P3TALtTy7W/mHoiBzHAnDfNNW6ZSK8MQSKEsIJYh3ZKWq7Si6N84hfm1+kfagYwLe/jBiMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767398; c=relaxed/simple;
	bh=KtyxtqNQA4rjI0weFILZJXCmzzlzWbJdk0Uth3L5BjI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IIrQEqLRI7gkssdMq94pDZ9QYIlA7GSA/WU07yrh5U62xMsM7x47bJFOiQ61BnDZ3Dl8DOCL04kYhIYR/aY3R39AenbIdX8qgDqYRKO5wmQdbgAhJSillntNQdx8riDfnAjLAI3KlVkM+Bm/k39GELhnQbafxrAiSB9VhzQdh+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WM1tafMN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WM1tafMN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C411F00A3A;
	Mon,  7 Sep 2026 07:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788767397;
	bh=2M32Or1vOvGfOIaQIYApBt8BuYxcFN3BIfjmwY532aI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WM1tafMNi+B2IR4MlH5JVfPbA1xKPtJ4B7/6Q7Bz1yEdncedRhoX9fWjRiPZmAVFd
	 w9FACOUUdikmruTN/WsNCnJDAc4qVuGm5dSQp+8o9qZeWDMBwgCYFv4O7/04cJC9GY
	 IcMIc3YzgZKMGmUGX699CYIeyyT+++szZZT5Eky31GY2FexWBG4aT38T/1mMfHbasV
	 yM+5RnaOD1w6wX52+cMXWec+itdh6q42vLPzmM1cDuQBf1rMGDN0bDGWBK7NFWgd6Z
	 7oFQhHGblC2lkIlhl82Oowu/qTLx87Lpj+PGkPGTvSONFY+CnlrqAVP5j7YnOWc8Xm
	 ZpjXSss+tVgJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: 8250_dw: Prefer SRBR in bogus RX timeout
 workaround if available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yicong Yang" <yang.yicong@picoheart.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260907074035.77796-1-yang.yicong@picoheart.com>
References: <20260907074035.77796-1-yang.yicong@picoheart.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 07:49:56 +0000
Message-Id: <20260907074957.16C411F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Runtime PM is enabled after UART port registration, causing circul=
ar dependencies and hung threads.
--

commit eaccc720cb53d60702a5d31bbe2439896bdfd1ce
Author: Yicong Yang <yang.yicong@picoheart.com>

serial: 8250_dw: Prefer SRBR in bogus RX timeout workaround if available

The DW uart can get into a state where a bogus RX timeout interrupt is
asserted without available data. The driver currently works around this by
doing a bogus read from the standard RBR, but this can cause hardware errors
on some platforms. This commit changes the driver to prefer reading from the
Shadow RBR (SRBR) if available, avoiding the error.

Link: https://lore.kernel.org/linux-serial/20260629075510.32854-1-yang.yico=
ng@picoheart.com/

> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/=
8250_dw.c
> index 51d026f20825a..b8a0bca8b536f 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but I noticed a potential circular dependency=
 in
the device probe sequence:

drivers/tty/serial/8250/8250_dw.c:dw8250_probe() {
    ...
	data->data.line =3D serial8250_register_8250_port(up);
	if (data->data.line < 0)
		return data->data.line;

	platform_set_drvdata(pdev, data);

	pm_runtime_enable(dev);
    ...
}

Does this ordering cause hung worker threads during device probe?

Calling serial8250_register_8250_port() invokes uart_add_one_port(), which
synchronously calls the pm() callback (dw8250_do_pm()) via uart_change_pm().
If the callback calls pm_runtime_get_sync() before runtime PM is enabled on
the device, the core will attempt operations on an uninitialized device,
leading to circular wait conditions.

Should pm_runtime_enable() be called before serial8250_register_8250_port()
to prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907074035.7779=
6-1-yang.yicong@picoheart.com?part=3D1
