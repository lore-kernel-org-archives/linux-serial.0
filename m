Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C62748A
	for <linux-serial@vger.kernel.org>; Fri, 18 Oct 2024 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729253474; cv=none; b=H6bzPFlGpVEjxC1c+JLLrbRELulsu6Pkd9JlMbQpYhKjUoqZmFJ8cd1n0yj0iIAFhP9Nh8QSu2Q+ZPNtjXRKYHnH0RDsa1jFjeo7M3hKIhgShZKA5GgVbrFKBMJWvzcvQ1kOPOLWB3X4MT92VOlvZ5h4vl/X0urK1qBDXZqoQNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729253474; c=relaxed/simple;
	bh=nshwy4YmoJw0jGdEpwSGaBuAdYlD+Lztn5xLB9hKFLg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mgjt2RU1b9haou9BZbHKWZesYUdOlC6TtG8eipNA9cZYpcZW4JfmL6f0lQmM6dxoyyN0oV9DJUWQvaXLNA7/gCLFsnqOuOwwsrPaYiJtwP9uh8V1A7bjdlrXx61XgKqwCf+Jvjiv55TW9TAGElyrpn6zHmXp1TfQaDsbd/wH9T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WMgPtJOt; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WMgPtJOt"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb3110b964so20676451fa.1
        for <linux-serial@vger.kernel.org>; Fri, 18 Oct 2024 05:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729253469; x=1729858269; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+dP4y57dpvhGZO8kM1bT3Kzo6ofN0wKTJz+jjLsNKtc=;
        b=WMgPtJOt9YFAbiygaDxe7tfeZJ6aPijI383WXlIqeLOiLjccpsySG+YjtL/OQazgs7
         u278u3sixFJXbbzyAYIgbgCp9WPLBRDD2hAGh6oxfzkDRjJeUungcZS9DKgbpA/CWKcE
         vbfegsFPZ3ZEUMAZoKEM9ogV4bqGrl32qxNvnvZ9QNcylxPJMVxhZrN6pGsLcgRXcuIV
         GQ9Qaq2r2gN3KxLda79SPSQzSpSscsjHipUyasJ1J6e/xDnzJDbQ6Pcr3GOC233tSjwd
         9LqhYMuWKNeG2oiqe0LX4k5gPyGVMGj+3glSimeR7dbM72OvgKLeqQRMfwsG20Tm2EtQ
         ETOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729253469; x=1729858269;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+dP4y57dpvhGZO8kM1bT3Kzo6ofN0wKTJz+jjLsNKtc=;
        b=Tg0SzcGFKWTJcKZXRAEzHKraOv39s413GgYyW1+erji7GiOXdmXW9hydy2UPmgdqwX
         ijoXZDD6zj1N531NlCITYKekOWqDseCo73eKG26cuGiK/yGhKzI7hj6LxxMHCZkw5sFH
         h74UJIcq3AtgXeoGuZm1H/ILfuge7/xIvvb0chnQyjz8/d8f3vsG59nhapJjTWcNBpzc
         m8sXGT5CExBo381lFUbwKyj8t5vc7HF29v5I4elPd2uR/H0TsiX0ynIv/GaIBWCV/rWj
         8NihIxKizK66kVd+O/saweHsfTsoosW5Mg7HA+IJt7K3I7RyZd97n7vu8MtJ1dq/cx+i
         xEcw==
X-Forwarded-Encrypted: i=1; AJvYcCVPQPQp2XbLuvouqIlALVgLT/g7m6U8i4pGhdtTechSbxQRDmSeAdA1DHdiVA463RRcgQuM32qAbYPkscI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu9JLAphYQ2PPqAyLsBSP8vM637TQJWTni9pg1crcnHJk/my+o
	9ig0ZovYroIlD2dwjHb/5StU603tk6F0Ao4tZQtlXU7DExkqme7iPAMJJi/+lsE=
X-Google-Smtp-Source: AGHT+IERqjgfjd2KcdtAegt7UEtSmI59Xh+MNOddMx8ewokEGCeMvlEXmBUej+QBSbS8xMPwi6b2ig==
X-Received: by 2002:a2e:920d:0:b0:2fb:3bef:6233 with SMTP id 38308e7fff4ca-2fb831e739fmr10390581fa.33.1729253468977;
        Fri, 18 Oct 2024 05:11:08 -0700 (PDT)
Received: from ?IPv6:2804:5078:817:9d00:58f2:fc97:371f:2? ([2804:5078:817:9d00:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea33119e0sm1290881b3a.6.2024.10.18.05.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 05:11:08 -0700 (PDT)
Message-ID: <5a88e070b7bb8dcfe495e9c120c0d62c992c4e7c.camel@suse.com>
Subject: Re: [PATCH 1/2] printk: Introduce LOUD_CON flag
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
  Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Date: Fri, 18 Oct 2024 09:11:04 -0300
In-Reply-To: <84plnz29zv.fsf@jogness.linutronix.de>
References: <20241016-printk-loud-con-v1-0-065e4dad6632@suse.com>
	 <20241016-printk-loud-con-v1-1-065e4dad6632@suse.com>
	 <84plnz29zv.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-16 at 20:17 +0206, John Ogness wrote:
> Hi Marcus,
>=20
> On 2024-10-16, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> > Introduce LOUD_CON flag to printk.
>=20
> Generally speaking, I do not like the name "LOUD_CON". The flag is
> related to records, not consoles. Something like "NO_SUPPRESS" or
> "FORCE_PRINT" might be more appropriate. Note that naming is not my
> strength.

Makes sense. I'll talk with Petr to check which better name we case,
but personally speaking I liked FORCE_CON that he suggested.

>=20
> > The new flag will make it possible to
> > create a context where printk messages will never be suppressed.
> > This
> > new context information will be stored in the already existing
> > printk_context per-CPU variable. This variable was changed from
> > 'int' to
> > 'unsigned int' to avoid issues with automatic casting.
> >=20
> > This mechanism will be used in the next patch to create a
> > loud_console
> > context on sysrq handling, removing an existing workaround on the
> > loglevel global variable. The workaround existed to make sure that
> > sysrq
> > header messages were sent to all consoles.
>=20
> IMO the more interesting aspect is that the "loud" flag is stored in
> the
> ringbuffer so that the message is not suppressed, even if printed
> later
> (for example because it was deferred). This actually even fixes a bug
> since the current workaround will not perform as expected if the
> sysrq
> records are deferred (for example due to threaded printing or
> consoles
> that are registered later).

Indeed, I'll describe that this new behavior fixes a problem.

>=20
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index beb808f4c367..b893825fe21d 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -1321,6 +1321,7 @@ static void boot_delay_msec(int level)
> > =C2=A0	unsigned long timeout;
> > =C2=A0
> > =C2=A0	if ((boot_delay =3D=3D 0 || system_state >=3D SYSTEM_RUNNING)
> > +		|| is_printk_console_loud()
> > =C2=A0		|| suppress_message_printing(level)) {
>=20
> I do not think "loud" should be a reason to skip the delays. The
> delays
> are there to slow down printing. I would think that for "loud"
> messages,
> this is even more important. I suppose this function (as well as
> printk_delay()) would need a new boolean parameter whether it is a
> "loud" message. Then:
>=20
> 	|| (!loud_con && suppress_message_printing(level))

Done locally, thanks!

>=20
> > @@ -2273,6 +2274,9 @@ int vprintk_store(int facility, int level,
> > =C2=A0	if (dev_info)
> > =C2=A0		flags |=3D LOG_NEWLINE;
> > =C2=A0
> > +	if (is_printk_console_loud())
> > +		flags |=3D LOG_LOUD_CON;
> > +
> > =C2=A0	if (flags & LOG_CONT) {
> > =C2=A0		prb_rec_init_wr(&r, reserve_size);
> > =C2=A0		if (prb_reserve_in_last(&e, prb, &r, caller_id,
> > PRINTKRB_RECORD_MAX)) {
>=20
> I guess LOG_LOUD_CON should also be set in the LOG_CONT case (like
> LOG_NEWLINE does).
>=20
> > diff --git a/kernel/printk/printk_safe.c
> > b/kernel/printk/printk_safe.c
> > index 2b35a9d3919d..4618988baeea 100644
> > --- a/kernel/printk/printk_safe.c
> > +++ b/kernel/printk/printk_safe.c
> > @@ -12,7 +12,30 @@
> > =C2=A0
> > =C2=A0#include "internal.h"
> > =C2=A0
> > -static DEFINE_PER_CPU(int, printk_context);
> > +static DEFINE_PER_CPU(unsigned int, printk_context);
> > +
> > +#define PRINTK_SAFE_CONTEXT_MASK		0x0000ffffU
> > +#define PRINTK_LOUD_CONSOLE_CONTEXT_MASK	0xffff0000U
> > +#define PRINTK_LOUD_CONSOLE_CONTEXT_OFFSET	0x00010000U
> > +
> > +void noinstr printk_loud_console_enter(void)
> > +{
> > +	cant_migrate();
> > +	this_cpu_add(printk_context,
> > PRINTK_LOUD_CONSOLE_CONTEXT_OFFSET);
> > +}
>=20
> Have you tested this with lockdep? AFAICT, the write_sysrq_trigger()
> path can migrate since it is only using rcu_read_lock() in
> __handle_sysrq().

Now I have and I found the error. Let me investigate how I can proceed
here.

Thanks a lot for the review!

>=20
> John Ogness

