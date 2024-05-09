Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D96812DD9A;
	Thu,  9 May 2024 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251312; cv=none; b=eGge0aBitcug5MpizISPFOPQDzuvdalURevCNBaLHNfoVB+JfRcWFPkmgYDSfWOR6FncrOzwqe9/XMepU10lyE1cpvb6V+4FOc8rLKeIZaS/nS5sYvmbFik1sjyu9bNWdtMNEAMQ0Vv9JavBgAfWngqvYtNIB8lUXCRrS/0K1cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251312; c=relaxed/simple;
	bh=dWmcZ55RwlWzopdm2MrjCUbObr1JH+NBfWDA3eR0PC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8EuCNTmEshcZcQeNDKHqGzbFVOQxdpr2oDTS0KeLVOrStatOYrGFPpV0DFcFbjZYKyWNelmznFPpIKSAwo0mfBf4qIUgZTN6OnK0xxsWEqvGaaeBFeL8Kx9y2+MvbMVqdvt3tkhO9pVjToaW0or1drxWoMkx5n/FCnB6iCMHD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wa9A5C0w; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wa9A5C0w"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f460e05101so536651b3a.1;
        Thu, 09 May 2024 03:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715251310; x=1715856110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6RMqRZX0HIBUYzm8GMDrhg1RkSGNPy9fJGMUwnU3cVE=;
        b=Wa9A5C0wLKywUHXVq9m+NXBcZLrU/6PrmXyQA3LGwvpeWjHnkqDo8KjMFS3wxw6ncL
         +Z4Atj4cvfAFoXDGifoaF9ZsO/3RpjmNOPfMu1vnwrAiDtWvDnCMyFhuQf3btBm4nvd5
         AgOurXVX8j0dFxGvEZxk3kaTP9hpEqg3dF/n9TzeuU5Yq9jRhAYbJGlmK3rDPhlJCbPd
         C5Eb2+BuSHzuCKb81AhXXs55sNuODpw7QENOrOoCdT5tuwkX+WKxAJ2COvPiMiCAN92b
         6AypryguXYi9UdBWO7+MjpWtyWF0hxgq3h2nH/q30A7QN8LuO/+2JUxY0NQCuugaLztI
         ScFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715251310; x=1715856110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RMqRZX0HIBUYzm8GMDrhg1RkSGNPy9fJGMUwnU3cVE=;
        b=Pr6ZbLTHaWhEJQnh1ilhWzwteB1SJyVoPydnPF+ylO+29Xipb65JdgFblpzJ5gqHz+
         ktJaeo5pD4k/sveUB0TAnp4VvA0JhIpfspGd5GakeK20+z8lWDTLIkiC1oNk6bkWL+vh
         ZKj/ypZxxz+U/IwotI3I9tE0m+b0GXMm5coCeGe5poFo1Y/jt+MR7wirN4qeoyP9Cl/o
         LGVicTMV8DUOLyNhYqYamS0AsbjG8eGWM4249n/43Fvzew6ZW+6zPGUUZ01k/kFLgBYF
         Kkdi2ElKS9H2WwcyRhqQSbATzCjYXKKQ2Hku805bqqq4Z2FvTBT0+Dq6cJoX/Bad99fQ
         EZEA==
X-Forwarded-Encrypted: i=1; AJvYcCUD0iM+rYy7hRUIKb3JEyk/sYX5iOJBbkVAirEVNH680a9ooIQNH+6S6AcgNKpHht8yU73fO2yE7recDYZRymeVMZE+j8r4LTv9HIAG7atYunPMPUkR2XF2ldn1V/j/jwRloQvMyFoDrwGz
X-Gm-Message-State: AOJu0Yw3mJMJdsxPmrpaCyRyrMAqVtvKjuygy0s3gBwX3LYEfbUxu+xB
	LXTbD7zxhXkVg7Bmhud5Msp8uay1qVzztofFJH+ADq+BSw3vppZv
X-Google-Smtp-Source: AGHT+IFShpc5EqZaSEqimhDxw5q2VLiTnTbYjMPFsUhO0YAAA+2DSBT05n9MeLgO4CftUumVO2HIDA==
X-Received: by 2002:a05:6a00:1826:b0:6f4:4b35:d7b5 with SMTP id d2e1a72fcca58-6f4c908b5e0mr3906907b3a.1.1715251310214;
        Thu, 09 May 2024 03:41:50 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af523csm1049662b3a.175.2024.05.09.03.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 03:41:49 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 805D6183B5E8A; Thu, 09 May 2024 17:41:45 +0700 (WIB)
Date: Thu, 9 May 2024 17:41:45 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Serial <linux-serial@vger.kernel.org>,
	Elvis <elvisimprsntr@gmail.com>,
	"A. Steinmetz" <anstein99@googlemail.com>
Subject: Re: Fwd: Add method to allow switching kernel level PPS signal from
 DCD to CTS serial pin
Message-ID: <ZjyoaZ1zJhMVGjbS@archie.me>
References: <Zjra2GZIDC7BPoZx@archie.me>
 <2024050853-basin-salsa-32bb@gregkh>
 <20240509062456.GE3620298@mit.edu>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nKxqMyvWjc07RdJB"
Content-Disposition: inline
In-Reply-To: <20240509062456.GE3620298@mit.edu>


--nKxqMyvWjc07RdJB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[+Cc Rodolfo and not1337 (kernel hack author)]
On Thu, May 09, 2024 at 02:24:56AM -0400, Theodore Ts'o wrote:
> I'd suggest that you reach out to Rondolfo as the maintainer, or to
> the linuxpps mailing list.
>=20
> First of all, looking at the patch referenced in the bugzilla (which
> is actually found in github), it appears that the person who made the
> request via Bugzilla is different from the the person who authored the
> patch (apparently, github.com/not1337).
>=20
> Secondly, the patch is really quite hacky.  First, the termonology
> used of "4wire" is non-standard (e.g., uised nowhere but at
> github.com/not1337/pss-stuff), and misleading.  A cable which only has
> RxD, TxD, RTS, and CTS is not going to work well without GND, so "4
> wire" is quite the misnomer".  This termonology is also not used by
> FreeBSD, BTW.  Secondly, unconditionally mapping CTS to DCD when
> setting a magic UART-level attribute is a bit hacky, since it will do
> this magic ad-hoc mapping all of the time, not only if the PPS line
> discpline is selected.
>=20
> Now, I haven't been the tty maintainer in quite a while, but in my
> opinion, a much cleaner way would be to plumb a new tty ldisc
> function, cts_change, which is analogous to the dcd_change function
> (which was introduced specifically for pps_ldisc).  Then for bonus
> points, consider using the pps capture mode mde that FreeeBSD's UART
> driver, including the invert option and narrow pulse mode, and eschew
> using the non-standard "4wire" naming terminology.

I have pinged Rodolfo (and also Cc: linuxpps ML but the ML address bounces,
essentially turned into private mail) and here's his comments about the
feature request:

> The DCD-change information is delivered via struct tty_ldisc to the PPS c=
lient pps-ldisc.c (file serial_core.c):
>
> /**
>  * uart_handle_dcd_change - handle a change of carrier detect state
>  * @uport: uart_port structure for the open port
>  * @active: new carrier detect status
>  *
>  * Caller must hold uport->lock.
>  */
> void uart_handle_dcd_change(struct uart_port *uport, bool active)
> {
>         struct tty_port *port =3D &uport->state->port;
>         struct tty_struct *tty =3D port->tty;
>         struct tty_ldisc *ld;
>
>         lockdep_assert_held_once(&uport->lock);
>
>         if (tty) {
>                 ld =3D tty_ldisc_ref(tty);
>                 if (ld) {
>                         if (ld->ops->dcd_change)
>                                 ld->ops->dcd_change(tty, active);
>                         tty_ldisc_deref(ld);
>                 }
>         }
>
>         uport->icount.dcd++;
>
>         if (uart_dcd_enabled(uport)) {
>                 if (active)
>                         wake_up_interruptible(&port->open_wait);
>                 else if (tty)
>                         tty_hangup(tty);
>         }
> }
> EXPORT_SYMBOL_GPL(uart_handle_dcd_change);
>
> But for CTS this is not (serial_core.c):
>
> /**
>  * uart_handle_cts_change - handle a change of clear-to-send state
>  * @uport: uart_port structure for the open port
>  * @active: new clear-to-send status
>  *
>  * Caller must hold uport->lock.
>  */
> void uart_handle_cts_change(struct uart_port *uport, bool active)
> {
>         lockdep_assert_held_once(&uport->lock);
>
>         uport->icount.cts++;
>
>         if (uart_softcts_mode(uport)) {
>                 if (uport->hw_stopped) {
>                         if (active) {
>                                 uport->hw_stopped =3D false;
>                                 uport->ops->start_tx(uport);
>                                 uart_write_wakeup(uport);
>                         }
>                 } else {
>                         if (!active) {
>                                 uport->hw_stopped =3D true;
>                                 uport->ops->stop_tx(uport);
>                         }
>                 }
>
>         }
> }
> EXPORT_SYMBOL_GPL(uart_handle_cts_change);
>
> This is because the struct tty_ldisc has no cts_change() method (file tty=
_ldisc.h):
>
> struct tty_ldisc_ops {
>         char    *name;
>         int     num;
>
>         /*
>          * The following routines are called from above.
>          */
>         int     (*open)(struct tty_struct *tty);
>         void    (*close)(struct tty_struct *tty);
>         void    (*flush_buffer)(struct tty_struct *tty);
>         ssize_t (*read)(struct tty_struct *tty, struct file *file, u8 *bu=
f,
>                         size_t nr, void **cookie, unsigned long offset);
>         ssize_t (*write)(struct tty_struct *tty, struct file *file,
>                          const u8 *buf, size_t nr);
>         int     (*ioctl)(struct tty_struct *tty, unsigned int cmd,
>                         unsigned long arg);
>         int     (*compat_ioctl)(struct tty_struct *tty, unsigned int cmd,
>                         unsigned long arg);
>         void    (*set_termios)(struct tty_struct *tty, const struct kterm=
ios *old);
>         __poll_t (*poll)(struct tty_struct *tty, struct file *file,
>                              struct poll_table_struct *wait);
>         void    (*hangup)(struct tty_struct *tty);
>
>         /*
>          * The following routines are called from below.
>          */
>         void    (*receive_buf)(struct tty_struct *tty, const u8 *cp,
>                                const u8 *fp, size_t count);
>         void    (*write_wakeup)(struct tty_struct *tty);
>         void    (*dcd_change)(struct tty_struct *tty, bool active);
>         size_t  (*receive_buf2)(struct tty_struct *tty, const u8 *cp,
>                                 const u8 *fp, size_t count);
>         void    (*lookahead_buf)(struct tty_struct *tty, const u8 *cp,
>                                  const u8 *fp, size_t count);
>
>         struct  module *owner;
> };
>
> So, in order to do what you suggest you have to add this feature first.
>

>=20
> Finally, note that the way kernel development works is that it's not
> enough for a user to ask for a feature.  Someone has to create a high
> quality, clean, maintainable patch.  Note all random hacks found in
> random Bugzilla or Github git trees are suitable for inclusion in the
> upstream kernel.  And if you don't know how to evaluate the patch for
> quality, it might not be best thing to just ask the bugzilla requester
> to follow the Submitting Patches procedure, given that (a) they might
> not be a kernel developer, and (b) it might just frustrate the
> bugzilla requester and maintainer if the patch isn't sufficient high
> quality, especially if you've managed to set expectations that all the
> bugzilla requestor needs to do is to submit the patch and it will be
> accepted.

I also expected the same (provide patches).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--nKxqMyvWjc07RdJB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZjyoZAAKCRD2uYlJVVFO
oxUmAQDP92/mNAgiTMk/ZDg9tWCvhkHcwhlnjEUMlIZodcZ6AgEAv6dwG6ofkitj
gfQ4umEXVPnPvO2XNcFNvcUCm0PZ9A4=
=T0A1
-----END PGP SIGNATURE-----

--nKxqMyvWjc07RdJB--
