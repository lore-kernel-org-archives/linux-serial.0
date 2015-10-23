From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH] Revert "serial: amba-pl011: fix incorrect integer size in
 pl011_fifo_to_tty()"
Date: Fri, 23 Oct 2015 11:38:46 -0500
Message-ID: <562A6296.3070600@codeaurora.org>
References: <1445594400-29095-1-git-send-email-shijie.huang@arm.com>
 <20151023103056.GI4801@e103592.cambridge.arm.com>
 <562A297A.9030204@codeaurora.org>
 <20151023133403.GI4796@e103592.cambridge.arm.com> <562A544D.7080506@tabi.org>
 <20151023160246.GM4796@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151023160246.GM4796@e103592.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave P Martin <Dave.Martin@arm.com>
Cc: Huang Shijie <shijie.huang@arm.com>, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 10/23/2015 11:02 AM, Dave P Martin wrote:
> I'm pretty sure CREAD should default to enabled[1], and that usually
> software won't modify it.
>
> Assuming that this is indeed the problem, it's possible that another bug
> in the pl011 driver is wrongly clearing this flag.  Sadly I don't have
> time to look at the code again just now ...:(

Perhaps, but !CREAD is definitely broken without this patch.  So if the 
driver really is clearing CREAD somewhere else, then that's where the 
real bug is.

>
> Could be interesting to stick some BUG_ON(!CREAD) in the driver to
> try and track down where that's coming from.

CREAD is disabled by default when opening the console.  You need to 
explicitly set it in the termios structure.  I can easily believe that 
Huang's rootfs is just forgetting to set that bit because for the last 
five years, it didn't matter.

Huang,

In the beginning of pl011_set_termios() and sbsa_uart_set_termios(), 
please add this code:

	BUG_ON(!(termios->c_cflag & CREAD));		

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
