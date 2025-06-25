Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5382882CA
	for <linux-serial@vger.kernel.org>; Wed, 25 Jun 2025 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841346; cv=none; b=rl6h7lq+Sbzt3fm5bYhe6ZG6udRELtza2s5oaos1kdU/U5SN1l+j2vsU00WNJsxAZNZSjlnGPZtNb93oshRmfBax1D/uCXQQVlgXkt2vrupW7oPi2InqeJt0rPYjP2o0cV0NpjtB+fyR7fjo9REORVo5NXbbPw4yXQubvClHaGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841346; c=relaxed/simple;
	bh=B3qA9zwfpMRJL/FzUeX54kCiEnXCOJesL1S9ExwYFa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLLg3t/PA+DzAXz0XiLkTcdfjGbF0UBArMaKznttoZm4W8uJ2se5MUUGqiq+Ssch+KPUXQ/gacqp6IHw209qDuOTDfdRhSPpNAuSDO/AbadIFCwrhA3pXm7LU9i/zL87jbLEuK97+hixjVtr93SMC0DLvXvHQTpW7PFpZb3+BV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WypY8/il; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WypY8/il"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a6e8b1fa37so1554850f8f.2
        for <linux-serial@vger.kernel.org>; Wed, 25 Jun 2025 01:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750841343; x=1751446143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gzuTLj0h0BP8Faa4F4QGiLAR1aawV6atkUr8dq493UA=;
        b=WypY8/ilZvnr8XQXF+nHD3oXDtrp6abxHUbKbbDGFYiy9e4wa7F91Z4XN+gp0HNaNX
         LPJhOVWKMtlIECB85h9qI8a0G77qHZxcZHsBdmEK2i0y5EGwSA7U0Ig0qylO3dNRrqoL
         4BQhd9umPSKKtXYf+47L06M7TeNrjRzxheHz7qOXJcOwC1ZYnsXJoHVdW1tzbGw11xjN
         6kjVE+D9M67tJG/+lX2MNvW31rdg0Z4EuYpGW5e+wRf9j0CyfTmeRT9w+abcTFXD3QN3
         8rDRlSqT4YFVNP1MJ3OwSnyQsMNqtAlmtIb9C848zmb1mzmtnwznZ/IoLh7AkUDcmkRt
         QBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750841343; x=1751446143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzuTLj0h0BP8Faa4F4QGiLAR1aawV6atkUr8dq493UA=;
        b=K7U5hgDMiXsBDiemzgZejbc93emYN1qDaMT6umi8CVmc0j8fiMiLJNEfHVSFbnU44n
         T5Wym3McY64f0frpIlSt35jFOwjintrD87tGvgK6gIo1pHKaIQ+HIwwZfXtU4Su1O4YG
         qjvEAh9KVx0LitRI9+d1LU+ZJ3WE12tFWSQjNGjaWKl4rDPEHTJt83WMJlHhxCY3CTdX
         7sOs7NNVy5CZuya4fyJJweMfjUV/FjxEdj16yPTMfuevustov1D89aQXjgrSOp72oihh
         tNVuZFUq7sU9QA+9BIYc+M3/cLRe5LPerfolWuV59RLBY96vPUL46rWn5zesGjl8Td1l
         I3Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXnbxA+OeHzA3UWZFdGSwprZ5VI2Oc9TF4lJo8rAaKc4N7bf3OBgl/wGe5e0Hrq89zoPgjUTvHjnKGcn4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuHhogJjxBz5TwdJD+3qjmDMfTNBCDX+s6q3vrdTx8bbOCDhEz
	KjDbQ3a5TUZV5tV7N1C18bTtDuP6a3+e+/5QC9VY8s2l14SCIqJwwIF6JYug96x739A=
X-Gm-Gg: ASbGncsm3QzgchsuWqteeTkUPmPHYKmq9tbJWwvIVDLaNmpHJVuZqCaXDSEoCYubIQU
	qMuZgYD/LrMj9TctLYVqGcoVSshbfk4A4fqGKMZMPQKUQGa8zgNfv94/CDNo21rDxtscp7cildh
	9fgUT093V9fxEhr/Jh0A6RB3jt3Xj1bQE3AAWIqlHhbIk1hg1QvOoFWpnZNV7EQuMt9SnFViKbX
	dM58BktksLPfdmBVgPVbfs6FYjVR8X7VdaQeulE1CeB30A2Ma2YFa8a/VDrO9VPvHXf7lFeNvLY
	TpdtGyP88a+cb2QO8QC3HGypzRUTCJiHfrPZZ0ft99GTM1x1vkizp4Mbp2+ie2m9
X-Google-Smtp-Source: AGHT+IF1swuTytOZ/mOzx/aDJsTp0hYVrC347nQzODYODKZFAGNs/udBAXxCCv2VIRKBSD921Bw3yg==
X-Received: by 2002:a05:6000:4803:b0:3a6:d191:a835 with SMTP id ffacd0b85a97d-3a6ed646453mr1182080f8f.41.1750841342692;
        Wed, 25 Jun 2025 01:49:02 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83ea243sm132652565ad.72.2025.06.25.01.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 01:49:02 -0700 (PDT)
Date: Wed, 25 Jun 2025 10:48:45 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org
Subject: Re: [PATCH 2/7] printk: Use consoles_suspended flag when
 suspending/resuming all consoles
Message-ID: <aFu37RyHZ4wYF-ZV@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-2-f427c743dda0@suse.com>
 <aExBo-8cVOy6GegR@pathway.suse.cz>
 <84y0tmiidg.fsf@jogness.linutronix.de>
 <aFpkQHwNCslbKSP6@pathway.suse.cz>
 <84wm919z9i.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84wm919z9i.fsf@jogness.linutronix.de>

On Tue 2025-06-24 13:10:25, John Ogness wrote:
> On 2025-06-24, Petr Mladek <pmladek@suse.com> wrote:
> >> > Variant C:
> >> > ==========
> >> >
> >> > Remove even @flags parameter from console_is_usable() and read both
> >> > values there directly.
> >> >
> >> > Many callers read @flags only because they call console_is_usable().
> >> > The change would simplify the code.
> >> >
> >> > But there are few exceptions:
> >> >
> >> >    2. Another exception is __pr_flush() where console_is_usable() is
> >> >       called twice with @use_atomic set "true" and "false".
> >> >
> >> >       We would want to read "con->flags" only once here. A solution
> >> >       would be to add a parameter to check both con->write_atomic
> >> >       and con->write_thread in a single call.
> >> 
> >> Or it could become a bitmask of printing types to check:
> >> 
> >> #define ATOMIC_PRINTING 0x1
> >> #define NONATOMIC_PRINTING 0x2
> >> 
> >> and then __pr_flush() looks like:
> >> 
> >> if (!console_is_usable(c, flags, ATOMIC_PRINTING|NONATOMIC_PRINTING)
> >
> > I like this. It will help even in all other cases when one mode is needed.
> > I mean that, for example:
> >
> >    console_is_usable(c, flags, ATOMIC_PRINTING)
> >
> > is more self-explaining than
> >
> >    console_is_usable(c, flags, true)
> 
> After I wrote that suggestion, I decided that the naming is not
> good. There is always confusion about what "atomic printing" means. For
> that reason the parameter was changed to "use_atomic". Basically we are
> specifying which callback to use and not the purpose. It is a bit tricky
> because legacy consoles do not have an atomic callback, i.e. the
> parameter only has meaning for nbcon consoles.
> 
> Perhaps these macros would be more suitable:
> 
> #define NBCON_USE_ATOMIC 0x1
> #define NBCON_USE_THREAD 0x2

I personally prefer this variant.

> or
> 
> #define NBCON_USE_WRITE_ATOMIC 0x1
> #define NBCON_USE_WRITE_THREAD 0x2

This one sounds more precise but it very long.

> or
> 
> #define NBCON_ATOMIC_CB 0x1
> #define NBCON_THREAD_CB 0x2
> 
> or
> 
> #define NBCON_ATOMIC_FUNC 0x1
> #define NBCON_THREAD_FUNC 0x2
> 
> Hopefully that gives Petr enough ideas that he can come up with good
> naming. ;-)

I thought about better names yesterday but I somehow did not have
inspiration ;-) Thanks for coming with the variants.

Best Regards,
Petr
