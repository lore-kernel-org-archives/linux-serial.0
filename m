From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH V2] tty: serial: imx: allow breaks to be received when
 using dma
Date: Fri, 9 Feb 2018 23:09:36 -0200
Message-ID: <CAOMZO5AcM7wakoLLKvYb93LJ2iDgnvq66agd9ARwA4QMqmeJbA@mail.gmail.com>
References: <20180209212240.14095-1-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180209212240.14095-1-troy.kisky@boundarydevices.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mort@bork.org, linux-serial@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

Hi Troy,

On Fri, Feb 9, 2018 at 7:22 PM, Troy Kisky
<troy.kisky@boundarydevices.com> wrote:
> This allows me to login after sending a break when service
> serial-getty@ttymxc0.service is running

Please improve the commit log by explaining why this patch fixes the issue.

Thanks
