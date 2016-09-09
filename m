From: Rob Herring <robh@kernel.org>
Subject: [PATCH 6/9] tty: serial_core: introduce tty_port_to_uart_state
Date: Fri,  9 Sep 2016 17:37:07 -0500
Message-ID: <20160909223711.26238-7-robh@kernel.org>
References: <20160909223711.26238-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160909223711.26238-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The uart_state is a container of tty_port. Add an inline to convert
tty_port ptr to uart_state ptr and convert existing container_of users.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/tty/serial/serial_core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index d48ea0a98e92..29eef4644e98 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -93,6 +93,11 @@ static inline void uart_port_deref(struct uart_port *uport)
 		uart_port_deref(__uport);				\
 	})
 
+static inline struct uart_state *tty_port_to_uart_state(struct tty_port *port)
+{
+	return container_of(port, struct uart_state, port);
+}
+
 static inline struct uart_port *uart_port_check(struct uart_state *state)
 {
 	lockdep_assert_held(&state->port.mutex);
@@ -720,7 +725,7 @@ static void uart_unthrottle(struct tty_struct *tty)
 
 static int uart_get_info(struct tty_port *port, struct serial_struct *retinfo)
 {
-	struct uart_state *state = container_of(port, struct uart_state, port);
+	struct uart_state *state = tty_port_to_uart_state(port);
 	struct uart_port *uport;
 	int ret = -ENODEV;
 
@@ -1603,7 +1608,7 @@ static void uart_hangup(struct tty_struct *tty)
 /* uport == NULL if uart_port has already been removed */
 static void uart_port_shutdown(struct tty_port *port)
 {
-	struct uart_state *state = container_of(port, struct uart_state, port);
+	struct uart_state *state = tty_port_to_uart_state(port);
 	struct uart_port *uport = uart_port_check(state);
 
 	/*
@@ -1630,7 +1635,7 @@ static void uart_port_shutdown(struct tty_port *port)
 
 static int uart_carrier_raised(struct tty_port *port)
 {
-	struct uart_state *state = container_of(port, struct uart_state, port);
+	struct uart_state *state = tty_port_to_uart_state(port);
 	struct uart_port *uport;
 	int mctrl;
 
@@ -1655,7 +1660,7 @@ static int uart_carrier_raised(struct tty_port *port)
 
 static void uart_dtr_rts(struct tty_port *port, int onoff)
 {
-	struct uart_state *state = container_of(port, struct uart_state, port);
+	struct uart_state *state = tty_port_to_uart_state(port);
 	struct uart_port *uport;
 
 	uport = uart_port_ref(state);
-- 
2.9.3
