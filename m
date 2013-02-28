From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: What to set uart_port->irq to for polled driver?
Date: Thu, 28 Feb 2013 13:32:18 -0500
Message-ID: <1362076338.3337.3.camel@thor.lan>
References: <kfgb7a$gl2$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout02.c08.mtsvc.net ([205.186.168.190]:52420 "EHLO
	mailout02.c08.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755232Ab3B1ScW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Feb 2013 13:32:22 -0500
In-Reply-To: <kfgb7a$gl2$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

On Wed, 2013-02-13 at 15:24 +0000, Grant Edwards wrote:
> For a polled serial driver that doesn't use interrupts, to what should
> the "irq" field in the uart_port structure be set?  Should it be 0?
> Should it be the unused IRQ associated with the PCI card slot in which
> the board is found?

Doesn't look supported, but adding the support doesn't look difficult.
At the very least, a patch is required so that on port shutdown, the
core doesn't synchronize_irq().

Regards,
Peter Hurley

