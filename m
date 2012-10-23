From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: 8250 check iir rdi in interrupt
Date: Tue, 23 Oct 2012 11:01:33 +0100
Message-ID: <20121023110133.62bed522@pyramind.ukuu.org.uk>
References: <alpine.LFD.2.02.1210221633450.28146@nightowl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:49934 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932503Ab2JWJ4a (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Oct 2012 05:56:30 -0400
In-Reply-To: <alpine.LFD.2.02.1210221633450.28146@nightowl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Min Zhang <mzhang@mvista.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

> Added module parameter skip_rdi_check to opt out this workaround.

NAK. Anything like this should be runtime.

> Tested on Radisys ATCA 46XX which uses FPGA 16550-compatible and
> other generic 16550 UART. It takes from an hour to days to reproduce by
> pumping inputs to serial console continously using TeraTerm script:

You turn this on by default but it's a nasty IRQ latency penalty
on a lot of x86 platforms with the uarts on the lpc bus.

What I am not clear on from this is

- do you see it on both the ports (the bug that is)
- if you do see it on both are you sure its not in reality a symptom of
  some other console/irq handling race ?

Alan
