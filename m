From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] tty/serial/pl011: don't print error msg if
	dmaengine_pause is not supported
Date: Mon, 18 Apr 2011 16:13:40 +0100
Message-ID: <20110418151340.GB25671@n2100.arm.linux.org.uk>
References: <98422bc7c3ebb4bf6a4ab26179b3f3b7d1a5b5ca.1303125086.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57748 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab1DRPOH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Apr 2011 11:14:07 -0400
Content-Disposition: inline
In-Reply-To: <98422bc7c3ebb4bf6a4ab26179b3f3b7d1a5b5ca.1303125086.git.viresh.kumar@st.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: linux-arm-kernel@lists.infradead.org, linus.walleij@stericsson.com, armando.visconti@st.com, shiraz.hashim@st.com, amit.goel@st.com, viresh.linux@gmail.com, linux-serial@vger.kernel.org

On Mon, Apr 18, 2011 at 04:52:00PM +0530, Viresh Kumar wrote:
> Few dma controller doesn't support dmaengine_pause() and return -ENXIO if
> dmaengine_pause() is called for them. Error messages such as "unable to pause
> DMA transfer" shouldn't be printed for them.

It is _required_ to pause the DMA engine at this point, as we need to
read characters via PIO.  Leaving the DMA engine active at this point
invites it to transfer additional characters beneath us, before we've
had time to properly update the DMA engine for the characters received.

So, dmaengine_pause() is a requirement for PL011.
