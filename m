From: Benjamin Valentin <benjamin.valentin-WxehSq5lv7P58Y2lBU5/X10bvzIJ1INa@public.gmane.org>
Subject: ftdi_sio: no per-byte parity error detection possible?
Date: Fri, 27 Oct 2017 17:49:34 +0200
Message-ID: <25ffaffb-cdab-4df5-f21d-17820e0e3dcc@volatiles.lighting>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-GB
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi,
I'm trying to communicate with an embedded device using a serial 
protocol which uses the parity bit to indicate the start of a frame 
(MARK/SPACE parity).

Sending such frames works well, but when receiving them with a FT232RL 
USB adapter, the parity error detection is very unreliable.

I created a minimal example to reproduce this [1] with just two of these 
USB adapters. When I use the internal, 16550-compatible UART of the 
MT7688 instead, parity errors are detected reliably.

So I decided to dig deeper and indeed in 
ftdi_sio.c:ftdi_process_packet() I found that if a parity error occurs, 
the error flag is set for all bytes of the current transfer (up to 64). 
This of course breaks my assumption that a parity error would mark only 
the affected byte.

But maybe the ftdi will generate a new transfer when an error occurs, so 
the flag is only valid for the first (last?) byte of the transfer.
So I tried this

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 49d1b2d..83fcb20 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -2112,7 +2112,9 @@ static int ftdi_process_packet(struct 
usb_serial_port *port,
                  tty_insert_flip_char(&port->port, *ch, flag);
          }
      } else {
-        tty_insert_flip_string_fixed_flag(&port->port, ch, flag, len);
+        /* report flag only for first char */
+        tty_insert_flip_string_fixed_flag(&port->port, ch, flag, 1);
+        tty_insert_flip_string_fixed_flag(&port->port, ch + 1, 
TTY_NORMAL, len - 1);
      }

      return len;

Only to discover that this flag being set only means that there is *at 
least* one parity error *anywhere* in the transfer.

This of course lowers the information content of this flag immensely.

Is this the indented behaviour/a limitation of the hardware? Or is there 
some way to query which bytes caused the error in more detail?

If not, is it maybe possible to restrict the transfer size to 1 byte 
from user space?

I unfortunately could not find the details of the protocol the file 
header claimed FTDI was so kind to provide :-)


[1] https://gist.github.com/benVolatiles/c0aa455d4ace0761537818efbaba40ff
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
