From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 2/3] serial: samsung: Add missing checks for
 dma_map_single failure
Date: Tue, 4 Apr 2017 11:36:21 +0200
Message-ID: <20170404093621.GA28551@kozik-book>
References: <1491200468-28463-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170403062119eucas1p1fb7d0ceba0bc104d5e78cbc3343cf9fe@eucas1p1.samsung.com>
 <1491200468-28463-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1491200468-28463-2-git-send-email-m.szyprowski@samsung.com>
Sender: stable-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Seung-Woo Kim <sw0312.kim@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Inki Dae <inki.dae@samsung.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Apr 03, 2017 at 08:21:00AM +0200, Marek Szyprowski wrote:
> This patch adds missing checks for dma_map_single() failure and proper error
> reporting. Although this issue was harmless on ARM architecture, it is always
> good to use the DMA mapping API in a proper way. This patch fixes the following
> DMA API debug warning:
> 
> WARNING: CPU: 1 PID: 3785 at lib/dma-debug.c:1171 check_unmap+0x8a0/0xf28
> dma-pl330 121a0000.pdma: DMA-API: device driver failed to check map error[device address=0x000000006e0f9000] [size=4096 bytes] [mapped as single]
> Modules linked in:
> CPU: 1 PID: 3785 Comm: (agetty) Tainted: G        W       4.11.0-rc1-00137-g07ca963-dirty #59
> Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [<c011aaa4>] (unwind_backtrace) from [<c01127c0>] (show_stack+0x20/0x24)
> [<c01127c0>] (show_stack) from [<c06ba5d8>] (dump_stack+0x84/0xa0)
> [<c06ba5d8>] (dump_stack) from [<c0139528>] (__warn+0x14c/0x180)
> [<c0139528>] (__warn) from [<c01395a4>] (warn_slowpath_fmt+0x48/0x50)
> [<c01395a4>] (warn_slowpath_fmt) from [<c072a114>] (check_unmap+0x8a0/0xf28)
> [<c072a114>] (check_unmap) from [<c072a834>] (debug_dma_unmap_page+0x98/0xc8)
> [<c072a834>] (debug_dma_unmap_page) from [<c0803874>] (s3c24xx_serial_shutdown+0x314/0x52c)
> [<c0803874>] (s3c24xx_serial_shutdown) from [<c07f5124>] (uart_port_shutdown+0x54/0x88)
> [<c07f5124>] (uart_port_shutdown) from [<c07f522c>] (uart_shutdown+0xd4/0x110)
> [<c07f522c>] (uart_shutdown) from [<c07f6a8c>] (uart_hangup+0x9c/0x208)
> [<c07f6a8c>] (uart_hangup) from [<c07c426c>] (__tty_hangup+0x49c/0x634)
> [<c07c426c>] (__tty_hangup) from [<c07c78ac>] (tty_ioctl+0xc88/0x16e4)
> [<c07c78ac>] (tty_ioctl) from [<c03b5f2c>] (do_vfs_ioctl+0xc4/0xd10)
> [<c03b5f2c>] (do_vfs_ioctl) from [<c03b6bf4>] (SyS_ioctl+0x7c/0x8c)
> [<c03b6bf4>] (SyS_ioctl) from [<c010b4a0>] (ret_fast_syscall+0x0/0x3c)
> 
> Reported-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> Fixes: 62c37eedb74c8 ("serial: samsung: add dma reqest/release functions")
> CC: stable@vger.kernel.org # v4.10+
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> This issue was there since adding DMA support, but this patch applies cleanly
> only to v4.10+ kernels due to other changes in the surrounding code.
> 
> v3:
> - moved spinlock removal to separate patch, extended commit message

Thanks for the changes, looks fine.
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
