From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] tty: serial core: use the ACPI PM state defines
Date: Thu, 6 Dec 2012 19:40:40 +0000
Message-ID: <20121206194040.0c79e7e8@pyramind.ukuu.org.uk>
References: <1354819612-2401-1-git-send-email-linus.walleij@stericsson.com>
	<20121206193131.33823e02@bob.linux.org.uk>
	<CACRpkdaFaL9jm9Je2NO_m+=-JgN02_s8=W8=t+TcHxn0ro2ojg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:55396 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946556Ab2LFTfg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Dec 2012 14:35:36 -0500
In-Reply-To: <CACRpkdaFaL9jm9Je2NO_m+=-JgN02_s8=W8=t+TcHxn0ro2ojg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alan Cox <alan@linux.intel.com>, Linus Walleij <linus.walleij@stericsson.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Rickard Andersson <rickard.andersson@stericsson.com>, linux-acpi@vger.kernel.org

On Thu, 6 Dec 2012 20:31:15 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Thu, Dec 6, 2012 at 8:31 PM, Alan Cox <alan@linux.intel.com> wrote:
> 
> > Almost none of the platforms using the serial driver even have ACPI so
> > this seems to be an obfuscation of a simple numbering system for a
> > subsystem specific set of definitions that may or may not fit in future.
> 
> OK so we need to get away from using the ACPI numbering scheme.

So whats wrong with 0 1 2 3 ?

