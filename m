Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF4A3002BA
	for <linux-serial@vger.kernel.org>; Fri, 28 Nov 2025 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764323551; cv=none; b=dIuJwW6FYv00eht26FoGB/60u101DjhGodLvjGR3sG/H64P0t3cOP6wvLZlix7LB11WKfy4t0ukaWLncQQOWEtVNmyHhBJHx1zZNtnRJJW5YH2Kx24O5W9nmO3MyS/2GbNlknTX7nYpLwCOL41e3DjRU/gqvAM17Qylb8EjjlaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764323551; c=relaxed/simple;
	bh=WXJsmsuNb/mm0iewmiRY5cDrpCtzmeJogbnrZVOhhR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1keMo2nvB+cQHGWCG0T2kvBADtukdGA6KCS6aXU5ZWuzx4mJPuG5rD8L78BWHE78GU+6R4M7iPKVbS/A5zaKnY5wiadsDCV3OYZf0ngUslbOEzodnlf90eoyIFIsQKzTYr0bb7w6HKfnYZkL2EoJI9FRn6poCCg5DfFr70y9OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=DR4szICw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="DR4szICw"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477632b0621so9259415e9.2
        for <linux-serial@vger.kernel.org>; Fri, 28 Nov 2025 01:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1764323547; x=1764928347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+JX3XeAoPziFMJInK2Wsnqx3380N8ZAktDPiEBHNHZM=;
        b=DR4szICw7lJuibmv+j3QIEtMOWBhCvdj+yxQvQLIAEsr7ztlLmMVe7N4VyR3xThS4R
         AnX0WQUWa24xB/c9sySPsuX4ZVcLFIxefYK+/GS9c0icwEcZoA7/GHhB0K4ejR2xsZxw
         BBMwwqZ/vfoxZx8JRytp9wyzf2lwtk49SQDlbYgMyjcvMLMI6HCq/09O4APNETadjaPU
         3I6r1Jk4RaOB9+WoZFOhid+R7OwPUN9xvI+r+whVaYauU60N65tCr+wXMoTiv5v3tIwG
         AeH7fs1pSaKAfOSWAESmBZ/4LoLoqg7GQ7UXxVs08IweIzo59e+hkDUuglbKhNj8QzU+
         gEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764323547; x=1764928347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JX3XeAoPziFMJInK2Wsnqx3380N8ZAktDPiEBHNHZM=;
        b=Oh56QsYq/+GqqyivmrdglNNM5bHBNr8tY0Fp/b3ZbkSc2ZN8/kxXFg8UzxThmC1q8B
         7kj/2hZib7lCl5+Ef0DYJFtNL56MA5EAwxDl3FpyERT/MfQPHHZnScmS4/M8t1UExCKX
         nyP+BEWY5ISKIPYdakBKcgPwBYYOwGPUNp2+BB5UxeNqWxrUaEsNHQtRKNs12+fe+QLl
         vNnp3UDI+fhWEyrIhdSTI6zeILxkLPt1ClBYS5rTheTHApRIDE3dxFV2iy5ctWHVw4Bp
         yIwzAPUKcqBJ7MNHxG50EQ8S/Zpg3d20sl35kdQGuYg/VgrjQ4fmBs0PpdxTGd24OBs+
         gnMg==
X-Forwarded-Encrypted: i=1; AJvYcCXqD0lHZ6gnK8m2cJlJX3gpA18MgcXkyNjkspVNEZ5ozrmsu06I76fZEYJTa8yW0glnUX1Swhg8rlZ+QuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXHYemwOU3L5vT0ZMFpbq9rgiqMMl300jvud/CEghgf+zz48xN
	cxhOeJpSOnMdVXTWKTuK7Dk1+Z5WB3Cv1ovGsGDqpvgVrAfmocnnQFX/KP+rUhOqe8s=
X-Gm-Gg: ASbGncv8reNMebsajd2tbr2W1jCY/EAETzCNc33Sj0hfSc5VpzI3CMlIwewk14KTZiP
	FNXm7hXMb5qf/J0XP77gZeZ2NRy0AneKM5VGoX6nlhk/NwIfj1ZekJWz7JXxqDV2dYqLEJHHz/t
	8RBaXoOjF83H1sDZ3ws+CfbRIRH1QoOA2WpoqBiHvw1tvfbqhteamffyuorBjNzhj4ybJunv8CI
	CkHpvtLjK1sBjWUrDZtBnHcFhUsdNij/s3jOC7aPAH321vPCK3zQxjrNiLaK9TZMZKMKYo+2vIz
	al4zNZvrlI9DztlE1e/U58ANkzbcylK3Vo8+vqTOJ7/+f9IdClTJihphIYjwWFKzSunUywKdCci
	bgS5xn39+laMfsmfaV7fO6CyeoHT/Eva6rVPI4UMu+ow1L0GXjnvlRgrqAR8gAevzxmVd5aSfS2
	Te0oZTDOgWbPB1WnUhLOhae1//fsMI6uaIdww+/YfNDIYIIyHMRdvJTLrKMdl6/lPcD8wuog==
X-Google-Smtp-Source: AGHT+IEou8ioIaohphRX3g14Kfa+nakRPZ5lw4pW3M17hreUZfX39G6tpJPxcg2/gDvtuPOahWfOAg==
X-Received: by 2002:a05:600c:1f0f:b0:46e:37fe:f0e6 with SMTP id 5b1f17b1804b1-477c1131db6mr263935475e9.30.1764323547239;
        Fri, 28 Nov 2025 01:52:27 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791164d365sm76381955e9.12.2025.11.28.01.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 01:52:26 -0800 (PST)
Date: Fri, 28 Nov 2025 09:52:24 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
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
Subject: Re: [PATCH v2 0/4] printk cleanup - part 2
Message-ID: <aSlw2AHo_AWzjH-s@aspen.lan>
References: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
 <aShr0DZRmpDnL0nz@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aShr0DZRmpDnL0nz@pathway.suse.cz>

On Thu, Nov 27, 2025 at 04:18:40PM +0100, Petr Mladek wrote:
> On Fri 2025-11-21 15:50:32, Marcos Paulo de Souza wrote:
> > The first part can be found here[1]. The proposed changes do not
> > change the functionality of printk, but were suggestions made by
> > Petr Mladek. I already have more patches for a part 3 ,but I would like
> > to see these ones merged first.
> >
> > I did the testing with VMs, checking suspend and resume cycles, and it worked
> > as expected.
> >
> > Thanks for reviewing!
>
> > Marcos Paulo de Souza (4):
> >       drivers: serial: kgdboc: Drop checks for CON_ENABLED and CON_BOOT
> >       arch: um: kmsg_dump: Use console_is_usable
> >       printk: Use console_is_usable on console_unblank
>
> These three patches were simple, straightforward, and ready for linux
> next.
>
> I have comitted them into printk/linux.git, branch rework/nbcon-in-kdb.
> I am going to push them for 6.19.

I pointed the kgdb test suite at this branch (as I did for the earlier
part of the patchset, although I think I forgot to post about it).

The console coverage is fairly modest (I think just 8250 and PL011
drivers, with and without earlycon) and the suite exercises features
rather than crash resilience. Nevertheless and FWIW, the tests didn't
pick up any regressions. Yay!


Daniel.
