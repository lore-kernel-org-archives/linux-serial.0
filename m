From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: What to set uart_port->irq to for polled driver?
Date: Thu, 28 Feb 2013 18:43:28 +0000 (UTC)
Message-ID: <kgo8gf$b1e$1@ger.gmane.org>
References: <kfgb7a$gl2$1@ger.gmane.org> <1362076338.3337.3.camel@thor.lan>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51138 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756486Ab3B1Snn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Feb 2013 13:43:43 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1UB8SX-0006OI-92
	for linux-serial@vger.kernel.org; Thu, 28 Feb 2013 19:44:01 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 28 Feb 2013 19:44:01 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 28 Feb 2013 19:44:01 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2013-02-28, Peter Hurley <peter@hurleysoftware.com> wrote:
> On Wed, 2013-02-13 at 15:24 +0000, Grant Edwards wrote:
>> For a polled serial driver that doesn't use interrupts, to what should
>> the "irq" field in the uart_port structure be set?  Should it be 0?
>> Should it be the unused IRQ associated with the PCI card slot in which
>> the board is found?
>
> Doesn't look supported, but adding the support doesn't look difficult.
> At the very least, a patch is required so that on port shutdown, the
> core doesn't synchronize_irq().

Does the call ty synchronize_irq() do any harm? AFAICT, it will just
cause a short delay if handling of that IRQ is in-progress.

I currently set the "irq" field to the IRQ number that would be used
by the board if I did choose to enable interrupts. That seems to work
fine (with rather limited testing).

-- 
Grant Edwards               grant.b.edwards        Yow! We just joined the
                                  at               civil hair patrol!
                              gmail.com            

