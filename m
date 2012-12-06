From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 2/2] tty: serial core: use the ACPI PM state defines
Date: Thu, 6 Dec 2012 23:36:00 +0000
Message-ID: <20121206233600.7249c3f1@bob.linux.org.uk>
References: <1354819612-2401-1-git-send-email-linus.walleij@stericsson.com>
	<20121206193131.33823e02@bob.linux.org.uk>
	<CACRpkdaFaL9jm9Je2NO_m+=-JgN02_s8=W8=t+TcHxn0ro2ojg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:52848 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932156Ab2LFXd0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Dec 2012 18:33:26 -0500
In-Reply-To: <CACRpkdaFaL9jm9Je2NO_m+=-JgN02_s8=W8=t+TcHxn0ro2ojg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Linus Walleij <linus.walleij@stericsson.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Rickard Andersson <rickard.andersson@stericsson.com>, linux-acpi@vger.kernel.org

On Thu, 6 Dec 2012 20:31:15 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Thu, Dec 6, 2012 at 8:31 PM, Alan Cox <alan@linux.intel.com> wrote:
> 
> > Almost none of the platforms using the serial driver even have ACPI
> > so this seems to be an obfuscation of a simple numbering system for
> > a subsystem specific set of definitions that may or may not fit in
> > future.
> 
> OK so we need to get away from using the ACPI numbering scheme.
> What about we define something in the <linux/tty.h> file instead
> and delete the paragraph from the documentation saying it is related
> to ACPI? (Will try this next.)

What about just using 0, 1, 2, 3 to indicate states similar to D0-D3
which as a base concept everyone is familiar with ?

If we need something more than that, then can we talk about what the
actual extra non 0/3 states needed are and how to get a generic
meaningful definition, or indeed whether a number rather than flag bits
makes sense ?

Start with the driver/platform that causes the concern and then the
rest is probably blindingly obvious.

Alan
