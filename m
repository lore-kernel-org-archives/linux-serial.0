Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367051BBBE4
	for <linux-serial@vger.kernel.org>; Fri, 15 Nov 2024 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682179; cv=none; b=HvWNftCI/YLAokfZgvs6cPzTMjnEQ1iIQrkeA2AgaWaYj4ORFjalew8TlYbwy3zXqcpgwRRjaukV1gn78n26I/e3S6OjhKayBxEogwJ1bKt10mga2olANZXjWkCqmTsHbtEmbF5qPvJNtnx30Qjf5U/ZwECuDpkwUPku4sk/iIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682179; c=relaxed/simple;
	bh=cEvUtqNSSUAF6Hc6fJCx0AVQzJ2NwRNXKucjOZuQ1AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/dAyEUo4TsxMA0t3J33tKgaZFuqkcZtwl/W/WwjvTkVt0tAwjihRrtQRsIbI6IvG53vMtU1sNA04xX7t3s2Uc0ujXzdgJviyaqxwt5vFJQbFm6QKNZCeWxww3sPPAhOcfX76JJFt0ccHbPmTWc8g4aRg1RggLTuenSux9vuF4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g0xjHdAf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g0xjHdAf"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so16921335e9.1
        for <linux-serial@vger.kernel.org>; Fri, 15 Nov 2024 06:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731682175; x=1732286975; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1CQ3VJsQiO7mOfIPbHAPwesm3SB/ITY8Xq3kn4cE8Tw=;
        b=g0xjHdAfTIxG5qDSSfC4nyzS8BMvEhWdO31bw86HMlL6NcoioYinTMJ25huKjAgqVY
         z3aSZAWsDphP+zp+JkzmPIOHG62k3q3OSEPprZFOpvI8w5YE8pi+RXN0zmFW5OWDZzpQ
         xZMIzGD5jJlu0W5d40yC/afVX8iBeYptd/xkYC7vY18XayL6ttg+w0ITMwbpNkS7pVoT
         y2MxXwFpO8hqlNGpAlsw76HkM+oFOH07SJ+YZLvTfOAutIZ3FkGG955x/aY49V52QBU6
         pb9RfjQdjCstpDYhpnC5paIkXazTAVyw4RP2pY+wTrHqEfoUvDdLaGQrnsQJqs7N0Ns8
         fFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731682175; x=1732286975;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1CQ3VJsQiO7mOfIPbHAPwesm3SB/ITY8Xq3kn4cE8Tw=;
        b=Fz7GntFFpHWGbiO1OSavbDqGLWdcqu4khN0fOVWYtFVF48eE+LricHSy0uJ6oAw84Y
         cKSzolg/hvPp4bAjr4GcJetfMRHLLId6nlR9HK8cUYq6zfmMt3AddBaqpx/S5H1kMs5s
         AHeb2yFWMnJQPuGCqvRl+AuiQczEZ2ZSU5xA8iJuZG17n9bJmr1wz6tBqHaMGXyZ32/m
         gtGUAKCOs3/PMSsRnMZAocafReWYmK6FXdHj24wRzrU+KrR6itOZtNBN0xf9DJBS9vRz
         Hm5HmGQfddFSLAoECgDauVjGTMybX6jiSNBQ+u+gOIuuuVD29EwEC4t+9aMs88CTwz/z
         YsPg==
X-Forwarded-Encrypted: i=1; AJvYcCX+YmGVgjbjooKh8PE7JzvJFnE9v2I3koZoC3mEFnAa7Z/pPQ2dvjy1vPVEsZ+f9eyUeqKpUK1VQQOpBe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNQuo+StRuzfQCrKtcpiwDTvCPMStFNU+GzWkq5hDgkneid8ZP
	pJQIMxUhtrBve79uy1iQdTiCElkoSoarx0RP8o3+kKAEaw+s185lW/imU9wP8MI=
X-Google-Smtp-Source: AGHT+IEZTRw0z2rsXoSRrmHzajz/Ttj2huRza2LtauItrrsM2B9+avISdV6Iv4/xXAH3qIK4xepK7w==
X-Received: by 2002:a05:600c:5487:b0:431:44fe:fd9f with SMTP id 5b1f17b1804b1-432df78a529mr20763285e9.23.1731682175469;
        Fri, 15 Nov 2024 06:49:35 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae1685csm4664066f8f.83.2024.11.15.06.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 06:49:35 -0800 (PST)
Date: Fri, 15 Nov 2024 14:49:33 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Omar Sandoval <osandov@osandov.com>,
	Jason Wessel <jason.wessel@windriver.com>,
	Amal Raj T <amalrajt@meta.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
	linux-debuggers@vger.kernel.org
Subject: Re: kgdb replacing newline with CRLF in custom query response
Message-ID: <20241115144933.GB4408@aspen.lan>
References: <Zy093jVKPs9gSVx2@telecaster>
 <CAD=FV=UZKZ_RL73+JLjeW2FmAfifSyXqLV3M30XzmJSPE9Trzw@mail.gmail.com>
 <Zy1lyACVnZK4xwuW@telecaster>
 <CAD=FV=U2eiG1TuTq48VL+kNCxN6qp_ZcDk3o_6p3B_ENOspQ9Q@mail.gmail.com>
 <Zy45mCCGZ9sHsXTT@telecaster>
 <CAD=FV=WN5Nzjs2KowMbTij8CZ+T_eZxJ5rLdyyBDk-1H_Dj3cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WN5Nzjs2KowMbTij8CZ+T_eZxJ5rLdyyBDk-1H_Dj3cg@mail.gmail.com>

On Fri, Nov 08, 2024 at 09:37:32AM -0800, Doug Anderson wrote:
> Hi,
>
> On Fri, Nov 8, 2024 at 8:17 AM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > On Fri, Nov 08, 2024 at 07:31:19AM -0800, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Thu, Nov 7, 2024 at 5:13 PM Omar Sandoval <osandov@osandov.com> wrote:
> > > >
> > > > On Thu, Nov 07, 2024 at 05:08:58PM -0800, Doug Anderson wrote:
> > > > > Hi,
> > > > >
> > > > > On Thu, Nov 7, 2024 at 2:23 PM Omar Sandoval <osandov@osandov.com> wrote:
> > > > > >
> > > > > > Hi everyone,
> > > > > >
> > > > > > Amal is working on adding a custom query packet to kgdb for getting the
> > > > > > kernel's vmcoreinfo. The rationale and details are available here:
> > > > > > https://github.com/osandov/drgn/wiki/GDB-Remote-Protocol-proposal:-linux.vmcoreinfo-query-packet
> > > > > >
> > > > > > vmcoreinfo is about 3kB, so we were hoping to avoid hex-encoding the
> > > > > > response and doubling the time it takes to transmit over a slow serial
> > > > > > connection. Instead, we were hoping to use the escaped binary format,
> > > > > > which escapes the characters #$}* and leaves other bytes untouched.
> > > > > >
> > > > > > We ran into a problem, though: vmcoreinfo contains newline characters,
> > > > > > which the serial core replaces with CRLF; see commit c7d44a02ac60
> > > > > > ("serial_core: Commonalize crlf when working w/ a non open console
> > > > > > port").
> > > > >
> > > > > FWIW, the problem predates that commit, but that commit at least moved
> > > > > it to be someplace common. Before that some serial drivers were
> > > > > hardcoding it... ;-)
> > > > >
> > > > >
> > > > > > This effectively corrupts the data and causes a checksum
> > > > > > mismatch.
> > > > > >
> > > > > > We'd love some input on how to work around this, especially from the
> > > > > > kgdb maintainers. Here are a few options, in descending order of my
> > > > > > preference:
> > > > > >
> > > > > > 1. Disable the LF -> CRLF replacement while sending binary data.
> > > > > > 2. Escape the newlines using some other custom scheme.
> > > > > > 3. Give up and hex-encode the response.
> > > > >
> > > > > I haven't tried prototyping it, but what about moving the LR -> CRLF
> > > > > code to kdb_msg_write(). It would be really easy to do this in the
> > > > > case where we're doing "dbg_io_ops->write_char()" since we're already
> > > > > processing character at a time. It would be harder to do this when
> > > > > also sending the output to the various console, but may not _too_
> > > > > hard? You could loop searching for "\n" and send all the characters
> > > > > before the "\n", then send a "\r", then send the "\n" and all the
> > > > > characters up to the next "\n".
>
> Actually, looking at this again, I wonder if we even need to do any
> transformation before sending it to the various consoles. Probably
> not. I think it's _just_ the write_char() path that needed it?
>
>
> > > > > If you did this then you'd lose the "\n" to "\r\n" combination in the
> > > > > gdb stub, but _probably_ that doesn't matter?
> > > >
> > > > That sounds reasonable. I was concerned whether this would affect
> > > > anything else using the ->poll_put_char() tty operation, but kgdb seems
> > > > to be the only user, does that sound right?
> > >
> > > Right. As far as I can tell, kgdb is the only user of poll_put_char().
> >
> > Ah, one other concern, though: only uart_poll_put_char() does the CRLF
> > replacement, but there are other tty_operations that don't, like
> > hvc_poll_put_char(). So if we move that to kdb_msg_write(), then we'll
> > be adding extra '\r' for other tty types. Would that be a problem?
>
> I honestly don't know. I guess also it can be noted that if we do it
> in kdb_msg_write() then the write_char() path can even take us to
> places that don't invoke uart_poll_put_char(). For instance
> "ehci-dbgp.c" registers its own io_module...
>
> Bleh. It _probably_ wouldn't be a big deal to do the LF -> CRLF for
> all these, but I don't know for sure. I guess worst case you could add
> some flag in the "dbg_io_ops" and figure out how to set it just for
> UARTs?

I find myself in a similar position to Doug.

It sounds reasonable to move the CR synthesis into kdb_msg_write() but I
also am not certain the other polling backends will handle this correctly.

However I did apply the following patch and run a few tests and it all
looks good. Specifically there are no regressions from the kgdb test
suite although that's unsurprising since that suite exclusively tests
the serial port. I also fired up the kdb,kms polling backends on x86
and verified that I didn't get double line feeds in kdb (I did not).

That means I'd certainly accept patches based on Doug's idea and if it
proves later that we have to revert and add a new dbg_io_ops pointer to
switch the handler between binary and ascii modes then so be it!


Daniel.


diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index d94d73e45fb6d..fff1269c55498 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2738,8 +2738,10 @@ static void uart_poll_put_char(struct tty_driver *driver, int line, char ch)
 	if (!port)
 		return;

+#if 0
 	if (ch == '\n')
 		port->ops->poll_put_char(port, '\r');
+#endif
 	port->ops->poll_put_char(port, ch);
 	uart_port_deref(port);
 }
diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 6a77f1c779c4c..43a7c8ad741ac 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -572,6 +572,8 @@ static void kdb_msg_write(const char *msg, int msg_len)
 	len = msg_len;

 	while (len--) {
+		if (*cp == '\n')
+			dbg_io_ops->write_char('\r');
 		dbg_io_ops->write_char(*cp);
 		cp++;
 	}
