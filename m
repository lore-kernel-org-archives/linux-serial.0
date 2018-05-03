From: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Subject: Re: [PATCH] serial: imx: enable IMX21_UCR3_RXDMUXSEL for non-dte-mode
Date: Thu, 3 May 2018 14:13:53 +0800
Message-ID: <ca240b4a-aa42-b747-9bab-49b18290ca49@gtsys.com.hk>
References: <1524186479-25315-1-git-send-email-chris.ruehl@gtsys.com.hk>
 <20180420061316.sakoupltqxn2qhfr@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180420061316.sakoupltqxn2qhfr@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Greg,

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

The IMX serial driver is broken in the 4.9.x tree since 4.9.89.
Uwe's patch

6df765dca378bddf994cfd2044acafa501bd800f

please apply to clear the situation.

I know you very busy! -

Chris
