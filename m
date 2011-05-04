From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Subject: Re: [RFC 1/5] platform-drivers-x86: add support for Technologic Systems TS-5xxx detection
Date: Wed, 04 May 2011 16:34:33 -0400
Message-ID: <1304537667-sup-2171@sfl>
References: <1304115712-5299-1-git-send-email-vivien.didelot@savoirfairelinux.com> <1304115712-5299-2-git-send-email-vivien.didelot@savoirfairelinux.com> <20110430110705.5ca3376b@lxorguk.ukuu.org.uk> <1304520382-sup-3361@sfl> <20110504162954.7ecf5b5e@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([209.172.62.77]:56361 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab1EDUei (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 May 2011 16:34:38 -0400
In-reply-to: <20110504162954.7ecf5b5e@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jonas Fonseca <jonas.fonseca@savoirfairelinux.com>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Excerpts from Alan Cox's message of 2011-05-04 11:29:54 -0400:
> > It is possible to make a BIOS call (Int 15h / Function B000h) to get
> > board information, like the manufacturer ("TS"). It should be a safer
> > way to check if we are on a Technologic Systems board. a intcall(0x15,
> > &ireg, &oreg) should do the trick to check the platform, before checking
> > the SBC ID. What do you think?
> 
> And that goes to 'How you do yo know it's safe to call INT 15 0xB000 -
> especially as we are in 32bit mode and the BIOS is 16bit so you have to
> call it very early meaning its a great way to make something else not
> boot.
> 
> Does the board not support anything sane like DMI ?
> 
> Alan

I've looked at that, and the board doesn't support DMI. Elements we have
are the processor (i.e. AMD ElanSC520), the BIOS, maybe the memory and
PCI bus layouts...

Have you got another idea how to get information in a safe way?

Regards,
Vivien.
