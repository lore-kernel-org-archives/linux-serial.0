From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] serial: imx: Enable RTSD only when needed
Date: Wed, 12 Apr 2017 10:38:27 -0300
Message-ID: <CAOMZO5Anz_C-pxPke_mqCtD_D9LBxTRWSk5fAZrr6KaMeMZGqQ@mail.gmail.com>
References: <20170412133015.23185-1-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170412133015.23185-1-romain.perier@collabora.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Romain Perier <romain.perier@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Nandor Han <nandor.han@ge.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Apr 12, 2017 at 10:30 AM, Romain Perier
<romain.perier@collabora.com> wrote:
> From: Nandor Han <nandor.han@ge.com>
>
> Currently, this IRQ is always enabled. Some devices might mux these pins
> to other I/Os, like I2C. This could lead to spurious interrupts.
>
> This commit makes this IRQ optional, by using the field have_rtscts.
>
> Signed-off-by: Nandor Han <nandor.han@ge.com>
> Signed-off-by: Romain Perier <romain.perier@collabora.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
