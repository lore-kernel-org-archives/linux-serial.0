From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH] tty: serial: 8250: add CON_CONSDEV to
 flags
Date: Tue, 18 Oct 2016 17:23:05 +0100
Message-ID: <1452ffb1-429b-65e8-3c5d-76a03ea4eb4a@codethink.co.uk>
References: <1466522389-26943-1-git-send-email-matthew.leach@codethink.co.uk>
 <40b80b82-531d-d9e8-0b4d-bdd559ad5044@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <40b80b82-531d-d9e8-0b4d-bdd559ad5044@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>, Matthew Leach <matthew.leach@codethink.co.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-kernel@lists.codethink.co.uk, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 18/10/16 17:15, Jiri Slaby wrote:
> On 06/21/2016, 05:19 PM, Matthew Leach wrote:
>> When using the 8250 as a boot console and the main console results in
>> messages being printed twice.  The console framework will only
>> unregister boot consoles if a new console is registered with the
>> CON_CONSDEV flag set.
>>
>> Set this flag for the univ8250 console to prevent double-registration.
>>
>> Signed-off-by: Matthew Leach <matthew.leach@codethink.co.uk>
>> ---
>>  drivers/tty/serial/8250/8250_core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
>> index 2f4f5ee..7a7453d 100644
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -675,7 +675,7 @@ static struct console univ8250_console = {
>>  	.device		= uart_console_device,
>>  	.setup		= univ8250_console_setup,
>>  	.match		= univ8250_console_match,
>> -	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
>> +	.flags		= CON_PRINTBUFFER | CON_ANYTIME | CON_CONSDEV,
>
> This patch breaks console= parameter handling. Passing:
>   console=ttyS0 console=tty0
> no longer means /dev/console is tty0 and it should be as is documented.
>
> I have not investigated further yet.

Ok, thanks.
I'll need to find Matthew Leach's new address as he's moved jobs.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
