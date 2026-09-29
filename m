Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE090525A66
	for <linux-serial@vger.kernel.org>; Tue, 29 Sep 2026 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687309; cv=none; b=KCi1QaVt162Yj98mHF4w15VVk5ma1V21Iy1R7b+q8jXgiMmXMEMHGWf/9Wg+v/eukHejN0Kg3hbCHXh39mUtOJKBxhyH1MohgQ1UiIXHJ2GbgF5pt9stMU3ZOn3ph2Dni2JJBkMSVscqNz3T6Rsqub++hrlR+D7xkC1hEXN9wY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687309; c=relaxed/simple;
	bh=hKciauI3k8qEuoiG81DmdjR+6/zXIWJWwnNxf4M48Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMrQ2wijpBgl3delk6Zot2ud0GIrZqyPL0YxZRmmpmZ+Hz94qQ9lu74JpgBDFaEAyKz70PEIrr44PP04lXH4NkbLUrfsp+hJjDnJuzcCQFsaVYTUr/27Xah3gxLUC/FS4yVuUzOMlGZZq74JOoThq+kamNdDo0QgihrwBPZy8F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g/lMRuvf; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g/lMRuvf"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so31265665e9.2
        for <linux-serial@vger.kernel.org>; Tue, 29 Sep 2026 06:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790687306; x=1791292106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iuOkRbNJSVkFLmSsYlK0KIiULPv5CXdqQ88B5efXVA0=;
        b=g/lMRuvfHJiqumZ0Qe5ClpKAMThOClx/KWHeZBgQxyxczTVSf6M3qrg+VidTF/8dkb
         xlcEZme/p85R6mEYG/5RX6XRgyBtZb1lSb17MLpxgO6urOTdWIF0p3XQ6CMGDUhuzmZ7
         qI0LmsAQM9bAnIsy0E4mZHdtbEYFlzOKPNaf7J35D4W61iM04dJ/mzw8hiKjuvINSc0d
         QF+qzTjpla7Asyzg5/4vtrgJ0HFKTFPI5bQ1bfvJKNokawmJC7ZVa7zVX7GlfeqdPoaq
         jzu978E548A5e/63o6jkSWwJDCBzT9AO6NW4cOOHuR4rBdhCDq2pETGJAJkAXTZ0/z6e
         2dyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790687306; x=1791292106;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iuOkRbNJSVkFLmSsYlK0KIiULPv5CXdqQ88B5efXVA0=;
        b=OSUekjFkb9tZJse23hItwe2r3BW3/MQfv6tij1QGqGcvY6mxgDRtFeEhszR0u+Y3vm
         JAqRZrJ9oXtX+KTxbueclIeLG0bRUlP7vpt5MN+k4WtzILWgCrqMWna/loDrN922sBDd
         SpMJjDZnb8YNvQYRF8OvjaMq9HBavv7IcQT3eoIdNo+9/kqmn6w3p3EaICq3oqsrb2Oq
         R4kR/O9Dlm7KlIQULT/X2/8RwWAu63UDk50Lth0TiSfIzeZM1HgK5ZEg+cypX104ne2W
         CqYwBcD8IoQGcpB3J3nyPE9kifuHsKt7DYiB8HqV+DAD6e1HN49hDXG/D0zuFPxgv/uH
         xsPQ==
X-Forwarded-Encrypted: i=1; AKwUvBw387DXoFbybCjfKssf0ZTLukf24IcfuMwDDITKgpmDJe9kNL0s1IcXcwirO6ZVy3a3Yt1+Ou9IOgRzwDk=@vger.kernel.org
X-Gm-Message-State: AFuF++n4uuVXk80y8ioSgsU1xeppDsRpykqbi08uDy06ECaTM/Yvr380
	OjkCYocg4X1QVRArb9WcBo2Pv3uJrNfOav1BZpIUKoKUoaC4/dWi49IlqJY72VYCMhU=
X-Gm-Gg: AYBFou0L/hUMMxE8pEy189na0XBz38+YO/V+/T/00jnySqkrqRGh8w0W5NEXgQw0Foj
	04Ae06bXQq0L95LW4u7AuDxzUXXeYCkFYRY6phJV9Z1PcrbTRHMlpd1/nOSkwy9Q968EP5rcoVm
	93M9YsiTNqzSVDfUgrzeCDZRmdL2pLBbOgvuu8v4raa7ho3b8R8evtoA4zXfG2HCF9QzB1qlxKo
	Jt8sFFNAzwvygGE18c0E15gekKXYQi9m/BIgcBfBrTgZ21PSroiHFPO/80djHAOzDuQi4uxqbnz
	AExtpgPVky9luuLpcmVTxaB5+DEgbCfqm225uRhKg72BBhCG5Xj5I13fcg/ZKGvOtOL5HLq4xMb
	bTtkx/U5DTESnVhn+/e+6bNLm3uVoMQlP+VZq3GgEnrSs8UfT+J3JxKGhrd3Ej+CEKk/dPSnq4z
	Rg2x+QrXnE6HAw/NPzDbIVE2rEH+icWUdeK3faUcq+LdheuRhmSLCf6SbYBEcMH2XP3fWOoRix8
	796pHfNwWrlR+gJLJUqjDB8Iw==
X-Received: by 2002:a05:600c:1394:b0:49e:6bc7:4e1b with SMTP id 5b1f17b1804b1-49fe66bdefcmr306581885e9.15.1790687305803;
        Tue, 29 Sep 2026 06:08:25 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf4598esm82809695e9.0.2026.09.29.06.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 06:08:25 -0700 (PDT)
Date: Tue, 29 Sep 2026 15:08:23 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Fushuai Wang <wangfushuai@baidu.com>, Kees Cook <kees@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>, linux-serial@vger.kernel.org,
	Manuel Lauss <manuel.lauss@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] braille: nbcon: Allow to use a serial console
 with NBCON API as Braille console
Message-ID: <aru4R20JtHzdScNC@pathway.suse.cz>
References: <20260925141729.173943-1-pmladek@suse.com>
 <20260925141729.173943-2-pmladek@suse.com>
 <874if8cpbd.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874if8cpbd.fsf@jogness.linutronix.de>

On Tue 2026-09-29 12:47:26, John Ogness wrote:
> On 2026-09-25, Petr Mladek <pmladek@suse.com> wrote:
> > The Braille console is integrated with the virtual terminal (VT) and
> > writes its data using the legacy con->write() callback of the associated
> > serial console driver.
> >
> > When the associated serial console driver gets converted to the NBCON API,
> > the braille write callback should use con->write_atomic() callback
> > with an appropriate locking.
> >
> > It must be the atomic variant because it can be called under a spin_lock,
> > for example via:
> >
> >   + kbd_event()
> >     + kbd_keycode()
> >       + atomic_notifier_call_chain(&keyboard_notifier_list)
> > 	+ vt_notifier_call()
> > 	  + vc_refresh()
> > 	    + braille_write()
> >
> > In addition, it can be called from printk() in any context via
> > the graphical tty driver (vt code) even when the Braille driver is not
> > in console_list directly.
> >
> > The locking is inspired with nbcon_legacy_emit_next_record(),
> > nbcon_kdb_try_acquire()/release(), and the original serial driver locking:
> >
> >   1. IRQs are explicitly disabled to prevent CPU migration and nested
> >      calls into the serial driver code.
> >
> >   2. New nbcon_braille_try_acquire()/release() API allows to initialize
> >      the write context and acquire the ownership. It is using
> >      NBCON_PRIO_NORMAL because it competes only with the other operations
> >      on the serial console driver which are serialized using
> >      nbcon_device_try_acquire().
> >
> >   3. It uses a busy loop until it acquires the ownership. Otherwise,
> >      the messages would get lost. [*]
> 
> There could only be ownership issues if userspace is playing with the
> /dev/ttySx device node, which userspace should not be doing.

Yup.

> >   4. It does just the best effort when oops_in_progress is set.
> >
> > Also, adjust __serial8250_console_write() in the 8250 serial driver to
> > exclude Braille consoles from the newline prepending logic.
> 
> Note that all NBCON drivers cause this issue, not just the 8250.

Good point!

> Later I mention why it does not matter and no changes to the 8250 are required.

I am afraid that it matters see below.


> > The serial
> > port is not used for standard printk logging which might be interrupted
> > in the middle of the operation. In the Braille mode, the serial driver
> > is supposed to write exactly what it gets. In fact, it does not print
> > any newlines at all in this case.
> 
> Well, it still performs the "\n" -> "\r\n" conversions. But I guess that
> is appropriate.

OK, it keeps "\n" when it is there. The problem is that
braille_write()  writes incomplete lines most of the time, see
https://lore.kernel.org/all/arW4C9TYane57IGN@end/

For example, I see the following on the serial console in the Braille mode:

<paste>
E>[                                       E>[                                       E>[  O                                    *>[  OK                                   A>[  OK                                   A>[  OK                                   A>[  OK  ]                                <>[  OK  ]                                <>[  OK  ] R                              N>[  OK  ] Re                             
       >[  OK  ] Rea                            J>[  OK  ] Reac                           	>[  OK  ] Reach                          A>[  OK  ] Reache                         D>[  OK  ] Reached                        @>[  OK  ] Reached                        @>[  OK  ] Reached t           
</paste>

So we need to avoid the extra newlines added by the driver code.

It would be better to handle this on the printk() code level.
But the write*() callbacks do not return any error value :-/


> > [*] The busy loop is not safe on PREEMPT_RT where the current owner
> >     might sleep. We will need another solution there.
> 
> If we are knowingly breaking PREEMPT_RT then this series should also
> include:
> 
> diff --git a/drivers/accessibility/Kconfig b/drivers/accessibility/Kconfig
> index 6b2f79d1f1b81..d4faa6e0e01b1 100644
> --- a/drivers/accessibility/Kconfig
> +++ b/drivers/accessibility/Kconfig
> @@ -21,6 +21,7 @@ config A11Y_BRAILLE_CONSOLE
>  	bool "Console on braille device"
>  	depends on VT
>  	depends on SERIAL_CORE_CONSOLE
> +	depends on !PREEMPT_RT
>  	help
>  	  Enables console output on a braille device connected to a 8250
>  	  serial port. For now only the VisioBraille device is supported.

Good point. Will add this in v3.

> The console_braille "driver" needs to be made into a proper driver and
> make use of the serdev subsystem. I am currently working on this, but
> the changes are not trivial. And, optimally, the vt_console should also
> be switched over to NBCON. So this is not something we are going to get
> fixed in an rc6. For that reason, I support moving forward with this
> series until a proper solution is developed.

Sounds like a good long term plan. But I agree that we need another solution
in the meantime.

> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -3417,8 +3417,11 @@ static void __serial8250_console_write(struct uart_8250_port *up,
> >  	 * If the console printer did not fully output the previous line, it
> >  	 * must have been handed or taken over. Insert a newline in order to
> >  	 * maintain clean output.
> > +	 *
> > +	 * Braille consoles are an exception. The serial port is not used
> > +	 * for printk(). The driver is supposed to write exactly what it gets.
> >  	 */
> > -	if (!up->console_line_ended) {
> > +	if (unlikely(!up->console_line_ended && !nbcon_is_braille(wctxt))) {
> 
> This change is not necessary because there will never be
> handovers/takeovers for Braille. It is not registered as a console.

Will do in v3.

Thanks a lot review.

Best Regards,
Petr
