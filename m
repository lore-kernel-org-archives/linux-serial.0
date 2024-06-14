Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EC8179BC
	for <linux-serial@vger.kernel.org>; Fri, 14 Jun 2024 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718385504; cv=none; b=ey6o8bjCiKG6eE3lVmJ/32w69d/lIKZ+9RKibG8zmctaNoaTdjZzzkMciBdF/ZjVDtdsntOmQJUfJbZ9vrZ0w7xHEUJth18ex5VoKQ7tqY5BOKJdQ4viFUa7PMBEoQ78SjkQkRy9spgPpRN7eyW2AeNsLDFXtCZsPssiu+ooGhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718385504; c=relaxed/simple;
	bh=RbQiXk//5LE0+CQFSTyMsBkvBONsF/BYSpqN0fdUO34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkITU/8ddg97nP2hc+opXitdrMI4SY+RyozoQDXPjBfF5u7bQyc66WIgH5LwsYhFZoCSShMSreWdMEKRMRNGU8GrJ12rjdp7p1i7Jr0GhNquo2Oo0t75ZI82PmlZYiKK+hEs7SZN+DR0BEdtknzSExymdutqFsy4SbW/iQBn4IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e75WSjAI; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e75WSjAI"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6f0e153eddso329415366b.0
        for <linux-serial@vger.kernel.org>; Fri, 14 Jun 2024 10:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718385501; x=1718990301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xGKaapsSeNQ6/aDBUFIiYP/WXTn0IiML89dBYrB59AE=;
        b=e75WSjAIOWwSXEtKPZgiqQvXtdth5VESQoe0nlW+FreKOL4DUzKW3OzL9rzKrUa5T4
         PwfdrxJojL5jAG8nOheCoGqR5EApOxCKUIk95AtI5p95HkDnfbp+rg6KzP0StjMV/uYO
         HPIVu5kPxEht8x4z38908/p7LjEMCS073Sz1yKvMCi6KoGXW3P/mCq0ACC/7z7OghVia
         8lEK9M3jOU4eb14xxfacR8uZKRhPbdKCYE970Fc9c+CytkslfhrsywUoMYHVAIjzxly/
         Lg/UW23YUERHR+5TNUGGFkBlv8BRQvIVfUxDXKjXLWY1vNaCexbv+vLXIdYNmFmhU1Yo
         b3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718385501; x=1718990301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGKaapsSeNQ6/aDBUFIiYP/WXTn0IiML89dBYrB59AE=;
        b=akynyy0eqwBro91wUy69vP+PKzZy5rVzUKjVPpKNzOBhxv6JTvYaznaP5OENpN01ya
         azKc0XF/SyfuIMYWpg5CluIZbbkQ9MNwYiM1k3QzXrhiYSumRt+gdNy0iaEj0TGQ9G1K
         YO+pLRL6UFhSeyucReBdvbjURF+wHDphz0GfwXJpd7MMV3J0K+3ufEhNENPsa4jED3YP
         wzaBedo+iwuq6qi/z7Lmn59+IED2cLicVckwkmAPrAJpcw9kAfuZ+yb9YXM8atQCMIoT
         e+isGu+ak64c2QpghbUbQ9w/qwL1E3Iul4ocku2RahmBT+S6ZR4HgFDPCLlTVp+XkT1x
         tx0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCDyaETaFAC/h9H10dC651DUJ+eemCtB9VbetMYQhfJg+a6lzJFn6SgVz0DA3BYOPMQa2u0TgIvvdOmGH2jBbIY6pogH2r2IcJYhnG
X-Gm-Message-State: AOJu0Yx79AEdlFbZZEz9ixLiO611ajPAULSVkY7tZmgIlboTCJOJYclX
	NyCOL/vVGAfHPQrfTno/cWFBVtM6n9ldUC96kmDXvM6Li1D4wW97OxA1jetCDPM=
X-Google-Smtp-Source: AGHT+IE2pnKt3XqbaHN9Co4Oidy2AJcBt7lNvOT56d1TzhME8fheTGSbeTsXXWSoOEi/pV9hIJFLPw==
X-Received: by 2002:a17:906:5648:b0:a6f:ce5:2875 with SMTP id a640c23a62f3a-a6f60dc5169mr224168366b.50.1718385500681;
        Fri, 14 Jun 2024 10:18:20 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db6743sm205257466b.90.2024.06.14.10.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 10:18:20 -0700 (PDT)
Date: Fri, 14 Jun 2024 19:18:18 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] printk: Revert add_preferred_console_match()
 related commits
Message-ID: <Zmx7WiwzQ2Ne_UoT@pathway.suse.cz>
References: <20240613125113.219700-1-tony.lindgren@linux.intel.com>
 <20240613125113.219700-2-tony.lindgren@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613125113.219700-2-tony.lindgren@linux.intel.com>

On Thu 2024-06-13 15:51:07, Tony Lindgren wrote:
> Recent changes to allow using DEVNAME:0.0 style console names caused a
> regression to the kernel command line handling for the console options.
> 
> The last preferred console added gets used for init. This is documented
> in the comments for add_preferred_console(). Now the kernel command line
> options for console=ttyS0,115200 console=tty0 are wrongly handled and
> cause the /dev/console to be associated with ttyS0 instead of tty0.
> 
> This happens because we are calling __add_preferred_console() later on
> from serial8250_isa_init_ports() after console_setup() and the console
> gets treated as the last added preferred console. As the DEVNAME:0.0 style
> console device is not known at console_setup() time, I added a call to
> __add_preferred_console() later on when the console is ready.
> 
> To fix the issue, let's revert the printk related commits:
> 
> f03e8c1060f8 ("printk: Save console options for add_preferred_console_match()")
> b73c9cbe4f1f ("printk: Flag register_console() if console is set on command line")
> 8a831c584e6e ("printk: Don't try to parse DEVNAME:0.0 console options")
> 
> We need to also drop the call for add_preferred_console_match() from
> serial_base_add_one_prefcon() added by commit 787a1cabac01 ("serial: core:
> Add support for DEVNAME:0.0 style naming for kernel console").
> 
> Petr has suggested a better way to handle the deferred consoles that does
> not rely on calling __add_preferred_console() again.
> 
> Reported-by: Petr Mladek <pmladek@suse.com>
> Link: https://lore.kernel.org/linux-serial/ZlC6_Um4P4b-_WQE@pathway.suse.cz/
> Fixes: f03e8c1060f8 ("printk: Save console options for add_preferred_console_match()")
> Signed-off-by: Tony Lindgren <tony.lindgren@linux.intel.com>

It seems that it really reverts the right parts.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
