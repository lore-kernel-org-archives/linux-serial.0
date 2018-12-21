From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/4] mfd: exynos-lpass: Enable UART module support
Date: Fri, 21 Dec 2018 11:27:15 +0100
Message-ID: <7a43948e-17b9-1fd6-6b11-400016a4a28c@samsung.com>
References: <20181214113410.22848-1-m.szyprowski@samsung.com>
        <CGME20181214113416eucas1p2002adf7b5438c525c34ff3274ceacbd1@eucas1p2.samsung.com>
        <20181214113410.22848-2-m.szyprowski@samsung.com>
        <20181221101306.GH13248@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221101306.GH13248@dell>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

Hi

On 2018-12-21 11:13, Lee Jones wrote:
> On Fri, 14 Dec 2018, Marek Szyprowski wrote:
>
>> From: Beomho Seo <beomho.seo@samsung.com>
>>
>> This patch enables support for UART module in Exynos Audio SubSystem.
>> There are boards (for example TM2), which use it for communication with
>> bluetooth chip.
> Does it though?  Or does it enable the interrupt and reset something?
> These calls would probably benefit from some documentation by way of
> comments.

It only enables routing interrupts out of LPASS HW module. This is
completely transparent for the rest of the system (UART and CPU/GIC).
UART driver will get them via standard ARM/GIC interrupt controller and
UART driver will enable/mask/handle it by itself via standard methods.

>> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
>> [mszyprow: rephrased commit message, added UART reset]
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> ---
>>  drivers/mfd/exynos-lpass.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
>> index ca829f85672f..2713de989f05 100644
>> --- a/drivers/mfd/exynos-lpass.c
>> +++ b/drivers/mfd/exynos-lpass.c
>> @@ -82,11 +82,13 @@ static void exynos_lpass_enable(struct exynos_lpass *lpass)
>>  		     LPASS_INTR_SFR | LPASS_INTR_DMA | LPASS_INTR_I2S);
>>  
>>  	regmap_write(lpass->top, SFR_LPASS_INTR_CPU_MASK,
>> -		     LPASS_INTR_SFR | LPASS_INTR_DMA | LPASS_INTR_I2S);
>> +		     LPASS_INTR_SFR | LPASS_INTR_DMA | LPASS_INTR_I2S |
>> +		     LPASS_INTR_UART);
>>  
>>  	exynos_lpass_core_sw_reset(lpass, LPASS_I2S_SW_RESET);
>>  	exynos_lpass_core_sw_reset(lpass, LPASS_DMA_SW_RESET);
>>  	exynos_lpass_core_sw_reset(lpass, LPASS_MEM_SW_RESET);
>> +	exynos_lpass_core_sw_reset(lpass, LPASS_UART_SW_RESET);
>>  }
>>  
>>  static void exynos_lpass_disable(struct exynos_lpass *lpass)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
