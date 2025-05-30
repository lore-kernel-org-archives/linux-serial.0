Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A6B1EA7C8
	for <linux-serial@vger.kernel.org>; Fri, 30 May 2025 10:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748601524; cv=none; b=GZYtdtlJFdgPiaYE1el8TDf7LzcwDUP/kW+fgE8ZA1reRWr6i4grIqSggS1+gDjTf/6hsAKWHSl3ZyoD03abwQER365J4olK/lYKDr+lknPEmRw6r7LytZbSaRqMl+lRLluKOJYweTtWEehZBBBJe3E32rblLomSACYlREP/qBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748601524; c=relaxed/simple;
	bh=cFMhkMfciXyewEjUC//B/5J1JC5bPLwNEni1mAkjwGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5G/EsiszxVa0zHhosmF2AgCWtRV5F8nZn9NxC2nt+EBMW0zaR11xdgaqW6TVhRcIILqh0JkFxifBz9n81NF0STZ9A5kR/z8bH8m6nB4dm6npjKIKPC8pebFcZgk+2MiFdyaZpDZC2z+T8U7EMy1nrq7RZKwCtQ2Hh+AgRQKF3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=Vqh9rlo/; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="Vqh9rlo/"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3115a6db4d6so1361191a91.2
        for <linux-serial@vger.kernel.org>; Fri, 30 May 2025 03:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1748601521; x=1749206321; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uQEZvYFKBE6aAuOFee4+vznPJaidsW1NHwLDi+y958o=;
        b=Vqh9rlo/xxOMqd66UUUdy8f88BEA92xCRZjXpUb6cUnPV3fYi520Pjqfl6LwDYLMAz
         QC+XddD+ozh8U0tdEUZSXJVvrBxeJMwbxcPOKNjCRe77+XtukAsyi1MFUMykJpeOdBa3
         Kb3rFC0tPSyobDoQ9X0UpVOVK8L+3NzvBF4PKY8IufM3jvF7XkaJWDIo54rH4qs0kl4J
         0Yu6Moshg+3xSqaz+L+0vPQimPbQYHomiI9UWgzcQq7K39T6kV1ezU8j+56NFUBHSWVl
         /Zs+0LK+z0ttXxkOmID2nDYv5j7ruvL7OqdwD24Djm0HrMUPpJeOf9nXTNQECeXLqzhf
         G1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748601521; x=1749206321;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQEZvYFKBE6aAuOFee4+vznPJaidsW1NHwLDi+y958o=;
        b=krPS942txmLrSIbhKjFvh/CMlrfCMGBISRwrAyQJvlI+Q2Z6kjmOdKT3nxtVJI4cwy
         3zVgZ4mbHYcgyzS9CZP8eSlYrxPq/v8MIUvZpQCwfnqGzpTpbt5UTWmhkC1kgv2wCD2q
         i74P2yvZpGIDB/ldYN/5TH73ZzpF39EM4wYaJr6WRehoZqc7SdUz9Zd44rP8Fclf/2OY
         81dS0tHtrE0X/FxbrhOUUIciHBIl3m9ZhGwYglKlW2mdKQSPxnBIuvOknh0rX6QNzirt
         PJbG6Hw/MTbzt3XGPmATwnn6N5FWF8+uHb+dq5Zp7qXthbn/1mPSKYn7BSaT3GayM6e3
         gd7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8wC3mJ0cz7AZcDF0HIrqHwqhwfHxelXTbWpXVyKpfbG/Aurz6LKsYkxLDgt7XG8uvhmofIn4KlOc/YkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe35UwiOvLed4zjau2iAXC+qE9GclC8wUOQpGC8fsUFB5+dU35
	/qGY9eyufIy71hLTm+PEp03ZMVZwiPW2Eb9X87Y3qL7W6sGb7npzvdR7y21HmoSwibi2K9TFM1l
	cuN+FBiD4ehWC+uGj3oU7mXoUKwPW94ktyOJ1bpE1YQ==
X-Gm-Gg: ASbGncvFDPkEqmQPavwlG7xWsfXegrpuKJqQqBm73fsGm/GhkRm+97BNgGZkiu3TyaI
	pPgHhdcMPr/VLGmCHJlggFYoJmFgrXSVIZsxnM1Xc8A9eukuJdNto5gPBXvUPnHXFxv9ZiGi2B4
	fwl+f0OvJtfx/6vtUKJI+ippL1RKzpr3u4
X-Google-Smtp-Source: AGHT+IEip90dEolDYL1sNGwckFwYNiw+/PcVVHxJEWeqVb7zDrxbG4lpTdqfZPDuxix3LLxiTXCGyQ4/eR7FaTVFVJw=
X-Received: by 2002:a17:90b:5104:b0:311:df4b:4b7a with SMTP id
 98e67ed59e1d1-31241ea9825mr4736694a91.29.1748601521008; Fri, 30 May 2025
 03:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514173514.2117832-1-mcobb@thegoodpenguin.co.uk> <84jz6gdh5r.fsf@jogness.linutronix.de>
In-Reply-To: <84jz6gdh5r.fsf@jogness.linutronix.de>
From: Michael Cobb <mcobb@thegoodpenguin.co.uk>
Date: Fri, 30 May 2025 11:38:30 +0100
X-Gm-Features: AX0GCFteRoxExXBLXDf1UvF2Zb9KQXZpUKtsxEXNomU5vUMxj2ENVRGuRS7_Cgs
Message-ID: <CAC251sUpHHU26wDgBuOGdxNGvE=2M22+b5E4Y+Lc9Ow63fOidw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] printk: Don't flush messages using write_atomic
 during console registration if kthreads have not been started yet.
To: John Ogness <john.ogness@linutronix.de>
Cc: pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 May 2025 at 10:44, John Ogness <john.ogness@linutronix.de> wrote:
> If I understand the problem correctly, it is really due to the "console
> enabled" message that is printed upon registration. For the first
> console, it would perform a full atomic flush, even though it is about
> to create the kthread printer.

Hi John,

Yes, you're correct, when the first nbcon console is registered, any
calls to printk() (made after have_nbcon_console is set and before
printk_kthreads_check_locked() sets printk_kthreads_running) will
trigger an atomic flush.

This can also happen if we attempt to register the console before
printk_set_kthreads_ready() has been called, as
printk_kthreads_check_locked() cannot start printer kthreads yet. In
this case printk() will also flush atomically until kthreads are
ready.

> What if we create the kthread _before_ printing the message. Something
> like the below (untested) changes. Does this also address the issue?

Yes, that works and avoids the atomic flush, however we then lose the
"console [ttyS0] enabled" message on any boot consoles that we are
about to unregister. See the comment above the con_printk() call:

    /*
     * By unregistering the bootconsoles after we enable the real console
     * we get the "console xxx enabled" message on all the consoles -
     * boot consoles, real consoles, etc - this is to ensure that end
     * users know there might be something in the kernel's log buffer that
     * went to the bootconsole (that they do not see on the real console)
     */
    con_printk(KERN_INFO, newcon, "enabled\n");

We would then also need to ensure that nowhere in this code path calls
printk(). I can see some places where printk() might be called (mainly
for error reporting). For example, unregister_console_locked(), prints
a "console disabled" message, also in the call to
console_sysfs_notify() (linux/kernel/printk/printk.c:4116),
kernfs_put() calls WARN_ONCE() (linux/fs/kernfs/dir.c:579).

I am worried that by avoiding calling printk() to not trigger a flush,
this might not be robust enough?
Any future changes, even those made outside printk.c if made inside
this code path, can reintroduce an atomic flush just by calling
printk().

Kind regards,

Michael
