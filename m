From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: Re: [PATCH 06/13] serial: samsung: add support for Exynos5420
Date: Mon, 10 Jun 2013 14:35:22 +0530
Message-ID: <CANuQgHE40JeV1+yqHNVpv+-OBh1Vzi1EZYew6KgauEj76xHH9A@mail.gmail.com>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
	<1370516488-25860-6-git-send-email-chander.kashyap@linaro.org>
	<CAKrE-Ke1J+Xr0XeaxO4Trf=AqRm_N1arjtpYwXwupsE7m56u8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAKrE-Ke1J+Xr0XeaxO4Trf=AqRm_N1arjtpYwXwupsE7m56u8w@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Girish KS <girishks2000@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, linux-serial@vger.kernel.org, t.figa@samsung.com, linux-samsung-soc@vger.kernel.org, thomas.ab@samsung.com, s.nawrocki@samsung.com
List-Id: linux-serial@vger.kernel.org

Hi,

On 6 June 2013 17:05, Girish KS <girishks2000@gmail.com> wrote:
> On Thu, Jun 6, 2013 at 4:31 PM, Chander Kashyap
> <chander.kashyap@linaro.org> wrote:
>> The serial port used in Exynos5420 is similar to the serial ports used
>> in the other Exynos SoC. Hence, extend the serial driver support for
>> Exynos5420.
>>
>> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
>> ---
>>  drivers/tty/serial/samsung.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
>> index 3cda4ed..841221c 100644
>> --- a/drivers/tty/serial/samsung.c
>> +++ b/drivers/tty/serial/samsung.c
>> @@ -1716,7 +1716,7 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
>>
>>  #if defined(CONFIG_CPU_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212) || \
>>         defined(CONFIG_SOC_EXYNOS4412) || defined(CONFIG_SOC_EXYNOS5250) || \
>> -       defined(CONFIG_SOC_EXYNOS5440)
>> +       defined(CONFIG_SOC_EXYNOS5420) || defined(CONFIG_SOC_EXYNOS5440)
>
> Instead of comparing all CONFIGS of the SOC of exynos series, it can
> be optimized with #if defined(CONFIG_ARCH_EXYNOS)
> Make sure to test on all the boards for functionality.

Yes all belongs to Exynos family. Will change that and test.
>
>>  static struct s3c24xx_serial_drv_data exynos4210_serial_drv_data = {
>>         .info = &(struct s3c24xx_uart_info) {
>>                 .name           = "Samsung Exynos4 UART",
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
