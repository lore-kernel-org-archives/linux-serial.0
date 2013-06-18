From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: Re: [PATCH v4 04/10] serial: samsung: select Exynos specific driver
 data if ARCH_EXYNOS is defined
Date: Tue, 18 Jun 2013 15:44:14 +0530
Message-ID: <CANuQgHGhmq+jJV_2ciPAHztnEwLqvD9V_80KVMPy5t6XPw-rZA@mail.gmail.com>
References: <1371536962-13322-1-git-send-email-chander.kashyap@linaro.org>
	<1371536962-13322-5-git-send-email-chander.kashyap@linaro.org>
	<CAKrE-KcvV5dQz0vUb-1y1msoron2Z=RjSnH1uxy8rzMtn8iChA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAKrE-KcvV5dQz0vUb-1y1msoron2Z=RjSnH1uxy8rzMtn8iChA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Girish KS <girishks2000@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "t.figa@samsung.com" <t.figa@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>
List-Id: linux-serial@vger.kernel.org

On 18 June 2013 12:20, Girish KS <girishks2000@gmail.com> wrote:
> On Tue, Jun 18, 2013 at 11:59 AM, Chander Kashyap
> <chander.kashyap@linaro.org> wrote:
>> All Exynos4/5 SoCs share a common driver data in the samsung serial
>> driver. Hence, let the driver data inclusion be based on ARCH_EXYNOS
>> instead of SOC specific definition.
>>
>> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
>> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
>> ---
>>  drivers/tty/serial/samsung.c |    4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
>> index 2552c7f..e70d19a 100644
>> --- a/drivers/tty/serial/samsung.c
>> +++ b/drivers/tty/serial/samsung.c
>> @@ -1703,9 +1703,7 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
>>  #define S5PV210_SERIAL_DRV_DATA        (kernel_ulong_t)NULL
>>  #endif
>>
>> -#if defined(CONFIG_CPU_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212) || \
>> -       defined(CONFIG_SOC_EXYNOS4412) || defined(CONFIG_SOC_EXYNOS5250) || \
>> -       defined(CONFIG_SOC_EXYNOS5440)
>> +#if defined(CONFIG_ARCH_EXYNOS)
>>  static struct s3c24xx_serial_drv_data exynos4210_serial_drv_data = {
>>         .info = &(struct s3c24xx_uart_info) {
>>                 .name           = "Samsung Exynos4 UART",
> Looks good to me
> Reviewed by: Girish K S <ks.giri@samsung.com>

Thanks Girish
>> --
>> 1.7.9.5
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



--
with warm regards,
Chander Kashyap
