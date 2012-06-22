From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 07/12] 8250: propogate the bugs field
Date: Fri, 22 Jun 2012 16:44:08 +0100
Message-ID: <20120622154402.1405.86889.stgit@localhost.localdomain>
References: <20120622153600.1405.15575.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120622153600.1405.15575.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: greg@kroah.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Now we are using the uart_8250_port this is trivial

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/serial/8250/8250.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index 5e3f6a3..779d791 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -3147,6 +3147,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		uart->port.regshift     = up->port.regshift;
 		uart->port.iotype       = up->port.iotype;
 		uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;
+		uart->bugs		= up->bugs;
 		uart->port.mapbase      = up->port.mapbase;
 		uart->port.private_data = up->port.private_data;
 		if (up->port.dev)
