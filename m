From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] serial/amba-pl011: Disable interrupts around TX softirq
Date: Mon, 08 Jun 2015 11:34:45 +0100
Message-ID: <55756FC5.5000801@arm.com>
References: <1433513267-24163-1-git-send-email-Dave.Martin@arm.com>
 <5571E47E.5020800@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5571E47E.5020800@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave P Martin <Dave.Martin@arm.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@arm.linux.org.uk>, =?ISO-8859-2?Q?Jakub_Kici=F1?= =?ISO-8859-2?Q?ski?= <moorray3@wp.pl>, Andre Przywara <Andre.Przywara@arm.com>, Andrew Jackson <Andrew.Jackson@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, popcorn mix <popcornmix@gmail.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On 05/06/15 19:03, Robin Murphy wrote:
> On 05/06/15 15:07, Dave P Martin wrote:
>> pl011_tx_softirq() currently uses spin_{,un}lock(), which are not
>> sufficient to inhibit pl011_int() from being triggered by a local
>> IRQ and trying to re-take the same lock.  This can lead to
>> deadlocks.
>>
>> This patch uses the _irq() locking variants instead to ensure that
>> pl011_int() handling for a given port is deferred until any
>> pl011_tx_softirq() work for that port is complete.
>>
>> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
>> ---
>>
>> Another candidate for v4.1 if possible (sorry!) -- I thought this change
>> was already in, but it went astray when I was refactoring.
>>
>> This patch conflicts with tty-next like the previous patch, since it
>> fixes code that is removed by tty-next.  The correct resolution for
>> the resulting merge conflict is to keep the code from tty-next.
>>
>>
>> I am not 100% certain yet whether some rare deadlocks that Robin is
>> seeing are caused by this issue, or whether this patch fixes them --
>> he's testing atm.
>
> FWIW, I've been running Juno in a startup/shutdown loop with a very
> noisy systemd all afternoon and haven't hit a problem yet with this
> patch applied. Testing without this patch yesterday I saw 3 or 4 lockdep
> splats in about the same amount of time. I'll leave it going over the
> weekend just to make sure, though.

Having still seen nothing over several hundred more reboot cycles, I'm 
satisfied that the irq vs. softirq race explains the deadlock and that 
this patch fixes it, so;

Tested-by: Robin Murphy <robin.murphy@arm.com>

>
> Robin.
>
>>
>> The patch is straightforward and using non _irq() locking in a workitem
>> that expects the lock to protect against interrupt handlers on the same
>> CPU is clearly wrong.
>>
>>
>> Cheers
>> ---Dave
>>
>>
>>    drivers/tty/serial/amba-pl011.c |    4 ++--
>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
>> index 763eb20..0cc622a 100644
>> --- a/drivers/tty/serial/amba-pl011.c
>> +++ b/drivers/tty/serial/amba-pl011.c
>> @@ -1360,9 +1360,9 @@ static void pl011_tx_softirq(struct work_struct *work)
>>    	struct uart_amba_port *uap =
>>    		container_of(dwork, struct uart_amba_port, tx_softirq_work);
>>
>> -	spin_lock(&uap->port.lock);
>> +	spin_lock_irq(&uap->port.lock);
>>    	while (pl011_tx_chars(uap)) ;
>> -	spin_unlock(&uap->port.lock);
>> +	spin_unlock_irq(&uap->port.lock);
>>    }
>>
>>    static void pl011_tx_irq_seen(struct uart_amba_port *uap)
>>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
