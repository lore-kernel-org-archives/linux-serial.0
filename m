From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH tty] serial: 8250: pericom_do_set_divisor can be static
Date: Tue, 18 Jun 2019 19:23:51 +0800
Message-ID: <20190618112351.GA31802@lkp-kbuild18>
References: <201906181948.HzE13NAX%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201906181948.HzE13NAX%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jay Dolan <jay.dolan@accesio.com>
Cc: kbuild-all@01.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


Fixes: 6bf4e42f1d19 ("serial: 8250: Add support for higher baud rates to Pericom chips")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 8250_pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 7ba1c3b..7f740b3 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1326,7 +1326,7 @@ static int pci_default_setup(struct serial_private *priv,
 
 	return setup_port(priv, port, bar, offset, board->reg_shift);
 }
-void
+static void
 pericom_do_set_divisor(struct uart_port *port, unsigned int baud,
 			       unsigned int quot, unsigned int quot_frac)
 {
