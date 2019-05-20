From: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH] tty: serial: msm_serial: Fix XON/XOFF
Date: Mon, 20 May 2019 16:58:54 +0200
Message-ID: <f0c89b84-7c3d-596d-06e1-cb5172e62970@linaro.org>
References: <20190520103435.30850-1-jorge.ramirez-ortiz@linaro.org>
 <20190520145110.7BDAE21721@mail.kernel.org>
 <254704a2-ee20-30cd-8362-6e1bd23ec090@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <254704a2-ee20-30cd-8362-6e1bd23ec090@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>, agross@kernel.org, david.brown@linaro.org, gregkh@linuxfoundation.org
Cc: jslaby@suse.com, keescook@chromium.org, anton@enomsg.org, ccross@android.com, tony.luck@intel.com, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, khasim.mohammed@linaro.org, agsumit@qti.qualcomm.com
List-Id: linux-serial@vger.kernel.org

On 5/20/19 16:56, Jorge Ramirez wrote:
> On 5/20/19 16:51, Stephen Boyd wrote:
>> Quoting Jorge Ramirez-Ortiz (2019-05-20 03:34:35)
>>> When the tty layer requests the uart to throttle, the current code
>>> executing in msm_serial will trigger "Bad mode in Error Handler" and
>>> generate an invalid stack frame in pstore before rebooting (that is if
>>> pstore is indeed configured: otherwise the user shall just notice a
>>> reboot with no further information dumped to the console).
>>>
>>> This patch replaces the PIO byte accessor with the word accessor
>>> already used in PIO mode.
>>
>> Because the hardware only accepts word based accessors and fails
>> otherwise? I can believe that.
>>
>> I wonder if the earlier UART hardware this driver used to support (i.e.
>> pre-DM) would accept byte access to the registers. It's possible, but we
>> don't really care because those boards aren't supported.
> 
> ok.
> 
> also the PIO path uses iowrite32_rep to write a number of bytes (from 1
> to 4) so I think it is also appropriate to use it for XON/XOFF.
> 
>>
>>>
>>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>>> ---
>>
>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>>
>>>  drivers/tty/serial/msm_serial.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
>>> index 109096033bb1..23833ad952ba 100644
>>> --- a/drivers/tty/serial/msm_serial.c
>>> +++ b/drivers/tty/serial/msm_serial.c
>>> @@ -869,10 +870,12 @@ static void msm_handle_tx(struct uart_port *port)
>>>                 else
>>>                         tf = port->membase + UART_TF;
>>>  
>>> +               buf[0] = port->x_char;
>>> +
>>>                 if (msm_port->is_uartdm)
>>>                         msm_reset_dm_count(port, 1);
>>>  
>>> -               iowrite8_rep(tf, &port->x_char, 1);
>>> +               iowrite32_rep(tf, buf, 1);
>>
>> I suppose it's OK to write some extra zeroes here?
>>
>>
> 
> yeah, semantically confusing msm_reset_dm_count is what really matters:
> it tells the hardware to only take n bytes (in this case only one) so
> the others will be ignored

um after I said this, maybe iowrite32_rep should only be applied to
uartdm ... what do you think?

> 
> 
