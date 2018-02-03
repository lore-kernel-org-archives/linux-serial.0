From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] serial: core: mark port as initialized in autoconfig
Date: Sat,  3 Feb 2018 12:27:23 +0100
Message-ID: <20180203112723.11129-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Johan Hovold <johan@kernel.org>, Nikola Ciprich <nikola.ciprich@linuxbox.cz>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This is a followup on 44117a1d1732 ("serial: core: mark port as
initialized after successful IRQ change").
Nikola has been using autoconfig via setserial and reported a crash
similar to what I fixed in the earlier mentioned commit. Here I do the
same fixup for the autoconfig. I wasn't sure that this is the right
approach. Nikola confirmed that it fixes his crash.

Fixes: b3b576461864 ("tty: serial_core: convert uart_open to use tty_port_o=
pen")
Link: http://lkml.kernel.org/r/20180131072000.GD1853@localhost.localdomain
Reported-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Tested-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Cc: Johan Hovold <johan@kernel.org>
Cc: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/serial_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_c=
ore.c
index c8dde56b532b..35b9201db3b4 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1144,6 +1144,8 @@ static int uart_do_autoconfig(struct tty_struct *tty,=
struct uart_state *state)
 		uport->ops->config_port(uport, flags);
=20
 		ret =3D uart_startup(tty, state, 1);
+		if (ret =3D=3D 0)
+			tty_port_set_initialized(port, true);
 		if (ret > 0)
 			ret =3D 0;
 	}
--=20
2.15.1
