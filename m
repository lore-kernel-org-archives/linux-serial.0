From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] tty: serial core: use the ACPI PM state defines
Date: Thu, 06 Dec 2012 21:57:39 +0100
Message-ID: <4026440.u9szfCN7Na@vostro.rjw.lan>
References: <1354819612-2401-1-git-send-email-linus.walleij@stericsson.com> <20121206193131.33823e02@bob.linux.org.uk> <CACRpkdaFaL9jm9Je2NO_m+=-JgN02_s8=W8=t+TcHxn0ro2ojg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:42254 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1424824Ab2LFUwo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Dec 2012 15:52:44 -0500
In-Reply-To: <CACRpkdaFaL9jm9Je2NO_m+=-JgN02_s8=W8=t+TcHxn0ro2ojg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Alan Cox <alan@linux.intel.com>, Linus Walleij <linus.walleij@stericsson.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, Rickard Andersson <rickard.andersson@stericsson.com>

On Thursday, December 06, 2012 08:31:15 PM Linus Walleij wrote:
> On Thu, Dec 6, 2012 at 8:31 PM, Alan Cox <alan@linux.intel.com> wrote:
> 
> > Almost none of the platforms using the serial driver even have ACPI so
> > this seems to be an obfuscation of a simple numbering system for a
> > subsystem specific set of definitions that may or may not fit in future.
> 
> OK so we need to get away from using the ACPI numbering scheme.
> What about we define something in the <linux/tty.h> file instead
> and delete the paragraph from the documentation saying it is related
> to ACPI? (Will try this next.)

Deleting that paragraph would be fine by me, FWIW.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
