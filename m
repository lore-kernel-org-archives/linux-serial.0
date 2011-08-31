From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH v2 3/6] TTY: serial, remove tasklet for tty_wakeup
Date: Wed, 31 Aug 2011 16:43:06 +0200
Message-ID: <4E5E487A.10709@gmail.com>
References: <1310646915-3032-1-git-send-email-jslaby@suse.cz> <1310646915-3032-3-git-send-email-jslaby@suse.cz> <20110719173401.131e220f@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110719173401.131e220f@bob.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Jiri Slaby <jslaby@suse.cz>, gregkh@suse.de, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 07/19/2011 06:34 PM, Alan Cox wrote:
> On Thu, 14 Jul 2011 14:35:12 +0200
> Jiri Slaby <jslaby@suse.cz> wrote:
> 
>> tty_wakeup can be called from any context. So there is no need to have
>> an extra tasklet for calling that. Hence save some space and remove
>> the tasklet completely.
>>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> Cc: Greg Kroah-Hartman <gregkh@suse.de>
>> Cc: Alan Cox <alan@linux.intel.com>
>> ---
>>  drivers/tty/serial/serial_core.c |   20 +-------------------
>>  include/linux/serial_core.h      |    1 -
>>  2 files changed, 1 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/tty/serial/serial_core.c
>> b/drivers/tty/serial/serial_core.c index 2cbf1bd..4786232 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -72,7 +72,7 @@ void uart_write_wakeup(struct uart_port *port)
>>  	 * closed.  No cookie for you.
>>  	 */
>>  	BUG_ON(!state);
>> -	tasklet_schedule(&state->tlet);
>> +	tty_wakeup(state->port.tty);
> 
> Probably worth noting that this is only safe if the uart locks are held
> and because of the current lock/ref drop combinations in the
> serial_core code otherwise it can race with hangup...

I see this was merged. Since I was not sure this patch is OK after your
comment, I reviewed the code now. It shouldn't be an issue right now,
exactly as you wrote. I.e. the device is stopped, ISR synchronized and
even then ->hangup sets tty to NULL.

I have a patch in my queue which converts all these guys to
tty_port_tty_get. This is needed before I can use tty_port_hangup
obviously. It is because the order there is opposite (set tty to NULL,
then shutdown everybody).

thanks for review,
-- 
js
