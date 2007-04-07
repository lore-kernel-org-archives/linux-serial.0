From: Mikhail Zolotaryov <lebon@faust.net.ua>
Subject: Re: [PATCH] PPC4xx UART0 (8250) problem
Date: Sat, 07 Apr 2007 11:41:38 +0300
Message-ID: <46175942.7080707@faust.net.ua>
References: <46171C50.3020104@faust.net.ua> <1175922756.7407.46.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.faust.net.ua ([195.68.202.98]:32967 "EHLO
	mail.faust.net.ua" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965635AbXDGIgO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 7 Apr 2007 04:36:14 -0400
In-Reply-To: <1175922756.7407.46.camel@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: mporter@kernel.crashing.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote: 
> This is an old problem. The proper fix is already implemented for
> arch/powerpc and consist of having virtual irq numbers (which helps for
> many other things anyway).
> 
> Support for 4xx platforms in arch/powerpc is starting to get in, pop on
> linuxppc-dev@ozlabs.org where the patches are being posted and you are
> welcome to give a hand porting more platforms over :-)

First, thanks for response.

Ok, I see IRQ0 mapping to virtual number is good solution but I know the
problem from the times of 2.4 kernel. It was very surprising while moving to
2.6 kernel - serial driver was changed, but we have the same problem there.

Maybe it's good idea to create unofficial ppc linux branch repository
(or it already exists ?) where we can put patches that work (as above) but
not in pretty good way linux community expects.
