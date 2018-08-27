From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: [PATCH] serial: mvebu-uart: Fix reporting of effective CSIZE to
 userspace
Date: Mon, 27 Aug 2018 08:25:07 +0200
Message-ID: <211be85e-8ec1-541f-0d3a-9846079f068f@web.de>
References: <69ad54af-8732-b78a-7e0b-482bfcd6d25f@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <69ad54af-8732-b78a-7e0b-482bfcd6d25f@web.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial <linux-serial@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Allen Yan <yanwei@marvell.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Marc Zyngier <marc.zyngier@arm.com>
List-Id: linux-serial@vger.kernel.org

On 2018-08-26 19:49, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Apparently, this driver (or the hardware) does not support character
> length settings. It's apparently running in 8-bit mode, but it makes
> userspace believe it's in 5-bit mode. That makes tcsetattr with CS8
> incorrectly fail, breaking e.g. getty from busybox, thus the login shell
> on ttyMVx.
> 
> Fix by hard-wiring CS8 into c_cflag.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> It's a bit of a shame that still maturing drivers can break userspace
> that easily and subtly. I had to debug my way from old but working
> buildroot to busybox, libc (tcsetattr) and then finally this driver.
> This wasn't the first bug of this kind, and maybe it's not the last (I
> didn't check all that termio flags). Could the kernel help in some way
> with sanity checks or sane defaults driver have to make insane
> willingly?
> 
>   drivers/tty/serial/mvebu-uart.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
> index d04b5eeea3c6..170e446a2f62 100644
> --- a/drivers/tty/serial/mvebu-uart.c
> +++ b/drivers/tty/serial/mvebu-uart.c
> @@ -511,6 +511,7 @@ static void mvebu_uart_set_termios(struct uart_port *port,
>   		termios->c_iflag |= old->c_iflag & ~(INPCK | IGNPAR);
>   		termios->c_cflag &= CREAD | CBAUD;
>   		termios->c_cflag |= old->c_cflag & ~(CREAD | CBAUD);
> +		termios->c_cflag |= CS8;
>   	}
>   
>   	spin_unlock_irqrestore(&port->lock, flags);
> 

FWIW, below is the analogous fix for stable trees <= 4.14.

Jan

---8<---

From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] serial: mvebu-uart: Fix reporting of effective CSIZE to userspace

Apparently, this driver (or the hardware) does not support character
length settings. It's apparently running in 8-bit mode, but it makes
userspace believe it's in 5-bit mode. That makes tcsetattr with CS8
incorrectly fail, breaking e.g. getty from busybox, thus the login shell
on ttyMVx.

Fix by hard-wiring CS8 into c_cflag.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/tty/serial/mvebu-uart.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 45b57c294d13..401c983ec5f3 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -327,8 +327,10 @@ static void mvebu_uart_set_termios(struct uart_port *port,
 	if ((termios->c_cflag & CREAD) == 0)
 		port->ignore_status_mask |= STAT_RX_RDY | STAT_BRK_ERR;
 
-	if (old)
+	if (old) {
 		tty_termios_copy_hw(termios, old);
+		termios->c_cflag |= CS8;
+	}
 
 	baud = uart_get_baud_rate(port, termios, old, 0, 460800);
 	uart_update_timeout(port, termios->c_cflag, baud);
-- 
2.16.4
