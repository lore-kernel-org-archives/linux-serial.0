Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2E026A0BF
	for <linux-serial@vger.kernel.org>; Tue, 24 Jun 2025 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750754466; cv=none; b=rIYzy1Yl+wV/F/BkN/7xelQyix9EaVqPIr/7v0aFt/oIRAXLdTubdbH+tuq3H4UVptgmCGH5HFnEiM2fifCCRvhWufxrp1PgTmsoTSlbPfogPs4u07Aqq3ubS/mqJ3X0g9iPNdHRGk3ziIeOO5uder2pr1+fSvXFILRPTxUo10M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750754466; c=relaxed/simple;
	bh=zdAtxHvqY91gdiWBUFT7jBGg+f5hSLcaeJSjeAJNEVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBOYGfKJRDyskmPsp0ElfTY2xGQ+hhjZMYJN0UJVh6Vx/iOUlxOwNEZyIRgIRtHFBs3FnQ6zUjjgIQDRPfTFvmckLVcrKmvT/AKXHzmju8R42L0nODLBcMJ5ylpTzpHw2p1czj4YmfwXnNSOg4Q2JJ7ibxazvk34TP96p5i+ICc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UH1V3t9S; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UH1V3t9S"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso4038863f8f.1
        for <linux-serial@vger.kernel.org>; Tue, 24 Jun 2025 01:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750754463; x=1751359263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=42Y2N6ebar+wiBFiVwZ+1np3R1M+VYIv1aIQkqIKk40=;
        b=UH1V3t9S4NXkPqOqyNyHVbHAvxkVhK777/oSyAzWRZWd6k92Hp4OfCtbGtwNzDa4NO
         aHhBhJNq4Q3A+nOxolkOrzG72lygIik4Y4E+LWv/mSGQbN9iz3HUSvmv0HQK5PYMdQvj
         brqPqcaUXH96LLCaWAUegv/ZlT7PD9EU1kzbq4fve7XPzLifVTz0o4UWYAj7PQBeOQSr
         JRgXLjd1gtNqd/KDijBDLEv9x2tEREMuAv+kC35tuY2gJl9ERBaTJVwENE4mCpoAXrMP
         czg3WpLW9ng2/Ip1qS6Kg1UNBBG9QOQPV57fiSUcR4QzdS9omCKPVzKAT84JEmwyzS9d
         /10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750754463; x=1751359263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42Y2N6ebar+wiBFiVwZ+1np3R1M+VYIv1aIQkqIKk40=;
        b=P9bqopS9tghmOR48vUfV05dXKt0puck15XuYeWrgVdJX52GaxwhNykdv961Yc15+Ln
         W/YT9h6l5oSU4SeT2EYNGTKyJtzwcolAaHQPm2DF1oxzSlQLIt0+SvpCvszJDMy+6iyl
         4uQwciJSK5IZEHGrpnJhk7M8AdbUvX793Q1JZy76RoAjX/XdjZQmiJAHEZQJBDmNGAIY
         h+ny7irSW8UfaD1ggAldDlE12mYYDyR4X4CwVFtdXw9nAXUd7nXawH5TIjkSjW2GoSu9
         EXlOn1vyDnWhaVp+bQ8XodTzF68BmAKfSt4BT9+rDB+P6ETcU+EM/v0x6POmEQmQIbfY
         q5sA==
X-Forwarded-Encrypted: i=1; AJvYcCUXfxQ5w+W640zHjYQXngaHgwtfpX65xaDOfBRtGHWoZPiG/eILbQVadQOk2L5AFIiEngcDHi/q9zkxS88=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP4TwgcM+KFxMsKesY1lVuewxk4lXcCQzX5wJmWXrF0b6eL66z
	gHfRUE4AkW0XC6B7FYUHkwYQhuPGN58o4isdSBBqCfhNWlahBeA71y1NitAaYhpotZY=
X-Gm-Gg: ASbGncvw71bVFT101oLcRvJbXa3DJM3NJiS/d3x4BV4leipHMAT/a74YEwitEBCW5Om
	3VezJuVd7kBUkF55ku0qkLxWRJHkMJk6sE2vXMsyMWyHfa+xMYcvVnC5peOfP3zxjI7kyPY4JS/
	ueUHoWrV9iXaMevCqESPw/CHTjbvWhWJjuBMMZCGQWbiNtZXNITbeITBzPxGPvbu6Cmr9RZJ8+b
	TN0EyxgjIAbtMT+nYL/+tvxHzC4LWew0VtcqnWiKhLNLXMxa5AHD1tcupkLXndKr3gKem3iDvba
	+rRLaPDO93MZUeOUkWGgKHCfeXkTi/absjS65DuaXHbBHxVHKnkHc7FrPHCP7Pg1
X-Google-Smtp-Source: AGHT+IHSGyDwoYjnGgDbPlFSLTlqgEue3oGk1SeNKtOch4nBjPOzzj8KWkuWYgkah6BLwc+G22XXxA==
X-Received: by 2002:a05:6000:3111:b0:3a1:fcd6:1e6b with SMTP id ffacd0b85a97d-3a6d1334011mr11624969f8f.57.1750754462679;
        Tue, 24 Jun 2025 01:41:02 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749b5e08e52sm1231044b3a.9.2025.06.24.01.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 01:41:02 -0700 (PDT)
Date: Tue, 24 Jun 2025 10:40:46 +0200
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
Message-ID: <aFpkQHwNCslbKSP6@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-2-f427c743dda0@suse.com>
 <aExBo-8cVOy6GegR@pathway.suse.cz>
 <84y0tmiidg.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84y0tmiidg.fsf@jogness.linutronix.de>

On Fri 2025-06-20 16:49:07, John Ogness wrote:
> On 2025-06-13, Petr Mladek <pmladek@suse.com> wrote:
> >> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> >> index fd12efcc4aeda8883773d9807bc215f6e5cdf71a..72de12396e6f1bc5234acfdf6dcc393acf88d216 100644
> >> --- a/kernel/printk/nbcon.c
> >> +++ b/kernel/printk/nbcon.c
> >> @@ -1147,7 +1147,7 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
> >>  	cookie = console_srcu_read_lock();
> >>  
> >>  	flags = console_srcu_read_flags(con);
> >> -	if (console_is_usable(con, flags, false)) {
> >> +	if (console_is_usable(con, flags, false, consoles_suspended)) {
> >
> > The new global console_suspended value has the be synchronized the
> > same way as the current CON_SUSPENDED per-console flag.
> > It means that the value must be:
> >
> >   + updated only under console_list_lock together with
> >     synchronize_rcu().
> >
> >   + read using READ_ONCE() under console_srcu_read_lock()
> 
> Yes.
> 
> > I am going to propose more solutions because no one is obviously
> > the best one.
> 
> [...]
> 
> > Variant C:
> > ==========
> >
> > Remove even @flags parameter from console_is_usable() and read both
> > values there directly.
> >
> > Many callers read @flags only because they call console_is_usable().
> > The change would simplify the code.
> >
> > But there are few exceptions:
> >
> >    2. Another exception is __pr_flush() where console_is_usable() is
> >       called twice with @use_atomic set "true" and "false".
> >
> >       We would want to read "con->flags" only once here. A solution
> >       would be to add a parameter to check both con->write_atomic
> >       and con->write_thread in a single call.
> 
> Or it could become a bitmask of printing types to check:
> 
> #define ATOMIC_PRINTING 0x1
> #define NONATOMIC_PRINTING 0x2
> 
> and then __pr_flush() looks like:
> 
> if (!console_is_usable(c, flags, ATOMIC_PRINTING|NONATOMIC_PRINTING)

I like this. It will help even in all other cases when one mode is needed.
I mean that, for example:

   console_is_usable(c, flags, ATOMIC_PRINTING)

is more self-explaining than

   console_is_usable(c, flags, true)

Best Regards,
Petr
