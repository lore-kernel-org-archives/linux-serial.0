From: Claudio Scordino <claudio@evidence.eu.com>
Subject: Re: [PATCH] atmel_serial: RS485: receiving enabled when sending data
Date: Tue, 23 Aug 2011 10:30:46 +0200
Message-ID: <4E536536.3030004@evidence.eu.com>
References: <4E492CFF.7040905@pwrnet.de> <20110822211832.GA8023@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110822211832.GA8023@kroah.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg KH <greg@kroah.com>
Cc: linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Bernhard Roth <br@pwrnet.de>
List-Id: linux-serial@vger.kernel.org

Il 22/08/2011 23:18, Greg KH ha scritto:
> On Mon, Aug 15, 2011 at 04:28:15PM +0200, Bernhard Roth wrote:
>> Hello!
>>
>> By default the atmel_serial driver in RS485 mode disables receiving
>> data until all data in the send buffer has been sent. This flag
>> allows to receive data even whilst sending data. This is very useful
>> to
>>
>> - check if the data has been sent correctly over the RS485 bus
>> - assure that no collision happened
>> - check for short circuits/termination issues on the RS485 bus
>>
>> Usually this functionality is realized by hardware, wether
>> controlling the RX-Enable pin of the RS485 transceiver with RTS
>> (driver control signal) or pulling it LOW permanently. The present
>> atmel_serial driver makes this impossible, thus requiring following
>> patch.
>>
>> Usage example:
>>
>>      struct serial_rs485     rs485;
>>
>>      memset(&rs485, 0, sizeof(rs485));
>>      rs485.flags = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX;
>>      ioctl(fd, TIOCSRS485,&rs485);
>>
>>
>>
>>
>> atmel_serial: RS485: receiving enabled when sending data
>>
>> By default the atmel_serial driver in RS485 mode disables receiving
>> data until
>> all data in the send buffer has been sent. This flag allows to receive data
>> even whilst sending data.
>>
>> Signed-off-by: Bernhard Roth<br@pwrnet.de>
>> Signed-off-by: Claudio Scordino<claudio@evidence.eu.com>
>> ---
>>   drivers/tty/serial/atmel_serial.c |   17 ++++++++++-------
>>   include/linux/serial.h            |    1 +
>>   2 files changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/tty/serial/atmel_serial.c
>> b/drivers/tty/serial/atmel_serial.c
>> index af9b781..5f6c745 100644
>> --- a/drivers/tty/serial/atmel_serial.c
>> +++ b/drivers/tty/serial/atmel_serial.c
>> @@ -339,8 +339,9 @@ static void atmel_stop_tx(struct uart_port *port)
>>       /* Disable interrupts */
>>       UART_PUT_IDR(port, atmel_port->tx_done_mask);
>>
>> -    if (atmel_port->rs485.flags&  SER_RS485_ENABLED)
>> -        atmel_start_rx(port);
>> +    if ((atmel_port->rs485.flags&  SER_RS485_ENABLED)&&
>> +        !(atmel_port->rs485.flags&  SER_RS485_RX_DURING_TX))
>> +            atmel_start_rx(port);
> 
> Can you fix your email client to not strip patches of tabs and resend
> this so that I can apply it?
> 
> thanks,
> 
> greg k-h

Hi Greg,

    please find below the patch with the right tabs.

Remind however that the main author of the patch is Bernhard, not me.

Best regards,

    		Claudio 

atmel_serial: RS485: receiving enabled when sending data

By default the atmel_serial driver in RS485 mode disables receiving data until
all data in the send buffer has been sent. This flag allows to receive data
even whilst sending data.

Signed-off-by: Bernhard Roth <br@pwrnet.de> 
Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
---
 drivers/tty/serial/atmel_serial.c |   17 ++++++++++-------
 include/linux/serial.h            |    1 +
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index af9b781..5f6c745 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -339,8 +339,9 @@ static void atmel_stop_tx(struct uart_port *port)
 	/* Disable interrupts */
 	UART_PUT_IDR(port, atmel_port->tx_done_mask);
 
-	if (atmel_port->rs485.flags & SER_RS485_ENABLED)
-		atmel_start_rx(port);
+	if ((atmel_port->rs485.flags & SER_RS485_ENABLED) &&
+		!(atmel_port->rs485.flags & SER_RS485_RX_DURING_TX))
+			atmel_start_rx(port);
 }
 
 /*
@@ -356,8 +357,9 @@ static void atmel_start_tx(struct uart_port *port)
 			   really need this.*/
 			return;
 
-		if (atmel_port->rs485.flags & SER_RS485_ENABLED)
-			atmel_stop_rx(port);
+		if ((atmel_port->rs485.flags & SER_RS485_ENABLED) &&
+			!(atmel_port->rs485.flags & SER_RS485_RX_DURING_TX))
+				atmel_stop_rx(port);
 
 		/* re-enable PDC transmit */
 		UART_PUT_PTCR(port, ATMEL_PDC_TXTEN);
@@ -680,9 +682,10 @@ static void atmel_tx_dma(struct uart_port *port)
 		/* Enable interrupts */
 		UART_PUT_IER(port, atmel_port->tx_done_mask);
 	} else {
-		if (atmel_port->rs485.flags & SER_RS485_ENABLED) {
-			/* DMA done, stop TX, start RX for RS485 */
-			atmel_start_rx(port);
+		if ((atmel_port->rs485.flags & SER_RS485_ENABLED) &&
+			!(atmel_port->rs485.flags & SER_RS485_RX_DURING_TX)) {
+				/* DMA done, stop TX, start RX for RS485 */
+				atmel_start_rx(port);
 		}
 	}
 
diff --git a/include/linux/serial.h b/include/linux/serial.h
index ef91406..97ff8e2 100644
--- a/include/linux/serial.h
+++ b/include/linux/serial.h
@@ -211,6 +211,7 @@ struct serial_rs485 {
 #define SER_RS485_RTS_ON_SEND		(1 << 1)
 #define SER_RS485_RTS_AFTER_SEND	(1 << 2)
 #define SER_RS485_RTS_BEFORE_SEND	(1 << 3)
+#define SER_RS485_RX_DURING_TX		(1 << 4)
 	__u32	delay_rts_before_send;	/* Milliseconds */
 	__u32	delay_rts_after_send;	/* Milliseconds */
 	__u32	padding[5];		/* Memory is cheap, new structs
-- 
1.7.1
