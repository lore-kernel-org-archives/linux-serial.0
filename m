From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V1] serial: imx: revert setup DCEDTE early and ensure DCD
 and RI irqs to be off
Date: Tue, 23 May 2017 16:09:41 +0200
Message-ID: <20170523140941.l6cjvfdsvsg76cbx@pengutronix.de>
References: <20170523123145.E268B3FAD4@swsrvapps-01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170523123145.E268B3FAD4@swsrvapps-01.diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-SERIAL <linux-serial@vger.kernel.org>, Lucas Stach <l.stach@pengutronix.de>, Support Opensource <support.opensource@diasemi.com>, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On Tue, May 23, 2017 at 01:17:26PM +0100, Steve Twiss wrote:
> From: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> Revert the commit e61c38d85b7392e ("serial: imx: setup DCEDTE early and
> ensure DCD and RI irqs to be off")
> 
> The patch submitted to setup DCEDTE early and ensure DCD and RI irqs to
> be off, causes a serial console display problem the i.MX6Q SABRESD board.
> The console becomes unreadable and unwritable.
> 
> Tested-by: Steve Twiss <stwiss.opensource@diasemi.com>
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

You're not the first to report this issue but you still have the chance
to be the first to test a suggested patch for it.

See

	http://marc.info/?l=linux-serial&m=149434029912947&w=2

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
