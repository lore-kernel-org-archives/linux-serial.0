From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: What to set uart_port->irq to for polled driver?
Date: Thu, 28 Feb 2013 15:16:33 -0500
Message-ID: <1362082593.3337.16.camel@thor.lan>
References: <kfgb7a$gl2$1@ger.gmane.org> <1362076338.3337.3.camel@thor.lan>
	 <kgo8gf$b1e$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout02.c08.mtsvc.net ([205.186.168.190]:58550 "EHLO
	mailout02.c08.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759169Ab3B1UQg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Feb 2013 15:16:36 -0500
In-Reply-To: <kgo8gf$b1e$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

On Thu, 2013-02-28 at 18:43 +0000, Grant Edwards wrote:
> On 2013-02-28, Peter Hurley <peter@hurleysoftware.com> wrote:
> > On Wed, 2013-02-13 at 15:24 +0000, Grant Edwards wrote:
> >> For a polled serial driver that doesn't use interrupts, to what should
> >> the "irq" field in the uart_port structure be set?  Should it be 0?
> >> Should it be the unused IRQ associated with the PCI card slot in which
> >> the board is found?
> >
> > Doesn't look supported, but adding the support doesn't look difficult.
> > At the very least, a patch is required so that on port shutdown, the
> > core doesn't synchronize_irq().
> 
> Does the call ty synchronize_irq() do any harm? AFAICT, it will just
> cause a short delay if handling of that IRQ is in-progress.
> 
> I currently set the "irq" field to the IRQ number that would be used
> by the board if I did choose to enable interrupts. That seems to work
> fine (with rather limited testing).

AFAICT, it's probably ok; but it might not be. Certainly more robust to
just add a UPF_POLLING flag and skip the synchronize_irq().

Is this an in-tree driver?

Regards,
Peter Hurley

