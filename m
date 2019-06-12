From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Subject: Re: [PATCH] serial: Fix an invalid comparing statement
Date: Wed, 12 Jun 2019 18:18:50 +0900
Message-ID: <3b075194-9cea-6de9-31ed-b6dda1e87e9a@socionext.com>
References: <1558933288-30023-1-git-send-email-sugaya.taichi@socionext.com>
 <20190610165655.GA397@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610165655.GA397@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Takao Orito <orito.takao@socionext.com>, Kazuhiro Kasai <kasai.kazuhiro@socionext.com>, Shinji Kanematsu <kanematsu.shinji@socionext.com>, Jassi Brar <jaswinder.singh@linaro.org>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

On 2019/06/11 1:56, Greg Kroah-Hartman wrote:
> On Mon, May 27, 2019 at 02:01:27PM +0900, Sugaya Taichi wrote:
>> Drop the if-statement which refers to 8th bit field of u8 variable.
>> The bit field is no longer used.
>>
>> Fixes: ba44dc043004 ("serial: Add Milbeaut serial control")
>> Reported-by: Colin Ian King <colin.king@canonical.com>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>> ---
>>   drivers/tty/serial/milbeaut_usio.c | 15 +++++----------
>>   1 file changed, 5 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/tty/serial/milbeaut_usio.c b/drivers/tty/serial/milbeaut_usio.c
>> index 949ab7e..d7207ab 100644
>> --- a/drivers/tty/serial/milbeaut_usio.c
>> +++ b/drivers/tty/serial/milbeaut_usio.c
>> @@ -56,7 +56,6 @@
>>   #define MLB_USIO_SSR_FRE		BIT(4)
>>   #define MLB_USIO_SSR_PE			BIT(5)
>>   #define MLB_USIO_SSR_REC		BIT(7)
>> -#define MLB_USIO_SSR_BRK		BIT(8)
>>   #define MLB_USIO_FCR_FE1		BIT(0)
>>   #define MLB_USIO_FCR_FE2		BIT(1)
>>   #define MLB_USIO_FCR_FCL1		BIT(2)
>> @@ -180,18 +179,14 @@ static void mlb_usio_rx_chars(struct uart_port *port)
>>   		if (status & MLB_USIO_SSR_ORE)
>>   			port->icount.overrun++;
>>   		status &= port->read_status_mask;
>> -		if (status & MLB_USIO_SSR_BRK) {
>> -			flag = TTY_BREAK;
>> +		if (status & MLB_USIO_SSR_PE) {
>> +			flag = TTY_PARITY;
>>   			ch = 0;
>>   		} else
>> -			if (status & MLB_USIO_SSR_PE) {
>> -				flag = TTY_PARITY;
>> +			if (status & MLB_USIO_SSR_FRE) {
>> +				flag = TTY_FRAME;
>>   				ch = 0;
>> -			} else
>> -				if (status & MLB_USIO_SSR_FRE) {
>> -					flag = TTY_FRAME;
>> -					ch = 0;
>> -				}
>> +			}
>>   		if (flag)
>>   			uart_insert_char(port, status, MLB_USIO_SSR_ORE,
>>   					 ch, flag);
> 
> While the code never actually supported Break, you are explicitly
> removing that logic now.  So shouldn't you instead _fix_ break handling?
> The code before and after your change does not work any differently, so
> this patch isn't really needed at this point.
> 

According to research, MLB_USIO_SSR_BRK was a remnant of old HW.
Since current one does not handle the Break, all logic related it should be
removed. I try to make a new fix patch.

Thanks,
Sugaya Taichi

> thanks,
> 
> greg k-h
> 
