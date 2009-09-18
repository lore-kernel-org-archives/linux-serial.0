From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH][uart] fit blackfin uart over sport driver into common
	uart inftrastructure (v3)
Date: Fri, 18 Sep 2009 02:31:28 -0400
Message-ID: <8bd0f97a0909172331l8188d27t32899adc784cb503@mail.gmail.com>
References: <1253255241.16340.4.camel@eight.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yx0-f199.google.com ([209.85.210.199]:37068 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbZIRGbo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Sep 2009 02:31:44 -0400
In-Reply-To: <1253255241.16340.4.camel@eight.analog.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: sonic zhang <sonic.adi@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Serial <linux-serial@vger.kernel.org>

On Fri, Sep 18, 2009 at 02:27, sonic zhang wrote:

btw, "v3" and such in the subject should be inside of the [PATCH ...]
so that git will trim it automatically

> 1. Disable local interrupts in 32-bit reading from SPORT RX MMR to walk
> around the RX underflow hardware issue when this reading is interrupted
> by the other IRQ.

i dont think this change should be squashed.  it's unrelated to the
larger issue you're tackling.
http://git.kernel.org/?p=linux/kernel/git/vapier/blackfin.git;a=commitdiff;h=3393f5776d247fbd241c7fe52e2e420a64e36fa3
-mike
