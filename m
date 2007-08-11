From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: Serial ports rearranged in 2.6.22?
Date: Fri, 10 Aug 2007 21:54:02 -0700
Message-ID: <86802c440708102154r59e1acbj90fa0d5b73197fb9@mail.gmail.com>
References: <20070810213925.GB10855@elmicha>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:45039 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbXHKEyE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 11 Aug 2007 00:54:04 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1110717wah
        for <linux-serial@vger.kernel.org>; Fri, 10 Aug 2007 21:54:03 -0700 (PDT)
In-Reply-To: <20070810213925.GB10855@elmicha>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>

On 8/10/07, Michael Mauch <michael.mauch@gmx.de> wrote:
> Hi,
>
> until 2.6.21, I had the normal assignments for ttyS0 and ttyS1:
>
> 00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>
> With 2.6.22 I get the names <-> ports/irqs the other way around:
>
> 00:08: ttyS0 at I/O 0x2f8 (irq = 3) is a 16550A
> 00:09: ttyS1 at I/O 0x3f8 (irq = 4) is a 16550A
>
> Is this supposed to be that way? Should we reassign these names with
> udev? udev-114 doesn't seem to have built-in rules to assign the
> traditional names.
>
> Or could it be related to some brokeness in my BIOS (ACPI/PNP)?
>
> I'm using the 8250_pnp module (and it's the same with builtin serial
> modules). I made sure that I did not accidentally change the BIOS
> settings for the serial ports.
>
> I'm using Gentoo, but on the lirc list was a Fedora user with the same
> symptoms.

http://lkml.org/lkml/2007/7/25/455

YH
