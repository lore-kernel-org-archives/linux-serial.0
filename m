Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F33F2E7BD9
	for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790427944; cv=pass; b=VmnHT2UEkXhefkp2XygUUQI+UQWu5mE3REhX5B6UCLyxUpqypQQQ91ChCActxdWaiFii4yS+9TYXfPKEYPKGuYNQCO/jPKYcFBVb3u+uM4niTMHh3Z0yEL7S5S72BRO/XF1JjRvlxnrFI+RqUp+dfKFAAq681vqxuFaHErggy/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790427944; c=relaxed/simple;
	bh=3K1mfZhkgDFKMH7R9y8Ez2dUkmBN2l6z7mjcFIu/Lgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJ0E4h66CHkyGNIT3ORHXY1cihDUWG6z5WwkJEqL1bVc/RKVnrjX/NRmE7DXV1EBBZoNBMxHzzHcvRYlNQ6QXboF2Vxm9FjCdd9vO4mIwbpF1PCCiUWhy1oNQR1ySrDYNguWoyIpv27pN48qaMeKQM+Jul0KwGZ2k9SJMji9WAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYFEs2Jw; arc=pass smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYFEs2Jw"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8ef09e288so614318e87.3
        for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 06:05:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790427941; cv=none;
        d=google.com; s=arc-20260327;
        b=Y7kJHgPHsjwJxlwaZB1YtBoaGGIO9//NmWMp4Y3AmDKXT3IKH/v2AI+NqHQBT4EH/T
         sfzYCS8PHvR7Yxh2PZkP27ujRNfbyCkKJodDsaPqd7Z0vTBEUONDGLLejCfM2iulbQyc
         NjA36yLTqsslthfXwK5/9qPXiXDGIoe5HaxvlgaHdzM95zV5zZsP0h5OTasXpTVEhgXB
         o76aLxaCWQHNRZGT/XuPJnhMDN1NqAbD7FWemKjHSaG/VRx5vyv0dY5UGDFN2jMv6I9U
         8y82spKMja27Jr6W4nmdro6mIvO/qhlYUCdNttKuxU1x9iN5xDVK3WvzFoxIJErh9izE
         gHng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vi7otOLbSF1iO51/yCWzfPAUbn2qv/rzgZ6612F0vc4=;
        fh=gSZ/vuKf4P8sysMBzzZ6LFDncYgH140kKAYsXkLPtbg=;
        b=k9WgOBd5OzVC8SKkmGwb13Qezmn2mCQ0XWSesdSFjr5g/QGpYUi6Y+D+tZc7G7mCNd
         OqAXUpC6kNEDFsF8j5BNGFSAwePLgBw0Ax98aNMlGkoT7mBwVyUP1zM9JAK31MDG3DBb
         lzYM9GM7QB+R6gbAlUY8UJ+ssj4fMIz8I9FjOr3vM/P/YCOJdWae1jRGC8JVZp2Im5CE
         I3GTsqHnU1t06XQBErKsKHBqQzpUSVk+D5rXlpdePKEnnIaM0bYEj2wMdplVtD56oJV9
         tRZdxicS4CgJtsOjosNZRSJp1i+bFWT1WFY2Cro8AV2HUBS/flWkMt4/A7oC6tMrmbNq
         MH6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790427941; x=1791032741; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vi7otOLbSF1iO51/yCWzfPAUbn2qv/rzgZ6612F0vc4=;
        b=VYFEs2JwG20+I9lXrUtN4rxmRThMzX6fOuftqf+R2Bocyu9afPaBx3k116t4FDir7u
         e45riB8ZX8JJ3uyca8AweDGqIg+OspDwANojWmpELtyC536f57DRAAOvgygNeVUwl5Tr
         8KvCfIJTrcw4wAMrg0mpGMIItufsJcmm47IV9nO3D355EDi1G1hAjSg5VWquGzbmq+aN
         ODpGveB6k43fMZUvJ/GeLSaL0lqr+aMXkPVujyPRul9+RlCxFcYgDIA3hCOQh1CUvAQ4
         B4CS1+9Iw+P7pdA7i4riEW59ZQIl+aX3BewuNWxY40LloJqdZTWXIloT8OhL//q75Q6E
         XIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790427941; x=1791032741;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vi7otOLbSF1iO51/yCWzfPAUbn2qv/rzgZ6612F0vc4=;
        b=GeWZ1yIDtm+Ug0XlR9WSKCqkd8QZWSkFBFVVVvA3xXQ84c1nJ1p5udOGiDvuCDW0Ay
         uXaA6rXYH3zdzA8nhHlkcJdPpNBJx1b+Lqm8W6x2CMyX/sl2uYxfhdNTkpZVx4SQAYOb
         jMrbgJMXddph0fJngHQxyOagecXTQ33k+EWnKcXque94EqIsqyMZX/+yjs38JFufDjSc
         GwdCKJaYHgbdxHWViMIKczvnufeOuAo+Biveft4qIqr0/FbwqLzitw7WeEXCcO8Xc21U
         BzD3NxPwvB5foSCR7libkyxOVrYFEHmxut6IYlyNxyker5nv5D8pE6X+1YfNpO5+Jpus
         fjRA==
X-Forwarded-Encrypted: i=1; AKwUvBxKvGX6zppb+L81bJjwjPz+lkj1kdQ3Y+8XFcXZjITh8IwJGZljRhqIDfzzbqXdiybrckhjAGMtxtG0AKM=@vger.kernel.org
X-Gm-Message-State: AFuF++kM6vKkGvyS49rgmoO9tOUrtJbIFXAOz80KVlgJUzFNIB8nt5cZ
	/yIyQsmDAdtFqTSuR/1hvz5SBDXvZrSngkr4URXnJiIJsQo1AykWQGpOyRujulRQOJjQmJpUUD8
	vMax+lAdCGBpaHqIE8Mlohv8SZNNpr+w=
X-Gm-Gg: AYBFou3MC8lMgjR7MiHePjLsDqJx0iKvn2A/fpE6OvhGMuBTnnJbCoVy68BHZpVt2q0
	wWWFVee6VAl0MS12KIEirQ1p89dnx5yPsAXTrOfRN5qJAdcyE7OW4BT4qXfXIj//zB1wj6Gsswc
	GbHoEjCjWeYyYbR5aPYXfDvKj74m+CgB7VN96Q1Y+bohnMyow6KnQFUv5aOic2iVqqjuhm6Dijh
	Qzi3ONO3fACyKdQZQEmDDLqeeSQtqUwEUZjCuvgnfLq2D+WN4JWMyOeDblsKicHgnqezpE2wGv1
	WW5vF+rfE1blSn+LuyOaN4ELPXkNe/ebzTFAFf97DUkW+RcBxihzAM2Z2rxciRkpV8PHxZ9qJw7
	aiUxb/Q+lQdHGfWWgQFjrBQ==
X-Received: by 2002:a05:651c:150a:b0:3a6:5416:f854 with SMTP id
 38308e7fff4ca-3a65416f9a9mr10624311fa.20.1790427941145; Sat, 26 Sep 2026
 06:05:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924192224.3175-1-igorpetindev@gmail.com>
In-Reply-To: <20260924192224.3175-1-igorpetindev@gmail.com>
From: IgorpetinDev <igorpetindev@gmail.com>
Date: Sat, 26 Sep 2026 16:05:31 +0300
X-Gm-Features: AclHuK_ngvPeAqdZp_Mc6aSDyUBuGK7UyLzlz4V8m9b7vKesip4inNwP8GCbLcE
Message-ID: <CAG21Q81Fc1-0_ZX04tY9TUv61iQi9uYHj2Ew+vQgZjWczKbZ6Q@mail.gmail.com>
Subject: Re: [PATCH] serial: core: shut down initialized port on removal
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	syzbot+843bf2f48f4d12e6682e@syzkaller.appspotmail.com, 
	linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>, Vignesh R <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,
Note: syzbot did not actually provide a reproducer for this crash -
this patch is based on code analysis of the trace, not on hardware
testing. The pcl812 trigger from syzkaller is synthetic.

On a console port, tty_port_shutdown() skips ops->shutdown() because
port->console is true, so the IRQ is never released.
If the device is later unbound/removed, serial_core_remove_one_port()
frees uport->name via kfree(), but the IRQ is never freed.
Result: a stale irqaction pointing at freed memory in action->name,
even without anything else requesting that IRQ line.

sashiko-bot also pointed out a data race on port->console =3D false
outside the mutex - separate issue, but relevant.

If the underlying problem looks real to you, I'd rather withdraw this
patch, put together an actual reproducer (unbind a console port, check
for the stale irqaction), fix the locking properly, and send a v2.

thanks, igor

On Thu, Sep 24, 2026 at 10:22=E2=80=AFPM Igor Putko <igorpetindev@gmail.com=
> wrote:
>
> When a serial port configured as a console is opened and subsequently
> closed, tty_port_shutdown() skips invoking port->ops->shutdown() because
> port->console is true. As a result, tty_port_initialized() remains true
> and the port's interrupt handler stays registered in the irq subsystem.
>
> If the underlying device is later unbound or removed (e.g. via sysfs
> unbind), serial_core_remove_one_port() unregisters the console, frees
> uport->name with kfree(), and clears state->uart_port without ever
> shutting down the port or freeing its IRQ. Consequently, the irqaction
> remains linked in the genirq descriptor with action->name pointing to
> freed memory.
>
> When another device later requests the same IRQ line, __setup_irq()
> encounters the stale action, detects a flags mismatch, and attempts to
> print old->name in pr_err(), triggering a KASAN use-after-free read:
>
>   BUG: KASAN: slab-use-after-free in string_nocheck lib/vsprintf.c:648
>   BUG: KASAN: slab-use-after-free in string+0x471/0x4d0 lib/vsprintf.c:73=
0
>   Read of size 1 at addr ffff88802643b8a0 by task syz.0.818/8415
>   Call Trace:
>    <TASK>
>    string_nocheck lib/vsprintf.c:648
>    string+0x471/0x4d0 lib/vsprintf.c:730
>    vsnprintf+0x422/0x1300 lib/vsprintf.c:2949
>    vprintk_store+0x3b3/0xbe0 kernel/printk/printk.c:2307
>    vprintk_emit+0x139/0x6b0 kernel/printk/printk.c:2455
>    _printk+0xcf/0x110 kernel/printk/printk.c:2504
>    __setup_irq.cold+0x3be/0x3f1 kernel/irq/manage.c:1821
>    request_threaded_irq+0x261/0x3e0 kernel/irq/manage.c:2184
>    pcl812_attach+0x1b62/0x2300 drivers/comedi/drivers/pcl812.c:1174
>    ...
>
> Fix this by clearing port->console after unregistering the console and
> calling uart_shutdown(NULL, state) under port->mutex if the port remains
> initialized, ensuring the interrupt and hardware resources are freed
> before kfree(uport->name).
>
> Reported-by: syzbot+843bf2f48f4d12e6682e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D843bf2f48f4d12e6682e
> Fixes: 761ed4a94582 ("tty: serial_core: convert uart_close to use tty_por=
t_close")
> Fixes: f7048b15900f ("tty: serial_core: Add name field to uart_port struc=
t")
> Signed-off-by: Igor Putko <igorpetindev@gmail.com>
> ---
>  drivers/tty/serial/serial_core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 95774b0f1484..030735da6b8c 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3210,8 +3210,15 @@ static void serial_core_remove_one_port(struct uar=
t_driver *drv,
>         /*
>          * If the port is used as a console, unregister it
>          */
> -       if (uart_console(uport))
> +       if (uart_console(uport)) {
>                 unregister_console(uport->cons);
> +               port->console =3D false;
> +       }
> +
> +       guard(mutex)(&port->mutex);
> +
> +       if (tty_port_initialized(port))
> +               uart_shutdown(NULL, state);
>
>         /*
>          * Free the port IO and memory resources, if any.
> @@ -3227,7 +3234,6 @@ static void serial_core_remove_one_port(struct uart=
_driver *drv,
>         uport->type =3D PORT_UNKNOWN;
>         uport->port_dev =3D NULL;
>
> -       guard(mutex)(&port->mutex);
>         WARN_ON(atomic_dec_return(&state->refcount) < 0);
>         wait_event(state->remove_wait, !atomic_read(&state->refcount));
>         state->uart_port =3D NULL;
> --
> 2.47.3
>
