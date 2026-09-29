Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871A539A04D
	for <linux-serial@vger.kernel.org>; Tue, 29 Sep 2026 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675767; cv=none; b=Als9TcVjfC8Lvi0z8zm76U//ShCHDv3ESHcavvl6W3U2wCQOxRzOswInw2B6wNGLOwy+pEqA82mSYampBCwCdBleHQoYKgoTmckJYGloix0NP3ggQntXnNfO7jGAeWNf1urAdwVcaEHiVrHoH4P2DYuKZvYH3I0rbFI1D4bDd00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675767; c=relaxed/simple;
	bh=VOKGMuUYC8lSoiNZgECXnSKCkU759YNDyTYfi4EWf1Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lbQcmhLDLLFQ4JfvE3KQwCbH3lcIgY+bt5Z/ITK4ZtFW8lwb+37FnBz+NPMICKe9fumifL3sfNdJelGsjdNkWo/XZ1ISY9ZxpsE9fGp/VdHY79FLbI6Tb27pB7rvfad9yNrPxENGJCxCLOirCsC6a3jaEcFNhvcl3gSmfD6GESQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXd4RQ8d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXd4RQ8d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208611F0089A;
	Tue, 29 Sep 2026 09:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790675766;
	bh=vEuQFPcnwfNbNuPB3Z++CeiAQZPIe6TU5Cs4u82xQTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dXd4RQ8dPEr1a3A0kHAmKCCKkQbPMokqoTzyKOlYgfXZp/svyZtXLod/luUefxo4a
	 NYCR6IloakpYNof2IRUWsZNulgVo5bNqOGk33XMeYZ3e5Z8StyETRfgQFHPxesqtfV
	 fWd/tFFusYJ8DsmgMeIo8E5Tf04QVP91OcDQ/QJI4FDCYP71T6y41dlP/mFkZlG8MJ
	 6LQBZGHDqb6VgKdMq5MIzwfhZlIkHlkbLw+Qc18hZsDx+jtRmkqFMCiU/4co8wGAT8
	 JBB7ZOk1NRYY5UPxoWFmY8MxI5HlthuK7CLe5PuoGZOeHencRkOHNR6DtVzWtW3w6P
	 end6t/y2p2dLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/8] serial: max310x: assert the transceiver during a
 break
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260929-max310x-rs485-sw-delay-v5-2-ae46afa583f2@vaisala.com>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
 <20260929-max310x-rs485-sw-delay-v5-2-ae46afa583f2@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 09:56:05 +0000
Message-Id: <20260929095606.208611F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] serial: max310x: leaked RTS assertion if RS485 disabled mid-break
--

commit 7c2477330220cb7f9d2f88a0c967029ae3d062d8
Author: Tapio Reijonen <tapio.reijonen@vaisala.com>
serial: max310x: assert the transceiver during a break

This commit manually asserts the RTS bit during a break on RS485 ports,
as the auto-RTS mode does not assert it for non-FIFO data. It disables=20
auto-RTS for the break duration, tracking the break status in a variable=20
so the transceiver is restored when the break ends.

> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 4c1e10e0765f4..693decd04de10 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
[ ... ]
> @@ -929,9 +936,27 @@ static void max310x_set_mctrl(struct uart_port *port=
, unsigned int mctrl)
> =20
>  static void max310x_break_ctl(struct uart_port *port, int break_state)
>  {
> +	struct max310x_one *one =3D to_max310x_port(port);
> +
> +	one->tx_break =3D break_state;
> +
>  	max310x_port_update(port, MAX310X_LCR_REG,
>  			    MAX310X_LCR_TXBREAK_BIT,
>  			    break_state ? MAX310X_LCR_TXBREAK_BIT : 0);
> +
> +	if (!(port->rs485.flags & SER_RS485_ENABLED))
> +		return;

[Severity: High]
If a userspace application starts a break (TIOCSBRK), and then disables
RS-485 (TIOCSRS485) before ending the break (TIOCCBRK), won't this early
return bypass the restoration of the RTS bit? Could this leak the manual RTS
assertion and leave the transceiver permanently driving the bus, causing
collisions?

> +
> +	/*
> +	 * The chip's auto-RTS asserts the transceiver only while FIFO data is
> +	 * shifting out, and a break is not FIFO data. Disable auto-RTS for the
> +	 * break duration and drive RTS manually so the break reaches the wire;
> +	 * restore auto-RTS when the break ends.
> +	 */
> +	max310x_port_update(port, MAX310X_MODE1_REG,
> +			    MAX310X_MODE1_TRNSCVCTRL_BIT,
> +			    break_state ? 0 : MAX310X_MODE1_TRNSCVCTRL_BIT);
> +	max310x_rts_ctl(port, break_state);
>  }
[ ... ]
> @@ -1055,6 +1080,13 @@ static void max310x_rs_proc(struct work_struct *ws)
>  	struct max310x_one *one =3D container_of(ws, struct max310x_one, rs_wor=
k);
>  	unsigned int delay, mode1 =3D 0, mode2 =3D 0;
> =20
[ ... ]
> -	max310x_port_update(&one->port, MAX310X_MODE1_REG,
> -			MAX310X_MODE1_TRNSCVCTRL_BIT, mode1);
> +	/*
> +	 * A break owns the transceiver: break_ctl() disabled auto-RTS and
> +	 * drives RTS manually, and restores it when the break ends. Leave
> +	 * MODE1 alone meanwhile or the break goes undriven mid-way.
> +	 */
> +	if (!one->tx_break)
> +		max310x_port_update(&one->port, MAX310X_MODE1_REG,
> +				    MAX310X_MODE1_TRNSCVCTRL_BIT, mode1);

[Severity: High]
If the RS-485 state is changed mid-break, skipping this MODE1 update here=20
means the transceiver might be left in the wrong state once the break
finishes. Should this new configuration be deferred or tracked so it can
be correctly applied when the break ends?

>  	max310x_port_update(&one->port, MAX310X_MODE2_REG,
>  			MAX310X_MODE2_ECHOSUPR_BIT, mode2);
>  }
> @@ -1090,6 +1128,7 @@ static int max310x_rs485_config(struct uart_port *p=
ort, struct ktermios *termios
> =20
>  static int max310x_startup(struct uart_port *port)
>  {
> +	struct max310x_one *one =3D to_max310x_port(port);
>  	unsigned int val;
> =20
>  	max310x_power(port, 1);
> @@ -1099,6 +1138,7 @@ static int max310x_startup(struct uart_port *port)
>  	 * closed with a break still asserted, and set_termios() no longer
>  	 * rewrites it.
>  	 */
> +	one->tx_break =3D false;
>  	max310x_port_update(port, MAX310X_LCR_REG, MAX310X_LCR_TXBREAK_BIT, 0);

[Severity: High]
While max310x_startup() correctly clears the latched TXBREAK bit here, does
it also need to clear the LCR_RTS_BIT? If a port is closed with an active
break, wouldn't the manual RTS assertion from max310x_break_ctl() remain
leaked on the next open?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-max310x-rs=
485-sw-delay-v5-0-ae46afa583f2@vaisala.com?part=3D2
