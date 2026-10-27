Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793134225;
	b=5tjfx/sc5IXKxokWENW81d9gP9WDEp6ULNurDE0K6p9nrgHqEp8D4aEcBx/28dkQn1Xr
	 q5ghPIMWKrcyzKT4nHsWs7PqxCcdCw3JxDY5bN//IDFwiVUdEb2l10+2eCXOwxKRd2IZI
	 kIBPx1jB0Fsr/gn/Fo+X48ZGfVf4OZ005KLab4UKkcNzpXKJSRZixf+KHE/2df/+jOPvH
	 bJGkBwrqNKg0VTj6wl8vR/nbjpuZWftypkrjZHe6fTHIajnz84GNQ5clC8luHpR+XePFO
	 PE0jzEouBmLcDvmisFx6pvZ4lLLvyY1AW8cE9VgFGUG8618yuoNNlefJO6bQJVgolwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793134225;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YH5RRD8j15nMtz0K3zJT2tNGN5ccwjSfz/vr8VVrF78=;
	b=VKtWcajqy6S4zCyb5JtDCXD3CoVfBU/eFoUBLnQCsv91ER0oSLrslBpfLYOq961iFIqu
	 l16sTNXltcMcvhEY1B28/hOxP/tg61qrJ9+LvuvjL1GNSWhBtApyqLMuLTOENlNhmxd/b
	 VOreLUs6ZT4yB4WEZtcK2u/xk6Y6hvaY1rsFMtwJ1xhXRjhep8ZcLJlOr6VyLDjNnJotR
	 hbDOoHOYyiUDCxVtIVeOrygRykhTBzVR+QNuFiRfClBlYazW84WImZouRWnuVJyTgtcs5
	 vc9FsFl75wdOqXl3G05B9D+PT+QiBbW7IeddXPNypx08S3Cn3YHXoruF3P8IJShQGgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KxfXrAUC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EDD606A31E
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 20:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KxfXrAUC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF3E1F01825;
	Tue, 27 Oct 2026 20:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793134224;
	bh=YH5RRD8j15nMtz0K3zJT2tNGN5ccwjSfz/vr8VVrF78=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KxfXrAUCUXUI6cqSc4Vnz0IL/++Ml+2fnxFKS58V4PdTgJzXEVB7FQyyO5qglgUzK
	 6j0grfnFjHzyurMjFfk7tT1mzxwwyiisdq+exLY00x2mEGI/4pPR39JKjwEPTSinWa
	 8Y4INTxR0DJ5aIcdrcsbSCfsO/Q2avpj7/F6aa5dXGncJS1IXqhdIIhJ6GZhEsDxkp
	 LFNWW4kTDKa+HKVvzgLdRPx/a+ZGAI4vGLGsF/BCDFZwMNuO6RT78jTpMKBKsqxFvY
	 j5ENKGfxv3ZcmHgXrbWAqhBPmjIdwZwj5o+50tr0XWnh1O/+XsyWfC8omrD1aYEWRH
	 kYrpDDgbP1gsQ==
Message-ID: <sashiko-outbox-187100@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: qcom-geni: Set the serial engine up again after
 hibernation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Birk Skyum" <birk.skyum@pm.me>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027203136.95971-1-birk.skyum@pm.me>
References: <20261027203136.95971-1-birk.skyum@pm.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 20:50:24 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] serial: qcom-geni: unsafe console re-setup in qcom_geni_serial_res=
tore()
--

commit 987848026d2292ba1e5b2bfaa3e913a58fce2b92
Author: Birk Skyum <birk.skyum@pm.me>

serial: qcom-geni: Set the serial engine up again after hibernation

This commit adds a hibernation restore callback that clears port->setup
before calling qcom_geni_serial_resume() so that the serial engine is
re-initialized when the port starts up after a hibernation power cycle.

> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index bfdc155c128da..4e5b0e2473aa2 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -2131,6 +2131,20 @@ static int qcom_geni_serial_resume(struct device *=
dev)
>  	return ret;
>  }
> =20
> +/*
> + * A hibernation image is restored after a power cycle, which reset the =
serial
> + * engine. The kernel that loaded the image only set up the engines it u=
sed
> + * itself, so set this one up again when the port starts.
> + */
> +static int qcom_geni_serial_restore(struct device *dev)
> +{
> +	struct qcom_geni_serial_port *port =3D dev_get_drvdata(dev);
> +
> +	port->setup =3D false;
> +
> +	return qcom_geni_serial_resume(dev);
> +}

[Severity: High]
Can clearing port->setup here and deferring qcom_geni_serial_port_setup() to
qcom_geni_serial_startup() cause ordering and concurrency issues for console
ports during hibernation restore?

When qcom_geni_serial_restore() calls qcom_geni_serial_resume() ->
uart_resume_port() in drivers/tty/serial/serial_core.c, the console
restoration block runs before ops->startup(uport):

drivers/tty/serial/serial_core.c:uart_resume_port() {
	if (uart_console(uport)) {
		...
		if (console_suspend_enabled)
			uart_change_pm(state, UART_PM_STATE_ON);
		uport->ops->set_termios(uport, &termios, NULL);
		if (!console_suspend_enabled && uport->ops->start_rx) {
			guard(uart_port_lock_irq)(uport);
			uport->ops->start_rx(uport);
		}
		if (console_suspend_enabled)
			console_resume(uport->cons);
	}

	if (tty_port_suspended(port)) {
		...
		if (console_suspend_enabled || !uart_console(uport)) {
			struct tty_struct *tty =3D port->tty;

			ret =3D ops->startup(uport);
}

If the kernel that loaded the hibernation image did not initialize the
console serial engine (for instance, when the driver was built as a module
not loaded before restore, when the boot kernel command line did not enable
the console, or on sa8255p where the power domain is powered off during
quiesce), uport->ops->set_termios(), uport->ops->start_rx(), and
console_resume() will run before qcom_geni_serial_port_setup() configures
FIFO packing, watermarks, and FIFO mode. Furthermore, if
tty_port_suspended(port) is false (no userspace tty open on the console port
at hibernation time) or console_suspend_enabled is false, ops->startup(upor=
t)
is not called by uart_resume_port() at all.

Conversely, when qcom_geni_serial_startup() does run on a console port with
port->setup =3D=3D false (either inside uart_resume_port() immediately after
console_resume() has re-enabled NBCON console output, or later when userspa=
ce
opens the console tty device), it invokes qcom_geni_serial_port_setup()
without holding uport->lock (which serves as the NBCON device_lock in
qcom_geni_serial_console_device_lock()) or NBCON console ownership:

drivers/tty/serial/qcom_geni_serial.c:qcom_geni_serial_startup() {
	if (!port->setup) {
		ret =3D qcom_geni_serial_port_setup(uport);
		if (ret) {
			pm_runtime_put_sync(uport->dev);
			return ret;
		}
	}
	...
	uart_port_lock_irq(uport);
	qcom_geni_serial_start_rx(uport);
	uart_port_unlock_irq(uport);
}

Inside qcom_geni_serial_port_setup(), qcom_geni_serial_stop_rx(),
qcom_geni_serial_poll_tx_done() (which can issue M_GENI_CMD_ABORT),
geni_se_config_packing(), geni_se_init() (which writes FORCE_DEFAULT and
clears all M/S IRQ status bits via geni_se_irq_clear()), and
geni_se_select_mode() can then race with concurrent NBCON console writes in
__qcom_geni_serial_console_write().

Should console ports instead be re-initialized in the restore path before
uart_resume_port() (after runtime resume), or while holding the appropriate
port/console lock before console_resume()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027203136.9597=
1-1-birk.skyum@pm.me?part=3D1
