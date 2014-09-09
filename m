From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH 3.17-rc3 v2] serial: asc: Adopt readl_/writel_relaxed()
Date: Tue,  9 Sep 2014 11:03:57 +0100
Message-ID: <1410257037-20030-1-git-send-email-daniel.thompson@linaro.org>
References: <1409745651-3247-1-git-send-email-daniel.thompson@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34881 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904AbaIIKEM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 9 Sep 2014 06:04:12 -0400
Received: by mail-wg0-f44.google.com with SMTP id y10so2405558wgg.15
        for <linux-serial@vger.kernel.org>; Tue, 09 Sep 2014 03:04:11 -0700 (PDT)
In-Reply-To: <1409745651-3247-1-git-send-email-daniel.thompson@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, linux-kernel@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, Jiri Slaby <jslaby@suse.cz>, kernel@stlinux.com, linux-serial@vger.kernel.org

The architectures supported by this driver, arm and sh, have expensive
implementations of writel(), reliant on spin locks and explicit L2 cache
management. These architectures provide a cheaper writel_relaxed() which
is much better suited to peripherals that do not perform DMA. The
situation with readl()/readl_relaxed()is similar although less acute.

This driver does not use DMA and will be more power efficient and more
robust (due to absence of spin locks during console I/O) if it uses the
relaxed variants.

The driver supports COMPILE_TEST and therefore falls back to writel()
when writel_relaxed() does not exist.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
Cc: Maxime Coquelin <maxime.coquelin@st.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: kernel@stlinux.com
Cc: linux-serial@vger.kernel.org
---

Notes:
    Changes since v1:
    
    * Added fallback to writel() to permit COMPILE_TESTing (review
      of Greg Kroah-Hartmam).

 drivers/tty/serial/st-asc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 8b2d735..a3fc167 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -151,12 +151,16 @@ static inline struct asc_port *to_asc_port(struct uart_port *port)

 static inline u32 asc_in(struct uart_port *port, u32 offset)
 {
-	return readl(port->membase + offset);
+	return readl_relaxed(port->membase + offset);
 }

 static inline void asc_out(struct uart_port *port, u32 offset, u32 value)
 {
+#ifdef writel_relaxed
+	writel_relaxed(value, port->membase + offset);
+#else
 	writel(value, port->membase + offset);
+#endif
 }

 /*
--
1.9.3

