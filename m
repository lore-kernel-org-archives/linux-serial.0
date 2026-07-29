Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4D8442B2F
	for <linux-serial@vger.kernel.org>; Wed, 29 Jul 2026 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323382; cv=none; b=NFoBPVaPcVAcNer3qfvhdTT1yvoW3DQhPUfJP2yqCdyNaETVH/wv8bfY5wCHm7fDB3hNhcEfFotFnBiq9u8N/CD+KKRPqj9fjxrXPm+lmXPlzoFZjAicIabLAZnE2YZaoGIKw6X9I+EqhwjngSpa/2hjpRto/e9MAaptczY+G6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323382; c=relaxed/simple;
	bh=tRD9Hnc+FiDzMwa7ooASAfjCm420hLC7sETJ7IsQPtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=li+UP54nfAGftS+jQgBGyXoyxdi6Pph5Zuia5vc3QzpJ4pLDrfHByat63TddKSUF1CxOEIpJBdQiWwniWJyZDZCfRPPREsmIbkdlzcXqlNtDjH41uC6SdPn6xs3TpGhOyBn5sjU08Brz7GJR3om9vKTZsmto+2mirrFghaAfoUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=en9jXXHC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="en9jXXHC"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso5865065e9.0
        for <linux-serial@vger.kernel.org>; Wed, 29 Jul 2026 04:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785323379; x=1785928179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1mrR0h5a2tnzaiN6M63ThlKTtbHhhDFOkDL005+wWy0=;
        b=en9jXXHCKkeMTJ/aAQQwom7kBedDhAJfGLong2HCHotr6QyE1k2ovJ8odHbW6CeSoA
         HTE7PfcEmblVHiAK+qxUWpDF9Fi3m3NZr3UjtcrXaD88xEKttyjSIAZKid7ym0adg3N7
         xlMk9qjH3zuUd3DCDoVKpR2QuMZX89v/DyNWXQHLsze+v5cfkn5DdUX87AhfGb0dxj9c
         F1wSaXrsiNq1Ee1zT6dh1nlYsHZwARUxcntsN9bxvJBq07cf+hhZ0M6ERwBPrUJFvHgv
         nIym9MT3ZOyXOVScfiGDcDIsCp9LQpz5UnmqOWdfpReeLcE8uF6iYBsze5q8YeS7V4qR
         39ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785323379; x=1785928179;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1mrR0h5a2tnzaiN6M63ThlKTtbHhhDFOkDL005+wWy0=;
        b=XPbh+6ehlMxqmujiGKjs5qGahGKPyUOSaYgFFFJRcds+gIQANuNnlcJpeWN2pSwHGQ
         1C4b1U2GPjqTKpLlt5oFf9iNcuCci9yDxWHcpy8HubYfxk9WVuFTWiDyq0hhrZ+iLMOM
         q7m9NC8Raz/VX4lBD4whEvJW1cGBNNVs4MzLRt8NYGvZ4IEf4aLsGpTLUJi72NyWEjLB
         PZMvv2nipqnG5sDulV/tSlHIQIqJYgyehQoOcBVQ2rXXBWHa2vE4atr2j+wGsK5qz5ON
         Pm1OuueZdCwMEZ05uwQqiMhFXi5yi3nEr44ooWJhf7zRz5Z3K0mbYEPrbIyAozLhZ/6A
         VD7w==
X-Forwarded-Encrypted: i=1; AHgh+RrzZYQDomVM9eqtHkh/Zb0cWL8hG1xFaIVg0gZ56wRiaCiHI7OE288ZCDxBmdOkK1T0n7p59HuEP+W7ViI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj7LmFxipmeo2FCmJHTDrFk3RfeiveHlC/IDu+4siqpzNc+o+u
	cjdlvgSgiioaWHxgJBtLQ0XZOeLPQ6RueJAEmHmWPs+GS9OPw2pVNtA+jvODYqUlyWP01ppnBSc
	C3/FRYa8=
X-Gm-Gg: AR+sD11bbGq7fEKy0r2cDGwIvMObHN3fuiDv7Ulm3WnhKbtnGNFAtOUL/3qBLmIzRON
	pipk6hcQo+bMxxkdTcoqaUZACSjpBAXk7Z3XQeG/8b5PKW8bTPHMdDHAbv60YPMLWS8b4LuIhEI
	sn2rBbbKjETGVWezu+YRsscELixal7sFk/a8deuCF3tpnOVnd15o9NUDHaFdXbMqAtaqeWl+UEC
	WT0q/jckwJxEFTPVG850t747uo4go3eGszivNhNh87HiG8Q0zd8Qaz6aQRoQRuG4MLlyfjvVSW7
	5psQIXy2loKcODPX3Qrffvr00+ZKWrtrs1DuDopruR5SO6OPlkSocwZbQ9z+qkrv66DgxkesLQm
	hGikhluEIHUPxEP1jBNwQsnGwVHd0RNYGgZKXwxeGu68gQJJFj+fVl0l/WAv7fvAX7S8nU8SzUI
	I6Jjl0YqW/zvV9SmsFMQIbq06fCbOUL87KTj2+lzDDbgCdZ5HAdFF8VBJCH6FngpY=
X-Received: by 2002:a05:600c:3b13:b0:495:5890:8f6c with SMTP id 5b1f17b1804b1-496c653d3dcmr82110535e9.7.1785323378759;
        Wed, 29 Jul 2026 04:09:38 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4976bd7c4c2sm50189635e9.14.2026.07.29.04.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 04:09:38 -0700 (PDT)
Date: Wed, 29 Jul 2026 13:09:36 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>,
	'Karl Mehltretter' <kmehltretter@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <clrkwllms@kernel.org>
Subject: Re: [PATCH v2 2/2] serial: amba-pl011: keep console clock enabled
 for atomic writes
Message-ID: <amnfcOod6ayqfNda@pathway.suse.cz>
References: <20260724213348.77418-1-kmehltretter@gmail.com>
 <20260724213348.77418-3-kmehltretter@gmail.com>
 <TYXPR01MB15199DA567AF4541DD79359FBD7CC2@TYXPR01MB15199.jpnprd01.prod.outlook.com>
 <87pl0863t5.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pl0863t5.fsf@jogness.linutronix.de>

On Mon 2026-07-27 14:05:50, John Ogness wrote:
> Hi Toshiyuki,
> 
> On 2026-07-27, "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com> wrote:
> > Regarding Petr's comment [1] as well, I'm concerned about the
> > potential impact when the clk remains enabled during periods without
> > console output.
> 
> Can you elaborate on your concerns? Do you actually need such low-power
> _and_ kernel logging directly on serial?

Good point!

> > When creating nbcon patch, I saw a similar patch [2] from the past.
> > Have you considered coordinating with the clk subsystem implementation
> > for this?
> 
> AFAICT there was no real justification for enabling clocks per write
> other than because we can. A lot has changed since 2013 and neither
> spin_locks nor raw_spin_locks are appropriate because atomic printing
> can occur in _any_ context (including NMI's).
> 
> If the amba-pl011 insists on enabling clocks per write, I would
> recommend not implementing the write_atomic() callback. Since I assume a
> significant amount of users _will_ want atomic printing support, perhaps
> you can add a Kconfig to toggle building with clock-disabling and no
> atomic, or clock-always-on and atomic.
> 
> Note that there is also CON_NBCON_ATOMIC_UNSAFE available, if the driver
> wants to somehow blindly enable clocks on panic in order to unsafely
> dump panic logs.

I personally vote for removing the enable_clock()/disable_clock()
from the console->write_*() callbacks. It was an interesting power
optimization. But I believe that the chance to see kernel messages
in critical situations is more important.

Also I guess that the serial port is _not_ used on devices powered
by baterry in production. It might be used when debugging and
it is exatly the situation where the messages are important.

Best Regards,
Petr

> John Ogness
> 
> > [1] https://lore.kernel.org/all/al4KdsU9YLOmwDoV@pathway.suse.cz/
> > [2] https://lore.kernel.org/all/1359475526-17523-1-git-send-email-walimisdev@gmail.com/
