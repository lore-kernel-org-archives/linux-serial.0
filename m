Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73763442B32
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186108; cv=none; b=hn0yYOvfB0y2cnxWlUJCNsEaljOEfnLfZ3j4o7gsL2ieRSJQS1WJcTzTIYI0SJPVAB5K1zOAbpA+823rG6mVBwi7sL4mBDKZfQZoIdmGbF0kM3KBte+PI31pA81ZVYZLZdsEopBcUCy+z8YyCSzxEvQYUhHL47KtTBjEjmqllHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186108; c=relaxed/simple;
	bh=VRA03Ppq4FNnfgLD4IxH7KUxeSrLLECddNX28rjQOBA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MEVzDnb2RuXjyq77CJrUUNYIb/hBoEAhQSI1JJTn2IjSLRCfTAuKMFFomCt3Ps9wkGVS4VUg0cxDqmKT8erBZSb+GtxSOInSY0IQfFG55n7G8d4d+ETcoMrvK3s2b0hdxPSrJqvTBseu60QiLn0HPPqcnkmkEFcNhepGpjbF5Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mxpf5XEf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mxpf5XEf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E332D1F000E9;
	Mon, 31 Aug 2026 14:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788186107;
	bh=LanlRvQEJE8qqBTMdvjvHdnrRaG7CEmWzWZytoXHu9k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mxpf5XEfotTjVnsPXLMXqYWCAxrczM0L0pIZ0QFW0I5GQPPKtxQ7avtNmEqSYKgSx
	 k6gDPQrzI85TC4DcP1aR/jZ0swirawpgsbHjfTo3hCuE44zGpbvUlfqIznGNLEPHZm
	 TuBm8NfX4xE/3LUizP+Le0WLX7VnIOS9y4aqRy2TOjvRkJQkMYVrVws2KGnBTlf/5N
	 dKOepi71rs42zyRBEuSRC4OSHJqAOzmvZ5ONNAxsW3/jId27Bf4FlUwenS9n4pIpzp
	 CfVAa9hJY/QW7ZR505XFr61O79HnVcBQ26Hf0Igaix/1GvTRrFh1TDth3giqFPUFWa
	 V/ss/EiV0SoUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] tty: serial: 8250: protect against NULL
 uart->port.dev in register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260831133314.4125787-77-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-77-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 14:21:46 +0000
Message-Id: <20260831142146.E332D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Skipping `mctrl_gpio_init()` and `uart_get_rs485_mode()` when `uar=
t->port.dev` is NULL exposes a Use-After-Free vulnerability due to dangling=
 pointers in the reused static port slot.

Pre-existing issues:
- [High] The patch adds a NULL check for `uart->port.dev` before `has_acpi_=
companion()`, but leaves an unprotected dereference in `pm_runtime_get_sync=
()` just a few lines down.
- [Medium] The runtime PM usage counter is leaked if `uart_add_one_port()` =
fails.
--

commit c7d8108ae7556bad9c5dd70639d77621e2028aef
Author: Stepan Ionichev <sozdayvek@gmail.com>

tty: serial: 8250: protect against NULL uart->port.dev in register

This commit adds a NULL check for uart->port.dev before calling
has_acpi_companion(). This prevents a kernel oops for legacy callers that
legitimately pass no parent device.

Link: https://patch.msgid.link/20260508181237.11146-1-sozdayvek@gmail.com

> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/825=
0/8250_core.c
> index bfa421ab32536..8c169756710b5 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -760,7 +760,7 @@ int serial8250_register_8250_port(const struct uart_8=
250_port *up)
>  	 * Only call mctrl_gpio_init(), if the device has no ACPI
>  	 * companion device
>  	 */
> -	if (!has_acpi_companion(uart->port.dev)) {
> +	if (uart->port.dev && !has_acpi_companion(uart->port.dev)) {

[Severity: High]
Does skipping this initialization leave dangling pointers if the slot was
previously used?

uart->gpios and the RS485 GPIOs are devres-managed memory tied to the port's
device. If a port is unregistered, serial8250_unregister_port() sets
uart->port.dev to NULL and the devm memory is freed, but the global
serial8250_ports array retains the dangling pointers.

If the slot is subsequently reused by a legacy caller without a device, this
patched code skips mctrl_gpio_init() and uart_get_rs485_mode() without
clearing the old pointers. When uart_add_one_port() is called,
serial8250_set_mctrl() will dereference the freed gpios pointer.

Before this patch, this use-after-free was unreachable because the
unconditional has_acpi_companion() check would oops first. By bypassing the
oops, this patch makes the use-after-free reachable.

[Severity: High]
This isn't a bug introduced by this patch, but does this leave an unprotect=
ed
dereference just a few lines further down?

If a legacy caller registers a port over an active console without a parent
device, which this patch intends to support, we reach this code:

	if (uart_console_registered(&uart->port))
		pm_runtime_get_sync(uart->port.dev);

Since __pm_runtime_resume() unconditionally dereferences dev->power
internally, would this crash on the NULL pointer when pm_runtime_get_sync()
is called?

[Severity: Medium]
This is a pre-existing issue, but does this code leak the runtime PM usage
counter if uart_add_one_port() fails?

If the port is registered as a console, pm_runtime_get_sync() increments the
PM usage counter. If the subsequent uart_add_one_port() call fails, the
function jumps to the error handler:

	if (uart_console_registered(&uart->port))
		pm_runtime_get_sync(uart->port.dev);

	...
	ret =3D uart_add_one_port(&serial8250_reg, &uart->port);
	if (ret)
		goto err;
	...

err:
	uart->port.dev =3D NULL;
	return ret;

Since pm_runtime_put_sync() is never called on this error path, does this
prevent the device from ever suspending?

>  		struct mctrl_gpios *gpios =3D mctrl_gpio_init(&uart->port, 0);
>  		if (IS_ERR(gpios)) {
>  			ret =3D PTR_ERR(gpios);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-77-sashal@kernel.org?part=3D1
