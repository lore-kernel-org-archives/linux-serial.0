Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A9A392C4D
	for <linux-serial@vger.kernel.org>; Wed,  4 Feb 2026 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770193763; cv=none; b=Ba0PCxxoUm15OAN0lH25WaYToMCLhaY5ONg+cVzw734IdxVqx4ZTgkNx7D1UWIDjCxfHP6XjN20tumb3gbDpzURGfLzz9KuSvzyGqSWOObna/OThgDk+g6z2bYroQgjHf1AIoO823vmja4dN+zk5yS42fdo4t/kv34bN31xkeR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770193763; c=relaxed/simple;
	bh=NTJnpd0cRSR19Bv8AO127gNmpo01Vcr66tYghj0AsA4=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=ASY0Cm3gKF9jKDjlJISIycJ0qqr9xoAKUp0i3HrQVNu38z6MFjik8oNZHgSn9S49inqlNgTbb6XDut2GOs44lgGWG0JnlwRqJytYMj6jOTKuGNhHxiMF7YKqUlKqoVLUakbO5z4uF9KterZzU5BjSiwBTXfWdYrs8WLzeqEDOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oGDf3TAj; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oGDf3TAj"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770193751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hI7c6NXuIo6rUtS9JyG+mDju7fGpyuTcvrLrgtK/i+o=;
	b=oGDf3TAjb+lVt3Q9ZEZAW1ywzXJhj4NO+JdBVzAe/tMhbNy2O/eyiCMxxnix9lyjOahR4/
	EPqlbGBO97CVpIp4fHoPR883O4V1YEjJdSNbe5CJmFhJz4Gpoa1OIC4iiL7+LnAOazLzBo
	BgCK13ha1wi9J5vxqS4F8NFzPv1nNtM=
Date: Wed, 04 Feb 2026 08:29:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <fa7e9e86df95ffcc301c60367654e084cbff5d83@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v1] serial: core: fix infinite loop in handle_tx() for
 PORT_UNKNOWN
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, "Jiayuan Chen" <jiayuan.chen@shopee.com>,
 "Jiri Slaby" <jirislaby@kernel.org>, "Petr Mladek" <pmladek@suse.com>,
 "Marcos Paulo de Souza" <mpdesouza@suse.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@oss.qualcomm.com>, "Dr. David Alan Gilbert"
 <linux@treblig.org>, "Joseph Tilahun" <jtilahun@astranis.com>, "Sjur
 Braendeland" <sjur.brandeland@stericsson.com>, "David S. Miller"
 <davem@davemloft.net>, linux-kernel@vger.kernel.org
In-Reply-To: <2026020459-lisp-display-0506@gregkh>
References: <20260204074327.226165-1-jiayuan.chen@linux.dev>
 <2026020459-lisp-display-0506@gregkh>
X-Migadu-Flow: FLOW_OUT

2026/2/4 16:20, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org mailto:g=
regkh@linuxfoundation.org?to=3D%22Greg%20Kroah-Hartman%22%20%3Cgregkh%40l=
inuxfoundation.org%3E > wrote:


>=20
>=20On Wed, Feb 04, 2026 at 03:43:20PM +0800, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >=20=20
>=20>  uart_write_room() and uart_write() behave inconsistently when
> >  xmit_buf is NULL (which happens for PORT_UNKNOWN ports that were
> >  never properly initialized):
> >=20
>=20How does this happen? Why were they not initialized properly, what
> drivers/hardware cause this?


  In QEMU environment, /dev/ttyS3 is PORT_UNKNOWN type (no real UART hard=
ware).
  When uart_port_startup() sees uport->type =3D=3D PORT_UNKNOWN, it retur=
ns early
  without allocating xmit_buf:
      if (uport->type =3D=3D PORT_UNKNOWN)
          return 1;   // xmit_buf never allocated
  So xmit_buf remains NULL.

> >=20
>=20> - uart_write_room() returns kfifo_avail() which can be > 0
> >  - uart_write() checks xmit_buf and returns 0 if NULL
> >=20=20
>=20>  This inconsistency causes an infinite loop in drivers that rely on
> >  tty_write_room() to determine if they can write:
> >=20=20
>=20>  while (tty_write_room(tty) > 0) {
> >  written =3D tty->ops->write(...);
> >  // written is always 0, loop never exits
> >  }
> >=20=20
>=20>  For example, caif_serial's handle_tx() enters an infinite loop whe=
n
> >  used with PORT_UNKNOWN serial ports, causing system hangs.
> >=20=20
>=20>  Fix by making uart_write_room() also check xmit_buf and return 0 i=
f
> >  it's NULL, consistent with uart_write().
> >=20=20
>=20>  Reproducer: https://gist.github.com/mrpre/d9a694cc0e19828ee3bc3b37=
983fde13
> >=20=20
>=20>  Fixes: 9b27105b4a44 ("net-caif-driver: add CAIF serial driver (ldi=
sc)")
> >=20
>=20This really isn't a fix for that driver, but rather something else.

  You're right, this is awkward. The API inconsistency between uart_write=
_room()
  and uart_write() has existed since 2.6.12, but it only became visible a=
s a
  deadloop when CAIF was introduced - because CAIF's handle_tx() relies o=
n
  tty_write_room() to decide whether to call write().
  The fix location is in uart, but the trigger condition requires CAIF (o=
r
  similar drivers). I can remove the Fixes tag if you prefer.

> >=20
>=20> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> >  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >=20
>=20This doesn't make sense, signing off twice for the same person?
>=20
>=20As you did this from your shopee.com account, that should be sufficie=
nt.

Sorry, I'll keep only one Signed-off-by.

> >=20
>=20> ---
> >  drivers/tty/serial/serial_core.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >=20=20
>=20>  diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial=
/serial_core.c
> >  index 2805cad10511..0b2edf185cc7 100644
> >  --- a/drivers/tty/serial/serial_core.c
> >  +++ b/drivers/tty/serial/serial_core.c
> >  @@ -643,7 +643,10 @@ static unsigned int uart_write_room(struct tty_=
struct *tty)
> >  unsigned int ret;
> >=20=20
>=20>  port =3D uart_port_ref_lock(state, &flags);
> >  - ret =3D kfifo_avail(&state->port.xmit_fifo);
> >  + if (!state->port.xmit_buf)
> >=20
>=20This feels odd. What ports have no transmit buffers? And why would
> this be the only check that is needed for such broken devices?
>=20
>=20Maybe let's fix the root cause here, the driver that does not have a
> transmit buffer at all?


  Do you suggest we should prevent setting line discipline (like N_CAIF)
  on PORT_UNKNOWN ports? Or should CAIF check the port type before using =
it?
  Note that CAIF is currently in orphan status (no active maintainer), so
  I'm not sure about the process for modifying it. The serial core fix
  might be more straightforward.

  I'm happy to take either direction.
  Thanks,
  Jiayuan

> thanks,
>=20
>=20greg k-h
>
