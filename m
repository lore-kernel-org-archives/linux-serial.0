From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 7/8] tty/serial: add arm64 semihosting earlycon
Date: Mon, 24 Mar 2014 11:48:39 +0000
Message-ID: <20140324114839.GH3850@arm.com>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
 <1395436128-11244-8-git-send-email-robherring2@gmail.com>
 <20140324113821.GF3850@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fw-tnat.austin.arm.com ([217.140.110.23]:43393 "EHLO
	collaborate-mta1.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750924AbaCXLtA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Mar 2014 07:49:00 -0400
Content-Disposition: inline
In-Reply-To: <20140324113821.GF3850@arm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Russell King <linux@arm.linux.org.uk>, Will Deacon <Will.Deacon@arm.com>, "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>

On Mon, Mar 24, 2014 at 11:38:21AM +0000, Catalin Marinas wrote:
> On Fri, Mar 21, 2014 at 09:08:47PM +0000, Rob Herring wrote:
> > --- /dev/null
> > +++ b/drivers/tty/serial/earlycon-arm-semihost.c
> > @@ -0,0 +1,44 @@
> > +/*
> > + * Copyright (C) 2012 ARM Ltd.
> > + * Author: Catalin Marinas <catalin.marinas@arm.com>
> 
> Nitpick: author should be Mark Zyngier <marc.zyngier@arm.com> 

And a typo in my email: s/Mark/Marc/.

Thanks.

-- 
Catalin
