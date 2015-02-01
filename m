From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 1/4] tty: serial: Add 8250 earlycon to support noinit
 option
Date: Sun, 01 Feb 2015 13:26:33 -0500
Message-ID: <54CE6FD9.5030606@hurleysoftware.com>
References: <1421068104-30463-1-git-send-email-eddie.huang@mediatek.com> <1421068104-30463-2-git-send-email-eddie.huang@mediatek.com> <54CE53F3.5040709@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54CE53F3.5040709-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vladimir Murzin <vladimir.murzin-5wv7dgnIgG8@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yh.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Howard Chen <ibanezchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ashwin Chaugule <ashwin.chaugule-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Joe.C" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On 02/01/2015 11:27 AM, Peter Hurley wrote:
> Hi Eddie,
> 
> On 01/12/2015 08:08 AM, Eddie Huang wrote:
>> Add earlycon support not only baudrate option, but also add noinit option.
>> If use noinit option, 8250 earlycon will not init serial hardware and use
>> loader setting.
> 
> I see this went into Greg's tty-testing branch.
> 
> The only point of this is to not program the divisor, right?
> 
> I ask because early_serial8250_setup() could already handle this without
> extra options by simply not doing divisor programming if no baud option is
> present.

Does the patch below work for your use-case?

[ Note: the patch applies to 3.19-rcX. To test, your noinit patches need to be
  reverted first.
]

--- >% ---
From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: [PATCH] serial: 8250_early: Assume uart already initialized if no
 baud option

The <baud><parity><bit> option string is not supplied if the earlycon
is started via devicetree and OF_EARLYCON_DECLARE(). The option string
is also not required if started via kernel command line parameters of
the form:
  earlycon=uart,mmio,<addr>
  console=uart,mmio,<addr>

If earlycon_device->baud is 0, then an option string was not supplied.
In this case, assume the uart has already been initialized by the
bootloader or firmware.

Signed-off-by: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
---
 drivers/tty/serial/8250/8250_early.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index d7b831b..1701d00 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -149,12 +149,18 @@ static int __init early_serial8250_setup(struct earlycon_device *device,
 		return 0;
 
 	if (!device->baud) {
+		struct uart_port *port = &device->port;
+		unsigned int ier;
+
 		device->baud = probe_baud(&device->port);
 		snprintf(device->options, sizeof(device->options), "%u",
 			 device->baud);
-	}
 
-	init_port(device);
+		/* assume the device was initialized, only mask interrupts */
+		ier = serial8250_early_in(port, UART_IER);
+		serial8250_early_out(port, UART_IER, ier & UART_IER_UUE);
+	} else
+		init_port(device);
 
 	device->con->write = early_serial8250_write;
 	return 0;
-- 
2.2.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
