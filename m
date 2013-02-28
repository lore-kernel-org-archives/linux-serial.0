From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: What to set uart_port->irq to for polled driver?
Date: Thu, 28 Feb 2013 20:42:39 +0000 (UTC)
Message-ID: <kgoffv$kbi$1@ger.gmane.org>
References: <kfgb7a$gl2$1@ger.gmane.org> <1362076338.3337.3.camel@thor.lan>
 <kgo8gf$b1e$1@ger.gmane.org> <1362082593.3337.16.camel@thor.lan>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:45679 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754751Ab3B1Umy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Feb 2013 15:42:54 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1UBAJs-0004vZ-TD
	for linux-serial@vger.kernel.org; Thu, 28 Feb 2013 21:43:12 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 28 Feb 2013 21:43:12 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 28 Feb 2013 21:43:12 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2013-02-28, Peter Hurley <peter@hurleysoftware.com> wrote:
> On Thu, 2013-02-28 at 18:43 +0000, Grant Edwards wrote:
>> On 2013-02-28, Peter Hurley <peter@hurleysoftware.com> wrote:
>>> On Wed, 2013-02-13 at 15:24 +0000, Grant Edwards wrote:
>>>> For a polled serial driver that doesn't use interrupts, to what should
>>>> the "irq" field in the uart_port structure be set?  Should it be 0?
>>>> Should it be the unused IRQ associated with the PCI card slot in which
>>>> the board is found?
>>>
>>> Doesn't look supported, but adding the support doesn't look
>>> difficult. At the very least, a patch is required so that on port
>>> shutdown, the core doesn't synchronize_irq().
>> 
>> Does the call ty synchronize_irq() do any harm? AFAICT, it will just
>> cause a short delay if handling of that IRQ is in-progress.
>> 
>> I currently set the "irq" field to the IRQ number that would be used
>> by the board if I did choose to enable interrupts. That seems to work
>> fine (with rather limited testing).
>
> AFAICT, it's probably ok; but it might not be. Certainly more robust
> to just add a UPF_POLLING flag and skip the synchronize_irq().
>
> Is this an in-tree driver?

No.

One of my polled mode drivers is an enhanced version of the new rp2
serial driver.  It's currently in beta test.  I posted a snapshot of
that one to this list last week, but it hasn't been submitted as a git
patch yet.

The other is a rewrite of the rocket driver -- it's still under
development.  I'd be happy to submit it for inclusion in the tree when
it's done.

-- 
Grant Edwards               grant.b.edwards        Yow! Give them RADAR-GUIDED
                                  at               SKEE-BALL LANES and
                              gmail.com            VELVEETA BURRITOS!!

