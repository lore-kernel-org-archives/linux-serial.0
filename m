From: Dean Jenkins <Dean_Jenkins@mentor.com>
Subject: Re: [PATCH 3/5] serial: imx: avoid spinlock recursion deadlock
Date: Wed, 14 May 2014 17:24:53 +0100
Message-ID: <537398D5.2010608@mentor.com>
References: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com> <1399648788-26061-4-git-send-email-dean_jenkins@mentor.com> <53703C0F.20504@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:44015 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbaENQY6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 May 2014 12:24:58 -0400
In-Reply-To: <53703C0F.20504@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, dirk.behme@de.bosch.com, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, shawn.guo@freescale.com

On 12/05/14 04:12, Huang Shijie wrote:
> =E4=BA=8E 2014=E5=B9=B405=E6=9C=8809=E6=97=A5 23:19, dean_jenkins@men=
tor.com =E5=86=99=E9=81=93:
>> From: Andy Lowe<andy_lowe@mentor.com>
>>
>> The following deadlock has been observed:
>>
>> imx_int() {
>>    imx_txint() {
>>      spin_lock_irqsave(&sport->port.lock,flags);
>>      /* ^^^uart_port spinlock taken in imx_txint */
>>      imx_transmit_buffer() {
>>        uart_write_wakeup(&sport->port) {
>>          tty_wakeup() {
>>            hci_uart_tty_wakeup() {
>>              hci_uart_tx_wakeup() {
>>                uart_write() {
>>                  spin_lock_irqsave(&port->lock, flags);
>>                  /* ^^^deadlock here when spinlock is taken again */
>>                    .
>>                    .
>>                    .
>>                  spin_unlock_irqrestore(&port->lock, flags);
>>                }
>>              }
>>            }
>>          }
>>        }
>>      }
>>      spin_unlock_irqrestore(&sport->port.lock,flags);
>>    }
>> }
>>
>> To correct this call uart_write_wakeup() at the end of imx_txint() a=
fter
>> the uart_port spinlock is unlocked.
>>
>> Signed-off-by: Andy Lowe<andy_lowe@mentor.com>
>> Signed-off-by: Dirk Behme<dirk.behme@de.bosch.com>
>> ---
>>   drivers/tty/serial/imx.c |    7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index abe31ad..cc79706 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -636,8 +636,13 @@ static irqreturn_t imx_txint(int irq, void *dev=
_id)
>>
>>       imx_transmit_buffer(sport);
>>
>> -    if (uart_circ_chars_pending(xmit)<  WAKEUP_CHARS)
>> +    if (uart_circ_chars_pending(xmit)<  WAKEUP_CHARS) {
>> +        spin_unlock_irqrestore(&sport->port.lock, flags);
>>           uart_write_wakeup(&sport->port);
>> +    } else
>> +        spin_unlock_irqrestore(&sport->port.lock, flags);
>> +
>> +    return IRQ_HANDLED;
>>
>>   out:
>>       spin_unlock_irqrestore(&sport->port.lock, flags);
> I think this patch :
>
> https://lkml.org/lkml/2014/3/20/623
My analysis of this modification in the lkml suggests the following=20
undesirable side-effects have been introduced:

The addition of the work queue to split the IRQ interrupt context=20
handling from running hci_uart_tx_wakeup() or new hci_uart_write_work()=
=20
"fixes" the i.MX6 serial driver deadlock crash. However, this code is=20
being scheduled far too often so adds unnecessary processor loading.

There is an underlying flaw in the operation of the TTY_DO_WRITE_WAKEUP=
=20
bit which is set too early which causes the wakeup mechanism to trigger=
=20
when there are no pending characters to be written to the holding=20
circular buffer. For BCSP under normal operating conditions, I think th=
e=20
wakeup mechanism is redundant because the BCSP frames are unable to=20
completely fill the holding circular buffer so no characters remain=20
pending. But currently, I think this work queue scheduling will occur=20
for EVERY transmission of a BCSP frame from the interrupt context and=20
again from the writing of the BCSP frame into the holding circular=20
buffer via hci_uart_send_frame(). eg. is scheduled twice per TX BCSP fr=
ame.

TTY_DO_WRITE_WAKEUP is tested in drivers/tty/tty_io.c: tty_wakeup() and=
=20
therefore if TTY_DO_WRITE_WAKEUP is in the clear state then=20
ld->ops->write_wakeup(tty) is not called so avoids running=20
hci_uart_tty_wakeup() so avoids the scheduling of the work queue.

Separate to the deadlock issue, is a contributing issue concerning the=20
setting of TTY_DO_WRITE_WAKEUP when it is known there are pending=20
characters to be sent when the holding circular buffer becomes full. Th=
e=20
problematic code is in drivers/bluetooth/hci_ldisc.c :=20
hci_uart_tx_wakeup() or new hci_uart_write_work() because=20
TTY_DO_WRITE_WAKEUP is ALWAYS set despite the writing of BCSP frames=20
usually not filling up the holding circular buffer. I do not see an eas=
y=20
fix for this because the TTY_DO_WRITE_WAKEUP must be set BEFORE the TX=20
interrupts are set in the lower bound function tty->ops->write().=20
Perhaps a callback function pointer is needed that sets=20
TTY_DO_WRITE_WAKEUP when the write function fails to write all of the=20
characters into the holding circular buffer ?

An additional side effect of adding the work queue is that BCSP frame=20
hci_uart_send_frame() calls will also become delayed by the scheduling=20
and running of the work queue. This is undesirable because it adds=20
unnecessary processor loading. The work queue should only act on the=20
interrupt context program flow and not the normal kernel thread flow of=
=20
writing BCSP frames. I fear that the work queue is in the wrong place. =
A=20
better place would be in hci_uart_tty_wakeup() for the work queue so=20
that it only effects the interrupt context.

In other words, fixing TTY_DO_WRITE_WAKEUP prevents unnecessary TX=20
wakeup handling (probably no TX wakeups in BCSP operation) and this=20
reduces the chances of the original deadlock issue occurring due to the=
=20
lower rate of TX wakeup events, if any. The patch fixes the deadlock in=
=20
the i.MX6 UART driver without introducing a work-queue in the general c=
ode.
>
> has fixed this deadlock.
>
Well, it has prevented the deadlock but fundamentally it is inefficient=
=20
due to increasing latency and processor loading as described above.

> We can ignore this patch now.
>
This patch is compatible with the change in
https://lkml.org/lkml/2014/3/20/623
with the result that the deadlock is prevented in 2 places.

Regards,
Dean
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
