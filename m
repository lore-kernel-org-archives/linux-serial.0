From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH][SERIAL] serial_core.h: Fix compilation error
Date: Thu,  8 Nov 2007 23:45:52 +0100
Message-ID: <1194561952-18175-1-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v32413.1blu.de ([88.84.155.73]:59482 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872AbXKHXE0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Nov 2007 18:04:26 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Frank Lichtenheld <frank@lichtenheld.de>

struct uart_port only has a sysrq member if SERIAL_CORE_CONSOLE is defi=
ned, so
don't try to use it if it isn't (e.g. if using allmodconfig).

  CC [M]  drivers/serial/mux.o
In file included from drivers/serial/mux.c:37:
include/linux/serial_core.h: In function =E2=80=98uart_handle_sysrq_cha=
r=E2=80=99:
include/linux/serial_core.h:438: error: =E2=80=98struct uart_port=E2=80=
=99 has no member named =E2=80=98sysrq=E2=80=99
include/linux/serial_core.h:439: error: =E2=80=98struct uart_port=E2=80=
=99 has no member named =E2=80=98sysrq=E2=80=99
include/linux/serial_core.h:439: warning: type defaults to =E2=80=98int=
=E2=80=99 in declaration of =E2=80=98__dummy2=E2=80=99
include/linux/serial_core.h:439: warning: comparison of distinct pointe=
r types lacks a cast
include/linux/serial_core.h:439: error: =E2=80=98struct uart_port=E2=80=
=99 has no member named =E2=80=98sysrq=E2=80=99
include/linux/serial_core.h:441: error: =E2=80=98struct uart_port=E2=80=
=99 has no member named =E2=80=98sysrq=E2=80=99
include/linux/serial_core.h:444: error: =E2=80=98struct uart_port=E2=80=
=99 has no member named =E2=80=98sysrq=E2=80=99
include/linux/serial_core.h: In function =E2=80=98uart_handle_break=E2=80=
=99:
include/linux/serial_core.h:461: error: =E2=80=98struct uart_port=E2=80=
=99 has no member named =E2=80=98sysrq=E2=80=99
include/linux/serial_core.h:462: error: =E2=80=98struct uart_port=E2=80=
=99 has no member named =E2=80=98sysrq=E2=80=99
include/linux/serial_core.h:465: error: =E2=80=98struct uart_port=E2=80=
=99 has no member named =E2=80=98sysrq=E2=80=99

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 include/linux/serial_core.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 6a5203f..e2233a8 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -434,7 +434,7 @@ int uart_resume_port(struct uart_driver *reg, struc=
t uart_port *port);
 static inline int
 uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
 {
-#ifdef SUPPORT_SYSRQ
+#if defined(SUPPORT_SYSRQ) && defined(CONFIG_SERIAL_CORE_CONSOLE)
 	if (port->sysrq) {
 		if (ch && time_before(jiffies, port->sysrq)) {
 			handle_sysrq(ch, port->info->tty);
@@ -456,7 +456,7 @@ uart_handle_sysrq_char(struct uart_port *port, unsi=
gned int ch)
 static inline int uart_handle_break(struct uart_port *port)
 {
 	struct uart_info *info =3D port->info;
-#ifdef SUPPORT_SYSRQ
+#if defined(SUPPORT_SYSRQ) && defined(CONFIG_SERIAL_CORE_CONSOLE)
 	if (port->cons && port->cons->index =3D=3D port->line) {
 		if (!port->sysrq) {
 			port->sysrq =3D jiffies + HZ*5;
--=20
1.5.3.4

-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
