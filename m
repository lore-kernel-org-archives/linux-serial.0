Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.215.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794489414;
	b=oEuJzKCQi4FeXKxnCnIjSKvlMkJQEED1eOvGi7btTTnR4Zbhjzz+d1xMGdBVwlJ7L3g3
	 PBeX47Mk5Th/AaaDvRjh1Qd2V3+xnu4f8IG5X6R97epHUJoTIMOnvoCSQBT+mNQ1a7RTY
	 Zo4AqnOnNLVAemtADySY6SaqHeZtjN4ZyctXO3eilsTr1ZBH2k/4I7fVKXvbpxZoBoCYC
	 lMUbFtIZqN3DI53VmLjkBvD2cX09GA9RSJqUGWmWqamLM4rSb0NfU9hdd8zX8wvZhoVUy
	 Nwn86EB8Hbw/RDAPDZT5cxKEp0yFcFm9801PZwxtPEqT6Irv33sTSQqx4s7t+7ZEqoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=IhzF0+tcNo5kCDahctjPTIknxC8jK7QawDXcg2iqpig=;
	b=n5rCOucZb0Xnqqt6ItxvmPuOvrDjD1AVVVYtGEmUz5qiGHT554fDfBGdb7MSA3nyBIYo
	 PFR5dgATLOXleumD1PY7AM1m3NQURGdXAUERKSKXkPk5TfeJ/6ouZeIDTqNm8w27VuCXY
	 0VtdMEf3RihWQC6zk1egZSBjJ2I6kwhsRX5pRFWFw4Lsc3eD/j1CF97I+Zdv2EzYI8DgO
	 4egRIZMdi+6/pF4chIypsSj1ajaepsklJEFjITkzCRmu3YE/03mCexNnw5rpwGVGBk+5N
	 4aVeXuPxHaCcLAQPRtoO8vMPMhCg006pEXFrhfZSxWsFxnrg5zdPR8CSWY4OR20s5vg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZiWpx37w;
	arc=fail smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010ED606A331
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 13:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 010ED606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZiWpx37w
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdb1199bfd8so1853772a12.1
        for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 05:16:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794489413; cv=none;
        d=google.com; s=arc-20260327;
        b=hdIFivLGfDsVFuIjPrJuhRab8WwQIbNtpa67n2X3to673t4DGYASSw7CLr+FzjFG3m
         j5rS8s8nH/V0EWrvJtanWyKoccyjcqXNCuLMB2vBEiyg8UdUTDtfB6HAflsRIv0BfZoo
         s9sGfGrNSjQxmjLeCslmDCFlWEmVrUFygzIEw9BYrpf1gqYktbGVSVCAkoTHs+ZwDPfS
         KOHVw/FKPBKjsP3t6CQFv9nXq46/rNRLERXk4cMaSaRv+Rt1/aqDqQMdsVVCmN/5bhWG
         kpljeHDCls1DxtH7dvRPlT431JTX+yfygkXjO09GGXhihgGBDhj3EpxDimKh+Eur1EcW
         X4Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IhzF0+tcNo5kCDahctjPTIknxC8jK7QawDXcg2iqpig=;
        fh=/QP+n2O4Hyc4wPS4zFFRlhIZQ4uvqm/l12+HjjpmfsY=;
        b=MUejNz0OGKJvwmlMo5wWfv5r8kZf6znxMqEV5oc15YqHRqVhxHqdm9Q1EiVS1KNGir
         ZrWzQr6uHEMV9sUPBSDsxoBhM0mFnU9+bJZgUN/IvG363ngo9ufGgdghbHF3k1r1nJUN
         gQHqSP4OEqWOtsddtB+dP4/SkA14upjojCLRsDCK2TMDQrMqDiCVy3FmUwjpIdO+o5Fi
         V21cFnlwzg6hNhES9bKr0d1DSwncmWlCpKpb+UnZGxV5bbW2qYreIr4MlcwNProUid0m
         TGOQjhNt1OXtU3eix3LvkEr8rrNK7HAH2eK9i8ZwJPNssQEO+DssyOP3qzj7JlWjQ3L5
         iQmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794489413; x=1795094213; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IhzF0+tcNo5kCDahctjPTIknxC8jK7QawDXcg2iqpig=;
        b=ZiWpx37weud7aC9KO6c6drerOCd6+ygYANZLNtoYglUi76j7uX3l3+QBLQpu3NagB1
         OkvchIojBTa0nmn37bNfbiS3t49ER+EfiCWJy6JBC0Hz6h3w9My7kp3hRgT8un9u/5jf
         YhxtzpXpHue6ltd5xOAJkZR5b9rjlRqUxE+ceg4IcKsXpNBz8zLG1ghVOy6uM8D9tZPC
         09Zd964hIVRntNDVwAIeHYGmc6vCVk8cHirMIFu2OaaXDLhiHh5+0eeXYtGJUb3Jk4KH
         DfBtaz6a7t3t6O9ubHWqkfc5xpvPcBLjGMVBpEvZNzTvCnRWmh0VmZenpdesDFBPKHJB
         Nrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794489413; x=1795094213;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IhzF0+tcNo5kCDahctjPTIknxC8jK7QawDXcg2iqpig=;
        b=cI+LO99rhPfW6bRMQhU+tbG6rzLQgdv+ZZeIfBN4vNNOwIppSbi8tVFadWyJJXeyFg
         m89M7fQi2s/UyiNIO4oqKPIIZm6difdJZNZhap7G2rYIMLL3PaDW1kuBSbNzZGKs9o3Z
         mY+FJfWzB2Bg36U4KOq0hMve8bEYH6+zh3IE2fEmmO4ICEFeE4k1Dwpl7gLjP7xhDaWY
         pd45g5ArpppiN7yCkvWl9Pnb1LEnFyWigFIz8wROS6aIsHI/pe24FQYEKk/0yEYGM/eK
         +2Gzy0r5hoRpBUUa5a+Y8pSu6rnS3FJ02nvLprkSVCKvKh8FWvSAROvUukC6iPhc7RSS
         bSZA==
X-Gm-Message-State: APuU4Z9gUpx72Tb/WXX9mrR2sxcmZ/yW6qaZIRsbN3mt2JwmAL9+7Tcf
	GFfhCTH1QcVKu7htgT26jbGq/RcBJvJhAxVff6wiZaG8kvvgVFVrlvhUDSbTZ3yS8YTFGC36BqS
	9XG7kadxl4pHus8j20VEXxZhmNbhXWaKWhfun87o=
X-Gm-Gg: AYBFou33uukRv+l5tr6BfaoggfARkW7Mq8y6tl7SiKBNXSQUkHh8aUlaD/6sM3Zh7c1
	jKMUIXYaiSG1wub3QuxQa2yywMI9Cm8JQHqMddvvL5doXTFaJ/4C3v+FIkLGVe+599IRUqUXldw
	qUkwulRBIkEfMt9vxU0EIpZBJws8Ql4zpbJh3ou9A2y9TbUZVRhUuybads6MHL2iKWaV+9PytT6
	i6dBDDfJA1sPnXDoJUFQLnu/AY/qOXDzCbLVz7OqLYuw+6POiNjUyaMbzEo/ZegUHd2KFG7Ogpw
	6b9z43aGCVqZkjpLC9SAjz/BBFXO46Mobe6bsRrLjcIk9wO8boL4xvmFd2GFkjPZi+UOJrcjkv+
	VIG+3ClyET8QM9nv0tM4WyCb7AlmHXK0vKsDVFyk8MdP3W8pi0JxvdssYeK1eZV9rWtML+w==
X-Received: by 2002:a17:90a:b107:b0:3b1:83aa:5b53 with SMTP id
 98e67ed59e1d1-3b183aa5ed3mr3810832a91.58.1794489412974; Thu, 12 Nov 2026
 05:16:52 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-vt8500-serial-cleanup-v1-0-b33594a25f87@gmail.com>
 <20261111-vt8500-serial-cleanup-v1-1-b33594a25f87@gmail.com> <sashiko-outbox-209587@kernel.org>
In-Reply-To: <sashiko-outbox-209587@kernel.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 12 Nov 2026 17:16:40 +0400
X-Gm-Features: AclHuK_EzwJVOg4AvJFgWeK4zwSmKMqdVxsBfBYhFYya4Gb1hOc3LGAcrZC_RjQ
Message-ID: <CABjd4YyN0aj_AY+GmsREkq7LavmSJRB2c61JyMR2yn7eiEkwMg@mail.gmail.com>
Subject: Re: [PATCH 1/4] serial: vt8500: Find console ports in the serial core state
To: sashiko-reviews@lists.linux.dev
Cc: linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 11:42=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] serial: vt8500: direct access to private uart_driver.state field
> --
>
> commit 97ad19d6dd8fe51bf33a0dd201b9aa1860b0702f
> Author: Alexey Charkov <alchark@gmail.com>
>
> serial: vt8500: Find console ports in the serial core state
>
> This commit removes the driver's vt8500_uart_ports[] array and looks up
> the console port via vt8500_uart_driver.state[co->index].uart_port in
> vt8500_console_write() and vt8500_console_setup().
>
> > diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt=
8500_serial.c
> > index a7f167a734160..6c53e108756a8 100644
> > --- a/drivers/tty/serial/vt8500_serial.c
> > +++ b/drivers/tty/serial/vt8500_serial.c
> > @@ -444,7 +444,6 @@ static int vt8500_verify_port(struct uart_port *por=
t,
> >       return 0;
> >  }
> >
> > -static struct vt8500_port *vt8500_uart_ports[VT8500_MAX_PORTS];
> >  static struct uart_driver vt8500_uart_driver;
> >
> >  #ifdef CONFIG_SERIAL_VT8500_CONSOLE
> > @@ -472,28 +471,27 @@ static void vt8500_console_putchar(struct uart_po=
rt *port, unsigned char c)
> >  static void vt8500_console_write(struct console *co, const char *s,
> >                             unsigned int count)
> >  {
> > -     struct vt8500_port *vt8500_port =3D vt8500_uart_ports[co->index];
> > +     struct uart_port *port =3D vt8500_uart_driver.state[co->index].ua=
rt_port;
> >       unsigned long ier;
> >
> >       BUG_ON(co->index < 0 || co->index >=3D vt8500_uart_driver.nr);
> >
> > -     ier =3D vt8500_read(&vt8500_port->uart, VT8500_URIER);
> > -     vt8500_write(&vt8500_port->uart, VT8500_URIER, 0);
> > +     ier =3D vt8500_read(port, VT8500_URIER);
> > +     vt8500_write(port, VT8500_URIER, 0);
> >
> > -     uart_console_write(&vt8500_port->uart, s, count,
> > -                        vt8500_console_putchar);
> > +     uart_console_write(port, s, count, vt8500_console_putchar);
> >
> >       /*
> >        *      Finally, wait for transmitter to become empty
> >        *      and switch back to FIFO
> >        */
> > -     wait_for_xmitr(&vt8500_port->uart);
> > -     vt8500_write(&vt8500_port->uart, VT8500_URIER, ier);
> > +     wait_for_xmitr(port);
> > +     vt8500_write(port, VT8500_URIER, ier);
> >  }
> >
> >  static int __init vt8500_console_setup(struct console *co, char *optio=
ns)
> >  {
> > -     struct vt8500_port *vt8500_port;
> > +     struct uart_port *port;
> >       int baud =3D 9600;
> >       int bits =3D 8;
> >       int parity =3D 'n';
> > @@ -502,16 +500,15 @@ static int __init vt8500_console_setup(struct con=
sole *co, char *options)
> >       if (unlikely(co->index >=3D vt8500_uart_driver.nr || co->index < =
0))
> >               return -ENXIO;
> >
> > -     vt8500_port =3D vt8500_uart_ports[co->index];
> > +     port =3D vt8500_uart_driver.state[co->index].uart_port;
>
> [Severity: Low]
> Should vt8500_console_write() and vt8500_console_setup() reach into
> vt8500_uart_driver.state directly?
>
> include/linux/serial_core.h:struct uart_driver {
>     ...
>         /*
>          * these are private; the low level driver should not
>          * touch these; they should be initialised to NULL
>          */
>         struct uart_state       *state;
>         struct tty_driver       *tty_driver;
> };
>
> struct uart_driver::state is marked private to the serial core and not
> meant to be accessed directly by low-level UART drivers.

This is true, although sh-sci.c and xilinx_uartps.c reach into .state
directly currently. I'll add an accessor instead as part of v2.

Best regards,
Alexey
