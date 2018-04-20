From: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Subject: Re: [PATCH] serial: imx: enable IMX21_UCR3_RXDMUXSEL for non-dte-mode
Date: Fri, 20 Apr 2018 16:56:04 +0800
Message-ID: <f9cea977-56b8-052d-ccc2-9b6de7cd3645@gtsys.com.hk>
References: <1524186479-25315-1-git-send-email-chris.ruehl@gtsys.com.hk>
 <20180420061316.sakoupltqxn2qhfr@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180420061316.sakoupltqxn2qhfr@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Friday, April 20, 2018 02:13 PM, Uwe Kleine-König wrote:
> Hello Chris,
> 
> On Fri, Apr 20, 2018 at 09:07:59AM +0800, Chris Ruehl wrote:
>> Fix a problem introduced with
>> commit e61c38d85b73 ("serial: imx: setup DCEDTE early and ensure DCD and RI irqs to be off")
>> result in non dte-mode imx-uart fail receive data.
>> By add back IMX21_UCR3_RXDMUXSEL the serial port works as expected.
>>
>> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
>> ---
>>   drivers/tty/serial/imx.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 91f3a1a..3d09933 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -1391,7 +1391,7 @@ static int imx_uart_startup(struct uart_port *port)
>>   
>>   		ucr3 = imx_uart_readl(sport, UCR3);
>>   
>> -		ucr3 |= UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
>> +		ucr3 |= IMX21_UCR3_RXDMUXSEL | UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
>>   
>>   		if (sport->dte_mode)
>>   			/* disable broken interrupts */
> 
> Doesn't 6df765dca378bddf994cfd2044acafa501bd800f fix this for you?
> 
> Best regards
> Uwe
> 

Uwe,

the patch you point out would fix that problem from what I can see.

But it not yet at the linux-next and since the error persists for 4.9.89 
to present I filed a patch simple patch which fix my system.

Let me apply your patch and see if all works well then I fine to drop my
one liner.

Chris
