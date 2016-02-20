From: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCHv2] serial: samsung: drop the spinlock around uart_write_wakeup
Date: Sat, 20 Feb 2016 09:06:50 +0530
Message-ID: <CANAwSgTyfkcMLkH=ehLWZ5hv2LYi6q4cXVsJS7y5Pf0oXZMtyA@mail.gmail.com>
References: <1455858937-2380-1-git-send-email-linux.amoon@gmail.com> <56C76D3D.3010009@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56C76D3D.3010009@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-serial@vger.kernel.org

Hi Peter,

On 20 February 2016 at 01:00, Peter Hurley <peter@hurleysoftware.com> wrote:
> [ +cc Krzysztof Kozlowski ]
>
> On 02/18/2016 09:15 PM, Anand Moon wrote:
>> From: Anand Moon <linux.amoon@gmail.com>
>>
>> drop the spin_unlock/lock around uart_write_wakeup to protect
>> write wakeup for uart port.
>
> What Krzysztof was saying wrt v1 of this patch is that the
> changelog should provide as much information as possible to
> the maintainer(s) and driver author(s), and that you should
> test that outcome.
>
> Here's what I would have written for a commit message:
>
>
>   Remove deadlock workaround for line disciplines that invoke
>   the tty driver's write() method directly from their write_wakeup()
>   method. As documented for the write_wakeup() line discipline method
>   in tty_ldisc.h, line disciplines must not attempt i/o directly
>   from write_wakeup() as this will deadlock. Reviews of in-tree line
>   disciplines confirm all defer i/o.
>
>   NB: This workaround was added in commit c15c3747ee32
>   ("serial: samsung: fix potential soft lockup during uart write")
>   which notes both slip and bluetooth hci attempt i/o directly from
>   write_wakeup(). These issues were fixed in commits 661f7fda21b1
>   ("slip: Fix deadlock in write_wakeup") and da64c27d3c93
>   ("bluetooth: hci_ldisc: fix deadlock condition"), respectively.
>
>
> Regards,
> Peter Hurley
>
>
> PS - Minor procedural note: please cc those who have reviewed previous
>      patch versions when you submit new versions, ok?  Not a big deal,
>      lots of submitters don't, but it's still preferred.
>
>
>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>> ---
>> changes logs: drop the previous approch of spin_unlock_irqrestore/save
>> ---
>>  drivers/tty/serial/samsung.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
>> index d72cd73..0cb70a9 100644
>> --- a/drivers/tty/serial/samsung.c
>> +++ b/drivers/tty/serial/samsung.c
>> @@ -758,11 +758,8 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
>>               goto out;
>>       }
>>
>> -     if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS) {
>> -             spin_unlock(&port->lock);
>> +     if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>>               uart_write_wakeup(port);
>> -             spin_lock(&port->lock);
>> -     }
>>
>>       if (uart_circ_empty(xmit))
>>               s3c24xx_serial_stop_tx(port);
>>
>

Thanks I will append your suggestions and resend this patch.
I will keep a note of your suggestions thanks you.

Best Regards.
-Anand Moon
