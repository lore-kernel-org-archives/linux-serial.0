Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C68834D93C
	for <linux-serial@vger.kernel.org>; Sat,  3 Oct 2026 17:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791050195; cv=none; b=QQEwzNnmqMCQPwXwhBp7m+nxar85zlhpsl9fuQtwZjj8WgfrhJIcLh4IuSAdADmAykiKPl63Wtn73BgCkdBSCcTEOnUGPRqcO0nyD7GvUnQuQIJG8B5fbhLbxFYZRY9GgUczPEuHv1XRfIM3seyQnputviNbQ4Yd6w118e3nfpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791050195; c=relaxed/simple;
	bh=WhWPJcX4oZtks3PCQb9UMUdrscQfS/SMC/Ri3SRhfqI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pqVb17DDIS5rRx/+p/9R7a76rphG5nuw5ID6qek15+1OqF+DfpMu9x3aEAmdBCIDoBQ289CeWgwqD7EHhxcKFowUFvSLLsgg82vzdBXRaW6CL+qdoG3/MzYTCuKVpnK6xktmdgigcyZgWYgqD3chqB1rh35HftyYwmLWFljNtiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HN/C2T2u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HN/C2T2u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0710A1F0089B;
	Sat,  3 Oct 2026 17:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791050194;
	bh=7wUNJTjtiJFEB8cN8ONA6ZeQ2zjfyvOEwKLenqNmE+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HN/C2T2u4OpehqX1ZY7TTCeIG632GiREPEAO6ATPt06lsHRsVc2dDgmX9713FsujI
	 vFZJLCCjFCP87gX94wvLG6SXoEDcsfOL+RgUH+RL+aJAKfLBNJsan22cJqT1b5I34I
	 Uguzotnw04U57o837YsD9C099SMrIw9vQhQytXXvWt3irBgjMx1PpDgwNd2c5aAz4J
	 FjDQrVBqGNkPo6P0W8TTItVRVad1AwK4VaESuPCQnhvwkGP2L1SCyRgtvDtXIw0tmR
	 eJFcW8vH5vNmz55JWpXR1jcFBOZI0WBtlTeV7tsvoLKbyceIq2MniYtXxRL8gAYpWd
	 gGuGQiN7gBdjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: core: shut down initialized port on removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Putko" <igorpetindev@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261003163337.45577-1-igorpetindev@gmail.com>
References: <20260924192224.3175-1-igorpetindev@gmail.com>
 <20261003163337.45577-1-igorpetindev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:56:33 +0000
Message-Id: <20261003175634.0710A1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] serial: PM state leak in serial_core_remove_one_port() due to mi=
ssed uart_change_pm()
--

commit 9122ece37c80d138a14cda352b9aec7db9935327
Author: Igor Putko <igorpetindev@gmail.com>

serial: core: shut down initialized port on removal

This commit clears port->console under the port mutex and explicitly calls
uart_shutdown() if the port is initialized during removal. It aims to fix a
use-after-free by ensuring the port is shut down and its IRQ freed when
unbinding a device that was previously used as a console.

Closes: https://syzkaller.appspot.com/bug?extid=3D843bf2f48f4d12e6682e
Reported-by: syzbot+843bf2f48f4d12e6682e@syzkaller.appspotmail.com

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 319a4b427f3a3..05450529871e0 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c

[ ... ]

> @@ -3239,6 +3239,13 @@ static void serial_core_remove_one_port(struct uar=
t_driver *drv,
>  	if (uart_console(uport))
>  		unregister_console(uport->cons);
> =20
> +	scoped_guard(mutex, &port->mutex) {
> +		port->console =3D false;
> +
> +		if (tty_port_initialized(port))
> +			uart_shutdown(NULL, state);

[Severity: Medium]
Does calling uart_shutdown() directly here skip the complete TTY port
shutdown sequence?

When unbinding a serial device that was previously opened and closed as a
console, uart_shutdown() only executes a partial teardown. It skips
uport->ops->stop_rx() and transitioning the PM state to OFF, which normally
happen in uart_tty_port_shutdown():

drivers/tty/serial/serial_core.c:uart_tty_port_shutdown() {
        ...
        scoped_guard(uart_port_lock_irq, uport)
                uport->ops->stop_rx(uport);

        serial_base_port_shutdown(uport);
        uart_port_shutdown(port);
        ...
        uart_change_pm(state, UART_PM_STATE_OFF);
}

Could this leave the device in an active power state (UART_PM_STATE_ON)
indefinitely or leave the hardware receiving data and interrupts? Calling
tty_port_shutdown_locked() would execute the complete sequence.

> +	}
> +
>  	/*
>  	 * Free the port IO and memory resources, if any.
>  	 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003163337.4557=
7-1-igorpetindev@gmail.com?part=3D1
