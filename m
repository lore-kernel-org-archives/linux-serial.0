From: Zhang Zhen <zhenzhang.zhang@huawei.com>
Subject: [PATCH] serial: 8250: fix a sparse warning
Date: Mon, 9 Mar 2015 15:42:30 +0800
Message-ID: <54FD4EE6.7000408@huawei.com>
References: <1425886615-78601-1-git-send-email-zhenzhang.zhang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425886615-78601-1-git-send-email-zhenzhang.zhang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tim.kryger@linaro.org, gregkh@linuxfoundation.org, jamie@jamieiles.com, alan@linux.intel.com, arnd@arndb.de
List-Id: linux-serial@vger.kernel.org

drivers/tty/serial/8250/8250_core.c: In function =E2=80=98serial8250_co=
nsole_write=E2=80=99:
drivers/tty/serial/8250/8250_core.c:3244: warning: =E2=80=98flags=E2=80=
=99 may be used u
unitialized in this function

Signed-off-by: Zhang Zhen <zhenzhang.zhang@huawei.com>
---
 drivers/tty/serial/8250/8250_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8=
250/8250_core.c
index deae122..50702e2 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -3241,7 +3241,7 @@ serial8250_console_write(struct console *co, cons=
t char *s, unsigned int count)
 {
 	struct uart_8250_port *up =3D &serial8250_ports[co->index];
 	struct uart_port *port =3D &up->port;
-	unsigned long flags;
+	unsigned long flags =3D 0;
 	unsigned int ier;
 	int locked =3D 1;

--=20
1.8.5.5


=2E
