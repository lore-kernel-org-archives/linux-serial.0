Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793082765;
	b=jo2AScLVSdi59l3fiPxnN/Zpu4DKLwS2GyHP/P8B2Zg+iv6kEeLZOsuRCLuAFukh4Mq8
	 o/BU/i7oJnIxHTsfwCGePrx2gmnl/WkUvjhaQVYOdUbnUjcZ2f3aLULPflDUmg2SkuZGW
	 DnoKx6ahalgxEgD7TLmTd7EPvSUZvh8g72TUZw0fJ9b6EZNDE4t1JYLWWE9F+eGAHxud8
	 7IJtR42vpmhIuF43Xl6s9ZVk73kNpM2TirqOKKXB7e62+jtKB0CXFPLEib34gWV9PDLTL
	 UwtqjtIdTUygZ7DF0/UdiQvvxrTONl9qjmEg8KaDo2/TLDhS1iQgAPV92x6R9F3U4wQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793082765;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YNC+5Q8ywcVhaGkJ70ug7xQ9xzmTEHv9efz0hGnifpU=;
	b=r2guivh7WWsg4/tAd0CZO93VzFDutVkbWLSZhFga2UeLTPt/8lNoAkU6QE2k4r9BExDE
	 Z82CZmo+fOTCuaC21YO0oMMZ8Hv2EmgDHDGVAMe+ETT8jUQY/nf9tvf9ZV2OYiu/6VWeh
	 cpbRosWbBn1Sk//WhSl7Cm+didn+bM5+bP3FtCzOfo3Xw4avxhDvDD/8+KrXRv7mE7Rxl
	 sto7PMqUZXe6fCfpoSYRa2OSiOk9eQ5bF0j5DUlJ+5puVdvgXl253IRGYczaRYzsRCuQW
	 LYhzhDbMNKYnJubzOyZDRN38Wa9+2KvQoQ/waZjpUk/vKaWxIEXYg59op3M7pXsepDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T1EUY+2q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9867606A31D
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 06:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9867606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T1EUY+2q
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eadef147ffso3773532e0c.3
        for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 23:32:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793082763; cv=none;
        d=google.com; s=arc-20260327;
        b=nc4Td1aQeH8iHcCCJ2sA8m230prcPrajjrKE6gd8kOtGWyQaUe0gOcU6z2HH2eqVcj
         tU13iZZKM7N9wouJ4Mda1E2ndZ08NVPptq9gaHVSxYOESn/5IxSC4MUi54J6JMmgaKNL
         A3vgYVKSa3ylfkTANaJsjQUCr50HWg7E3tfsh7EH6OLuofAivE3Bt9xK7zSN3HilhVWB
         kZ2IgSRzc17mvS3j8n934TJImHAjEDqqW/6alIMkma/8N6exVDzvb0PCaQKeQvSnzzOO
         LLd3SiZUwbbjfdvq0s+KcH3VmhoNPQbIvEU8tezbav+r0lM5mc0nRMgt06Ev8s52fApN
         12VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YNC+5Q8ywcVhaGkJ70ug7xQ9xzmTEHv9efz0hGnifpU=;
        fh=Gtj1DC/Ujx38FNRIC8hkla7tqUL2/xp0c6cpJ6mp2OY=;
        b=e6Ch4dhjOvbwtvvTSdYkkeZ3i5IznhYvYUmjabwFSWyTghjxHYXNJY9P5TXOqwXPM1
         c4NQrNMjGKXOMtYeCn2ak7PvqfnLNsvu5w84v5EOK9lMOVh9GGf+RKtBvja1WrmGo954
         0pWN2yO3hF94NMA6BqllskRGIjeda+bw6U63l51YJ9nXigLo3b28p6fCFnUPpiK4VIGb
         XPF1Tzw6GQebwrinxg1mjYJ2aFo1sg4bqaJJ/HO6hqBSERB0bfCsi64U+ceKyydU6wkA
         TnzLImjMI3uVbF4ZrJ40ZxfIELeSxQfFtRh5nnp/1zk0APOD4jEHVfjyH9+5IHXACeyY
         PbNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793082763; x=1793687563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YNC+5Q8ywcVhaGkJ70ug7xQ9xzmTEHv9efz0hGnifpU=;
        b=T1EUY+2qXsctc1tc/qq7ArsLq0EMQ3l3tMckOGlsXUXZXg3pUyx66odPL8RGIP3fTo
         lCzolKrjt84LSV3V8/fPTRxef5J9tF1UzGopXPIoDMAKYJrD4Qcg/lA87ntLSErMpkdD
         Ovg+hPsdL3bpX8oh1fKaZJ/7VmdlfIGeSLhQBxfg6lqnj5JAxR70KOFMJ1KOodL+6cr5
         8YUXui+rwr52ywhomIVEkSeHRSLRTGfa52u+18yIfH/pokp8BcfwZYVkIOOjq/+FaVn2
         Ng3f8hK78sjIm8G0IlliLYaQnaB75TIgAKtr232zQHkCZ+DoD2GStZ4BwHsS3DpweVxU
         nsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793082763; x=1793687563;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YNC+5Q8ywcVhaGkJ70ug7xQ9xzmTEHv9efz0hGnifpU=;
        b=oqdfRy1d0/rbFFZiunDX+Z2e2LI+IxQ9+GgMEmgP0rvwLG+pzC4OqMfGLAi7qyXJng
         5QW2JUl58LiMsxEZCxqVu/9JBp+iCPaLUeHvtM1VLFmJ/r9QEWn6vg9Z3aBBDUwRq0lt
         cIgr3loknriYGhz2SBi3f3gSiIkuJTCZIc/QFU8+tcLmzmJcIHbHvsx221ScteyiEOgJ
         M+XseZpflUJvvfhVdGu6ocJ5XkK4n+2bQPGCsAFqZLPpu0c7Dhwj9cF7UvnZ7cbg0quG
         3EZygrY3lPBPtbYIXEFgU3WWP2i8YSUVxOG2yMKjrmdFXZ+Zmbn5YOM0Kc1UVqyaXWPy
         +d3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwcZOS66ETlnGPlrCog20hMoYRIz9LKgmMSHxDr8Y5eGANi6zkLJdV8feoJzVUqWQ4SKvlKbrwiuXjbrg8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9a/PCJviwNXFfGciAEEFtQ4nh/mdO8adzb9y+UFrjYELqZaOj
	K6prHaWh3p7v3z8cXFK29Gm90CGhz+/f6q56b9JvetSKzRlFYye8HMhdRqiG02YBvCXKcKkK19/
	jibt7vmhDUKYuJCu2jG9Lg8IAGv5w90E=
X-Gm-Gg: AYBFou1jLtwVXy/wLF2j1vgKMz8HmxQerxPFow4878ZuumG2c8JaDXuF1UK2ctu0wPT
	Q5PzprHzzZtQNCVjwWwNUmg+qlT2cNBUvP56z5ql2+ifL70VfkF2nBr+41wR9L2AVXmLXTXIBEH
	5RRcVc1wy65EorZZweQZsUF0hQjrG65VwLYYgcbwAMBEM9CR0OmbR0KwiGfWp2lCQKPo72I8Gwy
	yuqUxq6qSjMIzfjdo683L27mXT7pO2TACJL16voDR5b4XSLnbwRLu+1g7cVyXsd76AXdK3fLw6I
	8wP+E75wBpss+uh+ZGpXBDpsljOmVCHZyYnjFZ7xlapfitGzK2eC1IJbD3evVb2IIyGuXvx96rA
	Hzoi3J0+Tih0RoGQ5js2lrncXax9vikQNYfjjLTAKhtbPwkvQDjiyqPRgiyBEgvSmnnTQHmfhfp
	+RnjWa98US/l1ORf7CDwzIjByF20S/OSIBU0/W25i2WsBXD7A1Ia91AsZxMekeMWzZQpAqX4T5e
	s7OXnQ9bybcpz5jIBxG+AnK9P7DKA==
X-Received: by 2002:a05:6122:511:b0:5e9:731b:850a with SMTP id
 71dfb90a1353d-5ec2325307bmr3697218e0c.11.1793082763616; Mon, 26 Oct 2026
 23:32:43 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024-submit-serial-8250-rxtrig-lifetime-v1-v1-1-731b78d5003d@gmail.com>
 <53624662-e94e-4fcb-9902-7fa4143c7689@kernel.org>
In-Reply-To: <53624662-e94e-4fcb-9902-7fa4143c7689@kernel.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 27 Oct 2026 00:32:32 -0600
X-Gm-Features: AclHuK-VteJCDyZWMTDi6g_Udz_eBxnBl4fZK7ID0EFFDg2cuYephSJCH3PY-eQ
Message-ID: <CADvTj4omDXXWBLJ__7jDjJHgkPe8NTc3BrVp0snexe-ETKNctg@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250: clear RX trigger callbacks when removing a port
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Crescent Hsieh <crescentcy.hsieh@moxa.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 12:09=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> =
wrote:
>
> On 24. 10. 26, 22:05, James Hilliard wrote:
> > serial8250_unregister_port() removes the device supplied by a driver an=
d
> > normally re-registers the persistent slot as an unknown legacy port. Th=
e
> > slot retains its RX trigger callbacks and sysfs attribute group, so the
> > replacement rx_trig_bytes attribute can still call the removed driver's
> > code. Unloading that driver leaves the callbacks pointing into freed
> > module text.
> >
> > Clear both callbacks after uart_remove_one_port() has drained the old
> > sysfs users and before registering the fallback port. Its RX trigger
> > attribute then uses the generic handlers, which reject a port without
> > FIFO capabilities.
> >
> > Also copy the callbacks unconditionally during registration. A replacem=
ent
> > port without custom handlers must use the generic implementation instea=
d
> > of inheriting callbacks from the previous owner of the slot.
>
> I don't understand why this is a problem only for the two callbacks.
> Care to elaborate?

It isn't limited to those two callbacks. The specific path here is the
rx_trig_bytes attribute recreated for the fallback PORT_UNKNOWN port.
Its show/store handlers call get_rxtrig/set_rxtrig directly, without
requiring an opened or initialized port. The FIFO capability checks are
inside the generic handlers, so retaining a custom callback bypasses
those checks.

The other callbacks have different protections: serial8250_init_port()
clears pm, for example, and uart_port_startup() skips startup for
PORT_UNKNOWN. Those protections do not cover subsequent slot reuse.

In that replacement case, startup and set_termios are also copied only
when the new driver supplies them, and serial8250_set_defaults() does
not reset them. They can therefore retain the previous owner's handlers
too.

This patch addresses the direct sysfs exposure introduced by the
referenced commit, including replacement of these callbacks when the
slot is reused. The other retained callbacks need a broader cleanup of
the replacement path as well.

>
> > Fixes: 8a6c543cf8b3 ("serial: 8250: allow UART drivers to override rx_t=
rig_bytes handling")
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >   drivers/tty/serial/8250/8250_core.c | 9 +++++----
> >   1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8=
250/8250_core.c
> > index 42319843cb5b..c638e10c43e2 100644
> > --- a/drivers/tty/serial/8250/8250_core.c
> > +++ b/drivers/tty/serial/8250/8250_core.c
> > @@ -830,10 +830,8 @@ static int __serial8250_register_8250_port(struct =
uart_8250_port *uart,
> >               uart->port.get_divisor =3D up->port.get_divisor;
> >       if (up->port.set_divisor)
> >               uart->port.set_divisor =3D up->port.set_divisor;
> > -     if (up->port.get_rxtrig)
> > -             uart->port.get_rxtrig =3D up->port.get_rxtrig;
> > -     if (up->port.set_rxtrig)
> > -             uart->port.set_rxtrig =3D up->port.set_rxtrig;
> > +     uart->port.get_rxtrig =3D up->port.get_rxtrig;
> > +     uart->port.set_rxtrig =3D up->port.set_rxtrig;
> >       if (up->port.startup)
> >               uart->port.startup =3D up->port.startup;
> >       if (up->port.shutdown)
> > @@ -953,6 +951,9 @@ void serial8250_unregister_port(struct uart_8250_po=
rt *uart)
> >       }
> >
> >       uart_remove_one_port(&serial8250_reg, &uart->port);
> > +     /* The fallback port must use the generic RX trigger handlers. */
> > +     uart->port.get_rxtrig =3D NULL;
> > +     uart->port.set_rxtrig =3D NULL;
> >       if (serial8250_isa_devs) {
> >               uart->port.flags &=3D ~UPF_BOOT_AUTOCONF;
> >               uart->port.type =3D PORT_UNKNOWN;
>
> thanks,
> --
> js
> suse labs
