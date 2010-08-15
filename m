From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: RS485: ioctls defined twice ?
Date: Sun, 15 Aug 2010 16:38:48 +0100
Message-ID: <20100815153848.GA19113@n2100.arm.linux.org.uk>
References: <4C67F815.8020808@evidence.eu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35359 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755715Ab0HOPjF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 15 Aug 2010 11:39:05 -0400
Content-Disposition: inline
In-Reply-To: <4C67F815.8020808@evidence.eu.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Claudio Scordino <claudio@evidence.eu.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Rick Bronson <rick@efn.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

On Sun, Aug 15, 2010 at 04:22:13PM +0200, Claudio Scordino wrote:
> Hi all,
> 
> 	is there any reason why ioctls TIOCGRS485 and TIOCSRS485 are defined

Please wrap your message sensibly so I can see it while replying to you.

> The same happens also for avr32, powerpc and cris (which, however, defines
> 
> Is it duplicated code ?
> 
> Or should these values stay in both asm/ioctls.h and asm-generic/ioctls.h ?

As an exercise to help you answer your own question, please research
how asm-generic/ioctls.h get included on an avr32, powerpc, cris or
ARM kernel build.
