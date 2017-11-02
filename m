From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] tty: max3100: remove unused variable rts and remove
 unused assignment
Date: Thu, 2 Nov 2017 14:22:11 +0000
Message-ID: <4ab49f27-4122-15bd-bc36-2e28f96255b7@canonical.com>
References: <20171102140144.21514-1-colin.king@canonical.com>
 <59FB2849.6020108@bfs.de>
 <026e02c7-745e-af05-8d20-4588420888b3@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <026e02c7-745e-af05-8d20-4588420888b3@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: wharms@bfs.de
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 02/11/17 14:21, Colin Ian King wrote:
> On 02/11/17 14:14, walter harms wrote:
>>
>>
>> Am 02.11.2017 15:01, schrieb Colin King:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> Variable rts is being assigned but it is never read, hence it can be
>>> removed.  The assignment to param_new to zero is redundant as it is
>>> being updates a few statements later, so remove this redundant
>>> assignment. Cleans up two clang warnings:
>>>
>>> drivers/tty/serial/max3100.c:277:3: warning: Value stored to 'rts'
>>> is never read
>>> drivers/tty/serial/max3100.c:439:2: warning: Value stored to 'param_new'
>>> is never read
>>>
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>> ---
>>>  drivers/tty/serial/max3100.c | 4 +---
>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
>>> index b6b3453e8c1f..f691f3cdb5b1 100644
>>> --- a/drivers/tty/serial/max3100.c
>>> +++ b/drivers/tty/serial/max3100.c
>>> @@ -263,7 +263,7 @@ static void max3100_work(struct work_struct *w)
>>>  	struct max3100_port *s = container_of(w, struct max3100_port, work);
>>>  	int rxchars;
>>>  	u16 tx, rx;
>>> -	int conf, cconf, rts, crts;
>>> +	int conf, cconf, crts;
>>>  	struct circ_buf *xmit = &s->port.state->xmit;
>>>  
>>>  	dev_dbg(&s->spi->dev, "%s\n", __func__);
>>> @@ -274,7 +274,6 @@ static void max3100_work(struct work_struct *w)
>>>  		conf = s->conf;
>>>  		cconf = s->conf_commit;
>>>  		s->conf_commit = 0;
>>> -		rts = s->rts;
>>>  		crts = s->rts_commit;
>>>  		s->rts_commit = 0;
>>>  		spin_unlock(&s->conf_lock);
>>> @@ -436,7 +435,6 @@ max3100_set_termios(struct uart_port *port, struct ktermios *termios,
>>>  	dev_dbg(&s->spi->dev, "%s\n", __func__);
>>>  
>>>  	cflag = termios->c_cflag;
>>> -	param_new = 0;
>>>  	param_mask = 0;
>>>  
>>>  	baud = tty_termios_baud_rate(termios);
>>
>> are you sure ?
> 
> Yep. So are my compilers
> 
>>
>> based on this code:
>> https://lxr.missinglinkelectronics.com/linux/drivers/tty/serial/max3100.c
> 
>  438        cflag = termios->c_cflag;
>  439        param_new = 0;
>  440        param_mask = 0;
>  441
>  442        baud = tty_termios_baud_rate(termios);
>  443        param_new = s->conf & MAX3100_BAUD;
> 
> param_new is being updated again on line 440, so line 439 is redundant.
I mean "again on line 443"

> 
>>
>> the default case will not set param_new
>>
>> re,
>>  wh
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
