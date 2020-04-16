Return-Path: <SRS0=wizI=6A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C80FC38A29
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 04:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14E8C20771
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 04:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osz1QjWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405031AbgDPE5B (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Apr 2020 00:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404917AbgDPE4o (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Apr 2020 00:56:44 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51B1C061A0C;
        Wed, 15 Apr 2020 21:56:44 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mn19so861501pjb.0;
        Wed, 15 Apr 2020 21:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I4hh3tdIwmqTA+P7Mh6QQf08XRXoSBfsV04VwlvRsm4=;
        b=osz1QjWp1020irer65rpMPe/ErPjohr62ViZLGMjJ/vOpgdDd2LTAN9KCF5SI7yGX2
         F/cHV4JjKaN+prk5Cw6yBil/ylbm09KEb4VTRhcIkUAWmmG7W5vMf+u1zCM66azl2x08
         hXP17++Yvyk+ZmkIw0lVx3Qun0hVaJeJVgCqvxXNmWwlVy7GsMzrMuYrWOEkE6IhkGWa
         w0+8XhXRpzCvoYgx/WRPLaru4a+YwTEoeLdnm9y6xHLVPULPooJvRw47b4YoolLIYttd
         4Y9mpPUk5UL9K9uyOO3HSGRlgKdBDCmFzLpbk4jEUshHHXo/+0cQSijuRP3l6rarucUP
         9uVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I4hh3tdIwmqTA+P7Mh6QQf08XRXoSBfsV04VwlvRsm4=;
        b=F8gv/bfouAphwW3dx7RM8lqEHih3+DqGg4qFXBfLPzfOlnu/GiHFhnyUz9wbR/mndh
         hxFDRhXZkn47aLgHRZn+gu/IsBKSbtaOmW8I0G0WCZY2ENnLxaI1mbOyevsTiNcrcs9y
         hdxQUVil8S6xmvl00HWWIFGsZmTV7azuzk8PSzFFLQKHH1luKCPLasUfDMYHVlG7N7H1
         QCyDZtcz3R8t6CP4O8ZrT/RWd6xsBPw5XvAOrFWhnRXZRvEX2ajuEEm0h2ClW7c4yBQY
         MDAkPtcfvSYVfQMRShXRpwLz0Pn22Tqp0GUKAlPbFTK5ySip0QS/VbNGKA2cPEOvC46T
         AoQg==
X-Gm-Message-State: AGi0PuYUEIqdTSyD4UfQ9tAxtGbVmLH2+MZXvQSrm5Pk0RVwR2MUKBAY
        WZsBUH+U06rqD+R2m4E9NROKZqM2fOU=
X-Google-Smtp-Source: APiQypLiDdJh3uL5k9HSyRBucAN0GYaopPR1JAHaV1BJbfJIFKENrxfk/JbPvqbesWthwdODSoIVCQ==
X-Received: by 2002:a17:902:222:: with SMTP id 31mr8442036plc.108.1587013004236;
        Wed, 15 Apr 2020 21:56:44 -0700 (PDT)
Received: from localhost.localdomain ([183.82.182.213])
        by smtp.gmail.com with ESMTPSA id 3sm4749198pgh.75.2020.04.15.21.56.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 21:56:43 -0700 (PDT)
From:   Rishi Gupta <gupt21@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, robh+dt@kernel.org,
        corbet@lwn.net, andriy.shevchenko@linux.intel.com
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH v3 4/4] tty: documentation: document how to use ttyvs driver
Date:   Thu, 16 Apr 2020 10:26:14 +0530
Message-Id: <1587012974-21219-4-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587012974-21219-1-git-send-email-gupt21@gmail.com>
References: <1587012974-21219-1-git-send-email-gupt21@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The commit documents how to use ttyvs driver to create/delete
virtual tty devices, how to emulate various serial port events
through this driver etc.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
Changes in v3:
- Rebased on top of v5.7-rc1
- Moved virtual-tty-ttyvs.rst from Documentation/virtual to Documentation/admin-guide

Changes in v2:
- Added this file from v2 only

 Documentation/admin-guide/index.rst             |   1 +
 Documentation/admin-guide/virtual-tty-ttyvs.rst | 142 ++++++++++++++++++++++++
 2 files changed, 143 insertions(+)
 create mode 100644 Documentation/admin-guide/virtual-tty-ttyvs.rst

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 5a6269f..9a72fb8 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -50,6 +50,7 @@ ABI will be found here.
    :maxdepth: 1
 
    sysfs-rules
+   virtual-tty-ttyvs
 
 The rest of this manual consists of various unordered guides on how to
 configure specific aspects of kernel behavior to your liking.
diff --git a/Documentation/admin-guide/virtual-tty-ttyvs.rst b/Documentation/admin-guide/virtual-tty-ttyvs.rst
new file mode 100644
index 0000000..c30b768
--- /dev/null
+++ b/Documentation/admin-guide/virtual-tty-ttyvs.rst
@@ -0,0 +1,142 @@
+================================================
+Kernel driver for virtual tty null modem devices
+================================================
+
+Author: Rishi Gupta <gupt21@gmail.com>
+
+The ttyvs driver (drivers/tty/ttyvs.c) creates virtual tty devices
+that can be used with standard POSIX APIs for terminal devices.
+
+Applications can write to the sysfs file provided by this driver to
+emulate various serial port communication events and error conditions.
+
+This driver creates a virtual card which can have 0 to 65535 virtual
+tty devices.
+
+Use cases
+=========
+- Automated performance and scalability testing
+- Serial port redirector to any other subsystem like TCP/IP
+- Feeding data to GPS simulator
+- Segregating hardware issues from software bugs quickly
+- Serial port communication sniffer or test sniffer application itself
+- Application development when hardware is still not available
+- Testing user space drivers & corner case by injecting handcrafted data
+- Migrate binary only or legacy applications to new communication medium
+- Analyze and reverse-engineer serial protocols
+- Cases where socat utility does not meet requirements for unix-like OS
+- Cases where available physical serial ports don't meet requirements
+- Product demo where data from hardware needs to be sent to the GUI app
+- Stress and corner case testing of user space application
+
+How to create devices
+=====================
+There are two ways to create devices:
+
+1. Using device tree:
+The card is modelled as a node with zero or more child nodes each
+representing a virtual tty device. To create a device simply define
+a child node with the required device parameters. This is explained
+in detail in DT binding file:
+Documentation/devicetree/bindings/serial/ttyvs.yaml
+
+2. Using configfs:
+When ttyvs driver is loaded, it will create ttyvs directory inside
+configfs mount point. For ex; if configfs is mounted at /config, then
+/config/ttyvs directory will be created. To create a device, simply
+create directory inside this, write values to be used as device
+parameters and finally write 1 to create attribute. Defining ownidx
+and devtype is mandatory.
+
+Pin mappings are bit maps; set bit 0 to connect a pin to CTS pin,
+set bit 1 to connect to DCD pin, set bit 2 to connect to DSR and
+set bit 3 to connect to RI. Pin naming conventions are follows
+standard RS232 DB9 connector naming conventions.
+
+An example to create a loop-back device with device number as 0
+(/dev/ttyvs0), RTS and DTR pins unconnected, no need to assert DTR
+when device is opened would be something like this:
+
+.. code-block:: sh
+
+ mkdir /config/ttyvs/devlb-0
+ echo 0 > /config/ttyvs/devlb-0/ownidx
+ echo lb > /config/ttyvs/devlb-0/devtype
+ echo 0 > /config/ttyvs/devlb-0/ortsmap
+ echo 0 > /config/ttyvs/devlb-0/odtrmap
+ echo 0 > /config/ttyvs/devlb-0/odtratopn
+ echo 1 > /config/ttyvs/devlb-0/create
+
+An example to create a standard null modem pair with device numbers
+0 and 1 with pin numbers as per RS232 standards will be something
+like this:
+
+.. code-block:: sh
+
+ /dev/ttyvs0        /dev/ttyvs1
+   TX  (3)   ---->    (2) RX
+   RX  (2)   <----    (3) TX
+   RTS (7)   ---->    (8) CTS
+   DTR (4)   --+->    (1) DCD
+               +->    (6) DSR
+   CTS (8)   <----    (7) RTS
+   DCD (1)   <-+--    (4) DTR
+   DSR (6)   <-+
+
+ mkdir /config/ttyvs/devnm-0-1
+ echo nm > /config/ttyvs/devnm-0-1/devtype
+ echo 0 > /config/ttyvs/devnm-0-1/ownidx
+ echo 1 > /config/ttyvs/devnm-0-1/ortsmap
+ echo 6 > /config/ttyvs/devnm-0-1/odtrmap
+ echo 0 > /config/ttyvs/devnm-0-1/odtratopn
+ echo 1 > /config/ttyvs/devnm-0-1/peeridx
+ echo 1 > /config/ttyvs/devnm-0-1/prtsmap
+ echo 6 > /config/ttyvs/devnm-0-1/pdtrmap
+ echo 0 > /config/ttyvs/devnm-0-1/pdtratopn
+ echo 1 > /config/ttyvs/devnm-0-1/create
+
+Directory name devnm-0-1 can be user defined. We used this simple style
+as it is intuitive to understand that the device is null modem with
+numbers 0 and 1. Further, to use configfs based approach, kernel must
+be compiled with CONFIG_CONFIGFS_FS=y option.
+
+How to delete devices
+=====================
+To delete a device created by configfs simply delete the directory
+created in /config/ttyvs directory. If the device is part of a null
+modem pair, peer device will also be deleted automatically.
+
+How to emulate events
+=====================
+When a virtual tty device is created, an event sysfs file will also
+be created by the driver (/sys/class/tty/ttyvsN/event N is device
+number).
+
+1. Emulating framing error: the driver inserts -7 in data buffer as
+the byte that got corrupted due to framing error while receiving data.
+To emulate this write 1 to /sys/class/tty/ttyvsN/event file.
+
+2. Emulating parity error: the driver inserts -8 in data buffer as
+the byte that got corrupted due to parity error while receiving data.
+To emulate this write 2 to /sys/class/tty/ttyvsN/event file.
+
+3. Emulating overrun error: the driver reports to tty layer that an
+overrun has happened.To emulate this write 3 to /sys/class/tty/ttyvsN/event
+file.
+
+4. Emulating ring indication: to emulate as if ring indication has been
+observed write 4 to the event file. To emulate as if ring indication has
+been removed write 5 to the event file.
+
+5. Emulate break received: to emulate as if break condition has been received
+write 6 to the /sys/class/tty/ttyvsN/event file.
+
+6. Emulate faulty cable: to emulate as if the cable is faulty write 7
+to the event file. In this case data sent from sender will not be received
+by the receiver end. To remove this condition write 8 to the event file.
+
+How to support more devices
+===========================
+By default ttyvs driver supports upto 64 devices. This can be
+changed by passing module parameter max_num_vs_devs or by defining
+max-num-vs-devs device tree property.
-- 
2.7.4

