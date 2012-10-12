From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 8250_early for big-endian
Date: Fri, 12 Oct 2012 17:51:50 +0100
Message-ID: <20121012175150.4b081343@pyramind.ukuu.org.uk>
References: <264C179F799EF24AB26D5319053335E80CC30499A2@ezexch.ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:37287 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759814Ab2JLQqu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 12 Oct 2012 12:46:50 -0400
In-Reply-To: <264C179F799EF24AB26D5319053335E80CC30499A2@ezexch.ezchip.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

> I am using 8250 console and wish to use the 8250_early as well.
> 
> I encounter endianess problem while using this driver for mmio32.
> 
> The problem is since my serial peripheral like my cpu is in BIG endian.
> 
> Driver through serial_in/serial_out uses readl/writel from asm-generic/io.h.
> 
> These macros assume peripheral is always in LITTLE endian.
> 
> Therefore all data needs a swab. 
> 
> In 8250 driver I can register replacement for default serial_in/serial_out and workaround the problem.
> In 8250_early I had no choice but to change code with additional swab to workaround the problem.
> 
> I am looking for proper solution so it can be added to upstream.
> I got several ideas if interest arise.

Given they are all byte registers so how can they need swapping ? They are
merely 3 further bytes offset.

Alan
