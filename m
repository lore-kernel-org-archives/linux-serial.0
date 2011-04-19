From: viresh kumar <viresh.kumar@st.com>
Subject: Re: [PATCH] tty/serial/pl011: don't print error msg if	dmaengine_pause
 is not supported
Date: Tue, 19 Apr 2011 11:37:33 +0530
Message-ID: <4DAD26A5.6080907@st.com>
References: <98422bc7c3ebb4bf6a4ab26179b3f3b7d1a5b5ca.1303125086.git.viresh.kumar@st.com> <20110418151340.GB25671@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:58415 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751943Ab1DSGIL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Apr 2011 02:08:11 -0400
In-Reply-To: <20110418151340.GB25671@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus WALLEIJ <linus.walleij@stericsson.com>, Armando VISCONTI <armando.visconti@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>, amitgoel <amit.goel@st.com>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On 04/18/2011 08:43 PM, Russell King - ARM Linux wrote:
> On Mon, Apr 18, 2011 at 04:52:00PM +0530, Viresh Kumar wrote:
>> Few dma controller doesn't support dmaengine_pause() and return -ENXIO if
>> dmaengine_pause() is called for them. Error messages such as "unable to pause
>> DMA transfer" shouldn't be printed for them.
> 
> It is _required_ to pause the DMA engine at this point, as we need to
> read characters via PIO.  Leaving the DMA engine active at this point
> invites it to transfer additional characters beneath us, before we've
> had time to properly update the DMA engine for the characters received.
> 
> So, dmaengine_pause() is a requirement for PL011.
> .
> 

Ok.
