From: Dave P Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH] Revert "serial: amba-pl011: fix incorrect integer size
 in pl011_fifo_to_tty()"
Date: Fri, 23 Oct 2015 17:02:46 +0100
Message-ID: <20151023160246.GM4796@e103592.cambridge.arm.com>
References: <1445594400-29095-1-git-send-email-shijie.huang@arm.com>
 <20151023103056.GI4801@e103592.cambridge.arm.com>
 <562A297A.9030204@codeaurora.org>
 <20151023133403.GI4796@e103592.cambridge.arm.com>
 <562A544D.7080506@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <562A544D.7080506@tabi.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@tabi.org>
Cc: Huang Shijie <shijie.huang@arm.com>, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Fri, Oct 23, 2015 at 10:37:49AM -0500, Timur Tabi wrote:
> On 10/23/2015 08:34 AM, Dave P Martin wrote:
> >Well, I'm not saying there's definitely no kernel bug, but I can't see
> >how the patch should cause it.  It may be triggering a latent bug
> >somewhere else in the driver than hasn't been biting us before, however.
> 
> Fair enough.
> 
> >!CREAD is the most obvious cause, so that should definitely be ruled
> >out first.  If CREAD is clear, we need to figure out why...
> 
> So I tested this by booting to my console, and then typing in:
> 
> 	stty -cread
> 
> and when I did that, the console ignored all input.
> 
> I do admit that since !CREAD has been ignored for so many reason, it
> could be that a lot of userspaces will suddenly have broken
> consoles.

I'm pretty sure CREAD should default to enabled[1], and that usually
software won't modify it.

Assuming that this is indeed the problem, it's possible that another bug
in the pl011 driver is wrongly clearing this flag.  Sadly I don't have
time to look at the code again just now ... :(

Could be interesting to stick some BUG_ON(!CREAD) in the driver to
try and track down where that's coming from.

Cheers
---Dave

[1] See serial_core.c:uart_register_driver(),
        serial_core.c:uart_set_options().
