Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8716339361
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787568877; cv=none; b=g5s5wkoOjYFRkedpVx/RO7Iifhu2Q2Ezld4k6d8QFSPT4yD37xZ6s8Y812JuF3n3DQ2LzVTChWwb/CDKXhd28ChSgoAmPQ4wywCySUJc7Imt25mBbzjy/Xe8E+q4/pBUq5Cx/H/wHBnn682HOwk+/O8UQHF/QYITDkjzvO3ryoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787568877; c=relaxed/simple;
	bh=tcM5xRtZxoQIIrYm0XDgdLjJazJgb/831bd5TMR4d6o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DybwD7+8qN7DgQFbcpPRi9OnXGRmCm7MJZSc2YUfscuCdbA7lpSyBH1mZuX81PUpenPQAFP3rMIWdOpyxxQFcp6X7FLNrsFpU8VgTYuTkYXG8b5oXyQYsHWhG39EcTy4XBUooTbxHQkBg1RPQD6cpaIi66duqu8Y9PrJHk6B644=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaEcfI4V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaEcfI4V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216901F000E9;
	Mon, 24 Aug 2026 10:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787568876;
	bh=0khqjOMxF9RCosaW+buwDhZzUPVAEDD++Pt4OwyBRnQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FaEcfI4VxNotlgQ1Amw/5LtbTODgzT4s7rQOen1j2mmmG9vfB0iM/4tD6Q1uOmwf2
	 pjoPuBdHibYSQBVgIlbsKw8SYM432/RDirCdyK+MpscietUg1aWOIIpYYvNoCZA58w
	 4b5yv4DQB5K1spX4tubkaUeOgzLI8KAJPr5U+4dwwHSoRKRusWCXtKg6lLwnh3Oo3Q
	 +Qwozn0g6RsLjP6gcnde1MV/X8lwAe/7QTPuHDK2PC0KPJjIQkT+DVheVKbtkKI3if
	 uhgioT8V3FRav1QIL55TFvC6SMWUseaE++MJ5p7y7DXaJHKKtx4Pl6+K0dYZ/UXRr1
	 xlMXK9jWMnNow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: qcom-geni: Drop unsafe rx_buf realloc from
 setup_fifos()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260824-drop-unsafe-rx-buf-realloc-from-setup-fifos-v1-1-52d231c840e1@oss.qualcomm.com>
References: <20260824-drop-unsafe-rx-buf-realloc-from-setup-fifos-v1-1-52d231c840e1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 10:54:35 +0000
Message-Id: <20260824105436.216901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] ida_free() is called before uart_remove_one_port() in qcom_geni_se=
rial_remove().
- [High] The RX DMA length reported by the hardware is not validated agains=
t the allocated buffer size, which can lead to out-of-bounds memory reads a=
nd information leaks.
--

--- Patch [1]: [PATCH] serial: qcom-geni: Drop unsafe rx_buf realloc from s=
etup_fifos() ---
commit 78bd555a9d69466b1db67c194aa2b0540f9577ee
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>

serial: qcom-geni: Drop unsafe rx_buf realloc from setup_fifos()

The RX buffer is allocated once during probe using a fixed size and is
DMA-mapped for the lifetime of the port. This removes the rx_buf
reallocation from setup_fifos() to prevent the DMA engine from accessing
freed memory when the buffer pointer changes.

> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 3633723acef8d..75b2e0b77d059 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
[ ... ]
> @@ -1300,19 +1299,6 @@ static int setup_fifos(struct qcom_geni_serial_por=
t *port)
>  	uport->fifosize =3D
>  		(port->tx_fifo_depth * port->tx_fifo_width) / BITS_PER_BYTE;
> =20
> -	if (port->rx_buf && (old_rx_fifo_depth !=3D port->rx_fifo_depth) && por=
t->rx_fifo_depth) {
> -		/*
> -		 * Use krealloc rather than krealloc_array because rx_buf is
> -		 * accessed as 1 byte entries as well as 4 byte entries so it's
> -		 * not necessarily an array.
> -		 */
> -		port->rx_buf =3D devm_krealloc(uport->dev, port->rx_buf,
> -					     port->rx_fifo_depth * sizeof(u32),
> -					     GFP_KERNEL);
> -		if (!port->rx_buf)
> -			return -ENOMEM;
> -	}
> -
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but is it possible for a concurrent driver pr=
obe
to allocate the same line ID and call uart_add_one_port() while
uart_remove_one_port() is still executing?

Looking at qcom_geni_serial_remove() in drivers/tty/serial/qcom_geni_serial=
.c:

	ida_free(&port_ida, uport->line);
	uart_remove_one_port(drv, &port->uport);

Since ida_free() is called before completely unregistering the port, it
appears a race condition could occur if the device is unbound. A concurrent
probe could reuse the freed IDA while the removal thread is waiting for the
port mutex, which might incorrectly tear down the newly added port's state
and result in a use-after-free.

[Severity: High]
This is a pre-existing issue, but does the hardware-reported DMA length get
validated against the allocated buffer size?

Looking at qcom_geni_serial_handle_rx_dma() in
drivers/tty/serial/qcom_geni_serial.c, the length is read directly from the
device:

	rx_in =3D readl(uport->membase + SE_DMA_RX_LEN_IN);
	if (!rx_in)
		dev_warn_ratelimited(uport->dev, "serial engine reports 0 RX bytes in!\n"=
);
	else if (!drop) {
		trace_geni_serial_rx_data(uport->dev, port->rx_buf, rx_in);
		handle_rx_uart(uport, rx_in);
	}

This unvalidated rx_in length is then passed to handle_rx_uart():

	ret =3D tty_insert_flip_string(tport, port->rx_buf, bytes);

If a compromised hardware device or firmware reports an rx_in value larger
than the buffer size (DMA_RX_BUF_SIZE), could this lead to an out-of-bounds
read from port->rx_buf and expose kernel heap data to user-space?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-drop-unsaf=
e-rx-buf-realloc-from-setup-fifos-v1-1-52d231c840e1@oss.qualcomm.com?part=
=3D1
