From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Documentation about RS485 serial communications
Date: Tue, 16 Nov 2010 15:30:16 +0100
Message-ID: <20101116143016.GB6527@ucw.cz>
References: <20100408111310.524f7354@lxorguk.ukuu.org.uk>
	<4CBD8EE4.5040808@evidence.eu.com> <i9ka0s$4ua$1@dough.gmane.org>
	<201010191727.53314.alexander.stein@systec-electronic.com>
	<i9kk4o$svc$1@dough.gmane.org> <4CC418A9.6090602@evidence.eu.com>
	<4CDA630F.4060903@atmel.com> <20101110172842.GC12371@suse.de>
	<4CDBC3EC.6020707@evidence.eu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4CDBC3EC.6020707@evidence.eu.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Claudio Scordino <claudio@evidence.eu.com>
Cc: Grant Edwards <grant.b.edwards@gmail.com>, Greg KH <gregkh@suse.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi!

> Documentation about RS485 serial communications

I have seen hardware (kontron pmc-6l) that was capable of switching
between RS232, RS485 and one other standard by software.

Is such hw common? If so, should we have standard interface?

> +   From user-level, RS485 configuration can be get/set using the previous
> +   ioctls. For instance, to set RS485 you can use the following code:
> +
> +	#include <linux/serial.h>
> +
> +	/* Driver-specific ioctls: */
> +	#define TIOCGRS485      0x542E
> +	#define TIOCSRS485      0x542F
> +
> +	/* Open your specific device (e.g., /dev/mydevice): */
> +	int fd = open ("/dev/mydevice", O_RDWR);
> +	if (fd < 0) {
> +		/* Error handling. See errno. */
> +	}
> +
> +	struct serial_rs485 rs485conf;
> +
> +	/* Set RS485 mode: */
> +	rs485conf.flags |= SER_RS485_ENABLED;

IOW... is this supposed to switch electrical levels?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
