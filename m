From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] tty: serial, return values platform_get_irq, part II.
Date: Fri, 29 Apr 2016 11:24:44 +0200
Message-ID: <5723285C.3080008@suse.cz>
References: <1461921721-30169-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461921721-30169-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <kernel@pengutronix.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Peter Korsgaard <jacmet@sunsite.dk>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, linux-arm-kernel@lists.infradead.org, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-serial@vger.kernel.org

On 04/29/2016, 11:22 AM, Jiri Slaby wrote:
> When commit "TTY: serial, handle platform_get_irq retval properly" was
> merged, it was pointed out, that platform_get_irq is more peculiar
> than it seems.
> 
> platform_get_irq can actually return zero for some platforms. So
> reverts parts of the aforementioned commits which did the worng thing
> on those platforms.

Given I double checked the code, I should do so for the commit message
too. Please scratch this one due to the commit message.

thanks,
-- 
js
suse labs
