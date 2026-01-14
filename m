Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7517239A802
	for <linux-serial@vger.kernel.org>; Wed, 14 Jan 2026 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768396346; cv=none; b=com8vBLhm1I7i9xoOqkKzwGF7Fqb/8Qts36AAYQkrKEtoTjKttGod/+1Bf+u3LHnsftfcM9hdVY6BtSda/XOvYEgdmXR4tKYLL23XU1yVEldbQw+4DQUAC7WRIKV9UMKqZf+mvAY5V4ASMc1v2lUGpK8uU/NrMr63JpJScAggi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768396346; c=relaxed/simple;
	bh=qVQVDrDK8GQt0EFjDkN2BeDB9NxS3hqaAC/BXhJUBXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDvtgNbCk1aqgyy6TtRqx0/ZqM+9lRAS6dANC/PK1+t9eFvvOQWdT1BoSZWb8n/BfiGp0CysOi8xcFzpLKq/Dwf7zrvHO9jO9wCgRtqIMAZho2NV1xIuI5/01Lze0TST1ohBEGeA+n6ENFXI8uOVPORfXQFyAYT6K6gdqr+9iQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L1iB/yNj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L1iB/yNj"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so64647995e9.3
        for <linux-serial@vger.kernel.org>; Wed, 14 Jan 2026 05:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768396343; x=1769001143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ucpTGToIn8N6Wm60fm7MZ05SRRlKYptl+ek5X25PfwQ=;
        b=L1iB/yNjYqm3FvqWymV6AoNf5MtA+Y6/OWs/RJg3e7CYxfZqQFULHvSUfTEk4onLe3
         K8kZuPagmhqvDJFtw9c9UTxqcd+qJZkw4PQl4BUg5k4yF9scQKi9RHMwyVcofMOLNmf9
         pbhNXDMXDshXlT74Wh0bXiV5vvKeLUf6p39IJ8wY5dpK6KBsy4W3IFGstIqmYoUCnIw4
         nqRilxwC37pzPLIWVgJsrDbAi5fP08rSd1LIYgBshYGZ1PcyNhk5nl3IPlrRV45sac/Z
         Yxfv6Z4RUlHmbXdVWT3j7gI66pAgzx3k3AqR7HGarevdhb1crqPGqGHXY8Pe43pEFeZ4
         oD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768396343; x=1769001143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucpTGToIn8N6Wm60fm7MZ05SRRlKYptl+ek5X25PfwQ=;
        b=nb/J9dUTPqtt99JfYecR5QopBpH9wkcYRS2OFL8MFy6gwuzS2yuXxAnb0y+RvaAzB9
         dgyCtPCHQ+BJczX4rEfQC3OZSZka0QUwGjHfxgGNHTQ4gNwv+q5DAeuYSV5B49eKMrUX
         WI4ZBEWENStnRBhTGpprqi0XkAKz+MDo3aMa06vmUpizgp1OLB6eVP52QAqh90pK/Mul
         kZlUCfLN0b1eHD1oG7O/PTuS7Ao6vycUaGg0fHRqus5MlQ2Ah8GTvDhUrhuI71Mjz7qR
         yBA+qH+3gHb2TYxE4Ezv3XyktIjkRfXvaj/reifM9tkPh25OGoyJwqurRIGtOEBAUw6K
         awJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe2Bs5oO2uDXQlwlpEXSxN2uorFRs4PsxScoVKOi4OMUCWe/AFdH3NVGb2OjssHZ6m6ngLbvKVAjrUizo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKhMoHHQV7VihYrLSc9S4OeS20y+SQHEiKISZR2SFmO46NQMU3
	fSwEIXXLfVILkFzV2LwUSn4CMuPU1UKXpWJiGUMeHvk8Xi3zbKp0mXnAk5WSB5RqTaE=
X-Gm-Gg: AY/fxX5OXU5k1B06qvhA1+If2jOfBkXX9eZmIIIz+szPh+Mx26ithpTuPLNurs9OJZQ
	CVnoeV2vxUOUPgmRrlCAvr9tQfCmqW0TrSkRJYu68bMnMkzUcLIbJl280+r5/2/DzEHQhqzo6Vt
	q87AbJQ0OIALs2KcxQF0x1SR2iqlp0MwvMC6cxdrtmS9+GOJmXS7VNmjVmBqeyKOG4oyAVfDVFA
	2YHO6i7APSWs6nMzQxp4W8D5zcqt99UQLxhVIIdSH7fIldpt3iL7cMUr9KvMJ3WFhBYG4HyT0Va
	ykrcSq6urDxTf7MjXWsOoFeDpJZfmjZGZxVq2tGfIM4OTd3TG83eh4YMz+t/IA9qt86m4FTiQw+
	efQLWhPa0/34xEZEApslW3MqMKRx6akPv3y4ejqRGqVyEisrj4BcUi5/hyBGkZqHtB8yYcwKbhc
	ves0U42MJFrHEJLkuF/9WhnAL+
X-Received: by 2002:a05:600c:5490:b0:479:3876:22a8 with SMTP id 5b1f17b1804b1-47ee3356d5dmr36820375e9.16.1768396341643;
        Wed, 14 Jan 2026 05:12:21 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee54b8c9bsm27274065e9.3.2026.01.14.05.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 05:12:21 -0800 (PST)
Date: Wed, 14 Jan 2026 14:12:18 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/19] printk: Reintroduce consoles_suspended global state
Message-ID: <aWeWMga1VaT0sYwj@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-4-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-4-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:11, Marcos Paulo de Souza wrote:
> This change partially reverts commit 9e70a5e109a4
> ("printk: Add per-console suspended state"). The intent of the original
> commit was to move the management of the console suspended state to the
> consoles themselves to be able to use SRCU instead of console lock.
> 
> But having a global state is still useful when checking if the global
> suspend was triggered by power management. This way, instead of setting
> the state of each individual console, the code would only set/read from the
> global state.
> 
> Along with this change, two more fixes are necessary: change
> console_{suspend,resume} to set/clear CON_SUSPEND instead of setting
> CON_ENABLED and change show_cons_active to call __console_is_usable to
> check console usefulness.

I would invert the logic a bit. I think that the main motivation
is to replace CON_ENABLE -> CON_SUSPEND.

<proposal>
The flag CON_ENABLE is cleared when serial drivers get suspended. This
"hack" has been added by the commit 33c0d1b0c3ebb6 ("[PATCH] Serial
driver stuff") back in v2.5.28.

Stop hijacking CON_ENABLE flag and use the CON_SUSPEND flag instead.

Still allow to distinguish when:

  - the backing device is being suspended, see console_suspend().

  - the power management wants to calm down all consoles using
    a big-hammer, see console_suspend_all().

And restore the global "consoles_suspended" flag which was removed
by the commit 9e70a5e109a4 ("printk: Add per-console suspended state").

The difference is that accesses to the new global flag are
synchronized the same way as to the CON_SUSPEND flag. It allows
to read it under console_srcu_read_lock().

Finally, use __console_is_usable() in show_cons_active(). It is the
last location where the CON_ENABLED flag was checked directly.

The patch should not change the existing behavior because all users check
the state of the console using console_is_usable().
</proposal>

> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index e2d92cf70eb7..7d2bded75b75 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -3552,9 +3552,9 @@ static ssize_t show_cons_active(struct device *dev,
>  	for_each_console(c) {
>  		if (!c->device)
>  			continue;
> -		if (!(c->flags & CON_NBCON) && !c->write)
> -			continue;
> -		if ((c->flags & CON_ENABLED) == 0)
> +		if (!__console_is_usable(c, c->flags,
> +					 consoles_suspended,
> +					 NBCON_USE_ANY))

It would be better to move this into a separate patch.

>  			continue;
>  		cs[i++] = c;
>  		if (i >= ARRAY_SIZE(cs))

Otherwise, it looks good.

Best Regards,
Petr
