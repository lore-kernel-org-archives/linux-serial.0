From: Paul Fulghum <paulkf@microgate.com>
Subject: Re: Bug?: 2.6.9-bk3
Date: Tue, 19 Oct 2004 21:46:06 -0500
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <1098240366.5963.21.camel@at2.pipehead.org>
References: <4175C484.5070009@tuxq.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:11106 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S270405AbUJTCqP
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Oct 2004 22:46:15 -0400
In-Reply-To: <4175C484.5070009@tuxq.com>
List-Id: linux-serial@vger.kernel.org
To: "Steven E. Woolard" <tuxq@tuxq.com>
Cc: linux-serial@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, rmk@flint.arm.linux.org.uk

On Tue, 2004-10-19 at 20:51, Steven E. Woolard wrote:
> I ran into this problem when trying to compile 2.6.9-bk3 (since it came 
> out less than 24 hours after 2.6.9 ... bad omen eh?)
> I've attached my .config used just incase it helps. (New to bug 
> reporting...)
> ...
>    CC      drivers/serial/8250.o
> drivers/serial/8250.c:185: error: `UART_FCR_R_TRIG_10' undeclared here 
> (not in a function)

Russell's patch introduces the use of
the UART_FCR_x_TRIG_xx macros, but not
the definition.

-- 
Paul Fulghum
paulkf@microgate.com


