From: Shuyu Wei <wsy-flSAGy4ZnMjQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH][RFC] 8250_dw: unregister dw8250_set_termios for rk3188
 chip
Date: Tue, 21 Nov 2017 00:14:55 +0800
Message-ID: <20171120161455.orvooleyzfsslon3@home.dogben.com>
References: <20171120144045.juwm64m2j736h5ps@home.dogben.com>
 <d8ba3c8a-a406-cbee-d71b-d6784d6ebacc@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d8ba3c8a-a406-cbee-d71b-d6784d6ebacc-56FIPCJpnYtBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ed Blake <ed.blake-56FIPCJpnYtBDgjK7y7TUQ@public.gmane.org>
Cc: wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 20, 2017 at 03:44:13PM +0000, Ed Blake wrote:
> On 20/11/17 14:40, Shuyu Wei wrote:
> > dw8250_set_termios is causing problems for rk3188 on my radxa board.
> > It's using a fixed clock at 24M, not baud*16 in dw8250_set_termios.
> > I'm not sure if other rk3xxx chips are facing the same problem.
> >
> > Signed-off-by Wei Shuyu <wsy-flSAGy4ZnMjQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/tty/serial/8250/8250_dw.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> > index 5bb0c42c88dd..e760a5c1f3f6 100644
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
> > @@ -340,6 +340,9 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
> >  			data->skip_autocfg = true;
> >  		}
> >  #endif
> > +		if (of_device_is_compatible(np, "rockchip,rk3188-uart")) {
> > +			p->set_termios = NULL;
> > +		}
> >  		if (of_device_is_big_endian(p->dev->of_node)) {
> >  			p->iotype = UPIO_MEM32BE;
> >  			p->serial_in = dw8250_serial_in32be;
> 
> Can you provide more details on the problem you're trying to solve?

Hi Ed,

Current dw8250_set_termios() trys to set p->uartclk and d->clk to
baud*16, which is incorrect for rk3188. It should be a fixed 24000000.
The incorrect value will result in a wrong baud rate, generating bad
bytes on my serial console. Heikki Krogerus had worried about this,
see https://patchwork.kernel.org/patch/9306275/.
