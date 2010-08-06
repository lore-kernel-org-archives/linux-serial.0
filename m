From: Darius Augulis <augulis.darius@gmail.com>
Subject: Re: [PATCH] serial: samsung: fix device name
Date: Fri, 06 Aug 2010 09:13:36 +0300
Message-ID: <4C5BA810.3030205@gmail.com>
References: <20100805201000.14030.34703.stgit@darius-desktop>
	<AANLkTikp2ThBqF2jkU4CXS9-iYRoy3AWpeqWXjmLF6Gd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AANLkTikp2ThBqF2jkU4CXS9-iYRoy3AWpeqWXjmLF6Gd@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 08/06/2010 03:04 AM, Kyungmin Park wrote:
> Hi,
>
> It's already posted by Mr. Shim
> http://marc.info/?l=linux-arm-kernel&m=127410047306149&w=2
>
> As discussed with Ben. even though it's right patch, there's some
> users to use previous interface.
> I also think it will be fixed. but need to coordinate with existing users.
>

IMHO, it must be fixed. It's very annoying bug and I spend few hours 
trying to understand why kernel with devtmpfs auto-mount option doesn't 
provide ttySAC0, because when grep'ing 'grep -R ttySAC0 drivers/serial/*
it's found in samsung driver and I thought everything should be o.k. Who 
could imagine that it's driver name, not device?...
Regarding old users, they should not use such strange device name in 
their configs, they have to sync with main line.

> Ben, how to you think?
>
> On Fri, Aug 6, 2010 at 5:10 AM, Darius Augulis<augulis.darius@gmail.com>  wrote:
>> Swap device and driver names in serial/samsung.c
>>
>> Signed-off-by: Darius Augulis<augulis.darius@gmail.com>
>> ---
>>   drivers/serial/samsung.c |    4 ++--
>>   1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/serial/samsung.c b/drivers/serial/samsung.c
>> index a9d6c56..9d63f24 100644
>> --- a/drivers/serial/samsung.c
>> +++ b/drivers/serial/samsung.c
>> @@ -878,10 +878,10 @@ static struct uart_ops s3c24xx_serial_ops = {
>>
>>   static struct uart_driver s3c24xx_uart_drv = {
>>         .owner          = THIS_MODULE,
>> -       .dev_name       = "s3c2410_serial",
>> +       .driver_name    = "s3c2410_serial",
>>         .nr             = CONFIG_SERIAL_SAMSUNG_UARTS,
>>         .cons           = S3C24XX_SERIAL_CONSOLE,
>> -       .driver_name    = S3C24XX_SERIAL_NAME,
>> +       .dev_name       = S3C24XX_SERIAL_NAME,
>>         .major          = S3C24XX_SERIAL_MAJOR,
>>         .minor          = S3C24XX_SERIAL_MINOR,
>>   };
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
