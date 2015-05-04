From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] Documentation/magic-number: Remove SCC_MAGIC
Date: Mon,  4 May 2015 19:39:51 +0200
Message-ID: <1430761191-23663-2-git-send-email-geert+renesas@glider.be>
References: <1430761191-23663-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1430761191-23663-1-git-send-email-geert+renesas@glider.be>
Sender: linux-doc-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Harry Wei <harryxiyou@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@zh-kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The SCC_MAGIC define was removed in commit 1ec3ba93c5fad9dc ("Staging:
remove drivers/char/scc.h as it should have gone a while ago"), while
its actual last user was removed before in commit bb2a97e9ccd525dd
("Staging: delete generic_serial drivers").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/magic-number.txt       | 1 -
 Documentation/zh_CN/magic-number.txt | 1 -
 2 files changed, 2 deletions(-)

diff --git a/Documentation/magic-number.txt b/Documentation/magic-number.txt
index d9af851a6f2056bc..28befed9f6102a09 100644
--- a/Documentation/magic-number.txt
+++ b/Documentation/magic-number.txt
@@ -116,7 +116,6 @@ COW_MAGIC             0x4f4f4f4d  cow_header_v1     arch/um/drivers/ubd_user.c
 I810_CARD_MAGIC       0x5072696E  i810_card         sound/oss/i810_audio.c
 TRIDENT_CARD_MAGIC    0x5072696E  trident_card      sound/oss/trident.c
 ROUTER_MAGIC          0x524d4157  wan_device        [in wanrouter.h pre 3.9]
-SCC_MAGIC             0x52696368  gs_port           drivers/char/scc.h
 SAVEKMSG_MAGIC1       0x53415645  savekmsg          arch/*/amiga/config.c
 GDA_MAGIC             0x58464552  gda               arch/mips/include/asm/sn/gda.h
 RED_MAGIC1            0x5a2cf071  (any)             mm/slab.c
diff --git a/Documentation/zh_CN/magic-number.txt b/Documentation/zh_CN/magic-number.txt
index c2607a69a72743a5..e9db693c0a2302d2 100644
--- a/Documentation/zh_CN/magic-number.txt
+++ b/Documentation/zh_CN/magic-number.txt
@@ -116,7 +116,6 @@ COW_MAGIC             0x4f4f4f4d  cow_header_v1     arch/um/drivers/ubd_user.c
 I810_CARD_MAGIC       0x5072696E  i810_card         sound/oss/i810_audio.c
 TRIDENT_CARD_MAGIC    0x5072696E  trident_card      sound/oss/trident.c
 ROUTER_MAGIC          0x524d4157  wan_device        [in wanrouter.h pre 3.9]
-SCC_MAGIC             0x52696368  gs_port           drivers/char/scc.h
 SAVEKMSG_MAGIC1       0x53415645  savekmsg          arch/*/amiga/config.c
 GDA_MAGIC             0x58464552  gda               arch/mips/include/asm/sn/gda.h
 RED_MAGIC1            0x5a2cf071  (any)             mm/slab.c
-- 
1.9.1

