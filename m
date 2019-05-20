From: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH v2] tty: serial: msm_serial: Fix XON/XOFF
Date: Mon, 20 May 2019 20:57:39 +0200
Message-ID: <ef705e54-78bb-27e2-5060-31056234dad3@linaro.org>
References: <20190520183848.27719-1-jorge.ramirez-ortiz@linaro.org>
 <20190520185008.GX2085@tuxbook-pro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190520185008.GX2085@tuxbook-pro>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: agross@kernel.org, david.brown@linaro.org, gregkh@linuxfoundation.org, sboyd@kernel.org, jslaby@suse.com, keescook@chromium.org, anton@enomsg.org, ccross@android.com, tony.luck@intel.com, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 5/20/19 20:50, Bjorn Andersson wrote:
> On Mon 20 May 11:38 PDT 2019, Jorge Ramirez-Ortiz wrote:
> 
>> When the tty layer requests the uart to throttle, the current code
>> executing in msm_serial will trigger "Bad mode in Error Handler" and
>> generate an invalid stack frame in pstore before rebooting (that is if
>> pstore is indeed configured: otherwise the user shall just notice a
>> reboot with no further information dumped to the console).
>>
>> This patch replaces the PIO byte accessor with the word accessor
>> already used in PIO mode.
>>
>> Fixes: 68252424a7c7 ("tty: serial: msm: Support big-endian CPUs")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> You missed Stephen's
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

argh sorry Stephen. can the maintainer add it when it gets merged or
shall I post V3?

> 
> Regards,
> Bjorn
> 
>> ---
>>  drivers/tty/serial/msm_serial.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
>> index 109096033bb1..23833ad952ba 100644
>> --- a/drivers/tty/serial/msm_serial.c
>> +++ b/drivers/tty/serial/msm_serial.c
>> @@ -860,6 +860,7 @@ static void msm_handle_tx(struct uart_port *port)
>>  	struct circ_buf *xmit = &msm_port->uart.state->xmit;
>>  	struct msm_dma *dma = &msm_port->tx_dma;
>>  	unsigned int pio_count, dma_count, dma_min;
>> +	char buf[4] = { 0 };
>>  	void __iomem *tf;
>>  	int err = 0;
>>  
>> @@ -869,10 +870,12 @@ static void msm_handle_tx(struct uart_port *port)
>>  		else
>>  			tf = port->membase + UART_TF;
>>  
>> +		buf[0] = port->x_char;
>> +
>>  		if (msm_port->is_uartdm)
>>  			msm_reset_dm_count(port, 1);
>>  
>> -		iowrite8_rep(tf, &port->x_char, 1);
>> +		iowrite32_rep(tf, buf, 1);
>>  		port->icount.tx++;
>>  		port->x_char = 0;
>>  		return;
>> -- 
>> 2.21.0
>>
> 
