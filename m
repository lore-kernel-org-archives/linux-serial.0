From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v1] tty: serial: imx: enable IDDMAEN for the last tail
 data
Date: Thu, 20 Sep 2018 11:39:36 +0200
Message-ID: <1537436376.3362.159.camel@pengutronix.de>
References: <1537457160-10792-1-git-send-email-yibin.gong@nxp.com>
         <20180920075513.6jqfbrrjax3sp4cn@pengutronix.de>
         <VI1PR04MB45432291716B64380C1B90DD89130@VI1PR04MB4543.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <VI1PR04MB45432291716B64380C1B90DD89130@VI1PR04MB4543.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Gong <yibin.gong@nxp.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Andy Duan <fugang.duan@nxp.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "jslaby@suse.com" <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Am Donnerstag, den 20.09.2018, 08:39 +0000 schrieb Robin Gong:
> > -----Original Message-----
> > From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > Sent: 2018年9月20日 15:55
> > To: Robin Gong <yibin.gong@nxp.com>
> > Cc: jslaby@suse.com; Andy Duan <fugang.duan@nxp.com>;
> > linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org; dl-
> > linux-imx
> > <linux-imx@nxp.com>; kernel@pengutronix.de
> > Subject: Re: [PATCH v1] tty: serial: imx: enable IDDMAEN for the
> > last tail data
> > 
> > Hello,
> > 
> > On Thu, Sep 20, 2018 at 11:26:00PM +0800, Robin Gong wrote:
> > > enable IDDMAEN in UCR4 to let sdma script has the chance to
> > > detect the
> > > idle status and transfer the last tail data with the interrupt
> > > notifying uart driver.Otherwise, the last dma done interrupt of
> > > the
> > > tail data in rxfifo whose size is less than watermark may never
> > > be
> > > received by uart driver.
> > 
> > Is this a theoretic issue? Or does it fix a real problem?
> > 
> > If the former I'd say UCR1_ATDMAEN being set should prevent this
> > stall.
> 
> It's a real fix, you will see 'timeout We read 0 byte' with the
> attached stress test
> running on i.mx7d or i.mx6 if no this patch applied. 
> ' while [ 1 ]; do /unit_tests/UART/mxc_uart_stress_test.out
> /dev/ttymxc5 2000000 D L 100 100 L; done &'
> Please make sure dma enabled on ttymxcX for your test, and sdma
> firmware setup in your rootfs 
> /lib/firmware/imx/sdma/sdma-imx6q.bin or /lib/firmware/imx/sdma/sdma-
> imx7d.bin.
> You can get sdma firmware from below:
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-
> firmware.git/tree/imx/sdma

Please see commit 905c0decad28402aa166975023fb88c8f62f93c8 on why using
the idle detect together with with SDMA is wrong. We don't want to re-
introduce the broken behavior.

Regards,
Lucas
