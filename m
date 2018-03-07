From: <patrice.chotard@st.com>
Subject: [PATCH v3 3/3] tty: st-asc: Update tty alias
Date: Wed, 7 Mar 2018 09:49:57 +0100
Message-ID: <1520412597-30545-4-git-send-email-patrice.chotard@st.com>
References: <1520412597-30545-1-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520412597-30545-1-git-send-email-patrice.chotard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org
Cc: patrice.chotard@st.com
List-Id: linux-serial@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Since dtc v1.4.6-9-gaadd0b65c987, aliases property name
must include only lowercase and '-'.

After having updated all STi boards serial aliases from "ttyASN"
to "serialN", st-asc driver need to be updated accordingly as tty
aliases id is retrieved using of_alias_get_id().

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
v3: _ update st-asc driver with "serial" alias prefix and keep "ttyAS" in second choice
v2: _ update st-asc driver with "serial" alias prefix

 drivers/tty/serial/st-asc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index c763253514e9..5f9f01fac6dd 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -782,7 +782,9 @@ static struct asc_port *asc_of_get_asc_port(struct platform_device *pdev)
 	if (!np)
 		return NULL;
 
-	id = of_alias_get_id(np, ASC_SERIAL_NAME);
+	id = of_alias_get_id(np, "serial");
+	if (id < 0)
+		id = of_alias_get_id(np, ASC_SERIAL_NAME);
 
 	if (id < 0)
 		id = 0;
-- 
1.9.1
