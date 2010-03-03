From: Sergei Organov <s.organov@javad.com>
Subject: Re: Disregard: [PATCH] tty: Char: mxser, add support for CP114EL
Date: Wed, 03 Mar 2010 14:11:52 +0300
Message-ID: <873a0hek1z.fsf@osv.gnss.ru>
References: <87bpf6esd7.fsf@osv.gnss.ru> <87r5o24efj.fsf@osv.gnss.ru>
	<4B8D8477.8020003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from javad.com ([205.178.136.214]:46505 "EHLO 02aef2d.netsolvps.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768Ab0CCLMc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Mar 2010 06:12:32 -0500
In-Reply-To: <4B8D8477.8020003@gmail.com> (Jiri Slaby's message of "Tue, 02
	Mar 2010 22:34:47 +0100")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-serial@vger.kernel.org

Jiri Slaby <jirislaby@gmail.com> writes:

> On 03/02/2010 10:11 PM, Sergei Organov wrote:
>> Sergei Organov <osv@javad.com> writes:
>>> Add support for MOXA:0x1144 pci device. It's a 4-port device and
>>> differs in no way from the others. So this turns out to be a trivial
>>> pci_device_id change.
>> 
>> Please disregard this patch for now. This board doesn't in fact work
>> properly with the driver and recognizing it by the driver might lead to
>> problems.
>> 
>> I'll be working on this, -- sorry for the noise.
>
> Yeah, the device you have is handled by different driver which is not
> upstream yet, If you really have the card, you can try to merge it and
> cleanup e.g. through staging. Note that the driver provided by moxa is
> ugly and needs cleanup before moving to drivers/char/. It might be worth
> to merge it with mxser (I haven't look into how much similar/different
> they are.).

Yeah, they seem to be similar, as I've almost got in-kernel driver to
work by looking at lspci output and making wild guesses, but then trying
to use /dev/ttyMI3 hang my PC.

I now compiled the driver provided by moxa and it works, so I now have a
code to refer to, and it has special-case for port 3 ;-) Unfortunately
their driver only supports kernels up to 2.6.30, so it will take
additional efforts to run it on recent.

I'm going to try to make in-kernel mxser to work with this board, --
will see how it goes.

-- Sergei.
