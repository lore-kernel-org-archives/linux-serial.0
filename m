From: Darron Black <darron@griffin.net>
Subject: Re: [PATCH] RS485: fix inconsistencies in the meaning of some
 variables
Date: Sun, 13 Nov 2011 18:37:11 -0600
Message-ID: <4EC062B7.2090100@griffin.net>
References: <4E492CFF.7040905@pwrnet.de> <20110822211832.GA8023@kroah.com>
 <4EB3A009.10502@evidence.eu.com> <4EB8F6B9.6010008@atmel.com>
 <4EB90902.4030200@evidence.eu.com>
 <20111108134804.07095c5d@lxorguk.ukuu.org.uk>
 <20111108142432.GA11293@kroah.com> <4EBA9385.7010806@evidence.eu.com>
 <20111113215318.GA2966@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20111113215318.GA2966@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Jesper Nilsson <Jesper.Nilsson@axis.com>, Greg KH <greg@kroah.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Claudio Scordino <claudio@evidence.eu.com>, Mikael Starvik <mikael.starvik@axis.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org

On 11/13/2011 03:53 PM, Wolfram Sang wrote:
> Hi,
>
> I have been working on a patch series which adds hardware RS485 to the 8250
> according to the latest developments. The series will be posted tomorrow after
> some more tests. However, there is one thing I wondered about:
>
>>  From now on, SER_RS485_RTS_AFTER_SEND and SER_RS485_RTS_ON_SEND will be used to
>> set the voltage of the RTS pin (as in the crisv10.c driver); the delay will be
>> understood by looking only at the value of delay_rts_before_send and
>> delay_rts_after_send.
> Do I overlook something or is SER_RS485_RTS_AFTER_SEND always the inverted
> signal of SER_RS485_RTS_ON_SEND. So why do we need both? (BTW
> SER_RS485_RTS_ON_SEND is a non-obvious name, I think. But changing it will
> probably break even more users?)
It allows the application to configure RTS to not toggle at all in one 
of those two scenarios.

Perhaps the RTS toggle after transmit delay needs to be large, and 
they'd rather do it in userspace than block in the driver. I also recall 
a protocol that would send a master assertion command and hold on to RTS 
afterwards. I can easily imagine needing to quickly transmit something, 
hold on to RTS for a while, then finish your transmit later.

However, I don't have any concrete examples of needing this outside that 
vague recollection of a master assertion sequence in an old embedded 
platform far away from Linux.

>> diff --git a/include/linux/serial.h b/include/linux/serial.h
>> index 97ff8e2..3d86517 100644
>> --- a/include/linux/serial.h
>> +++ b/include/linux/serial.h
>> @@ -207,13 +207,15 @@ struct serial_icounter_struct {
>>
>>   struct serial_rs485 {
>>   	__u32	flags;			/* RS485 feature flags */
>> -#define SER_RS485_ENABLED		(1<<  0)
>> -#define SER_RS485_RTS_ON_SEND		(1<<  1)
>> -#define SER_RS485_RTS_AFTER_SEND	(1<<  2)
>> -#define SER_RS485_RTS_BEFORE_SEND	(1<<  3)
>> +#define SER_RS485_ENABLED		(1<<  0)	/* If enabled */
>> +#define SER_RS485_RTS_ON_SEND		(1<<  1)	/* Logical level for
>> +							   RTS pin when
>> +							   sending */
>> +#define SER_RS485_RTS_AFTER_SEND	(1<<  2)	/* Logical level for
>> +							   RTS pin after sent*/
> Nit: 80 char should be broken here, because that is not readable. Or put the
> comment above the define.
>
> Thanks,
>
>     Wolfram
>
