Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685B748FF9C
	for <linux-serial@vger.kernel.org>; Thu,  8 Oct 2026 10:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453880; cv=none; b=VaNz0QO0MjsfcDPVwAHO3WiDbaa+MwgLLzsphFkqpD9CcfKW/TAnhaWcmvkiCD7pOikVSbI493ZdnqOXVDQ0RBaaGWzsGt42ZjhYllls3enjdjBbuf6iQHfbwAtao53UCiw/u3A1/S3O7+BtDb+aQmqS5SYQBGbqULU2Qo/61I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453880; c=relaxed/simple;
	bh=KUh5pKHD1n2XJ71HWbJmKEn3cwnttGdHRnSFiHwvIgs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=jbIzFa6D4ciJpMVWx3JBvwVD464vQTFLRvh0to3I53vPqwz4ayjDATJDLoVIWaR2JnI0zfWPSnbar0PIAdM+d+SoMOoN1ij/GlLpZacWy8n/ITHmvPDB5H4Kgp83t4Iipuux/VUZn6zjt9HhOoAmLdbfmXpOKSAAg0WE4qcWMXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgJ/EoO2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgJ/EoO2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A969B1F00893;
	Thu,  8 Oct 2026 10:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791453873;
	bh=+BS9CP8H8tX0Y2eYsdrpiYS8W1keO3rsFapVH0MT0mA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CgJ/EoO2qUiNrf7N4TYK/0Vang21Tk8U++uJ4vZ4UuLcjrWGWLstjU804ZJwf4kWq
	 tKhTFWGi+8euOvaNsQYXFP2NCgt1YaBz2v1THVqGn9GO+3IqnNWe3tUx9fh36pKw+a
	 vWX1uiL4n13rqZ3J9qIxkYogRr7HQqTy4g3I/Hn9vom9gFlEFEFb4LnmZGKYS94Zh+
	 L4vqAp7EGwOiI/AfanaZ6Cb5ZyvpQK1tIYine0nkW0cVuQUpmS1QIJir0jLrMM4J0+
	 W+QYeG+jZG8Wb2bCLJXZ4nIDjsF4wkRqnES5WUpUzZULmpHvCe5wQTeRA6PjjgwdUJ
	 Sna086G186FbQ==
Message-ID: <sashiko-outbox-163987@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 7/9] serial: max310x: schedule tx_work directly from
 the IRQ handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261008-max310x-rs485-sw-delay-v8-7-6ba881f81e1f@vaisala.com>
References: <20261008-max310x-rs485-sw-delay-v8-0-6ba881f81e1f@vaisala.com>
 <20261008-max310x-rs485-sw-delay-v8-7-6ba881f81e1f@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 10:04:33 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tty: max310x: Use-After-Free of workqueues in probe error path and=
 remove
--

commit 6bfa220718efcbb6292bc06e4e18a373318c9c1a
Author: Tapio Reijonen <tapio.reijonen@vaisala.com>

serial: max310x: schedule tx_work directly from the IRQ handler

This commit schedules tx_work directly from the IRQ handler instead of going
through start_tx(). This keeps the interrupt path as a pure FIFO refill in
preparation for a following patch.

> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 0c40283f44ba1..c1fe4ad887839 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -858,8 +858,12 @@ static irqreturn_t max310x_port_irq(struct max310x_p=
ort *s, int portno)
>  		}
>  		if (rxlen)
>  			max310x_handle_rx(port, rxlen);
> +		/*
> +		 * TXEMPTY latches on the FIFO becoming empty, so a stale
> +		 * interrupt cannot pump data during an RTS setup delay.
> +		 */
>  		if (ists & MAX310X_IRQ_TXEMPTY_BIT)
> -			max310x_start_tx(port);
> +			schedule_work(&s->p[portno].tx_work);
>  	} while (1);
> =20
>  	return res;

[Severity: High]
Does this code allow delayed works to outlive the driver's memory?

In max310x_remove(), works are cancelled before uart_remove_one_port():

drivers/tty/serial/max310x.c:max310x_remove() {
	for (i =3D 0; i < s->devtype->nr; i++) {
		cancel_work_sync(&s->p[i].tx_work);
		cancel_work_sync(&s->p[i].md_work);
		cancel_work_sync(&s->p[i].rs_work);

		if (test_and_clear_bit(s->p[i].port.line, max310x_lines))
			uart_remove_one_port(&max310x_uart, &s->p[i].port);
		...
	}
}

If the port is open, removing the port invokes a vhangup, dropping DTR/RTS =
via
uart_shutdown() -> uart_port_dtr_rts(0) -> max310x_set_mctrl().

This synchronously re-schedules md_work. Since it was already cancelled
earlier, it is left pending while max310x_remove() completes and devres
frees the max310x_port structure, resulting in a use-after-free.

Similarly, the probe error path completely fails to cancel works before dev=
res
frees the structure:

drivers/tty/serial/max310x.c:max310x_probe() {
...
out_uart:
	for (i =3D 0; i < devtype->nr; i++) {
		if (test_and_clear_bit(s->p[i].port.line, max310x_lines))
			uart_remove_one_port(&max310x_uart, &s->p[i].port);
	}
...
}

This means md_work and rs_work scheduled by uart_add_one_port() will execute
after devres cleanup on probe failures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-max310x-rs=
485-sw-delay-v8-0-6ba881f81e1f@vaisala.com?part=3D7
