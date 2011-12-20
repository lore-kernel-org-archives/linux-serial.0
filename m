From: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH V2] omap-serial: add RS485 mode support
Date: Wed, 21 Dec 2011 02:10:22 +0400
Message-ID: <4EF107CE.1080307@emcraft.com>
References: <1324416212-10012-1-git-send-email-yanok@emcraft.com> <20111220215333.GA6775@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20111220215333.GA6775@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, sasha_d@emcraft.com, 'Detlev Zundel' <dzu@denx.de>, Wolfgang Denk <wd@denx.de>
List-Id: linux-serial@vger.kernel.org

Hi Wolfram,

On 21.12.2011 01:53, Wolfram Sang wrote:
>> Add support for asserting RTS line while TX is in progress. OMAP
>> hardware doesn't support auto-RS485 mode so we control the line from
>> software. We use TX_EMPTY_CTL_IT bit in SCR register to generate TX
>> empty interrupt.
> 
> Sorry to bring bad news, but software RS485 is not mainlinable [1].
> You can browse linux-serial for RS485 to find more threads about it.

I see. Actually I searched the lists and seen that completely software
solution (using timers) was never merged. This is somewhere in between:
hardware can fire an interrupt exactly after both TX FIFO and shift
register are emptied so it's only the interrupt latency that affects the
timing.

Thanks for your reply anyway. We will have to maintain this patch in our
tree then.

Regards, Ilya.
