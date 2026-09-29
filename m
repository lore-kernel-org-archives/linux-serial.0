Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457F74FC8FA
	for <linux-serial@vger.kernel.org>; Tue, 29 Sep 2026 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675796; cv=none; b=jZ21vB8qLGmzA6jR/SZbbiuX3H8UeFcYsTjD0t6rfAc/aBX+ezLmORsyK15cV7vTDjwXAOj0/D0M+nqazQA0wWZmTB2oao25HNRn4YYpVkOJEdh5Xu/WuQwPGBkmL007p1R78jUq+xhZC3afqRRSA2ICXXB34Mf1SnwSr9NZweA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675796; c=relaxed/simple;
	bh=gGLyGMKwhYwFqsdfbZ1Je1C+dTHkf4XOuWm/Tkhgus8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RTeAW3xE73pjHOnN0VqbAgQYhI2IT/uO8nhqWdEEsxc6VXiRYFauXb4ciqa6gHf7hZkAWQogvfAWdo61Aq3YT2CH8960PnI8CD33ZAhIDccDLA1/x0eyG7rQIVQiy/14OzIW2Hbk/SSA0EV08+p903kPhdEHYV9gV/WXvsNaBO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKmQp4Wi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKmQp4Wi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E291F000FF;
	Tue, 29 Sep 2026 09:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790675791;
	bh=ROkyl/iDw7sdDbpkwJ6HcMBhChdM/I7YMEY1hSiyFFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RKmQp4WizUyWFVVNFGDAjYY4wlbnqbuuGNSqvuszv7lUsnvHA+UdjYOAvPL/9IXEm
	 85VEMxqB6i2NqZQFKei72rTkvqiJPcsueW17oxHkHdV33ERJXCJzkpVI2752EwZPMX
	 B9feydqwE/9OD/l0vjHM2qCd2BrKnCLuwpasD52/JBn5Hnf/KVv9R/NPzkVjM5pvqL
	 nw2N0Rf/WZJGyAi46mUhj907pukgeKFQavk9xdK4M6KEUAKsZ8MRd8qaZJ/pdS9A5Y
	 BmHjzMsgAZBAh1AF6D5YoEacDH1rYPHoCSdpxKVkTwLp92TqWrhKbMiLzKPbOj5DVb
	 Pjq3aQoIC1hCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/8] serial: max310x: support active-low RTS on the
 hardware path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260929-max310x-rs485-sw-delay-v5-5-ae46afa583f2@vaisala.com>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
 <20260929-max310x-rs485-sw-delay-v5-5-ae46afa583f2@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 09:56:31 +0000
Message-Id: <20260929095631.C2E291F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] tty: max310x: RS485 disable during active break leaks manual RTS a=
ssertion
- [High] tty: max310x: closing port during break leaves RTS permanently ass=
erted
--

commit b82804e84b25e0e908ec331792a65b1ae30210a0
Author: Tapio Reijonen <tapio.reijonen@vaisala.com>

serial: max310x: support active-low RTS on the hardware path

The chip's auto-RTS engine asserts the RTS_ pin high while data is
shifting out, so a transceiver with an active-low driver-enable could
not use the hardware RS485 path at all: SER_RS485_RTS_AFTER_SEND is
not in the supported flags and the core normalizes it away with
"invalid RTS setting, using RTS_ON_SEND instead".

The output stage is invertible: program IRDA.RTSINVERT when the
requested polarity is active-low and advertise SER_RS485_RTS_AFTER_SEND
in rs485_supported. A break already drives break_state onto the RTS
bit unadjusted, which remains correct because RTSINVERT inverts the
output stage itself, not the register value.

> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index cd3b1913aaadb..e07fb87f21f10 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
[ ... ]
> @@ -999,7 +1008,9 @@ static void max310x_break_ctl(struct uart_port *port=
, int break_state)
>  	 * The chip's auto-RTS asserts the transceiver only while FIFO data is
>  	 * shifting out, and a break is not FIFO data. Disable auto-RTS for the
>  	 * break duration and drive RTS manually so the break reaches the wire;
> -	 * restore auto-RTS when the break ends.
> +	 * restore auto-RTS when the break ends. For an active-low RTS,
> +	 * IRDA.RTSINVERT already inverts the RTS_ output stage, so break_state
> +	 * is driven as it is.
>  	 */
>  	if (break_state) {
>  		max310x_port_update(port, MAX310X_MODE1_REG,

[Severity: High]
Does this code leak the manual RTS assertion if RS-485 is disabled during an
active break?

If a user initiates a break (ioctl(TIOCSBRK)), max310x_break_ctl(1) execute=
s,
setting one->tx_break =3D 1 and asserting the manual RTS bit. If the user t=
hen
disables RS-485 (ioctl(TIOCSRS485)), the configuration update is deferred.

When the user clears the break (ioctl(TIOCCBRK)), max310x_break_ctl() will
hit its early return:

drivers/tty/serial/max310x.c:max310x_break_ctl() {
...
	if (!(port->rs485.flags & SER_RS485_ENABLED))
		return;
...
}

Will max310x_break_ctl(0) skip releasing the manual RTS bit and fail to app=
ly
the deferred RS-485 configurations, locking the RS-485 bus?

[Severity: High]
Can closing the port during a break leave the RTS permanently asserted in
subsequent sessions?

If an application starts a break with RS-485 enabled, max310x_break_ctl(1)
enables the manual RTS bit (MAX310X_LCR_RTS_BIT). If the application closes
the port without clearing the break, max310x_shutdown() powers down the chip
but does not clear its registers.=20

When reopened, max310x_startup() handles the latched break:

drivers/tty/serial/max310x.c:max310x_startup() {
...
	one->tx_break =3D false;
	max310x_port_update(port, MAX310X_LCR_REG, MAX310X_LCR_TXBREAK_BIT, 0);
...
}

Since this clears the TXBREAK bit but neglects to clear the manual RTS bit
(MAX310X_LCR_RTS_BIT), and the hardware auto-RTS path in
max310x_set_rts_ctl_params() does not clear it either, will the transceiver
remain continuously asserted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-max310x-rs=
485-sw-delay-v5-0-ae46afa583f2@vaisala.com?part=3D5
