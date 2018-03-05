From: <patrice.chotard@st.com>
Subject: [PATCH 2/2] tty: st-asc: Convert tty alias in lowercase
Date: Mon, 5 Mar 2018 16:00:25 +0100
Message-ID: <1520262025-21088-3-git-send-email-patrice.chotard@st.com>
References: <1520262025-21088-1-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1520262025-21088-1-git-send-email-patrice.chotard@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org
Cc: patrice.chotard@st.com
List-Id: linux-serial@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Since dtc v1.4.6-9-gaadd0b65c987, aliases property name
must include only lowercase and '-'.

After having converted all STi boards serial aliases in lowercase,
st-asc driver need to be updated accordingly as tty aliases id is
retrieved using of_alias_get_id(np, ASC_SERIAL_NAME);

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/tty/serial/st-asc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index c763253514e9..8d2167759258 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -29,7 +29,7 @@
 #include <linux/gpio/consumer.h>
 
 #define DRIVER_NAME "st-asc"
-#define ASC_SERIAL_NAME "ttyAS"
+#define ASC_SERIAL_NAME "ttyas"
 #define ASC_FIFO_SIZE 16
 #define ASC_MAX_PORTS 8
 
-- 
1.9.1
