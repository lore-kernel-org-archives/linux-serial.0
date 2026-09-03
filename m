Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F95B36F421
	for <linux-serial@vger.kernel.org>; Thu,  3 Sep 2026 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453933; cv=none; b=mibaO7YGItJ6JB1jY9m4AM/wMH6g+4d83PlbgUIDM/nEwQiD64GvatCsC4piZvj6sxwsI3uxS9Mm9OWmxjfv21voCJ+UecbzeV8lRxkINP/LRVmkiJs+tS2ze3MEVouRFAi0D0IREZwZGLwrjk5lmuY0+XfT78kFS8jh0j9S78g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453933; c=relaxed/simple;
	bh=YvYec/NX7njIF8eZEzZs1Z6UPu8kvTzBbppEEOm4PQQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cbTRJkyRQCCrmp5qbBjzzgHu5mQgu8xFRYcDf6Ikd5a1U2SPr3pevhtgc9RrKlt8a1r2j3T4oaCwmNwWHfSL1cygxRFlmI0Zc58R86pWKlekUzvzXiWZOFC2T32rVGGT5PiYE/hKTAsVMDTY3hXN0mtB9J4Pf+QiDlhH41fRd5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+ouBwNQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+ouBwNQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6FB1F000E9;
	Thu,  3 Sep 2026 16:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788453932;
	bh=WmMalUXWVlqtqL79TK6yIJNnHo/UORUtpkAIoi3hYPk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m+ouBwNQ2pl/xuqWAkIBnSv6wa36qUyQKEI2d7PX5olOU2TmutW/doprfxbDTpnH+
	 8SDE03+bp9VUS/nnS6JgWBSquqX9XYRKghfEALKjh508QIOrPHcfyehzhSwbXRH3UV
	 QDMmXRUSCqLMYYUCoqhqQVNFPAK3twtynHSvu/zKJBpins4ONshQdlnRMKJZguzLhY
	 5H+WBow1bl7pXpfpLHiApVItVNkJpeAb6egMK4fCQXvnl23gKsFxK53RWeFbYhRS/V
	 471b0q3oxPmqt+rrVrUBMrEHmjoMAh8OANN/xpfuonY16nak6LrP4hnnZBMzfCHwWB
	 F6GAIDnMhWalg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: fix ioctl hangup race
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johan Hovold" <johan@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260903163439.1499055-1-johan@kernel.org>
References: <20260903163439.1499055-1-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 16:45:31 +0000
Message-Id: <20260903164532.0B6FB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Using a `break` statement inside `scoped_guard()` incorrectly exit=
s the macro's internal loop instead of the intended outer `for (;;)` loop, =
leading to an infinite wait or severe latency.

Pre-existing issues:
- [High] The TIOCMIWAIT ioctl is still vulnerable to the hangup race becaus=
e `uart_wait_modem_status()` accesses hardware registers via `uart_enable_m=
s()`, despite the commit message claiming otherwise.
--

commit cc61eb3f9ab972ab6ba3e89cd9d7a45856a37c6c
Author: Johan Hovold <johan@kernel.org>

serial: fix ioctl hangup race

This patch attempts to prevent tty ioctls from racing with hangup by
checking if the port has been hung up before accessing the hardware. It
adds missing checks for tty_io_error() across several ioctl paths.

Link: https://lore.kernel.org/r/20260903163146.1498497-1-johan@kernel.org

> serial: fix ioctl hangup race
>
> The tty ioctls can race with hangup and end up calling into a tty
> driver for a device that is already gone or powered down.
>
> Add the missing checks to make sure the port has not been hung up before
> accessing the hardware to avoid issues like kernel panic due to
> unclocked accesses.
>
> Note that TIOCGSERIAL, TIOCGICOUNT and TIOCMIWAIT do not access hardware
> and are therefore not affected by the race.

[Severity: High]
This is a pre-existing issue, but does TIOCMIWAIT actually avoid hardware
access?

If a userspace process calls the TIOCMIWAIT ioctl, it routes through
uart_ioctl() to uart_wait_modem_status(). In uart_wait_modem_status(), we
directly call uart_enable_ms(), which invokes the enable_ms() hardware
callback to write to registers.

If a concurrent hangup powers down the port before uart_enable_ms()
executes, could this lead to an unclocked hardware access on a
powered-down port?

[ ... ]

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 95774b0f1484b..aac12be4ceac6 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c

[ ... ]

> @@ -1798,7 +1798,11 @@ static void uart_wait_until_sent(struct tty_struct=
 *tty, int timeout)
>  	 * 'timeout' / 'expire' give us the maximum amount of time
>  	 * we wait.
>  	 */
> -	while (!port->ops->tx_empty(port)) {
> +	for (;;) {
> +		scoped_guard(mutex, &state->port.mutex) {
> +			if (tty_io_error(tty) || port->ops->tx_empty(port))
> +				break;

[Severity: High]
Does this break statement exit the intended outer loop?

Since scoped_guard() is implemented as a hidden for loop in
include/linux/cleanup.h, the break statement will only exit the
scoped_guard macro's internal loop. The outer for (;;) loop in
uart_wait_until_sent() will continue executing and unconditionally sleep
via msleep_interruptible().

If timeout is 0, won't this result in an infinite wait loop unless a
signal is pending?

> +		}
>  		msleep_interruptible(jiffies_to_msecs(char_time));
>  		if (signal_pending(current))
>  			break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903163439.1499=
055-1-johan@kernel.org?part=3D1
