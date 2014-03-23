From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/8] tty/serial: add arm64 semihosting earlycon
Date: Sun, 23 Mar 2014 21:23:23 +0100
Message-ID: <14193198.1gAJ7xnz7b@wuerfel>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com> <1395436128-11244-8-git-send-email-robherring2@gmail.com> <alpine.LFD.2.11.1403231559160.1291@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.24]:55326 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbaCWUlP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 23 Mar 2014 16:41:15 -0400
In-Reply-To: <alpine.LFD.2.11.1403231559160.1291@knanqh.ubzr>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Rob Herring <robherring2@gmail.com>, Rob Herring <robh@kernel.org>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>

On Sunday 23 March 2014 16:04:41 Nicolas Pitre wrote:
> On Fri, 21 Mar 2014, Rob Herring wrote:
> 
> > From: Rob Herring <robh@kernel.org>
> > 
> > Add earlycon support for the arm64 semihosting debug serial interface.
> > This allows enabling a debug console when early_params are processed.
> > This is based on the arm64 earlyprintk smh support and is intended to
> > replace it.
> > 
> > This is named arm rather than arm64 in hopes it will be used for both,
> > but only arm64 is supported ATM.
> 
> It can't be used for both as the semihosting calls themselves need 
> assembly code and this is not compatible with the equivalent ARM32 
> calls.  So I'd suggest naming this "arm64" to avoid potential confusion.

How about using an compile-time conditional to put both inline assemblies
in there? While the driver is rather trivial to start with, I don't see
a point in duplicating it either.

	Arnd
