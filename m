From: Shuyu Wei <wsy-flSAGy4ZnMjQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH][RFC] 8250_dw: unregister dw8250_set_termios for rk3188
 chip
Date: Thu, 23 Nov 2017 23:40:31 +0800
Message-ID: <20171123153922.GA23503@home.dogben.com>
References: <20171120144045.juwm64m2j736h5ps@home.dogben.com>
 <f834a0a4-3d1e-6f97-6ff3-1d52d609f510@sondrel.com>
 <20171123145622.GA1272@home.dogben.com> <2890515.ZR3BzkItWh@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2890515.ZR3BzkItWh@phil>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Ed Blake <ed.blake-56FIPCJpnYtBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Nov 23, 2017 at 04:11:12PM +0100, Heiko Stuebner wrote:
> 
> you actually omitted the output part where sclk_uart2 is actually shown :-) .
> 
> On my rk3188 radxarock with a kernel build this morning from
> the middle of this merge-window, the relevant part of the clock-tree
> looks like the following and my serial console works like a charm:
> 
> xin24m                                   6            6    24000000          0 0
> [...]
>     pll_gpll                              1            1   594000000          0 0
>        gpll                               5            5   594000000          0 0
> [...]
>          uart_src                        1            1   594000000          0 0
>              uart3_pre                    0            0   594000000          0 0
>                 uart3_frac                0            0    29700000          0 0
>              uart2_pre                    1            1   594000000          0 0
>                 uart2_frac                1            1     1843200          0 0
>                    sclk_uart2             1            1     1843200          0 0
>  [			^^ the important clock]
> 
> In your dump the sclk_uart2 clock is not muxed to the uart2_frac clock
> but to something else but that part is missing from you dump.
> 
> So clk_round_rate is definitly correct in that it can reach this rate
> using the fractional divider and also can sucessfully set this in the
> clock framework.
> 
> Can you show where sclk_uart2 is for you please, as I guess your dump
> is with the settermios patch disabled, right?
> 
> 
> Thanks
> Heiko

You are right, here is the complete clk_summary from the latest
mainline, and my console is now filled with strange characters :-(

   clock                         enable_cnt  prepare_cnt        rate   accuracy   phase
----------------------------------------------------------------------------------------
 xin32k                                   0            0       32768          0 0
 xin24m                                  11           11    24000000          0 0
    timer6                                1            1    24000000          0 0
    timer5                                0            0    24000000          0 0
    timer4                                0            0    24000000          0 0
    timer3                                1            1    24000000          0 0
    timer2                                0            0    24000000          0 0
    pll_gpll                              1            1   891000000          0 0
       gpll                               3            3   891000000          0 0
          i2s_src                         0            0   891000000          0 0
             i2s0_pre                     0            0   891000000          0 0
                i2s0_frac                 0            0    44550000          0 0
             spdif_pre                    0            0   891000000          0 0
          aclk_cpu_pre                    3            3   297000000          0 0
             hclk_cpu_pre                 2            2   148500000          0 0
                hclk_ahb2apb              2            2    74250000          0 0
                   pclk_uart1             1            1    74250000          0 0
                   pclk_uart0             1            1    74250000          0 0
                hclk_cpu                  2            2   148500000          0 0
                   hclk_imem1             0            0   148500000          0 0
                   hclk_imem0             0            0   148500000          0 0
                   hclk_rga               0            0   148500000          0 0
                   hclk_ipp               0            0   148500000          0 0
                   hclk_cif0              0            0   148500000          0 0
                   hclk_lcdc1             0            0   148500000          0 0
                   hclk_lcdc0             0            0   148500000          0 0
                   hclk_vio_bus           0            0   148500000          0 0
                   hclk_cpubus            1            1   148500000          0 0
                   hclk_spdif             1            2   148500000          0 0
                   hclk_i2s0              0            0   148500000          0 0
                   hclk_rom               0            0   148500000          0 0
             pclk_cpu_pre                 1            1    37125000          0 0
                atclk_cpu                 0            0    37125000          0 0
                   trace                  0            0    37125000          0 0
                   atclk                  0            0    37125000          0 0
                pclk_cpu                  4            8    37125000          0 0
                   pclk_timer3            1            1    37125000          0 0
                   pclk_pmu               0            0    37125000          0 0
                   pclk_grf               0            0    37125000          0 0
                   pclk_dbg               0            0    37125000          0 0
                   pclk_ddrpubl           0            0    37125000          0 0
                   pclk_ddrupctl           0            0    37125000          0 0
                   pclk_tzpc              0            0    37125000          0 0
                   pclk_efuse             0            0    37125000          0 0
                   pclk_gpio2             0            1    37125000          0 0
                   pclk_gpio1             0            1    37125000          0 0
                   pclk_gpio0             2            1    37125000          0 0
                   pclk_i2c1              0            2    37125000          0 0
                   pclk_i2c0              0            0    37125000          0 0
                   pclk_timer0            1            1    37125000          0 0
                   pclk_pwm01             0            2    37125000          0 0
             aclk_cpu                     2            2   297000000          0 0
                aclk_strc_sys             0            0   297000000          0 0
                aclk_intmem               0            0   297000000          0 0
                aclk_dma1                 1            1   297000000          0 0
          gpll_armclk                     1            1   891000000          0 0
          gpll_ddr                        0            0   891000000          0 0
          hsadc_src                       0            0    89100000          0 0
             sclk_hsadc_out               0            0    89100000          0 0
                sclk_hsadc                0            0    89100000          0 0
             hsadc_frac                   0            0     4455000          0 0
          uart_src                        1            1   891000000          0 0
             uart3_pre                    0            0   891000000          0 0
                uart3_frac                0            0    44550000          0 0
             uart2_pre                    1            1   891000000          0 0
                uart2_frac                1            1     1843200          0 0
                   sclk_uart2             1            1     1843200          0 0
             uart1_pre                    0            0   891000000          0 0
                uart1_frac                0            0    44550000          0 0
             uart0_pre                    0            0   891000000          0 0
                uart0_frac                0            0    44550000          0 0
    pll_dpll                              0            0   300000000          0 0
       dpll                               0            0   300000000          0 0
          ddrphy                          0            0   300000000          0 0
          mac_src                         0            0    50000000          0 0
             sclk_macref                  0            0    50000000          0 0
                sclk_mac_lbtest           0            0    50000000          0 0
    pll_cpll                              1            1   600000000          0 0
       cpll                               1            1   600000000          0 0
          aclk_gpu_src                    0            0   600000000          0 0
             aclk_gpu                     0            0   600000000          0 0
          dclk_lcdc1                      0            0   150000000          0 0
          dclk_lcdc0                      0            0   150000000          0 0
          aclk_peri_pre                   3            3   150000000          0 0
             aclk_peri                    2            2   150000000          0 0
                aclk_gps                  0            0   150000000          0 0
                aclk_peri_axi_matrix           0            0   150000000          0 0
                aclk_cpu_peri             0            0   150000000          0 0
                aclk_peri_niu             0            0   150000000          0 0
                aclk_smc                  0            0   150000000          0 0
                aclk_dma2                 1            1   150000000          0 0
             hclk_peri                    5            5   150000000          0 0
                hclk_hsic                 0            0   150000000          0 0
                hclk_usbotg1              1            1   150000000          0 0
                hclk_emmc                 0            0   150000000          0 0
                hclk_sdio                 0            0   150000000          0 0
                hclk_sdmmc                1            1   150000000          0 0
                hclk_pidfilter            0            0   150000000          0 0
                hclk_hsadc                0            0   150000000          0 0
                hclk_usbotg0              1            1   150000000          0 0
                hclk_usb_peri             0            0   150000000          0 0
                hclk_nandc0               0            0   150000000          0 0
                hclk_emac                 0            0   150000000          0 0
                hclk_emem_peri            0            0   150000000          0 0
                hclk_peri_ahb_arbi           0            0   150000000          0 0
                hclk_peri_axi_matrix           0            0   150000000          0 0
                sclk_emmc                 0            0    37500000          0 0
                sclk_sdio                 0            0     6250000          0 0
                sclk_sdmmc                1            1    37500000          0 0
                sclk_smc                  0            0   150000000          0 0
             pclk_peri                    4            6    75000000          0 0
                pclk_saradc               0            0    75000000          0 0
                pclk_gpio3                0            1    75000000          0 0
                pclk_i2c4                 0            0    75000000          0 0
                pclk_i2c3                 0            0    75000000          0 0
                pclk_i2c2                 0            0    75000000          0 0
                pclk_uart3                1            1    75000000          0 0
                pclk_uart2                1            1    75000000          0 0
                pclk_spi1                 0            0    75000000          0 0
                pclk_spi0                 0            0    75000000          0 0
                pclk_wdt                  1            1    75000000          0 0
                pclk_pwm23                0            4    75000000          0 0
                pclk_peri_axi_matrix           0            0    75000000          0 0
                sclk_spi1                 0            0     9375000          0 0
                sclk_spi0                 0            0    37500000          0 0
          aclk_vepu                       0            0   600000000          0 0
             hclk_vepu                    0            0   600000000          0 0
          aclk_vdpu                       0            0   600000000          0 0
             hclk_vdpu                    0            0   600000000          0 0
          aclk_lcdc0_pre                  0            0   600000000          0 0
             aclk_vio0                    0            0   600000000          0 0
                aclk_ipp                  0            0   600000000          0 0
                aclk_cif0                 0            0   600000000          0 0
                aclk_lcdc0                0            0   600000000          0 0
          aclk_lcdc1_pre                  0            0   600000000          0 0
             aclk_vio1                    0            0   600000000          0 0
                aclk_rga                  0            0   600000000          0 0
                aclk_lcdc1                0            0   600000000          0 0
          cif_src                         0            0   600000000          0 0
             cif0_pre                     0            0    60000000          0 0
                sclk_cif0                 0            0    60000000          0 0
    pll_apll                              1            1   600000000          0 0
       apll                               1            1   600000000          0 0
          armclk                          1            1   600000000          0 0
             core_peri                    1            1   150000000          0 0
             core_dbg                     0            0   600000000          0 0
             aclk_core                    0            0   300000000          0 0
             core_l2c                     0            0   600000000          0 0
    timer1                                0            0    24000000          0 0
    timer0                                0            0    24000000          0 0
    sclk_uart3                            1            1    24000000          0 0
    sclk_uart1                            1            1    24000000          0 0
    sclk_uart0                            1            1    24000000          0 0
    sclk_saradc                           0            0     1000000          0 0
    sclk_otgphy1                          1            1    24000000          0 0
       sclk_otgphy1_480m                  1            1   480000000          0 0
    sclk_otgphy0                          1            1    24000000          0 0
       sclk_otgphy0_480m                  1            1   480000000          0 0
          sclk_hsicphy_480m               0            0   480000000          0 0
             sclk_hsicphy_12m             0            0    12000000          0 0
    xin12m                                1            1    12000000          0 0
       sclk_i2s0                          0            0    12000000          0 0
       sclk_spdif                         1            1    12000000          0 0
 jtag                                     0            0           0          0 0
 spdif_frac                               0            0           0          0 0
 pclkin_cif0                              0            0           0          0 0
    pclk_cif0                             0            0           0          0 0
