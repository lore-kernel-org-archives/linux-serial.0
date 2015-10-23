From: Dave P Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH] Revert "serial: amba-pl011: fix incorrect integer size
 in pl011_fifo_to_tty()"
Date: Fri, 23 Oct 2015 14:34:04 +0100
Message-ID: <20151023133403.GI4796@e103592.cambridge.arm.com>
References: <1445594400-29095-1-git-send-email-shijie.huang@arm.com>
 <20151023103056.GI4801@e103592.cambridge.arm.com>
 <562A297A.9030204@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <562A297A.9030204@codeaurora.org>
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
To: Timur Tabi <timur@codeaurora.org>
Cc: Huang Shijie <shijie.huang@arm.com>, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Fri, Oct 23, 2015 at 07:35:06AM -0500, Timur Tabi wrote:
> Dave Martin wrote:
> >>>The commit 71a5cd8a4 makes the console hang for some times.
> >>>This reverts commit 71a5cd8a4a2602a6e9010b557a23af0a54df87b6.
> >What hangs?  Input?  Output?  Both?
> >
> >Is CREAD set on the terminal?  If only input hangs, it's possible CREAD
> >is not set and we were previously getting away with it, though I can't
> >easily see why it should be unset...
> 
> Dave is right, the revert doesn't make any sense. Huang has a
> user-space bug.  Please check to see if CREAD is set.  I'm pretty
> sure it isn't.

Well, I'm not saying there's definitely no kernel bug, but I can't see
how the patch should cause it.  It may be triggering a latent bug
somewhere else in the driver than hasn't been biting us before, however.

!CREAD is the most obvious cause, so that should definitely be ruled
out first.  If CREAD is clear, we need to figure out why...

Cheers
---Dave
