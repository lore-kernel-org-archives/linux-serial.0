Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E789D17B418
	for <linux-serial@vger.kernel.org>; Wed, 18 Sep 2024 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726662407; cv=none; b=BkLvYo2obUoviHlvk/WS4OxwkRR249zPGL+ShOYac2p4VStzhYDy1jwMB8UlRwZkErzvPyMZtMfRhWDia8fo7tCUyNrf6CcQsdgb0NtgqIUIYVME8mSOwZ3ZbskLEtmdug+MNKmoAVMfzsn6TbhCnx51M1s2uQqovWvlyjjnIrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726662407; c=relaxed/simple;
	bh=owkSPE+N434gd412TfpJW7YM2i6bFDTs176bOwmFdnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3cNyWYKzRoYPSkmACq0jDQKeOg8w89zSz11GQweoMHjGXLzr/FyN7u9LazadfNADnm4cqJ8REwnGmyGxYzEfNv7v0S+640XxIx685qUDGLAT+3bVbIK+UNDSUrY5PPJofEXHK4drcqO3c+dBaY2Z8dYAZUy1vZqqovObIeJIlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BfnZLIWt; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BfnZLIWt"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f762de00fbso71326211fa.2
        for <linux-serial@vger.kernel.org>; Wed, 18 Sep 2024 05:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726662402; x=1727267202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cgAU7H+QNm1aqh8qRj4zRQupf73QoF2RSPiKY8v8FoM=;
        b=BfnZLIWtPMVtg8mvdAmSKLG2WigkOeBljbFnHMjcd2y+MjLCkshxzD6oaGTDAUtMeU
         kRr1erKMaoFslWajD0Ewo/4ifNOH0BHviaiJdWAzVQDfmQ7IhoW3eih8WrzRGrQ+BCdU
         BOhimVpHisyjAgN90bSWi72Qt+0vtSjRCJGe1NUVHBIFy9jImBi9xACckuNNBcviKcyf
         wkx169+tgpTyOezoweqGP2dA09gLTWs/hk5BJAhh3Yv1B16vqE1GShhiBiUhVahlFxfw
         WjYazcawgVUeHmaX05I9yHvdwJIZFLD7sS8YaoL8o5DCpCselCF5qPWXK17MZOzMGABH
         0j/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726662402; x=1727267202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgAU7H+QNm1aqh8qRj4zRQupf73QoF2RSPiKY8v8FoM=;
        b=YI4hgeB4jj3zSVz1t6beG9F+407jmbpQRp05qsJWERezm1A4o/OZE+DqRNkvUJpD+p
         0do+j78ckDWjeJ681U4DidSuaZTViqHzceMHgvvOsHsxNtGH9CvU0wZksEHrcJs5bBEY
         XfWVo1LTvH9N46PsLspVlplaHBt4hjzHIOoC09SlS/XYz5vWdQsJqQtak5tcvuCtXrq2
         lK24FEI0cA/YNi9xkB8eaZdns7kZ1y7F+a7446D/xrl7W5DhdgKTX4+TB2TYN1OwoT4n
         j/q3cqwRxibH9+4hhwJz4qY59YNvCJmemv5Sw2Ah4r22v5zF8iEZQm6MnuYJjjUOF4Ok
         amow==
X-Forwarded-Encrypted: i=1; AJvYcCVvbvBYAhnzLQx3FRo1IlGuTxa1HMZarqjUYvxcq3qYQTPtv9MM1exTBeOeMIvjIygdYbbL2FkQ39I9pgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxboSFce3tYqsdceV1/ZWgPQ1xcqQgLdRna13AgQkPLs/J0Zzes
	M4iVCU7u71kFb4tIAeDORmtXRPUve+hb8nu8Z0pjUEgH8hyhATP8VY7mASODieY=
X-Google-Smtp-Source: AGHT+IEC/F6EZ09kmQx5BVBSXoY98rkEXpb8znml9Z7Ud4EnUNW9fTdlXL3qQ9lBJjSySlTwEV3JKA==
X-Received: by 2002:a05:651c:2118:b0:2f3:e2fd:7dcd with SMTP id 38308e7fff4ca-2f787dad3f9mr116066101fa.6.1726662401814;
        Wed, 18 Sep 2024 05:26:41 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd609af18dsm1459973a91.40.2024.09.18.05.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 05:26:41 -0700 (PDT)
Date: Wed, 18 Sep 2024 14:26:25 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH next v2 3/4] serial: 8250: Switch to nbcon console
Message-ID: <ZurG8YMmBmVVxttj@pathway.suse.cz>
References: <20240913140538.221708-1-john.ogness@linutronix.de>
 <20240913140538.221708-4-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913140538.221708-4-john.ogness@linutronix.de>

On Fri 2024-09-13 16:11:37, John Ogness wrote:
> Implement the necessary callbacks to switch the 8250 console driver
> to perform as an nbcon console.
> 
> Add implementations for the nbcon console callbacks (write_atomic,
> write_thread, device_lock, device_unlock) and add CON_NBCON to the
> initial flags.
> 
> All register access in the callbacks are within unsafe sections.
> The write_thread() callback allows safe handover/takeover per byte.
> The write_atomic() callback allows safe handover/takeover per
> printk record and adds a preceding newline if it took over mid-line.
> 
> For the write_atomic() case, a new irq_work is used to defer modem
> control since it may be a context that does not allow waking up
> tasks.

It would be fair to mention that it does not longer support fifo in
the 8250 driver. It basically reverted the commit 8f3631f0f6eb42e5
("serial/8250: Use fifo in 8250 console driver").

It is not usable in write_thread() because it would not allow
a safe takeover between emitting particular characters.

It might still be used in write_atomic() but it is probably not
worth it. This callback is used "only" in emergency and panic
situations.

> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Otherwise, it looks good to me. And it even works fine.
With an updated commit message:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
