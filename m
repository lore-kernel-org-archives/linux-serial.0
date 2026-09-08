Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383E82D5932
	for <linux-serial@vger.kernel.org>; Tue,  8 Sep 2026 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877789; cv=none; b=XL9qWI3UA5KHuuXd7q97+I1fpNNZq0P+N3/yQPaWXPL8rqzplnf95EJTql2uDUMV4Wh9VYS+zGPkxsnNofFLZilBHU/XEULRsTGNP9uFlGZEpIp5xy1vOlVmFZIdwP3rwijpsqcs4pe1q5+wwPTOpcx442ZNO3AMdSnINe+LcQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877789; c=relaxed/simple;
	bh=W4qIcXY5SCPf0xGkvlD47BBUS2OqiYWQ4+rcOhMjWvk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bIwYRF3PvBI9UALW7lMBeGGnJkEUatLssa8+aux1q9GfXvdlM2ABLu/2lGMIo6qo8vorqQfM9hIs2/r9sY/2EJVqEeVOyxXTpPhCUL+uT5j6P0VVxudrmnUTd/wvbS6o6qx+4UY2Y2+by8Cuc+Z4XX0ppsZuFEdmXR1gwK5C614=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FF31F00A3A;
	Tue,  8 Sep 2026 14:29:42 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] serial: 8250_dw: Prefer SRBR in bogus RX timeout
 workaround if available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yicong Yang" <yang.yicong@picoheart.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260908141524.20302-1-yang.yicong@picoheart.com>
References: <20260908141524.20302-1-yang.yicong@picoheart.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 14:29:37 +0000
Message-Id: <20260908142942.E4FF31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling pm_runtime_enable() after serial port registration leads t=
o circular dependencies and blocked tasks during device probe.
--

commit fbed7674eea9b0cab135230c5f02f518f9590574
Author: Yicong Yang <yang.yicong@picoheart.com>

serial: 8250_dw: Prefer SRBR in bogus RX timeout workaround if available

This commit updates the DesignWare 8250 UART driver to use the Shadow=20
Receive Buffer Register (SRBR) instead of the standard RBR for bogus=20
reads during RX timeouts. This avoids potential hardware errors on=20
platforms that do not support standard RBR reads in this state.

Link: https://lore.kernel.org/linux-serial/20260907074035.77796-1-yang.yico=
ng@picoheart.com/
Link: https://lore.kernel.org/linux-serial/20260629075510.32854-1-yang.yico=
ng@picoheart.com/

> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/=
8250_dw.c
> index 51d026f20825a..b8a0bca8b536f 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the changes=
=20
to this file, I noticed a pre-existing issue regarding runtime PM=20
initialization in the probe sequence.

Does dw8250_probe() register the serial port before enabling runtime PM?

When serial8250_register_8250_port() is called, it synchronously invokes
uart_add_one_port(). This can trigger the dw8250_do_pm() callback:

dw8250_do_pm() {
    if (!state)
        pm_runtime_get_sync(port->dev);
    ...
}

If this callback fires before pm_runtime_enable() is executed at the end=20
of dw8250_probe(), it will attempt to use runtime PM APIs on an=20
uninitialized device.

Could this circular dependency lead to blocked tasks and hung worker=20
threads during device probe?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908141524.2030=
2-1-yang.yicong@picoheart.com?part=3D1
