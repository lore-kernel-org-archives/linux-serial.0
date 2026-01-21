Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A8829A9FE
	for <linux-serial@vger.kernel.org>; Wed, 21 Jan 2026 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011688; cv=none; b=KxYg7Y+nADTNfekSTpU4UmItWg+6PgrzOgUL7DB0vL6INbXOlrUcuKUbUhahe/rc8bQ5nW/9pLAGooDOuZJ4ebF/GHzRvNKBtDM15aFT3otgtMfjEPnR1uN0qhVpCRGa1WMWT9FqQf8VwlKbS10SqTfq2TyvtWWwVQYSbzclwSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011688; c=relaxed/simple;
	bh=CvbQrVmA1B6xeBzrWD46ToaJbCB+3kTz5b65FZW+DPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7mgO0F1qR/gFa8PsteXShMoHr8PwlMCsr9o7fuwvfqKrmhD7jonLjH5DAqsxa/jnNHL/4uxUjMycj4+qjnH+9kzposMh8WxGt8Mr1qkXu58zCar8wwVHFcHXh0uHKtJ3zvxCqgPNLjW5ggG78HyjkSqwXv5wJ7GHIc3qpSQOsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EhT7hpEY; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EhT7hpEY"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47ee2715254so21515e9.3
        for <linux-serial@vger.kernel.org>; Wed, 21 Jan 2026 08:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769011684; x=1769616484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a/m+CBFSuaRKey5NW1eLVVltJt+NfVZlJh5CXQB3NHc=;
        b=EhT7hpEYeCmHmWtNQ8IpBop33UBUEmSN3I2is6nKQ12vqMMU7948r+GtCxkZdYEaOP
         u9vn6mXn7vrishY02k4dK6Qp6ecT3i9g7KOUH6JuYb0x7bfrr9V+Sg2VkcKPMz314/Td
         gr0ZlCoA4tHp6ZBXfUp4Z1NbaOY08lqt4rlsjpqx0oHOAQo2PsbTR8yqRLkfFOMhloH7
         e2NUpxPU1Nu3Wws01K4ShV9KEXANxrZLTmhvpE61Rz8rOcUdYWQ3YeAxS4YKE0x2793n
         mE5n1PexLxmUp6gGuXiRslMr9wqyuA6DuXGeTAIn2VzHAa/9SOpnvitjWryjBEG5rHFe
         JlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769011684; x=1769616484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/m+CBFSuaRKey5NW1eLVVltJt+NfVZlJh5CXQB3NHc=;
        b=mIgUEcqzzzMnwozBWG9k4Pz+dehb8JDaxFNrRgNljDtT9KBqlUWNWjKawrYkv5JH3A
         D5djIicB4rZfcB+IDPIyA0I44hNqgM74flwpJbT/QFStUNMn8hYOBzAuS5oMKwulye3z
         PROwHnGyd+x5HApqfveQaYFD4DgEp4GuvPZ62s6j6zzbDuVn1497F53ZZR1Zw6o9uMdP
         /u/HMxC04RbaT6jjuFAWAJwYuehLvz5S7/HhG3NxWLiiS1gR+VcK3J6GszKQVQY3Ke6O
         gTm/7uWKAfREvhaEE9EaYCZIJcCWSve2P+QysR0dcpb0+sgsn4DptZpJjBWtckOv0Caf
         0kaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3lqxl8VmfH9lBxaIjqhmU1QZFDzdJ1PB6gIcp4XFEc2Vzk6k4tiPkE49t7ANlOSZianvfBTNrVMbC1b4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXj1DhG4u+DyRJrtTsUS8PgBeBpMhO+w9G41bSr42515sLdhKh
	ZGHcbNTawytIBr1T2SEavA2AEhX26TEus4PdyliuiTMFu53gU+TUejL3Rn5kTnH8JNw=
X-Gm-Gg: AZuq6aJNxCPlVhuLQpg+JiV2kJfD5YkuvjV69nzN+Ucc3mSM+zMA43vkC1UA6AtRY9j
	cDCDiZsDx+ePK3gY+0ILLY3yl/4LtFwbbx3IquvyUmaelwzoA/q41K9qQX9lht/0FUOEcILrdfR
	1voKZMJct57ejZi/onEJr3oyPAY0zMP5T5zMnpUcROBiBqMxv6sq0HlWp+6a2glHErAEhn66t0m
	tvBaf/L08odUikXZenC9EfyRgiwXQyoIprfg7zrdZdmmR5zN9zGsjkbIoB4MnvtTwEKgbQj9O50
	BQ1Seqsn9nfJ5c8KgK1+YEIIiXUjVx40gOGWZfHRkF8eYCzB/ZLdYQbj3SBH/2Uz7h/ZGQgZdtn
	T720yj7hHhPBSQbDBT04sH4WzcjzfikzTJfvBvPSiLydkdmn07cnznUOJoP61sLqH/uYxzEdDVT
	QZu6LKc2aRfhA9QdDRYwdUGXiA
X-Received: by 2002:a05:600c:3b1b:b0:480:3230:6c9b with SMTP id 5b1f17b1804b1-48041472847mr68408865e9.7.1769011683738;
        Wed, 21 Jan 2026 08:08:03 -0800 (PST)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071a2sm371807795e9.11.2026.01.21.08.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 08:08:03 -0800 (PST)
Date: Wed, 21 Jan 2026 17:08:00 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>
Subject: Re: printk's threaded legacy console + fbcon => schedule where it
 should not
Message-ID: <aXD54PcYpxQ-SeNh@pathway>
References: <20260114145955.d924Z-zu@linutronix.de>
 <20260120110845.2922a91a@gandalf.local.home>
 <aXDYEVlkFgxdSVSG@pathway.suse.cz>
 <20260121135737.K7b-4M5r@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121135737.K7b-4M5r@linutronix.de>

On Wed 2026-01-21 14:57:37, Sebastian Andrzej Siewior wrote:
> On 2026-01-21 14:43:45 [+0100], Petr Mladek wrote:
> > I know that there was a plan to get rid of cond_resched().
> > But what is the status now, please?
> 
> It is slowly moving => https://lore.kernel.org/all/20251219101502.GB1132199@noisy.programming.kicks-ass.net/

Good to know.

> > I still see more that 1k cond_resched() calls in the code:
> > 
> >   $> git grep cond_resched\(\) | grep "\.c:" | wc -l
> >   1263
> > 
> > And config PREEMPT_VOLUNTARY still talks about the explicit
> > preemption points.
> > 
> > > Should we just remove it and see what breaks?
> > 
> > Honestly, I do not feel comfortable with removing it. It is true that
> > it has no effect in the printk() code path. But the vt code is used
> > also when working on the terminal.
> > 
> > The vt code still uses console_lock() because it was intertwined
> > with printk console code since very old days. console_lock is a kind
> > of big kernel lock there.
> 
> Do you a have path which loops and would mandate it? I found a few which
> do not matter and have their own cond_resched() around. So I don't see a
> reason to keep it. And I found one which breaks things so a removal
> makes sense.

Could anyone from VT guys comment on it, please?

> > Alternative solution is to get rid of the spin_trylock(). The only
> > purpose is to prevent race in console_flush_on_panic(). It used
> > to be a simple bit operation. The spin_lock() was added just to
> > get barriers right. But we have a great atomic_t API these days.
> > 
> > IMHO, it is a win-win solution because a preemptive context is
> > always better.
> 
> So why do we keep warts again? Just because it *might* be required?
> Keeping things preemptible makes sense but this is locking with no
> annotation what so ever.

Well, the current locking is documented but it creates false
positives. The "printing_lock" is taken on a single place
using spin_trylock(). Nobody would ever spin on it. So
sleeping is perfectly fine.

> Again. printk has its cond_resched, the tty has it, too.
> I'm with Steven on the removal side.

As I said, the cond_resched() does not have any effect from
the printk() code path. But the other VT paths might rely on it.
If VT-guys are willing to take the risk and remove it
then I am fine with it.

Best Regards,
Petr
