Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598501;
	b=Ht+DOrGHceZo3yxwh75N2A7pVXQZHo5/AnP/09QcjnzOntgkSaYMxE3Xc+1cf0/KVPWw
	 4iDX7qjj+8vLRV0YOVnPNQABpYIvyyGN1XzKN2H3F8VVRxTycrUtSpMFvN2K18VZjCLRL
	 R93OiaS8HuEQ1Bq5ZsIPvyg3jU7eqIebMgPmS7oLEE2Pk6mPsZj+NoMAqmXAJYZnrPGKE
	 6eLr4ERFATauo41U34JCuzxoGvd5Unx4DmOzAdbgmh4rKSlmpugslwpCIgBdbOvF/kwbB
	 CalGg0SjLzgx/iAHRA5163IbmTH2QZsww3cYVaeUjguyu5iMqya+bovewnQxBv49Uzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598501;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jqCitScURCsRw3G/hXbjqzPynzj1pKFEPR1T3UXuKDQ=;
	b=r2fgxYnCrEPyiINlK2acrYuRlr2oXI1NgN51U8Kxq1+OJYQl0FJp2BFP/NGbB+YQ+QvY
	 zFzJR30vQe6DTjeHLx3GBaBlEOcQfCJ4tVITWTGRcIEwWSKGeORupuRJUW7YJ5/gOprV5
	 6fSUwClJh8l6i94KqfBHwzdVeRcFFguc7sGvFD1GWgjrK14zpZ1H2u22oQiA6MR67LgKQ
	 55jNMnK3L3Hu3wuobDiYbTjJzlrKEYrLbcz0GC2bNwh7qcO3ixVxAMXfrL2Ar7WshhrKa
	 KedwqzeKzjRmw0ulYI/69HbHaQgxSNrKAmPCVy0Zs9Kwjftwq50QnlTx/aBBHrRQg2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bO6K6CH3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5C4606A327
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 19:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bO6K6CH3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4877C1F000C4;
	Fri, 13 Nov 2026 19:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794598501;
	bh=jqCitScURCsRw3G/hXbjqzPynzj1pKFEPR1T3UXuKDQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bO6K6CH3uLfTpOTkoPpMglvP5yxEjwq9uTXsUV/RrKngwrVA+GBC4N/zwjemhI83V
	 eJ6asJ2pV4Mp35g3+huGshhQB+T1fG5xkFa+TGvolI2/4AlTeq7rY02ewjbStR+GOV
	 2hhS0icnI6uLwtYx5icG7BBxxteHZZ1aSfaxV66nUz2s6QPSNkn1hh0R9nglhXM55o
	 X6dWI4XUOU01zzcLV+oXRoWeBk90mxy/lhtvGZjOqX34uWERYM2TomzGgcipQZ7RAe
	 mx9OxRd0Vln+9bymblb5jO/o+oN1c515a0wUmh60hTFhSv06apzbxTvtQ1iNmTVF2b
	 XdpcR28eKrHuQ==
Message-ID: <sashiko-outbox-213556@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/7] serial: rsci: Enable transmit end interrupt in
 rsci_stop_tx()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Diogo Ivo" <diogo.ivo.sx@renesas.com>
Cc: linux-serial@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261113-g2ul_sci-v4-3-6815e41d90c5@renesas.com>
References: <20261113-g2ul_sci-v4-0-6815e41d90c5@renesas.com>
 <20261113-g2ul_sci-v4-3-6815e41d90c5@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:35:00 +0000
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
- [Medium] serial: rsci: TX restart on suspend in sci_tx_end_interrupt()
--

commit 071c63519ac773139fb715b1e8e4f93c225b5ba8
Author: Diogo Ivo <diogo.ivo.sx@renesas.com>

serial: rsci: Enable transmit end interrupt in rsci_stop_tx()

This commit enables the transmit end interrupt (CCR0_TEIE) in
rsci_stop_tx() when transmission is active (CCR0_TE is set) so that
sci_tx_end_interrupt() clears CCR0_TE once in-flight data finishes
shifting out.

> diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
> index 0391111db8ae8..05703bb31afde 100644
> --- a/drivers/tty/serial/rsci.c
> +++ b/drivers/tty/serial/rsci.c
> @@ -409,6 +409,8 @@ static void rsci_stop_tx(struct uart_port *port)
> =20
>  	ctrl =3D rsci_serial_in(port, CCR0);
>  	ctrl &=3D ~CCR0_TIE;
> +	if (ctrl & CCR0_TE)
> +		ctrl |=3D CCR0_TEIE;
>  	rsci_serial_out(port, CCR0, ctrl);
>  }

[Severity: Medium]
Can enabling CCR0_TEIE here cause sci_tx_end_interrupt() to restart
transmission during system suspend?

uart_suspend_port() sets uport->suspended =3D 1 and calls ops->stop_tx()
and ops->set_mctrl(uport, 0) without setting tty->flow.stopped or
uport->hw_stopped, then drops uport->lock to wait up to 30ms for the
hardware transmitter to empty.  When the in-flight bytes finish shifting
out, the resulting TEI interrupt sees !uart_tx_stopped(port) as true and
resumes transmission if tport->xmit_fifo still has queued data:

drivers/tty/serial/sh-sci.c:sci_tx_end_interrupt() {
    ...
	if (port->x_char || (!kfifo_is_empty(&tport->xmit_fifo) &&
			     !uart_tx_stopped(port))) {
		ctrl &=3D ~(s->params->param_bits->teie);
		ctrl |=3D s->params->param_bits->tie;
		s->ops->write_reg(port, regs->control, ctrl);
		s->ops->transmit_chars(port);
    ...
}

This keeps transmitting after stop_tx() and modem control deassertion,
and if xmit_fifo does not empty within 30ms, uart_suspend_port() times
out with "Unable to drain transmitter" and calls ops->shutdown()
mid-transmission.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-g2ul_sci-v=
4-0-6815e41d90c5@renesas.com?part=3D3
