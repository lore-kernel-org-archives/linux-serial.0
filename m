From: Pramod Gurav <pramod.gurav@smartplayin.com>
Subject: Re: [PATCH v2] tty: serial: msm_serial: Remove duplicate code in
 msm_console_setup
Date: Fri, 09 Jan 2015 11:46:02 +0530
Message-ID: <54AF7222.4050901@smartplayin.com>
References: <1420708545-6477-1-git-send-email-pramod.gurav@smartplayin.com> <54AEFAA0.3010605@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <54AEFAA0.3010605@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Stephen,

On Friday 09 January 2015 03:16 AM, Stephen Boyd wrote:
> On 01/08/2015 01:15 AM, Pramod Gurav wrote:
>>  drivers/tty/serial/msm_serial.c |   15 ---------------
>>  1 file changed, 15 deletions(-)
>>
>> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
>> index c88b522..057008d 100644
>> --- a/drivers/tty/serial/msm_serial.c
>> +++ b/drivers/tty/serial/msm_serial.c
>> @@ -932,27 +932,12 @@ static int __init msm_console_setup(struct console *co, char *options)
>>  	if (unlikely(!port->membase))
>>  		return -ENXIO;
>>  
>> -	msm_init_clock(port);
>> -
> 
> Hm.. doesn't the console setup happen before the port is opened though?
> I would think that we need to keep this around so that the clock is
> actually enabled before we go and write to hardware registers.
Thanks. Verified this. Will undo this change.

> 
>>  	if (options)
>>  		uart_parse_options(options, &baud, &parity, &bits, &flow);
>>  
>>  	bits = 8;
>>  	parity = 'n';
>>  	flow = 'n';
> 
> I wonder if we should leave this here? Maybe we can rely on the user
> specifying the right values on the command line?

Ok. Will do.
> 
>> -	msm_write(port, UART_MR2_BITS_PER_CHAR_8 | UART_MR2_STOP_BIT_LEN_ONE,
>> -		  UART_MR2);	/* 8N1 */
>> -
>> -	if (baud < 300 || baud > 115200)
>> -		baud = 115200;
>> -	msm_set_baud_rate(port, baud);
>> -
>> -	msm_reset(port);
>> -
>> -	if (msm_port->is_uartdm) {
> 
> msm_port is unused now. Please remove it in the same patch.
Sure. Thanks.
> 
