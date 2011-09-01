From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/7] serial/8250: move UPIO_TSI to powerpc
Date: Thu, 01 Sep 2011 10:28:12 +0200
Message-ID: <4560783.75JgbxnBn8@wuerfel>
References: <1309211120-2803-1-git-send-email-arnd@arndb.de> <1309211120-2803-4-git-send-email-arnd@arndb.de> <1314856926.4145.12.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55174 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755580Ab1IAI20 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Sep 2011 04:28:26 -0400
In-Reply-To: <1314856926.4145.12.camel@pasglop>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org

On Thursday 01 September 2011 16:02:06 Benjamin Herrenschmidt wrote:
> On Mon, 2011-06-27 at 23:45 +0200, Arnd Bergmann wrote:
> > This iotype is only used by the legacy_serial code in powerpc, so the
> > code should live there, rather than be compiled in for every 8250
> > driver.
> 
> Obviously untested 
> 
> Misses the definition of UART_IIR etc...
> 
> I'm committing a fixed version in my tree

Ok, thank you!

	Arnd
