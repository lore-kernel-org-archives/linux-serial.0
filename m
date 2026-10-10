Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB985204C31
	for <linux-serial@vger.kernel.org>; Sat, 10 Oct 2026 05:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791611200; cv=none; b=hXss1tFoYCFiCCATQKIT8O+xAMNffW34CLRz3jX2o8GYjZsAKvHq2cPWHe5n5XRW3rKo95LT8XltKe2Ybn80fzDgLDgfF7rc0bJ+HEiODdwRzDojOtPmV6ehHnmI3R6LavzotxPUtYA5Q4T0VWRqgq+X2p6feB7/2rg3zQu7HTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791611200; c=relaxed/simple;
	bh=ltCAYuogP+/s6EZE4OszakwZs7To7FDeOskTyx+jtvM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=XuZA1HGDZ36utJf/GMYxOGeVjuMZ+vhQWUwJRmvZGLlRBfxLiH2Yvy+L9b3wT2vYBMIQTHiPWih2sVD1dhwbet3WWG7Wsg6B5deMA0qkLl68AgcKYpUvBUUKOzZs4h2+1nEov9vemFCfV49AfeNKACyJ7KtfFKUUpiOPMbNZi3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6KgLa8j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6KgLa8j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5157B1F000FF;
	Sat, 10 Oct 2026 05:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791611199;
	bh=yGrQd0+noY7kBj4jCvBysDejYnNt29k8W6ogekgzzRE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f6KgLa8jFtvE/HGxQ2EnK2qGzYp9pfIMlAYxZrX/mM2AGhfD8pG8K1c4+InAFltC+
	 YDYuOVH9CdhSqXGS5nhDhWf3cMFyKFHqaPqtpYuKcrFlqeFq05SWh9ThKqpweyRzdD
	 fhkjelEQA70sayWn3jl4evGzrfejhTXsIHKLo5FhTAZsFLmWeSZDgfQGOUhmfJ7tHU
	 05u8dVH6CKYk/II41iyE6BVD/6vTezPA2Kk50gx80HIhunYPDOmXl8wR5TYlrpbHwA
	 gMarBArqoaE1IOx/FKaRyglY4ZDgbV9tzyv43oxXcKPQdwDA4kuMbYRQS+vxHS6c9N
	 /yGCJHufYmZMQ==
Message-ID: <sashiko-outbox-166267@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] serial: 8250_lpss: do not touch uninitialized line
 in ehl_serial_exit()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmlyaSBTbGFieSAoU1VTRSk=?= <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <ef47d676a44346e058f29a00c8701484db722831.1791524724.git.jirislaby@kernel.org>
References: <cover.1791524724.git.jirislaby@kernel.org>
 <ef47d676a44346e058f29a00c8701484db722831.1791524724.git.jirislaby@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 05:46:38 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] tty: serial: 8250_lpss: race in remove path corrupts reallocated p=
ort DMA
- [High] tty: serial8250: UAF due to dangling dma pointer on register failu=
re or unregister
--

commit 1d475b7f1e61baf36ab1328820f63e24baee9a1a
Author: Jiri Slaby (SUSE) <jirislaby@kernel.org>

serial: 8250_lpss: do not touch uninitialized line in ehl_serial_exit()

This commit fixes an issue in lpss8250_probe() where lpss->board->exit()
could clear the dma pointer of an unrelated port on the error path. It
initializes lpss->data.line to -1 and skips clearing the DMA pointer in
ehl_serial_exit() if no port was registered.

> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/825=
0/8250_lpss.c
> index 776ec1ef29d62..c5257847a94c8 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -183,6 +183,9 @@ static int ehl_serial_setup(struct lpss8250 *lpss, st=
ruct uart_port *port)
> =20
>  static void ehl_serial_exit(struct lpss8250 *lpss)
>  {
> +	if (lpss->data.line < 0)
> +		return;
> +
>  	struct uart_8250_port *up =3D serial8250_get_port(lpss->data.line);
> =20
>  	up->dma =3D NULL;

[Severity: High]
Does this locklessly clear the DMA pointer on a potentially reallocated port
slot?

In lpss8250_remove(), the port is unregistered before the board exit callba=
ck
cleans up the DMA pointer:

drivers/tty/serial/8250/8250_lpss.c:lpss8250_remove()
    serial8250_unregister_port(lpss->data.line);
    lpss->board->exit(lpss);

Because serial8250_unregister_port() clears the port's registration (setting
uart->port.dev =3D NULL) and releases serial_mutex, the global
serial8250_ports[] array slot becomes available.

If a concurrent driver probes a different 8250 serial device, claims the
same slot via serial8250_register_8250_port(), and assigns its own uport->d=
ma
pointer, won't up->dma =3D NULL in ehl_serial_exit() locklessly zero out the
newly assigned DMA pointer, leading to a NULL pointer dereference or loss of
DMA functionality for the new device?

> [ ... ]
> @@ -329,6 +332,8 @@ static int lpss8250_probe(struct pci_dev *pdev, const=
 struct pci_device_id *id)
>  		return ret;
> =20
>  	lpss->board =3D (struct lpss8250_board *)id->driver_data;
> +	/* for tests in lpss->board->exit() */
> +	lpss->data.line =3D -1;
> =20
>  	memset(&uart, 0, sizeof(struct uart_8250_port));
> =20

[Severity: High]
Does the failure path of serial8250_register_8250_port() leave a dangling
DMA pointer?

If serial8250_register_8250_port() fails (e.g. uart_add_one_port fails)
when called from probe, it jumps to its error path:

drivers/tty/serial/8250/8250_core.c:serial8250_register_8250_port()
err:
    uart->port.dev =3D NULL;
    return ret;

This nullifies the device pointer but leaves uart->dma pointing to memory
allocated during the caller's probe (e.g. devm_kzalloc). When the probe
fails and devm frees this memory, doesn't it leave a dangling pointer in
the global serial8250_ports array?

Similarly, if a module successfully registers a port but is unloaded before
the port is ever opened, serial8250_unregister_port() will not clear
uart->dma (as serial8250_do_shutdown is skipped for unopened ports) and the
module's memory is freed.

If an administrator unbinds and rebinds the serial8250 platform driver, or
the core automatically re-registers the port under serial8250_isa_devs,
couldn't an unprivileged user trigger serial8250_startup() ->
serial8250_request_dma() and dereference the freed pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ef47d676a44346e058f=
29a00c8701484db722831.1791524724.git.jirislaby@kernel.org?part=3D1
