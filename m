From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial: imx: Fix DCD reading
Date: Mon, 26 Sep 2016 16:25:06 +0200
Message-ID: <20160926142506.ix53ekhykp2svodu@pengutronix.de>
References: <20160926135531.31888-1-s.hauer@pengutronix.de>
 <20160926140938.ikjatvprk3t4lsed@pengutronix.de>
 <CAOMZO5Aw8pkt_tnM=M0SewN-Xjqq84E-mef-ewGs8aTv0xcHjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5Aw8pkt_tnM=M0SewN-Xjqq84E-mef-ewGs8aTv0xcHjQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hello Fabio,

On Mon, Sep 26, 2016 at 11:13:37AM -0300, Fabio Estevam wrote:
> On Mon, Sep 26, 2016 at 11:09 AM, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Mon, Sep 26, 2016 at 03:55:31PM +0200, Sascha Hauer wrote:
> >> The USR2_DCDIN bit is tested for in register usr1. As the name
> >> suggests the usr2 register should be used instead. This fixes
> >> reading the Carrier detect status.
> >>
> >> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Fixes: 90ebc4838666 ("serial: imx: repair and complete handshaking")
> > Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Great, so it affects 4.5+ kernels and should probably have:
> 
> Cc: <stable@vger.kernel.org> # 4.5+

This is usually not necessary if there is a Fixes: line.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
