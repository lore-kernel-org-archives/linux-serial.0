From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 7/8] tty/serial: add arm64 semihosting earlycon
Date: Sun, 23 Mar 2014 17:48:48 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1403231742430.1291@knanqh.ubzr>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com> <1395436128-11244-8-git-send-email-robherring2@gmail.com> <alpine.LFD.2.11.1403231559160.1291@knanqh.ubzr> <14193198.1gAJ7xnz7b@wuerfel>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:37089 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbaCWVsv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 23 Mar 2014 17:48:51 -0400
Received: by mail-qa0-f41.google.com with SMTP id j5so4593334qaq.14
        for <linux-serial@vger.kernel.org>; Sun, 23 Mar 2014 14:48:50 -0700 (PDT)
In-Reply-To: <14193198.1gAJ7xnz7b@wuerfel>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Rob Herring <robherring2@gmail.com>, Rob Herring <robh@kernel.org>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>

On Sun, 23 Mar 2014, Arnd Bergmann wrote:

> On Sunday 23 March 2014 16:04:41 Nicolas Pitre wrote:
> > On Fri, 21 Mar 2014, Rob Herring wrote:
> > 
> > > From: Rob Herring <robh@kernel.org>
> > > 
> > > Add earlycon support for the arm64 semihosting debug serial interface.
> > > This allows enabling a debug console when early_params are processed.
> > > This is based on the arm64 earlyprintk smh support and is intended to
> > > replace it.
> > > 
> > > This is named arm rather than arm64 in hopes it will be used for both,
> > > but only arm64 is supported ATM.
> > 
> > It can't be used for both as the semihosting calls themselves need 
> > assembly code and this is not compatible with the equivalent ARM32 
> > calls.  So I'd suggest naming this "arm64" to avoid potential confusion.
> 
> How about using an compile-time conditional to put both inline assemblies
> in there? While the driver is rather trivial to start with, I don't see
> a point in duplicating it either.

Sure.  But it can be trivially renamed at that point.

Or, even better would be to add the ARM calls right away.  And of course 
ARM in Thumb mode has yet another call convention.

The printascii and printch code in arch/arm/kernel/debug.S for
CONFIG_DEBUG_SEMIHOSTING can be copied almost as is.


Nicolas
