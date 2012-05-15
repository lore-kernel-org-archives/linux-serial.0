From: Kyoungil Kim <ki0351.kim@samsung.com>
Subject: RE: [PATCH] serial: samsung: Fixed wrong comparison for	baudclk_rate
Date: Tue, 15 May 2012 20:52:39 +0900
Message-ID: <000301cd3291$3a7a6940$af6f3bc0$%kim@samsung.com>
References: <000101cd3283$5f58eba0$1e0ac2e0$%kim@samsung.com>
 <20120515101541.GH10453@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:54566 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757851Ab2EOLwl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 May 2012 07:52:41 -0400
In-reply-to: <20120515101541.GH10453@n2100.arm.linux.org.uk>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Yoon' <junho78.yoon@samsung.com>, 'Alan Cox' <alan@linux.intel.com>

Russell King wrote:
> On Tue, May 15, 2012 at 07:13:28PM +0900, Kyoungil Kim wrote:
> > port->baudclk_rate should be compared to the rate of port->baudclk,
> > because port->baudclk_rate was assigned as the rate of port->baudclk previously.
> > So to check that the current baudclk rate is same as previous rate,
> > the target of comparison sholud be the rate of port->baudclk.
> >
> > Signed-off-by: Jun-Ho, Yoon <junho78.yoon@samsung.com>
> > Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
> > ---
> >  drivers/tty/serial/samsung.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> > index d8b0aee..c4867ea 100644
> > --- a/drivers/tty/serial/samsung.c
> > +++ b/drivers/tty/serial/samsung.c
> > @@ -1014,10 +1014,10 @@ static int s3c24xx_serial_cpufreq_transition(struct notifier_block *nb,
> >  	 * a disturbance in the clock-rate over the change.
> >  	 */
> >
> > -	if (IS_ERR(port->clk))
> > +	if (IS_ERR_OR_NULL(port->baudclk))
> 
> NAK.  See my previous emails on the validity of clk_get() return values.

I read your previous emails, but I don't understand.
Could you explain more details, please?

