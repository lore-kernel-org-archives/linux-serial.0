From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 4/4] arm64: dts: exynos: Add Bluetooth chip to TM2(e)
 boards
Date: Mon, 17 Dec 2018 22:23:19 +0100
Message-ID: <20181217212319.GA24130@kozik-lap>
References: <20181214113410.22848-1-m.szyprowski@samsung.com>
 <CGME20181214113419eucas1p2473172a49bf798ddd95265fa31125d96@eucas1p2.samsung.com>
 <20181214113410.22848-5-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181214113410.22848-5-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Lee Jones <lee.jones@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Dec 14, 2018 at 12:34:10PM +0100, Marek Szyprowski wrote:
> TM2(e) boards have a Broadcom Bluetooth chip connected to 3rd UART port.
> Add a device tree node describing it and its resources (control GPIO lines
> and clock).
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 14 ++++++++++++++

Thanks, applied.

Best regards,
Krzysztof
