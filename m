From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [RFC PATCH] tty/serial: atmel: fix TX path in
 atmel_console_write()
Date: Fri, 17 Mar 2017 16:11:49 +0100
Message-ID: <6fc2b136-3717-df85-92ec-55bb7b91971b@gmail.com>
References: <CACQ1gAgW4aGJSxSAXDWL7td9eV12UV=Xv=PZR58BqqHxEeRH0g@mail.gmail.com>
 <20170315152948.10978-1-nicolas.ferre@microchip.com>
 <074d057e-4971-a325-e985-3f5046536225@gmail.com>
 <d3abc5aa-b010-a6cc-4ab9-74078149a692@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <d3abc5aa-b010-a6cc-4ab9-74078149a692@microchip.com>
Sender: stable-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable # 4 . 4+" <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

2017-03-15 17:56 GMT+01:00 Nicolas Ferre <nicolas.ferre@microchip.com>:
> Le 15/03/2017 à 17:19, Richard Genoud a écrit :
>> On 15/03/2017 16:29, Nicolas Ferre wrote:
>>> A side effect of 89d8232411a8 ("tty/serial: atmel_serial: BUG: stop DMA
>>> from transmitting in stop_tx") is that the console can be called with
>>> TX path disabled. Then the system would hang trying to push charecters
>>> out in atmel_console_putchar().
>>>
>>> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>> Fixes: 89d8232411a8 ("tty/serial: atmel_serial: BUG: stop DMA from transmitting
>>> in stop_tx")
>>> Cc: stable <stable@vger.kernel.org> # 4.4+
>>> ---
>>> Hi Richard,
>>>
>>> I found this to fix the problem with system hang in my linux-4.4-at91 branch
>>> (in the atmel_console_putchar() waiting loop actually). I'm open to more
>>> insignt.
>>> As we cannot figure out if this bit is set or not, I didn't preserve the
>>> current status...
>>>
>>> Regards,
>>
>> So, I'm guessing that you may see some lines/characters printed twice on
>> the screen, don't you ?
>
> Well, actually, I don't think so because the repetitions that I see are
> probably due to open/close/open/close/re-open/... of the serial console
> itself.
>
> Same with the line "random: udevd: uninitialized urandom read (16 bytes
> read, 21 bits of entropy available)", they happen at different moment in
> time => the printk log timestamping seem to indicate that they are
> different.
Hi Nicolas,

It seems that the problem is between atmel_tx_dma() and its callback
atmel_complete_tx_dma().

At some point, atmel_tx_dma() is called, does the job, and then, just
before the callback is called, the xmit->head and xmit->tail pointers
are set to zero (by uart_flush_buffer())
So, when atmel_complete_tx_dma() is called, it does:
xmit->tail += atmel_port->tx_len;
not knowing that the head and tail pointers have been reseted.
=> it's like there's (UART_XMIT_SIZE - atmel_port->tx_len) characters to
transmit on the serial line.

PS: I can trigger this bug by holding down the d key at login and then
ctrl - basically, a ctrl-d just after sending text - with a rate success
of about 1/5 :)

Could you try this patch to see if it corrects also your system hang ?

(The patch is small, but the bug hunt was a headache :))

[PATCH] tty/serial: atmel: fix race condition (TX+DMA)

If uart_flush_buffer() is called between atmel_tx_dma() and
atmel_complete_tx_dma(), the circular buffer has been cleared, but not
atmel_port->tx_len.
That leads to a circular buffer overflow (dumping (UART_XMIT_SIZE -
atmel_port->tx_len) bytes).

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/tty/serial/atmel_serial.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c
b/drivers/tty/serial/atmel_serial.c
index 833d3d80446f..89552157e334 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1934,6 +1934,11 @@ static void atmel_flush_buffer(struct uart_port
*port)
 		atmel_uart_writel(port, ATMEL_PDC_TCR, 0);
 		atmel_port->pdc_tx.ofs = 0;
 	}
+	/*
+	 * in uart_flush_buffer(), the xmit circular buffer has just
+	 * been cleared, so we have to reset tx_len accordingly.
+	 */
+	atmel_port->tx_len = 0;
 }

 /*
