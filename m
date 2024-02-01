Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841965F49A
	for <linux-serial@vger.kernel.org>; Thu,  1 Feb 2024 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802574; cv=none; b=gSBNc1Fm0I7EyrXGwmcWnjwy4Ad40o4L7LWbUMBdAHpv3/NGgJucbYV4SO8eUkFlYwYWsg51DfCQ2Tb+XLvFcLC7IwjhszldLlB/Hh1ZrIBEnpFTHfbDUKdbw83sS8RB+eNElDZyXaNRVy4ZUpEEOGECfkspGfYHBtrScIhXzM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802574; c=relaxed/simple;
	bh=NPk98WBulq+hq2fUD9jM8B+ymuNCFgSHiTHFoEGJk1w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4b2CWMvvhR6AV5yfkaXbESBi60WRqKIuJzDDjj05NukeMwD6BpZeoAC8uWUBzGjy/ck/tqMWuvqpV5rhhGU5+mD8d+98KiR0kZ/gM/UmOqIe1PkMtBCcR6sOavAjgW1DkcNA5TrV1Tuwhe2yBdj2faOREaDdoTVikLIZha2N2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=flaZPBOZ; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="flaZPBOZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1706802565; x=1707061765;
	bh=SH1nmP8MQBJdqYjWZuEUz2VSp4EhHpkxSTitA2ghz6A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=flaZPBOZyM4p+5g78AAXY83pP3qjb0y+9v53CXSOOXcZzJwHPJGVxH5VY0qIUaysS
	 ahG35yqmcT6a7ylUxeWw1LevGvH+lLzsDvInF2JFGuGq3hoLq633Wj8rCkSTHw4K+e
	 HKkzf1rY5m6xasNBu3jo8hGVT2YmbrRZrkWGxvRj2xMbo+Iir4Qy8iIiDFPPFfcLbo
	 zInsnHxILzNxjUnubpSIjzflKGd8aQAq6LPDB26/5eB7QBLntTAOv9vbRfAtNUS91q
	 8YcqdtgqT8iENKzdg4/nVsUrbz9kmgY45H3vr06ff3RwmBzzL3O0R6X8RE7qVJ5XYM
	 Rte/3AF5FXihQ==
Date: Thu, 01 Feb 2024 15:49:06 +0000
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
From: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] serial: mxs-auart: fix tx
Message-ID: <qrark2grtpr7lpiffstvijod4ipp5ciz7ehigakdiu22semhkl@dawjy6nazccp>
In-Reply-To: <20240201105557.28043-2-jirislaby@kernel.org>
References: <20240201105557.28043-1-jirislaby@kernel.org> <20240201105557.28043-2-jirislaby@kernel.org>
Feedback-ID: 20949900:user:proton
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 11:55 +0100, Jiri Slaby (SUSE) wrote:
> Emil reports:
>   After updating Linux on an i.MX28 board, serial communication over
>   AUART broke. When I TX from the board and measure on the TX pin, it
>   seems like the HW fifo is not emptied before the transmission is
>   stopped.
>=20
> MXS performs weird things with stop_tx(). The driver makes it
> conditional on uart_tx_stopped().
>=20
> So the driver needs special handling. Pass the brand new UART_TX_NOSTOP
> to uart_port_tx_flags() and handle the stop on its own.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Reported-by: Emil Kronborg <emil.kronborg@protonmail.com>
> Fixes: 2d141e683e9a ("tty: serial: use uart_port_tx() helper")
> Closes: https://lore.kernel.org/all/miwgbnvy3hjpnricubg76ytpn7xoceehwahup=
y25bubbduu23s@om2lptpa26xw/
> ---
>  drivers/tty/serial/mxs-auart.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auar=
t.c
> index 3ec725555bcc..4749331fe618 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -605,13 +605,16 @@ static void mxs_auart_tx_chars(struct mxs_auart_por=
t *s)
>  =09=09return;
>  =09}
>=20
> -=09pending =3D uart_port_tx(&s->port, ch,
> +=09pending =3D uart_port_tx_flags(&s->port, ch, UART_TX_NOSTOP,
>  =09=09!(mxs_read(s, REG_STAT) & AUART_STAT_TXFF),
>  =09=09mxs_write(ch, s, REG_DATA));
>  =09if (pending)
>  =09=09mxs_set(AUART_INTR_TXIEN, s, REG_INTR);
>  =09else
>  =09=09mxs_clr(AUART_INTR_TXIEN, s, REG_INTR);
> +
> +=09if (uart_tx_stopped(&s->port))
> +               mxs_auart_stop_tx(&s->port);
>  }
>=20
>  static void mxs_auart_rx_char(struct mxs_auart_port *s)
> --
> 2.43.0
>=20

Tested on i.MX28.

Tested-by: Emil Kronborg <emil.kronborg@protonmail.com>

--=20
Emil Kronborg

