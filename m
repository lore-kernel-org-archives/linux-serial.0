Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE973A900B
	for <linux-serial@vger.kernel.org>; Thu,  8 Oct 2026 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791479029; cv=none; b=JhCZPZfamrGZgwSD2xVRY75a4BzZ8RgKAnzTQ5o2xUDllDRw1rxRZHxVCqZUSGuBGLka2/iXB0g0K3uFntC+S2hosLIUKiSRjdQWF04bhsohtGejWFlRguQO2iN4DMh1ydXJ7QAtW7DCknBpkoPpEVsrBFFHRD6YbnzVICY+RWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791479029; c=relaxed/simple;
	bh=wK7ZbJA29oDnfPgP5sFCyrenR8iWdvsO2E5QHVlXAzk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=EelqL4ZUq00KD7QDuve+8kKk8bf3rK7nz1XuRtlTcNTxdGN8Degsdt7WbtuORpAaH9NCjdHMkK+GVUmN369+ukxNIwlOEw+Y4GQoA0x3U6O9mdb1sutBepC0DvQY9Rvx6k+b8XeC8FZyln/w9WBJw1st5/www5nQCNwUHIkpjho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IE+eJ833; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IE+eJ833"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D425C1F000FF;
	Thu,  8 Oct 2026 17:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791479028;
	bh=5/1WxbTtQA8t+rWPgChI9i5hKQZ+E/n2KavijsYut2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IE+eJ833u/YEZzxT5quLVi9Jv6nTt9JijwLsJNlesry90X1VEoRWrWEiRk5VDUIhp
	 Wqx/VNdYuaKxpi0eCxhVEgWYQyyEhk9CHyK+FAI/9QqsThpWU/4KKxO8TapGHZ0d4x
	 TPgRiMZBYEkSgX5c2cROo9nFRKjbiIzAFKCAxHOZITMhd7shI3sF5Rq4rlP5ygRRe3
	 xTvV2+0d18ZigLUZxYwP84pWqca5gEk778I118ijpZbVUd1KiG1BqCEE9ZByD1gsLL
	 VOj2zqd7lvLOb1tF9jHRpyBVvSdyhFbNM1HIhI9zuigHs3eMUPhsooKRhOPh7vEpiC
	 jmYdz+WFIAkiA==
Message-ID: <sashiko-outbox-164404@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: core: Shut down a running console port before
 removing it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Phil Rosenthal" <phil@phil.gs>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261008-serial-console-remove-v1-1-288b9c315af7@phil.gs>
References: <20261008-serial-console-remove-v1-1-288b9c315af7@phil.gs>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 17:03:47 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tty: memory leak of xmit_buf in serial_core_remove_one_port for =
suspended ports
--

commit e63d9623630a1955eeac809c4b0a62f8d1db0bfb
Author: Phil Rosenthal <phil@phil.gs>

serial: core: Shut down a running console port before removing it

This patch shuts down a console port if it is still running when being
removed, ensuring its resources are released. It does this by adding a
conditional call to uart_shutdown() in serial_core_remove_one_port().

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 319a4b427f3a3..104a2b2eec641 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3239,6 +3239,18 @@ static void serial_core_remove_one_port(struct uar=
t_driver *drv,
>  	if (uart_console(uport))
>  		unregister_console(uport->cons);
> =20
> +	/*
> +	 * A console port is not shut down on last close (see
> +	 * tty_port_shutdown()), and the hangup above only shuts down a port
> +	 * that has a tty attached. A console that was opened and closed is
> +	 * therefore still running here; shut it down before its resources are
> +	 * released.
> +	 */
> +	mutex_lock(&port->mutex);
> +	if (tty_port_initialized(port))
> +		uart_shutdown(NULL, state);

[Severity: Medium]
Does this code introduce a regression by leaking port->xmit_buf if the seri=
al
device is unbound while suspended?

If a console or normal serial port is suspended (e.g., via system or runtime
PM), uart_suspend_port() clears the initialized flag but leaves
port->xmit_buf allocated:

drivers/tty/serial/serial_core.c:uart_suspend_port() {
        ...
        if (tty_port_initialized(port)) {
                ...
                tty_port_set_suspended(port, true);
                tty_port_set_initialized(port, false);
                ...
}

If the device is then removed or its driver is unbound,
serial_core_remove_one_port() will evaluate tty_port_initialized(port) as
false and skip calling uart_shutdown().

Since uart_shutdown() is the only path in serial_core responsible for
unconditionally calling uart_free_xmit_buf(port) and
serial_base_port_shutdown(uport), skipping it appears to leak the
page-sized transmit buffer.

> +	mutex_unlock(&port->mutex);
> +
>  	/*
>  	 * Free the port IO and memory resources, if any.
>  	 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-serial-con=
sole-remove-v1-1-288b9c315af7@phil.gs?part=3D1
