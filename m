From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: 2.6.16-mm1
Date: Tue, 28 Mar 2006 11:18:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0603281117530.16802@scrub.home>
References: <20060323014046.2ca1d9df.akpm@osdl.org> <6bffcb0e0603230631r5e6cc3d3p@mail.gmail.com>
 <20060323144922.GA25849@flint.arm.linux.org.uk> <Pine.LNX.4.64.0603241140350.16802@scrub.home>
 <20060324195917.GA32098@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from scrub.xs4all.nl ([194.109.195.176]:58803 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751245AbWC1JSy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Mar 2006 04:18:54 -0500
In-Reply-To: <20060324195917.GA32098@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Hi,

On Fri, 24 Mar 2006, Russell King wrote:

> the correct way to tell Kconfig to give us that is:
> 
> +config SERIAL_8250_PCI
> +       tristate "8250/16550 PCI device support" if EMBEDDED
> +       depends on SERIAL_8250 && PCI
> +       default SERIAL_8250
> +       help
> +         This builds standard PCI serial support. You may be able to
> +         disable this feature if you only need legacy serial support.
> +         Saves about 9K.
> 
> ?

Yes, this should do it.

bye, Roman
