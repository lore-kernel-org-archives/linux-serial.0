From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH][RFC] 8250_dw: unregister dw8250_set_termios for rk3188
 chip
Date: Thu, 23 Nov 2017 16:11:12 +0100
Message-ID: <2890515.ZR3BzkItWh@phil>
References: <20171120144045.juwm64m2j736h5ps@home.dogben.com>
 <f834a0a4-3d1e-6f97-6ff3-1d52d609f510@sondrel.com>
 <20171123145622.GA1272@home.dogben.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20171123145622.GA1272-ZQaglsx1qnHXWvwwbwmGMg@public.gmane.org>
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

Am Donnerstag, 23. November 2017, 22:56:22 CET schrieb Shuyu Wei:
> On Tue, Nov 21, 2017 at 05:33:47PM +0000, Ed Blake wrote:
> > On 21/11/17 17:17, Shuyu Wei wrote:
> > >
> > >> What baud rate is being set, and what rate does clk_round_rate() return
> > >> in dw8250_set_termios()?
> > > I'm using baud 115200, clk_round_rate() returns 1843200.
> > 
> > So dw8250_set_termios() requests a rate of 1843200 (baud * 16) from
> > clk_round_rate(), which returns the exact frequency requested.  If it
> > really is capable of being set to that frequency, I can't see why this
> > wouldn't work.  Or clk_round_rate() is incorrectly reporting that it's
> > capable of that rate, in which case the clock driver needs fixing.
> > 
> > Do you have any way of verifying the actual clock rate going into the UART?
> 
> Sorry, I know little about the clock system, and no equipment to do that,
> maybe Heiko knows.
> 
> The /sys/kernel/debug/clk/clk_summary is attached below, might be helpful.
> 
> 
>    clock                         enable_cnt  prepare_cnt        rate   accuracy   phase
> ----------------------------------------------------------------------------------------
>  xin32k                                   0            0       32768          0 0  
>  xin24m                                  12           12    24000000          0 0  
>     timer6                                1            1    24000000          0 0  
>     timer5                                0            0    24000000          0 0  
>     timer4                                0            0    24000000          0 0  
>     timer3                                1            1    24000000          0 0  
>     timer2                                0            0    24000000          0 0  
>     pll_gpll                              1            1   891000000          0 0  
>        gpll                               2            2   891000000          0 0  
>           i2s_src                         0            0   891000000          0 0  
>              i2s0_pre                     0            0   891000000          0 0  
>                 i2s0_frac                 0            0    44550000          0 0  
>              spdif_pre                    0            0   891000000          0 0  
>           aclk_cpu_pre                    3            3   297000000          0 0  
>              hclk_cpu_pre                 2            2   148500000          0 0  
>                 hclk_ahb2apb              2            2    74250000          0 0  
>                    pclk_uart1             1            1    74250000          0 0  
>                    pclk_uart0             1            1    74250000          0 0  
>                 hclk_cpu                  2            2   148500000          0 0  
>                    hclk_imem1             0            0   148500000          0 0  
>                    hclk_imem0             0            0   148500000          0 0  
>                    hclk_rga               0            0   148500000          0 0  
>                    hclk_ipp               0            0   148500000          0 0  
>                    hclk_cif0              0            0   148500000          0 0  
>                    hclk_lcdc1             0            0   148500000          0 0  
>                    hclk_lcdc0             0            0   148500000          0 0  
>                    hclk_vio_bus           0            0   148500000          0 0  
>                    hclk_cpubus            1            1   148500000          0 0  
>                    hclk_spdif             1            2   148500000          0 0  
>                    hclk_i2s0              0            0   148500000          0 0  
>                    hclk_rom               0            0   148500000          0 0  
>              pclk_cpu_pre                 1            1    37125000          0 0  
>                 atclk_cpu                 0            0    37125000          0 0  
>                    trace                  0            0    37125000          0 0  
>                    atclk                  0            0    37125000          0 0  
>                 pclk_cpu                  4            8    37125000          0 0  
>                    pclk_timer3            1            1    37125000          0 0  
>                    pclk_pmu               0            0    37125000          0 0  
>                    pclk_grf               0            0    37125000          0 0  
>                    pclk_dbg               0            0    37125000          0 0  
>                    pclk_ddrpubl           0            0    37125000          0 0  
>                    pclk_ddrupctl           0            0    37125000          0 0  
>                    pclk_tzpc              0            0    37125000          0 0  
>                    pclk_efuse             0            0    37125000          0 0  
>                    pclk_gpio2             0            1    37125000          0 0  
>                    pclk_gpio1             0            1    37125000          0 0  
>                    pclk_gpio0             2            1    37125000          0 0  
>                    pclk_i2c1              0            2    37125000          0 0  
>                    pclk_i2c0              0            0    37125000          0 0  
>                    pclk_timer0            1            1    37125000          0 0  
>                    pclk_pwm01             0            2    37125000          0 0  
>              aclk_cpu                     2            2   297000000          0 0  
>                 aclk_strc_sys             0            0   297000000          0 0  
>                 aclk_intmem               0            0   297000000          0 0  
>                 aclk_dma1                 1            1   297000000          0 0  
>           gpll_armclk                     1            1   891000000          0 0  
>           gpll_ddr                        0            0   891000000          0 0  
>           hsadc_src                       0            0    89100000          0 0  
>              sclk_hsadc_out               0            0    89100000          0 0  
>                 sclk_hsadc                0            0    89100000          0 0  
>              hsadc_frac                   0            0     4455000          0 0  
>           uart_src                        0            0   891000000          0 0  
>              uart3_pre                    0            0   891000000          0 0  
>                 uart3_frac                0            0    44550000          0 0  
>              uart2_pre                    0            0   891000000          0 0  
>                 uart2_frac                0            0    44550000          0 0  
>              uart1_pre                    0            0   891000000          0 0  
>                 uart1_frac                0            0    44550000          0 0  
>              uart0_pre                    0            0   891000000          0 0  
>                 uart0_frac                0            0    44550000          0 0  
> ..............
> more output is omitted.

you actually omitted the output part where sclk_uart2 is actually shown :-) .

On my rk3188 radxarock with a kernel build this morning from
the middle of this merge-window, the relevant part of the clock-tree
looks like the following and my serial console works like a charm:

xin24m                                   6            6    24000000          0 0
[...]
    pll_gpll                              1            1   594000000          0 0
       gpll                               5            5   594000000          0 0
[...]
         uart_src                        1            1   594000000          0 0
             uart3_pre                    0            0   594000000          0 0
                uart3_frac                0            0    29700000          0 0
             uart2_pre                    1            1   594000000          0 0
                uart2_frac                1            1     1843200          0 0
                   sclk_uart2             1            1     1843200          0 0
 [			^^ the important clock]

In your dump the sclk_uart2 clock is not muxed to the uart2_frac clock
but to something else but that part is missing from you dump.

So clk_round_rate is definitly correct in that it can reach this rate
using the fractional divider and also can sucessfully set this in the
clock framework.

Can you show where sclk_uart2 is for you please, as I guess your dump
is with the settermios patch disabled, right?


Thanks
Heiko
