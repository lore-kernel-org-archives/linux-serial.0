From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/4] mfd: exynos-lpass: Enable UART module support
Date: Fri, 21 Dec 2018 14:56:08 +0000
Message-ID: <20181221145608.GU13248@dell>
References: <20181221103907.GK13248@dell>
 <CGME20181221143250eucas1p120b2d4dbcb990c5893e0fa4c6a7dd861@eucas1p1.samsung.com>
 <20181221143228.934-1-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181221143228.934-1-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On Fri, 21 Dec 2018, Marek Szyprowski wrote:

> From: Beomho Seo <beomho.seo@samsung.com>
> 
> This patch enables proper interrupts routing between UART module
> in Exynos Audio SubSystem and the rest of the SoC. This routing is
> completely transparent for UART device and CPU/GIC. UART driver requests
> interrupts from the respective controller and enables/masks/handles it
> by itself via standard methods.
> 
> There are boards (for example TM2), which use UART module in Exynos Audio
> SubStem for communication with BlueTooth chip.
> 
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> [mszyprow: rephrased commit message, added UART reset]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changelog
> v2:
> - rephrased and extended commit message
> ---
>  drivers/mfd/exynos-lpass.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
