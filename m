From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: serial: imx: clarify rs485 support usage
Date: Thu, 28 Jun 2018 13:30:40 -0300
Message-ID: <CAOMZO5DfJZUayL_JCH1UKSXYQTraoBTK7w3YHif6aLz0nFdh3g@mail.gmail.com>
References: <e9beff38e9035c2f33d691f362e37d8e62aaa660.1530170732.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <e9beff38e9035c2f33d691f362e37d8e62aaa660.1530170732.git.baruch@tkos.co.il>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>
List-Id: linux-serial@vger.kernel.org

Hi Baruch,

On Thu, Jun 28, 2018 at 4:25 AM, Baruch Siach <baruch@tkos.co.il> wrote:
> The i.MX UART peripheral uses the RST_B signal as input, and CTS_B as
> output. This is just like the DCE role in RS-232. This is true
> regardless of the "DTE mode" setting of this peripheral.
>
> As a result, rs485 support hardware must use the CTS_B signal to control
> the RS-485 transceiver. This is in contrast to generic rs485 kernel
> code, documentation, and DT property names that consistently refer to
> the RTS as transceiver control signal.
>
> Add a note in the DT binding document about that, to reduce the
> confusion somewhat.
>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Yes, this is helpful:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
