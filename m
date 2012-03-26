From: Rajanikanth H V <rajanikanth.hv@stericsson.com>
Subject: RE: [PATCH] serial: pl011: implement workaround for CTS clear	event
 issue
Date: Mon, 26 Mar 2012 11:07:39 +0200
Message-ID: <2B1D156D95AE9B4EAD379CB9E465FE73255E4BB903@EXDCVYMBSTM005.EQ1STM.local>
References: <1332748868-10172-1-git-send-email-linus.walleij@stericsson.com>
 <20120326081756.GI5611@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:52092 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754772Ab2CZJJI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 26 Mar 2012 05:09:08 -0400
In-Reply-To: <20120326081756.GI5611@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Linus WALLEIJ <linus.walleij@stericsson.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Christophe ARNAL <christophe.arnal@stericsson.com>, Guillaume JAUNET <guillaume.jaunet@stericsson.com>, Matthias LOCHER <matthias.locher@stericsson.com>, Chanho Min <chanho0207@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>

Russell,

As per my understanding, pass counter helps to identify/break the 
Deadlock situation and triggers bottom half handler in which
Uart controller will be forced to reset (save and restore of UART register happens).

It has been found from hardware analysis that race condition(explained in my commit message)
was causing the situation to persist (i.e. CTS ack was not happening in spite of W1C),
hence, assuming UART controller in deadlock state is wrong.


Thanks,
Rajanikanth

-----Original Message-----
From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
Sent: Monday, March 26, 2012 1:48 PM
To: Linus WALLEIJ
Cc: Greg Kroah-Hartman; linux-serial@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Christophe ARNAL; Guillaume JAUNET; Matthias LOCHER; Chanho Min; Linus Walleij; Rajanikanth H V
Subject: Re: [PATCH] serial: pl011: implement workaround for CTS clear event issue

On Mon, Mar 26, 2012 at 10:01:08AM +0200, Linus Walleij wrote:
> -	unsigned int status, pass_counter = AMBA_ISR_PASS_LIMIT;
> +	unsigned int status;

Why are you removing the pass counter and associated code, which was
there before your work-around patch was applied?
