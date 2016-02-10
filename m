From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 1/2] serial: 8250: fix building mediatek with SERIAL_8250=m
Date: Wed, 10 Feb 2016 20:52:11 +0100
Message-ID: <7590955.HIrRGSSVmH@wuerfel>
References: <1454935947-2743255-1-git-send-email-arnd@arndb.de>
 <56BB7C23.5070600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <56BB7C23.5070600-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Matt Redfearn <matt.redfearn-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wednesday 10 February 2016 19:06:27 Matthias Brugger wrote:
> > ---
> 
> I tried this with:
> commit 2178cbc68f3602dc0b5949b9be2c8383ad3d93ef
> 
> $ grep 8250 .config
> CONFIG_SERIAL_8250=m
> # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> CONFIG_SERIAL_8250_PCI=m
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> # CONFIG_SERIAL_8250_EXTENDED is not set
> # CONFIG_SERIAL_8250_DW is not set
> # CONFIG_SERIAL_8250_RT288X is not set
> CONFIG_SERIAL_8250_MT6577=y
> # CONFIG_SERIAL_8250_INGENIC is not set
> # CONFIG_SERIAL_8250_MID is not set
> 
> $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- drivers/tty/
> 
> compiles just fine.
> 
> Do I missing something?
> 

I was simplifying the situation in the patch description: When CONFIG_SERIAL_8250=m,
Kbuild does not actually descend into drivers/tty/serial/8250/ while building
built-in code, so none of the built-in subdrivers actually get built.

After spotting the problem, I was building with this patch that I considered
submitting:

diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index ceba33c4ebb4..28121885e78e 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_SERIAL_SUNSU) += sunsu.o
 obj-$(CONFIG_SERIAL_SUNSAB) += sunsab.o
 
 # Now bring in any enabled 8250/16450/16550 type drivers.
-obj-$(CONFIG_SERIAL_8250) += 8250/
+obj-y += 8250/
 
 obj-$(CONFIG_SERIAL_AMBA_PL010) += amba-pl010.o
 obj-$(CONFIG_SERIAL_AMBA_PL011) += amba-pl011.o

However, after the other problems are fixed, it's not actually needed
any more, so I did not submit it.

	Arnd
