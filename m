From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] tty: serial core: use the ACPI PM state defines
Date: Thu, 6 Dec 2012 21:05:39 +0100
Message-ID: <CACRpkdaZax40nRqor33PKDRYKh_a2bXE2TdDhLHyRpcGXZnJLA@mail.gmail.com>
References: <1354819612-2401-1-git-send-email-linus.walleij@stericsson.com>
	<20121206193131.33823e02@bob.linux.org.uk>
	<CACRpkdaFaL9jm9Je2NO_m+=-JgN02_s8=W8=t+TcHxn0ro2ojg@mail.gmail.com>
	<20121206194040.0c79e7e8@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:58819 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761Ab2LFUFl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Dec 2012 15:05:41 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so3853047eek.19
        for <linux-serial@vger.kernel.org>; Thu, 06 Dec 2012 12:05:40 -0800 (PST)
In-Reply-To: <20121206194040.0c79e7e8@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@linux.intel.com>, Linus Walleij <linus.walleij@stericsson.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Rickard Andersson <rickard.andersson@stericsson.com>, linux-acpi@vger.kernel.org

On Thu, Dec 6, 2012 at 8:40 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Thu, 6 Dec 2012 20:31:15 +0100
> Linus Walleij <linus.walleij@linaro.org> wrote:
>
>> On Thu, Dec 6, 2012 at 8:31 PM, Alan Cox <alan@linux.intel.com> wrote:
>>
>> > Almost none of the platforms using the serial driver even have ACPI so
>> > this seems to be an obfuscation of a simple numbering system for a
>> > subsystem specific set of definitions that may or may not fit in future.
>>
>> OK so we need to get away from using the ACPI numbering scheme.
>
> So whats wrong with 0 1 2 3 ?

Mainly what is wrong is the documentation that says that this correlates
to the ACPI D-states.

But we're working to get a serial driver power aware and need to
start to let device drivers go to different power states, and then
we need to let the core handle not only state 0 and 3 (as it is
using today) but also 1 and 2 (currently not used in the serial
core). And if several device drivers shall do that it could be a
good idea to have some idea of what the numbers actually
mean, roughly atleast.

Yours,
Linus Walleij
