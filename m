From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] tty: serial core: use the ACPI PM state defines
Date: Thu, 6 Dec 2012 20:31:15 +0100
Message-ID: <CACRpkdaFaL9jm9Je2NO_m+=-JgN02_s8=W8=t+TcHxn0ro2ojg@mail.gmail.com>
References: <1354819612-2401-1-git-send-email-linus.walleij@stericsson.com>
	<20121206193131.33823e02@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:37933 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423225Ab2LFTbQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Dec 2012 14:31:16 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so3834304eek.19
        for <linux-serial@vger.kernel.org>; Thu, 06 Dec 2012 11:31:15 -0800 (PST)
In-Reply-To: <20121206193131.33823e02@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Rickard Andersson <rickard.andersson@stericsson.com>, linux-acpi@vger.kernel.org

On Thu, Dec 6, 2012 at 8:31 PM, Alan Cox <alan@linux.intel.com> wrote:

> Almost none of the platforms using the serial driver even have ACPI so
> this seems to be an obfuscation of a simple numbering system for a
> subsystem specific set of definitions that may or may not fit in future.

OK so we need to get away from using the ACPI numbering scheme.
What about we define something in the <linux/tty.h> file instead
and delete the paragraph from the documentation saying it is related
to ACPI? (Will try this next.)

Yours,
Linus Walleij
