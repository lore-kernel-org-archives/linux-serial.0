From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH][RFC] 8250_dw: unregister dw8250_set_termios for rk3188
 chip
Date: Fri, 24 Nov 2017 00:34:59 +0100
Message-ID: <6443393.PFOXghLreO@phil>
References: <20171120144045.juwm64m2j736h5ps@home.dogben.com>
 <2890515.ZR3BzkItWh@phil> <20171123153922.GA23503@home.dogben.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20171123153922.GA23503-ZQaglsx1qnHXWvwwbwmGMg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Shuyu Wei <wsy-flSAGy4ZnMjQT0dZR+AlfA@public.gmane.org>
Cc: wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Ed Blake <ed.blake-56FIPCJpnYtBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi,

Am Donnerstag, 23. November 2017, 23:40:31 CET schrieb Shuyu Wei:
> On Thu, Nov 23, 2017 at 04:11:12PM +0100, Heiko Stuebner wrote:
> > 
> > you actually omitted the output part where sclk_uart2 is actually shown :-) .
> > 
> > On my rk3188 radxarock with a kernel build this morning from
> > the middle of this merge-window, the relevant part of the clock-tree
> > looks like the following and my serial console works like a charm:
> > 
> > xin24m                                   6            6    24000000          0 0
> > [...]
> >     pll_gpll                              1            1   594000000          0 0
> >        gpll                               5            5   594000000          0 0
> > [...]
> >          uart_src                        1            1   594000000          0 0
> >              uart3_pre                    0            0   594000000          0 0
> >                 uart3_frac                0            0    29700000          0 0
> >              uart2_pre                    1            1   594000000          0 0
> >                 uart2_frac                1            1     1843200          0 0
> >                    sclk_uart2             1            1     1843200          0 0
> >  [			^^ the important clock]
> > 
> > In your dump the sclk_uart2 clock is not muxed to the uart2_frac clock
> > but to something else but that part is missing from you dump.
> > 
> > So clk_round_rate is definitly correct in that it can reach this rate
> > using the fractional divider and also can sucessfully set this in the
> > clock framework.
> > 
> > Can you show where sclk_uart2 is for you please, as I guess your dump
> > is with the settermios patch disabled, right?
> > 
> > 
> > Thanks
> > Heiko
> 
> You are right, here is the complete clk_summary from the latest
> mainline, and my console is now filled with strange characters :-(
> 
>    clock                         enable_cnt  prepare_cnt        rate   accuracy   phase
> ----------------------------------------------------------------------------------------
>  xin24m                                  11           11    24000000          0 0
[...]
>     pll_gpll                              1            1   891000000          0 0
>        gpll                               3            3   891000000          0 0
[...]
>           uart_src                        1            1   891000000          0 0
>              uart3_pre                    0            0   891000000          0 0
>                 uart3_frac                0            0    44550000          0 0
>              uart2_pre                    1            1   891000000          0 0
>                 uart2_frac                1            1     1843200          0 0
>                    sclk_uart2             1            1     1843200          0 0

Just to make sure, I did boot-tests on a lot of different Rockchip socs
(rk3036, rk3188, rk3288, rk3328, rk3399) with the serial console using
8250_dw and working normally on all of them with the most recent
torvalds kernel (and everything I tested in the past)

The only difference I see between our two clock dumps is the higher
gpll clock on your board, but I cannot really imagine that this could be
and issue.

So I'm really puzzled by what you see on your board, but don't have
any specific idea what to test right now.


Heiko
