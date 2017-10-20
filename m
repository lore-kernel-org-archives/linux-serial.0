From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH v2 3/3] tty: serial: imx: remove imx_disable_rx_int
Date: Fri, 20 Oct 2017 14:25:11 -0700
Message-ID: <15ff545c-5aaf-4f03-3672-2c1702f78316@boundarydevices.com>
References: <20171020212021.13065-1-troy.kisky@boundarydevices.com>
 <20171020212021.13065-3-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171020212021.13065-3-troy.kisky@boundarydevices.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, nandor.han@ge.com
Cc: fabio.estevam@nxp.com, l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, u.kleine-koenig@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On 10/20/2017 2:20 PM, Troy Kisky wrote:
> Since imx_disable_rx_int is only called by imx_startup,
> let's integrate it into that function.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> ---
> v2: new patch
> ---
>  drivers/tty/serial/imx.c | 39 ++++++++++-----------------------------
>  1 file changed, 10 insertions(+), 29 deletions(-)

While testing this series, I noticed that sending a break on the serial port caused

imx-uart 2020000.serial: DMA transaction error.

Is that normal ?
