Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0D53F58E8
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788506875; cv=none; b=cAWMO49ZXz7qRpT0jp8HETNULh5BUxuSUegppLy1T9LDc+A/NOavxkodtnG1C2V4LSOA/oEHCaZ06jyJ8dJYmtQZcZAZ8pxvEJbr9BhM9h2A6TT2L60xQdbSKVcrlvTc2pCTBZ6peD45DDcNixYMWuxZ2pGrrmm7ZaZ+ooOeZPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788506875; c=relaxed/simple;
	bh=QNIM7u9W9I/sorGHoiEU4Ds1RJcNplilsok6ZEBbHKo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=llw6tmhUmVDph0RPdjWiQdDPT/Tpa3MzLTdyUCAfAYpokJfGp+CEvngphJ+U+aL5YO87QeekqxFMQciiAAGTF6rkKM1oNBesBsx4ZuFV0aWtOwc2p7yWS04VkUbJy7v/fLcOrJ3+iG6iPR6adHZJ56DRdiIqFo25gAA2wIGUpiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IymMVGr2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IymMVGr2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860F41F00A3D;
	Fri,  4 Sep 2026 07:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788506873;
	bh=+eOIor5/Z2ZCAwye3fyOPPTi8Z8S1tWy9jzDAply4mo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IymMVGr25X4+6Jgd9R8GfZg/3jAjjA9cijh6GwG99jhZ2mGxn19hwJ1H5nbXDbvVj
	 3YkqokQdFzVJQidcheANX1qs0jIFPBO25qXTnHJeVSMXcrGNYVA+W0fo5BnWEBr8Oo
	 4sRgeNeqyhPwbsyv+JQWEFy6WlEvdApuC7Sw1jVYtVmKlmZz69k6L6CeM50h03D7/8
	 ISsBV++/9HkLGfz/XjA+jNrP0q8IDhEJ+ckB7/EqqqgVqi0h5Zug5K901+xirLHEW9
	 1CoMa57WgSfVNv2zMtB5aLzu8aU+Na/qgpjqgydkpJ47BAxFbJ6vUrH6EsJm50MCMM
	 Vsr4MiUAz86zA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: serial: qcom_geni: don't ida_free() the console
 port line
Reply-To: sashiko-reviews@lists.linux.dev
To: "Neil Armstrong" <neil.armstrong@linaro.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-v1-1-02e18c31aeba@linaro.org>
References: <20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-v1-1-02e18c31aeba@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 07:27:53 +0000
Message-Id: <20260904072753.860F41F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Double free and double detach of PM domains due to mixing devm=
_ allocation with manual cleanup.
- [High] The allocated IDA for non-console ports is permanently leaked on m=
ost probe error paths.
- [High] Wake IRQ and device wakeup capabilities are leaked and not reverte=
d on late probe failures, permanently breaking deferred probe.
- [High] `dma_unmap_single()` is executed against an invalid DMA address if=
 `dma_map_single()` fails.
- [Medium] Unsafe ordering of `ida_free()` and `uart_remove_one_port()` in =
the driver's remove function.
--

commit b824bc9910a93e019533a2fc7bb8b725efd22ca7
Author: Neil Armstrong <neil.armstrong@linaro.org>

tty: serial: qcom_geni: don't ida_free() the console port line

The console port (qcom_geni_console_port) is a static instance whose
uport.line is hardcoded to 0 and is never allocated from port_ida.
This commit updates the probe error path and remove function to only call
ida_free() for non-console ports.

> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 3633723acef8d..bdbdfd7dfaace 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1979,7 +1979,8 @@ static int qcom_geni_serial_probe(struct platform_d=
evice *pdev)
>  						port->wakeup_irq);
>  		if (ret) {
>  			device_init_wakeup(&pdev->dev, false);
> -			ida_free(&port_ida, uport->line);
> +			if (!uart_console(uport))
> +				ida_free(&port_ida, uport->line);
>  			goto error;
>  		}
>  	}

[Severity: High]
This is a pre-existing issue, but does the common error cleanup block fail
to release the allocated IDA for non-console ports on other probe error pat=
hs?

If get_port_from_line() successfully allocates an IDA, but an error occurs
later in qcom_geni_serial_probe() such as a dma_map_single() failure, contr=
ol
jumps to the error block which completely bypasses ida_free():

error:
	if (port->rx_dma_addr) {
		dma_unmap_single(pdev->dev.parent, port->rx_dma_addr,
				 DMA_RX_BUF_SIZE, DMA_FROM_DEVICE);
		port->rx_dma_addr =3D 0;
	}
	dev_pm_domain_detach_list(port->se.pd_list);
	return ret;

Could this exhaust the finite pool of IDAs upon repeated deferred probe
failures?

[Severity: High]
This is also a pre-existing issue, but does the error label handle general
cleanup while missing the reversion of the wake IRQ and wakeup initializati=
on?

If probe sets up the wake IRQ via dev_pm_set_dedicated_wake_irq() but fails
later, the error block completely bypasses dev_pm_clear_wake_irq() and
device_init_wakeup().  Will dev_pm_set_dedicated_wake_irq() return -EEXIST
upon a deferred probe retry because dev->power.wakeirq is already initializ=
ed,
permanently breaking the device?

[Severity: High]
Another pre-existing issue in the same error block: is dma_unmap_single()
executed against an invalid DMA address if dma_map_single() fails?

If dma_map_single() fails during probe, port->rx_dma_addr retains the mappi=
ng
error code.  Does the error path conditionally unmap the buffer using
if (port->rx_dma_addr), mistakenly evaluating the non-zero error code as a
valid address?

[Severity: Critical]
This is a pre-existing issue, but does mixing devm_ allocation with manual
cleanup cause a double-free of the PM domains?

geni_se_domain_attach() uses devm_pm_domain_attach_list() to attach the PM
domains and registers an automatic devres cleanup handler.  However, the er=
ror
block in qcom_geni_serial_probe() manually calls:

	dev_pm_domain_detach_list(port->se.pd_list);

When devres executes its cleanup routine, won't it call
dev_pm_domain_detach_list() again on the same freed pointer?

[ ... ]

> @@ -2024,7 +2025,8 @@ static void qcom_geni_serial_remove(struct platform=
_device *pdev)
>  	irq_work_sync(&port->tx_kick);
>  	dev_pm_clear_wake_irq(&pdev->dev);
>  	device_init_wakeup(&pdev->dev, false);
> -	ida_free(&port_ida, uport->line);
> +	if (!uart_console(uport))
> +		ida_free(&port_ida, uport->line);
>  	uart_remove_one_port(drv, &port->uport);

[Severity: Medium]
This is a pre-existing issue, but is there an unsafe ordering of ida_free()
and uart_remove_one_port() in qcom_geni_serial_remove()?

The line identifier is returned to the global port_ida pool via ida_free()
before uart_remove_one_port() unregisters the subsystem structure that reli=
es
on it.  Could a concurrent probe of another qcom_geni_serial device claim
this newly freed ID, hit the state->uart_port check in
serial_core_add_one_port(), and fail with -EINVAL?

[Severity: Critical]
This is a pre-existing issue, but does qcom_geni_serial_remove() also
manually clean up the devm-managed PM domains?

Similar to the probe error path, the remove function includes:

	dev_pm_domain_detach_list(port->se.pd_list);

Will the subsequent automatic devres cleanup trigger a double-free of the
dev_pm_domain_list structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-topic-sm8x=
50-upstream-tty-serial-geni-fix-ida-free-v1-1-02e18c31aeba@linaro.org?part=
=3D1
