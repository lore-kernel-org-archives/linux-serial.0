From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] serial: fix au1xxx UART0 irq setup
Date: Thu, 25 Oct 2007 15:57:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64N.0710251548080.24086@blysk.ds.pg.gda.pl>
References: <4720A11E.5060101@gmail.com> <20071025140940.GC23398@linux-mips.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:37147 "EHLO
	cerber.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754621AbXJYO5J (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Oct 2007 10:57:09 -0400
In-Reply-To: <20071025140940.GC23398@linux-mips.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Jan Nikitenko <jan.nikitenko@gmail.com>, linux-mips@linux-mips.org, linux-serial@vger.kernel.org

On Thu, 25 Oct 2007, Ralf Baechle wrote:

> That said, irq 0 is imho totally valid (take the good old PIT timer
> interrupt of the PC as the classic example) and treating it as an invalid 
> interrupt number is broken.

 I would rather -1 stood for the invalid IRQ number -- unlike with 0 
chances are nobody will need 4G of interrupt lines or vectors (as 
applicable) in a single system.  We sort of escape the problem with the 
MIPS processors because the IP0 bit of the Cause register is a software 
interrupt that is not used by devices, but still some platforms bypass the 
built-in interrupt "controller" as only a single source is used in the 
Cause register and want to start the numbering of lines in the external 
controller from 0.

  Maciej
