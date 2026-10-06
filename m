Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033B02D060D;
	Tue,  6 Oct 2026 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791311264; cv=none; b=CiGuLqu9+wgLEmMpJc62wZFzHAksr0HgBg/K2TgGQu2NcdDFg92WMujVsschbWYJVMod4ibBif6yvad/7UlgIRF2q3P+XedU5lfETJLythFcNHJm+i6BUL8TcNfTV0cddE7z1lY4f5HaTBqNX+jA9TZTn5gIKjuew1WDb9t4g7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791311264; c=relaxed/simple;
	bh=eb0JxMahiQW40XPiWR0rkHKpbVD9ul6sLG9NMegN5UQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=n5kPZmKP+zC6En/rYouY68u4KdrpeBmV+lOD1e+asU+VjUBMiUX1PlE5rlrTuIzFdkr4SSWQ/9YFml+dh8hYiLPdM0GxIB4jVNUSbank8vNd/jx37vMdAC00jFDmwK/It0Kz8SuOMAlpRsgG4n4o80EMJmizrjH2oBUcI8PMYDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vr+aAhEp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vr+aAhEp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDB41F0089B;
	Tue,  6 Oct 2026 18:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791311262;
	bh=mUxAqKVlEpI/5RZpt374KPo/BMSmIvJ1JmnTmCXImy8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vr+aAhEpocR7hPUCQm+twtRdjBweaaodGfQe013ExojIYaTuRsYMdoHGUI5lkCPuC
	 YewHzOn5VdSmbkKeTuxnN/eXRYQoZS7rpm6KYItUfm7gWGl2B6lTvkCEqYyTS6nRlv
	 miVRuN+SEURxXsCtbeXy2QppFJf2OMBCDke30BvjFMbntPHulICUINgtGQM/XRCWKu
	 KSV1O47rod87XTygOZwful+y8sJsoY7pzvxpGgHA9quir4kK+fIWqmoBDoIg1arWKu
	 euKuzVs99jrrTYQ8Hs/OI7dOIMgb76bRgTSzBtSKf4xNfzkh3mYdzt6k8GMfK0hmUt
	 pBqITWwOEkJuA==
Message-ID: <sashiko-outbox-162340@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 07/10] tty: serial: Add Cortina UART driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20261006-b4-cs75xx-v2-7-b7d6e1e24d44@gmail.com>
References: <20261006-b4-cs75xx-v2-0-b7d6e1e24d44@gmail.com>
 <20261006-b4-cs75xx-v2-7-b7d6e1e24d44@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 18:27:41 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tty: serial: use-after-free due to __init on console setup
--

commit f274bba502abaeb866daa29a51921a3960bdaaa5
Author: Fil Dunsky <filipp.dunsky@gmail.com>

tty: serial: Add Cortina UART driver

This commit adds a driver for the UART found in Cortina SoCs. It supports
the system console and earlycon, using the current serial core API and devm
resource management.

> diff --git a/drivers/tty/serial/cortina-uart.c b/drivers/tty/serial/corti=
na-uart.c
> new file mode 100644
> index 0000000000000..1952629de0522
> --- /dev/null
> +++ b/drivers/tty/serial/cortina-uart.c
> @@ -0,0 +1,583 @@

[ ... ]

> +static int __init cortina_uart_console_setup(struct console *co, char *o=
ptions)
> +{
> +	struct cortina_uart_port *up;

[Severity: High]
Is it safe to mark this function with __init?

Since cortina_uart_probe() uses devm_clk_get_enabled() which can return
-EPROBE_DEFER, the platform device might probe long after the boot process
has finished and the .init.text section has been freed.

During a post-boot probe, uart_add_one_port() invokes register_console(),
which unconditionally calls the console's .setup callback. If
cortina_uart_console_setup() is marked as __init, jumping to it at this
point would cause a kernel panic due to executing freed memory.

[ ... ]

> +static int cortina_uart_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;

[ ... ]

> +	up->clk =3D devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(up->clk))
> +		return dev_err_probe(dev, PTR_ERR(up->clk), "failed to get clock\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-b4-cs75xx-=
v2-0-b7d6e1e24d44@gmail.com?part=3D7
