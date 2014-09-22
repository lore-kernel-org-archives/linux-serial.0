From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH tty-next] serial: asc: Conditionally use readl_relaxed (COMPILE_TEST)
Date: Mon, 22 Sep 2014 15:16:07 +0100
Message-ID: <1411395367-17124-1-git-send-email-daniel.thompson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, linux-kernel@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, kernel@stlinux.com, linux-serial@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

Commit 08177ece596c ("serial: asc: Adopt readl_/writel_relaxed()) is
upsetting the build bots primarily because m68k allmodconfig builds
have regressed. This is due to the unconditional use of readl_relaxed()
which, although documented, does not currently exist for m68k.

This is trivially fixable for st-asc because we can just update the
asc_in() accessor to make this conditional.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
Cc: Maxime Coquelin <maxime.coquelin@st.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Jiri Slaby <jslaby@suse.cz>
---

Notes:
    Will Deacon is working on a patchset to introduce readl_relaxed (and
    writel_relaxed) to all platforms. I intend to keep an eye on this
    work and will remove the conditional code in asc_in/out() when this
    is possible.

 drivers/tty/serial/st-asc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index a3fc167..a316584 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -151,7 +151,11 @@ static inline struct asc_port *to_asc_port(struct uart_port *port)

 static inline u32 asc_in(struct uart_port *port, u32 offset)
 {
+#ifdef readl_relaxed
 	return readl_relaxed(port->membase + offset);
+#else
+	return readl(port->membase + offset);
+#endif
 }

 static inline void asc_out(struct uart_port *port, u32 offset, u32 value)
--
1.9.3
