From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] tty: serial core: use the ACPI PM state defines
Date: Fri, 7 Dec 2012 11:30:45 +0100
Message-ID: <CACRpkdaCjqo-DfFnpyi1v_U5vAXSM=W4YxanoXhGAsM__+rndA@mail.gmail.com>
References: <1354819612-2401-1-git-send-email-linus.walleij@stericsson.com>
	<20121206193131.33823e02@bob.linux.org.uk>
	<CACRpkdaFaL9jm9Je2NO_m+=-JgN02_s8=W8=t+TcHxn0ro2ojg@mail.gmail.com>
	<20121206233600.7249c3f1@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:42525 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933344Ab2LGKar (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Dec 2012 05:30:47 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so181093eek.19
        for <linux-serial@vger.kernel.org>; Fri, 07 Dec 2012 02:30:46 -0800 (PST)
In-Reply-To: <20121206233600.7249c3f1@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Rickard Andersson <rickard.andersson@stericsson.com>, linux-acpi@vger.kernel.org

On Fri, Dec 7, 2012 at 12:36 AM, Alan Cox <alan@linux.intel.com> wrote:

> What about just using 0, 1, 2, 3 to indicate states similar to D0-D3
> which as a base concept everyone is familiar with ?

Sorry, I might be something of an oddity, but ACPI is not used on
ARM systems as of today, and I was completely confused by
these:

  uart_change_pm(state, 0);
  uart_change_pm(state, 3);

I was just like ... eh ... 0? 3?

No ACPI associations existed in my head until I finally found
the note in the documentation saying that it corresponds to
ACPI states.

We are a few kernel developers these days who never ever
worked on Intel, sorry for this, but that's what we are like :-)

> If we need something more than that, then can we talk about what the
> actual extra non 0/3 states needed are and how to get a generic
> meaningful definition, or indeed whether a number rather than flag bits
> makes sense ?

Sure, I think my colleague Rickard will soon post another
patch for controlling the state 1,2 bottom-up from drivers.

> Start with the driver/platform that causes the concern and then the
> rest is probably blindingly obvious.

It's the introduction of runtime power management for the ARM
amba-pl011.c UART driver that confuse us.

It is atleast obvious that none of the 5 ARM platforms using that
driver do not use ACPI, and I expect the situation to be the same
for most of the ARM drivers.

Yours,
Linus Walleij
