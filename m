From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 3/3] tty: serial: imx: remove imx_disable_rx_int
Date: Sat, 4 Nov 2017 12:39:57 +0100
Message-ID: <20171104113957.GA10523@kroah.com>
References: <20171020212021.13065-1-troy.kisky@boundarydevices.com>
 <20171020212021.13065-3-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171020212021.13065-3-troy.kisky@boundarydevices.com>
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
Cc: nandor.han@ge.com, linux-serial@vger.kernel.org, u.kleine-koenig@pengutronix.de, fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On Fri, Oct 20, 2017 at 02:20:21PM -0700, Troy Kisky wrote:
> Since imx_disable_rx_int is only called by imx_startup,
> let's integrate it into that function.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> ---
> v2: new patch
> ---
>  drivers/tty/serial/imx.c | 39 ++++++++++-----------------------------
>  1 file changed, 10 insertions(+), 29 deletions(-)

Does not apply :(
