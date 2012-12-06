From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 1/2] ACPI: break out the states from the ACPI types
Date: Thu, 6 Dec 2012 19:46:36 +0100
Message-ID: <1354819596-2355-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, "Rafael J.  Wysocki" <rjw@sisk.pl>
Cc: Alan Cox <alan@linux.intel.com>, Rickard Andersson <rickard.andersson@stericsson.com>, linux-acpi@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-serial@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

The ACPI states are used by the serial core by way of magic numbers
in the code, it's pretty confusing, so we need to reference the
definitions from the actual ACPI includes.

This breaks out the state definitons. The entire <acpi/actypes.h>
include can not be used since that file will not compile for a
machine that is not using ACPI due to things like this:

  #ifndef ACPI_MACHINE_WIDTH
  #error ACPI_MACHINE_WIDTH not defined
  #endif

So just break it out, include it back into the original file and
be done with it. After this the serial core can piggyback the
actual state definitions from the ACPI subsystem.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/acpi/acstates.h | 32 ++++++++++++++++++++++++++++++++
 include/acpi/actypes.h  | 32 ++------------------------------
 2 files changed, 34 insertions(+), 30 deletions(-)
 create mode 100644 include/acpi/acstates.h

diff --git a/include/acpi/acstates.h b/include/acpi/acstates.h
new file mode 100644
index 0000000..fe73f6c
--- /dev/null
+++ b/include/acpi/acstates.h
@@ -0,0 +1,32 @@
+/*
+ * Power state values
+ *
+ * These defines are used by subsystems that are not necessarily
+ * tied in to using ACPI.
+ */
+#define ACPI_STATE_UNKNOWN              (u8) 0xFF
+
+#define ACPI_STATE_S0                   (u8) 0
+#define ACPI_STATE_S1                   (u8) 1
+#define ACPI_STATE_S2                   (u8) 2
+#define ACPI_STATE_S3                   (u8) 3
+#define ACPI_STATE_S4                   (u8) 4
+#define ACPI_STATE_S5                   (u8) 5
+#define ACPI_S_STATES_MAX               ACPI_STATE_S5
+#define ACPI_S_STATE_COUNT              6
+
+#define ACPI_STATE_D0                   (u8) 0
+#define ACPI_STATE_D1                   (u8) 1
+#define ACPI_STATE_D2                   (u8) 2
+#define ACPI_STATE_D3_HOT               (u8) 3
+#define ACPI_STATE_D3                   (u8) 4
+#define ACPI_STATE_D3_COLD              ACPI_STATE_D3
+#define ACPI_D_STATES_MAX               ACPI_STATE_D3
+#define ACPI_D_STATE_COUNT              5
+
+#define ACPI_STATE_C0                   (u8) 0
+#define ACPI_STATE_C1                   (u8) 1
+#define ACPI_STATE_C2                   (u8) 2
+#define ACPI_STATE_C3                   (u8) 3
+#define ACPI_C_STATES_MAX               ACPI_STATE_C3
+#define ACPI_C_STATE_COUNT              4
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 4f43f1f..29d6c46 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -44,6 +44,8 @@
 #ifndef __ACTYPES_H__
 #define __ACTYPES_H__
 
+#include "acstates.h"
+
 /* acpisrc:struct_defs -- for acpisrc conversion */
 
 /*
@@ -487,36 +489,6 @@ typedef u64 acpi_integer;
 #define ACPI_INITIALIZED_OK             0x02
 
 /*
- * Power state values
- */
-#define ACPI_STATE_UNKNOWN              (u8) 0xFF
-
-#define ACPI_STATE_S0                   (u8) 0
-#define ACPI_STATE_S1                   (u8) 1
-#define ACPI_STATE_S2                   (u8) 2
-#define ACPI_STATE_S3                   (u8) 3
-#define ACPI_STATE_S4                   (u8) 4
-#define ACPI_STATE_S5                   (u8) 5
-#define ACPI_S_STATES_MAX               ACPI_STATE_S5
-#define ACPI_S_STATE_COUNT              6
-
-#define ACPI_STATE_D0                   (u8) 0
-#define ACPI_STATE_D1                   (u8) 1
-#define ACPI_STATE_D2                   (u8) 2
-#define ACPI_STATE_D3_HOT               (u8) 3
-#define ACPI_STATE_D3                   (u8) 4
-#define ACPI_STATE_D3_COLD              ACPI_STATE_D3
-#define ACPI_D_STATES_MAX               ACPI_STATE_D3
-#define ACPI_D_STATE_COUNT              5
-
-#define ACPI_STATE_C0                   (u8) 0
-#define ACPI_STATE_C1                   (u8) 1
-#define ACPI_STATE_C2                   (u8) 2
-#define ACPI_STATE_C3                   (u8) 3
-#define ACPI_C_STATES_MAX               ACPI_STATE_C3
-#define ACPI_C_STATE_COUNT              4
-
-/*
  * Sleep type invalid value
  */
 #define ACPI_SLEEP_TYPE_MAX             0x7
-- 
1.7.11.3

