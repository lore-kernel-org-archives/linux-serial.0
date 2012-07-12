From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 8250: Add new UART type SC16C550
Date: Thu, 12 Jul 2012 09:59:19 +0100
Message-ID: <20120712095919.0d05f00f@pyramind.ukuu.org.uk>
References: <20120711195453.GC4260@8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:59323 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121Ab2GLIzl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Jul 2012 04:55:41 -0400
In-Reply-To: <20120711195453.GC4260@8d.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Raphael Assenat <raph@8d.com>
Cc: linux-serial@vger.kernel.org

On Wed, 11 Jul 2012 15:54:53 -0400
Raphael Assenat <raph@8d.com> wrote:

>     The NXP SC16C550 has a 16 Byte FIFO and support Automatic Flow Control,
>     enabled by setting bit 5 of MCR (a.k.a. AFE).
>     
>     This patch adds a new 8250 port type (PORT_SC16C550) to support
>     this chip correcly. Should also work for TI TL16550C/D.
>     
>     Tested on a custom OMAP board with an SC16C554 (quad uart) attached
>     to the GPMC. We experienced receive overruns when not using AFE.
>     
>     Signed-off-by: Raphael Assenat <raph@8d.com>

Looks fine and ready to go in as and when patches for the mainline kernel
that actually use it go in (ie submit it with the board support once you
get that far)

Alan
