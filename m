From: Joe Perches <joe@perches.com>
Subject: [PATCH] checkpatch: Add uart_ops to normally const structs
Date: Sat, 04 Apr 2015 10:47:31 -0700
Message-ID: <1428169651.2775.51.camel@perches.com>
References: <1428080481-18591-1-git-send-email-mcoquelin.stm32@gmail.com>
	 <1428080481-18591-11-git-send-email-mcoquelin.stm32@gmail.com>
	 <1428083006.13180.35.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428083006.13180.35.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Whitcroft <apw@shadowen.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Add another struct to the list of normally const struct types

Signed-off-by: Joe Perches <joe@perches.com>
---

On Fri, 2015-04-03 at 10:43 -0700, Joe Perches wrote:
> On Fri, 2015-04-03 at 19:01 +0200, Maxime Coquelin wrote:
> > This drivers adds support to the STM32 USART controller, which is a
> > standard serial driver.
> trivia:
> > diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> []
> > +static struct uart_ops stm32_uart_ops = {
> could be const
> and it could be updated in a separate patch later too.

 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9a8b2bd..db3dcf5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5338,6 +5338,7 @@ sub process {
 				stacktrace_ops|
 				sysfs_ops|
 				tty_operations|
+				uart_ops|
 				usb_mon_operations|
 				wd_ops}x;
 		if ($line !~ /\bconst\b/ &&
