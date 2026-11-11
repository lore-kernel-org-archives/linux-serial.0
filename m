Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391587;
	b=cUdvIjpNd6HTdgnaoiylZtAj8PD7heJ2i1LBG1yWrdTA6q7yUqgniRdV7u1/uxpLWF82
	 7U/wnt3mBA4HHGZjEF8GEJ04YDdSiGBgjqE6nsSZ+QInUPzbCrdjKeEQEddhLDVzYmszs
	 SDrvZd1+HsmxShArUkyhXYXprNYOyUcN6siEopTpclZ0XPEcm7WpfnrvM8h+wpubzl/Fa
	 zVXI29RKkCrzvvfBEH3B7NiYXhR1mR6kdeD6iVPaGqUMOPJ7wqMdVB5gX5jxnX8m/wQw4
	 jSgEIaZvHzxxPnk9WJFlU3mrb9wtcI4HL12LQp5HCGfHUVJ1yBBPF0Xblf3KCghNADg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391587;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1bDE7KDLu9jfAIQ9ef1xfs+m4nkgfIs7mnLLTujVMDI=;
	b=lNN55LSH8PDLUq3mDQWpWPf462zA3pyEZDh94BiVTZEnDvKcRYU9fgaWbngM25ON20gK
	 zFdEd3Jl1snK4FzHBQwkLo2zphbxJRowq2yeVhLW07OhcjCAzHTN9YaQxmJLio/kyBhNx
	 soHRWy6wi4IY2fO37t/0vpY/KzImnIa0wKwTHrHlagaFkbr9lPg6VqSgdlTW/eRvawQEf
	 atcX44xvjVApXNOLucM2JzhsKwCdUutpVjEZYkcFDcn3kken1IEALjlpvDxiAv08sixH0
	 P8L6JH1TKqCNY1xVdp3eiN0UKip7JNBhA5np0uMcUb7b8CThi5mtOIxDjk9rb+IWvnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frRWwhb2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C85606A321;
	Wed, 11 Nov 2026 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frRWwhb2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CCD1F00A05;
	Wed, 11 Nov 2026 10:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794391586;
	bh=1bDE7KDLu9jfAIQ9ef1xfs+m4nkgfIs7mnLLTujVMDI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=frRWwhb2okTWpsgMzXcqSRKioSW871L2+LtLOIV9EDx0uYOz4job3FKbjYkkl23zN
	 XLOgjiCpP07jReEH49a/O+1XZ5l7j9H5St3/11bNjQM5dZ9Pw9PZeL1NVJJEv+SePz
	 Mmxiz2rIFtxePV2t3WfwCjvGJNjfEQAosBdcXU2pueMKRzoa7z0Q8my3P8yhdPRs0B
	 YH7CUjJp543SroMtXZQo4w+7CWbU/2oWdfA5LLv2WhaNL3jo3GNaRE80203I7GXzT8
	 NKTMMrx6BP3tFB0SBxu/khE1DYVA+cyeHwiHM0C9Z1K8mCHzwP3yKlLF88+KTRtEW4
	 zUkejNcKKYRQA==
Message-ID: <sashiko-outbox-208746@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: serial: lpuart: Add port lock for registers read
 in lpuart32_set_termios()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U2hlcnJ5IFN1biAoT1NTKQ==?= <sherry.sun@oss.nxp.com>
Cc: linux-serial@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20261111-lpuart_port_lock-v1-1-5d332c51edfe@nxp.com>
References: <20261111-lpuart_port_lock-v1-1-5d332c51edfe@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 10:06:25 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] tty: serial: lpuart: split port->lock race in
  lpuart32_set_termios()
--

commit c6586e620953933a073532d069075858d2abff60
Author: Sherry Sun <sherry.sun@nxp.com>

tty: serial: lpuart: Add port lock for registers read in lpuart32_set_termi=
os()

This commit wraps the initial register reads of UARTCTRL, UARTBAUD, and
UARTMODIR in lpuart32_set_termios() with uart_port_lock_irqsave() to avoid
reading a stale UARTCTRL value while lpuart32_console_write() temporarily
clears RIE.

> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c
> index cd2575a3aef74..7c249b9371ae8 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -2241,9 +2241,11 @@ lpuart32_set_termios(struct uart_port *port, struc=
t ktermios *termios,
>  	unsigned int  baud;
>  	unsigned int old_csize =3D old ? old->c_cflag & CSIZE : CS8;
> =20
> +	uart_port_lock_irqsave(port, &flags);
>  	ctrl =3D old_ctrl =3D lpuart32_read(port, UARTCTRL);
>  	bd =3D lpuart32_read(port, UARTBAUD);
>  	modem =3D lpuart32_read(port, UARTMODIR);
> +	uart_port_unlock_irqrestore(port, flags);
>  	sport->is_cs7 =3D false;
>  	/*
>  	 * only support CS8 and CS7

[Severity: Medium]
Does releasing port->lock right after reading UARTCTRL, UARTBAUD, and
UARTMODIR still leave a window where ctrl and old_ctrl become stale before
they are written back to hardware?

CPU0                                  CPU1
lpuart32_set_termios()
  uart_port_lock_irqsave()
  ctrl =3D old_ctrl =3D
    lpuart32_read(UARTCTRL)
    (UARTCTRL_TIE is 0)
  uart_port_unlock_irqrestore()
                                      uart_write()
                                        lpuart32_start_tx()
                                          uart_port_lock_irqsave()
                                          lpuart32_write(ctrl | UARTCTRL_TI=
E,
                                                         UARTCTRL)
                                          uart_port_unlock_irqrestore()
  uart_get_baud_rate()
  lpuart_dma_rx_free()
  uart_port_lock_irqsave()
  ...
  lpuart32_write(ctrl, UARTCTRL)  <-- clears UARTCTRL_TIE, stalling TX

Callers such as lpuart32_start_tx(), lpuart32_stop_tx(),
lpuart32_stop_rx(), and lpuart32_set_mctrl() update UARTCTRL under
port->lock without holding tty_port->mutex.  Any modification made during
the unlocked window is overwritten when lpuart32_set_termios() re-acquires
port->lock and writes old_ctrl and ctrl back to UARTCTRL.  Clearing
sport->is_cs7 outside port->lock also races with lpuart32_rxint() and
lpuart_copy_rx_to_tty().

Since neither uart_get_baud_rate() nor lpuart_dma_rx_free() uses ctrl,
old_ctrl, bd, or modem, the register reads and bit manipulations could be
moved into the existing uart_port_lock_irqsave() critical section after
lpuart_dma_rx_free() so the read-modify-write stays under a single lock
acquisition.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-lpuart_por=
t_lock-v1-1-5d332c51edfe@nxp.com?part=3D1
