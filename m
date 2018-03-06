From: <patrice.chotard@st.com>
Subject: [PATCH v2 3/3] tty: st-asc: Update tty alias
Date: Tue, 6 Mar 2018 09:07:30 +0100
Message-ID: <1520323650-11030-4-git-send-email-patrice.chotard@st.com>
References: <1520323650-11030-1-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520323650-11030-1-git-send-email-patrice.chotard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org
Cc: patrice.chotard@st.com
List-Id: linux-serial@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Since dtc v1.4.6-9-gaadd0b65c987, aliases property name
must include only lowercase and '-'.

After having updated all STi boards serial aliases from "ttyASN"
to "serialN", st-asc driver need to be updated accordingly as tty
aliases id is retrieved using of_alias_get_id(np, ASC_SERIAL_NAME);

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v2: _ update st-asc driver with "serial" alias prefix


 drivers/tty/serial/st-asc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index c763253514e9..f9372b690e54 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -29,7 +29,7 @@
 #include <linux/gpio/consumer.h>
 
 #define DRIVER_NAME "st-asc"
-#define ASC_SERIAL_NAME "ttyAS"
+#define ASC_SERIAL_NAME "serial"
 #define ASC_FIFO_SIZE 16
 #define ASC_MAX_PORTS 8
 
-- 
1.9.1
