From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: serial: imx: clarify rs485 support usage
Date: Tue, 3 Jul 2018 17:10:40 -0600
Message-ID: <20180703231040.GA5749@rob-hp-laptop>
References: <e9beff38e9035c2f33d691f362e37d8e62aaa660.1530170732.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
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
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
List-Id: linux-serial@vger.kernel.org

On Thu, Jun 28, 2018 at 10:25:32AM +0300, Baruch Siach wrote:
> The i.MX UART peripheral uses the RST_B signal as input, and CTS_B as

s/RST_B/RTS_B/

> output. This is just like the DCE role in RS-232. This is true
> regardless of the "DTE mode" setting of this peripheral.
> =

> As a result, rs485 support hardware must use the CTS_B signal to control
> the RS-485 transceiver. This is in contrast to generic rs485 kernel
> code, documentation, and DT property names that consistently refer to
> the RTS as transceiver control signal.
> =

> Add a note in the DT binding document about that, to reduce the
> confusion somewhat.
> =

> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v2: Fix commit log typos (Lothar Wa=DFmann)
> ---
>  Documentation/devicetree/bindings/serial/fsl-imx-uart.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
