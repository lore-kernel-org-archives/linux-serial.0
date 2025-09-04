Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DD12C3768;
	Thu,  4 Sep 2025 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003826; cv=none; b=FUtmQ6/TyNMR+fcfijeOwPNMqfNyK4fXB6uGaY/kb5vtEL9gavqNjlIzyPl9XM7T44ytGX9DC9PEDYtVRYmOPEj7eNMZBKd0/mz9jfeZdhaa8Euef/9BWbnlnDKXXDB9ghZyCAGO2/FaQMTJeOqU/COioSB43fvMyzigaGG2Vyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003826; c=relaxed/simple;
	bh=aI33hpNZv7QPjfBmT68XRHirLg/skD+4qO8gAzqEKZ0=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=C/tR5v7cswLTZ/mlgQUbFx8Hi+bfjCIRIBa1l6hNSedpr4BppO2fZ0UN5wUGJJFE7ZL2ZWmaLjnL4BdQhVm8RKjpIPf+eumf08Z/ksWrn/kCScMX1fLDEO6u9gwZ9V7cIio3Hy252KURi8wD7pIradhcPn0dKvYzvspcIqkjzY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=AFvd+gkJ; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="AFvd+gkJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=aN8IZ0Npe/EHb0ZHn3hHSyVNoCWWTZZacN+GW1RF+5o=; b=AFvd+gkJajTuSscCJYkHR6IYsP
	SSPOXHvzg2ox0IaxGnVFS1GvhsaGRvJkzOGo3oiUJgMgFmuMUQAaXQbAk7BWaqBm4tCZZ7EKOD/lD
	TcyKWNmHTAcOprBrSKM7RzoHYVkmUdFv1hZBjTckfA/lFIWjt7MxVQbdtLPbwGtPGfVw=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:43692 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1uuCx1-0003c6-O7; Thu, 04 Sep 2025 12:36:45 -0400
Date: Thu, 4 Sep 2025 12:36:42 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Alexander Shiyan <shc_work@mail.ru>, Hugo
 Villeneuve <hvilleneuve@dimonoff.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Message-Id: <20250904123642.c8dd7bd6bf693ccbb5f6989b@hugovil.com>
In-Reply-To: <e88f3c74-2ea0-4266-b5f7-62b87a1987c5@vaisala.com>
References: <20250903-master-max310x-improve-interrupt-handling-v1-1-bfb44829e760@vaisala.com>
	<214edb7a-2631-4f7f-9516-a38a3796cc0b@kernel.org>
	<e88f3c74-2ea0-4266-b5f7-62b87a1987c5@vaisala.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -2.8 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH] serial: max310x: improve interrupt handling
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

Hi,

On Thu, 4 Sep 2025 14:50:16 +0300
Tapio Reijonen <tapio.reijonen@vaisala.com> wrote:

> Hi,
>=20
> On 9/4/25 10:53, Jiri Slaby wrote:
> > On 03. 09. 25, 11:23, Tapio Reijonen wrote:
> >> When there is a heavy load of receiving characters to all
> >> four UART's, the warning 'Hardware RX FIFO overrun' is
> >> sometimes detected.
> >> The current implementation always service first UART3 until
> >> no more interrupt and then service another UARTs.
> >>
> >> This commit improve interrupt service routine to handle all
> >> interrupt sources, e.g. UARTs when a global IRQ is detected.
> >>
> >> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
> >> ---
> >> =A0 drivers/tty/serial/max310x.c | 21 ++++++++++++++++-----
> >> =A0 1 file changed, 16 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x=
.c
> >> index=20
> >> ce260e9949c3c268e706b2615d6fc01adc21e49b..3234ed7c688ff423d25a007ed8b9=
38b249ae0b82 100644
> >> --- a/drivers/tty/serial/max310x.c
> >> +++ b/drivers/tty/serial/max310x.c
> >> @@ -824,15 +824,26 @@ static irqreturn_t max310x_ist(int irq, void=20
> >> *dev_id)
> >> =A0=A0=A0=A0=A0 if (s->devtype->nr > 1) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 do {
> >> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int val =3D ~0;
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int val;
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int global_irq =3D ~0;
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int port;
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 WARN_ON_ONCE(regmap_read(s->re=
gmap,
> >> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 MAX310X_GLOBALIRQ_REG, &val));
> >> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val =3D ((1 << s->devtype->nr) - 1)=
 & ~val;
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MAX310X_GLOBALIRQ_REG, =
&global_irq));
> >> +
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val =3D ((1 << s->devtype->nr) - 1)=
 & ~global_irq;
> >=20
> > This is horrid. Use GENMASK() (or BIT() below) instead. Likely, you wan=
t=20
> > a local var storing the mask (the first part before the &).
> >=20
> val =3D GENMASK(s->devtype->nr - 1, 0) & ~global_irq;>> =A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 if=20
> (!val)
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
> >> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (max310x_port_irq(s, fls(val) - =
1) =3D=3D IRQ_HANDLED)
> >> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 handled =3D true;
> >> +
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 do {
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 port =3D fls(val) - 1;
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (max310x_port_irq(s,=
 port) =3D=3D IRQ_HANDLED)
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 handled =3D=
 true;
> >> +
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 global_irq |=3D 1 << po=
rt;
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val =3D ((1 << s->devty=
pe->nr) - 1) & ~global_irq;
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } while (val);
> >=20
> > Actually, does it have to be from the end? I am thinking of=20
> > for_each_and_bit()...
> >=20
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 } while (1);
> >> =A0=A0=A0=A0=A0 } else {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (max310x_port_irq(s, 0) =3D=3D IRQ_HAND=
LED)

Combining what I suggested earlier, with Jiri's comments but using=20
for_each_clear_bit() allow to get rid of the original horrid mask:

---
        if (s->devtype->nr > 1) {
                do {
                        unsigned int val =3D ~0;
+                       unsigned long channel;
+                       unsigned long irq;
+                       bool read_reg_done =3D true;
=20
                        WARN_ON_ONCE(regmap_read(s->regmap,
                                                 MAX310X_GLOBALIRQ_REG, &va=
l));
-                       val =3D ((1 << s->devtype->nr) - 1) & ~val;
-                       if (!val)
+                       irq =3D val;
+
+                       for_each_clear_bit(channel, &irq, s->devtype->nr) {
+                               read_reg_done =3D false;
+
+                               if (max310x_port_irq(s, channel) =3D=3D IRQ=
_HANDLED)
+                                       handled =3D true;
+                       }
+
+                       if (read_reg_done)
                                break;
-                       if (max310x_port_irq(s, fls(val) - 1) =3D=3D IRQ_HA=
NDLED)
-                               handled =3D true;
                } while (1);
---


--=20
Hugo Villeneuve
