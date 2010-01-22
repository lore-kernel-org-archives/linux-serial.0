From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] serial imx.c: fix CTS trigger level lower to avoid
	lost chars
Date: Fri, 22 Jan 2010 16:57:19 +0000
Message-ID: <20100122165719.GB18461@n2100.arm.linux.org.uk>
References: <1264109163-28739-1-git-send-email-valentin.longchamp@epfl.ch> <20100121220653.GA21010@pengutronix.de> <20100121221133.GA30419@n2100.arm.linux.org.uk> <4B597A82.4020906@epfl.ch> <20100122110701.GA15699@shareable.org> <20100122113130.GB10449@n2100.arm.linux.org.uk> <20100122164713.GA21907@shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56545 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754838Ab0AVQ5k (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 22 Jan 2010 11:57:40 -0500
Content-Disposition: inline
In-Reply-To: <20100122164713.GA21907@shareable.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jamie Lokier <jamie@shareable.org>
Cc: Valentin Longchamp <valentin.longchamp@epfl.ch>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Fri, Jan 22, 2010 at 04:47:13PM +0000, Jamie Lokier wrote:
> Any tips on how to make the serial receive irq latency more reliable
> on ARM, with a boringly generic serial driver?

What you could do is arrange for a backtrace to be printed when
you read an overrun condition from the UART - if interrupts were
disabled by something taking a long time, and then enabled, you
should see the point where they were just enabled in the backtrace.

It could be down to another IRQF_DISABLED interrupt - in which case
you won't see it in the backtrace.

Of course, printing a backtrace will cause subsequent overruns...
