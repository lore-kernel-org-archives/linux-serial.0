From: christian pellegrin <chripell@fsfe.org>
Subject: Re: [PATCH v1 1/4] max3100: added raise_threaded_irq
Date: Sat, 17 Apr 2010 18:25:31 +0200
Message-ID: <g2xcabda6421004170925l8c824191t5d451434d24320ae@mail.gmail.com>
References: <cabda6421003230329w3fe596dbn8e4b37cc36118f9f@mail.gmail.com>
	 <1269340105-6503-1-git-send-email-chripell@fsfe.org>
	 <alpine.LFD.2.00.1004160110360.3625@localhost.localdomain>
	 <w2gcabda6421004160918vc5dc5ee2y14a5814b4e8573b3@mail.gmail.com>
	 <alpine.LFD.2.00.1004162143300.3625@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f225.google.com ([209.85.218.225]:39232 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab0DQQZd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 17 Apr 2010 12:25:33 -0400
In-Reply-To: <alpine.LFD.2.00.1004162143300.3625@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: feng.tang@intel.com, akpm@linux-foundation.org, greg@kroah.com, david-b@pacbell.net, grant.likely@secretlab.ca, alan@lxorguk.ukuu.org.uk, spi-devel-general@lists.sourceforge.net, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,


On Sat, Apr 17, 2010 at 12:06 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> I wonder whether we should restrict this mechanism to threaded
> handlers or just implement it in the following way:
>
.....
> This will not work out of the box when the irq is nested into some
> demultiplexing thread handler (IRQF_NESTED_THREAD).
>

OK, I see. The solution you proposed has many other uses such testing
of interrupt handlers in general. I will try to do some work along the
line you suggested next week.

Thank you!


-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
