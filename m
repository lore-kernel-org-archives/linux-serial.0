From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] Documentation/magic-number: Remove SCI_MAGIC
Date: Mon,  4 May 2015 19:39:50 +0200
Message-ID: <1430761191-23663-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Harry Wei <harryxiyou@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@zh-kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The SCI_MAGIC define was removed in commit f8e53553f452dcbf ("serial:
sh-sci: Kill off more unused defines.").
Its last user was the old drivers/char sh-sci driver, which was removed
in 2004.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/magic-number.txt       | 1 -
 Documentation/zh_CN/magic-number.txt | 1 -
 2 files changed, 2 deletions(-)

diff --git a/Documentation/magic-number.txt b/Documentation/magic-number.txt
index 4c8e142db2ef99fe..d9af851a6f2056bc 100644
--- a/Documentation/magic-number.txt
+++ b/Documentation/magic-number.txt
@@ -138,7 +138,6 @@ KMALLOC_MAGIC         0x87654321  snd_alloc_track   sound/core/memory.c
 PWC_MAGIC             0x89DC10AB  pwc_device        drivers/usb/media/pwc.h
 NBD_REPLY_MAGIC       0x96744668  nbd_reply         include/linux/nbd.h
 ENI155_MAGIC          0xa54b872d  midway_eprom	    drivers/atm/eni.h
-SCI_MAGIC             0xbabeface  gs_port           drivers/char/sh-sci.h
 CODA_MAGIC            0xC0DAC0DA  coda_file_info    fs/coda/coda_fs_i.h
 DPMEM_MAGIC           0xc0ffee11  gdt_pci_sram      drivers/scsi/gdth.h
 YAM_MAGIC             0xF10A7654  yam_port          drivers/net/hamradio/yam.c
diff --git a/Documentation/zh_CN/magic-number.txt b/Documentation/zh_CN/magic-number.txt
index dfb72a5c63e9ba63..c2607a69a72743a5 100644
--- a/Documentation/zh_CN/magic-number.txt
+++ b/Documentation/zh_CN/magic-number.txt
@@ -138,7 +138,6 @@ KMALLOC_MAGIC         0x87654321  snd_alloc_track   sound/core/memory.c
 PWC_MAGIC             0x89DC10AB  pwc_device        drivers/usb/media/pwc.h
 NBD_REPLY_MAGIC       0x96744668  nbd_reply         include/linux/nbd.h
 ENI155_MAGIC          0xa54b872d  midway_eprom	    drivers/atm/eni.h
-SCI_MAGIC             0xbabeface  gs_port           drivers/char/sh-sci.h
 CODA_MAGIC            0xC0DAC0DA  coda_file_info    include/linux/coda_fs_i.h
 DPMEM_MAGIC           0xc0ffee11  gdt_pci_sram      drivers/scsi/gdth.h
 YAM_MAGIC             0xF10A7654  yam_port          drivers/net/hamradio/yam.c
-- 
1.9.1

