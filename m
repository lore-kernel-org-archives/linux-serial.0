From: Philippe =?ISO-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Subject: Re: [PATCH 1/2] serial/imx: add DMA support
Date: Wed, 16 May 2012 11:37:07 +0200
Message-ID: <4474267.dxHCC3PlP5@laptop>
References: <1335436632-29499-1-git-send-email-b32955@freescale.com>
 <20120426120043.GH17184@pengutronix.de> <4F9A3831.1020203@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4F9A3831.1020203@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: B20596@freescale.com, B20223@freescale.com, gregkh@linuxfoundation.org, Sascha Hauer <s.hauer@pengutronix.de>, Huang Shijie <b32955@freescale.com>, linux-serial@vger.kernel.org, shawn.guo@linaro.org, r58066@freescale.com, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org

Le vendredi 27 avril 2012 14:09:53 Huang Shijie a =E9crit :
> Hi,
> =

> >> +/* see the "i.MX61 SDMA Scripts User Manual.doc" for the parameters */
> > =

> > I can't see how the manual helps here.
> =

> sorry, the comment is in the wrong place. it should placed at
> configuring the `slave_config`.
> =

> > Please test this patch at least on one more SoC. There should be nothing
> > i.MX6 specific in here, the fact that the i.MX6 is mentioned several
> > times in the comments make me suspicious.
> =

> There are bugs in the UART DMA code in the firmware before the imx6q.
> So we can not test the UART DMA except the imx6q arm2 board.

Does this mean that there is no hope for a working uart dma on imx31 ? =


Thanks,

Philippe
