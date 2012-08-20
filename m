From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: restart callback not supposed to sleep?
Date: Mon, 20 Aug 2012 09:57:20 +0100
Message-ID: <20120820085720.GQ18957@n2100.arm.linux.org.uk>
References: <20120820082423.GJ2232@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41077 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866Ab2HTI5f (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 20 Aug 2012 04:57:35 -0400
Content-Disposition: inline
In-Reply-To: <20120820082423.GJ2232@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

On Mon, Aug 20, 2012 at 10:24:23AM +0200, Uwe Kleine-K=F6nig wrote:
> while triggering a reboot via sysrq on an ARM machine I saw a "BUG:
> sleeping function called from invalid context" message (details below=
).
> The reason is that the sysrq handler is calling the restart hook in i=
rq
> context.

Correct - it's been the case for years that the restart hook is called
from atomic contexts (it's not only sysrq, but also softdog as well whi=
ch
does this, as well as any system panic with panic timeout/panic-on-oops
enabled.)

You need to fix your platform restart hook.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
