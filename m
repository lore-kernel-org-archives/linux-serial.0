From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH] Revert "tty: serial: pl011: add ttyAMA for matching pl011
 console"
Date: Wed, 1 Mar 2017 16:01:33 +0300
Message-ID: <b5f58d62-7c26-a949-c866-6c292ea07f6b@linaro.org>
References: <20170301122602.30025-1-aleksey.makarov@linaro.org>
 <af761742-1362-a120-3f54-4cbe92ddbbbb@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <af761742-1362-a120-3f54-4cbe92ddbbbb@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, linux-serial@vger.kernel.org
Cc: Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org



On 03/01/2017 03:59 PM, Robin Murphy wrote:
> On 01/03/17 12:26, Aleksey Makarov wrote:
>> The original patch makes condition always true, so it is wrong.
>>
>> This reverts commit aea9a80ba98a0c9b4de88850260e9fbdcc98360b.
> 
> It seems fairly clear that the intent of the code merely warrants
> s/||/&&/ - wouldn't it be more straightforward to just fix that?

No, I don't think so.  The description of the patch says that it fixes a problem
of double printing the logs with SPCR and both console=ttyAMA and earlycon are specified
on the command string.  That wrong patch does "fix" it, but introduces
a regression with the regular case.

With s/||/&&/ it would not even 'fix' the described problem.

Thank you
Aleksey Makarov

> Robin.
> 
>> ---
>>  drivers/tty/serial/amba-pl011.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
>> index 8789ea423ccf..56f92d7348bf 100644
>> --- a/drivers/tty/serial/amba-pl011.c
>> +++ b/drivers/tty/serial/amba-pl011.c
>> @@ -2373,7 +2373,7 @@ static int __init pl011_console_match(struct console *co, char *name, int idx,
>>  	if (strcmp(name, "qdf2400_e44") == 0) {
>>  		pr_info_once("UART: Working around QDF2400 SoC erratum 44");
>>  		qdf2400_e44_present = true;
>> -	} else if (strcmp(name, "pl011") != 0 || strcmp(name, "ttyAMA") != 0) {
>> +	} else if (strcmp(name, "pl011") != 0) {
>>  		return -ENODEV;
>>  	}
>>  
>>
> 

-- 
All the best
Alekséy Makárov
