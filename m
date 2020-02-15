Return-Path: <SRS0=m38j=4D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF92C7114D
	for <linux-serial@archiver.kernel.org>; Sat, 15 Feb 2020 17:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6CB2072D
	for <linux-serial@archiver.kernel.org>; Sat, 15 Feb 2020 17:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bigP+Fe7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgBORvg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 15 Feb 2020 12:51:36 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41845 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgBORvf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 15 Feb 2020 12:51:35 -0500
Received: by mail-pf1-f194.google.com with SMTP id j9so6652735pfa.8;
        Sat, 15 Feb 2020 09:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aOCzRdTt1yQCLavJegkAAZRjlqi9VOCuKyoKogIlAn0=;
        b=bigP+Fe7+KvZpDJn4uA7EPgogBtxY6xbioR8I+vSPWGlrX3S/3OFrdn426sC+N/3H5
         CUWD694QkhRxSolqE3QvvWy8lZq4c48vFYpLMiirSwscGn5VNukknWkOfNW3wImrrThW
         5kiIg7hBf+BPXYbJIOiZL6/+jTXv38QJAnYDl3XDWsdlkgri753NPV2bGaZYcJb1XTjZ
         NJQ3vlynSHX1zx6zUuKzJfMGjnVOQXmYOaIlCDsKSS3a0cMlQZg/4hJ/Gk5/HHew4q1K
         DfznvhBPF1eOQksoE2fArI0NHJj0a+Ag/wbm7GrcUSXTsMGXf3aFVDAPHzd6O1aB3Lep
         bNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aOCzRdTt1yQCLavJegkAAZRjlqi9VOCuKyoKogIlAn0=;
        b=rd6ywg8PTCpKT/4GH6KA7ioz6AAePurxdap0QCbI5mLd7W7joqh5ImbXLbBMOrdAj9
         43aqm0PsguUMH7Sm9ZAL9rgtAIfc/ptLNY+bqChOIP5SgM2S0/jPskzy3pmNMQvhNWRg
         JWhxNs5qPeQHxBIncTJ+uNsuY8OkP+CqQmfD2dZ4YChrD+MQ///tUpPg41X5Jtybvqst
         GFyOffDCmxUoMamFvE4XAYkr5MthEZIZP4N5hUSCNGXn6B7SvuvqamFCALKlMRfN83St
         WKabPEOFqk71AfHxxrd/GaI8twuM7HqqfebGssggw20ujukQAdkBKQuXGnzQ4YMN8/0A
         AF6w==
X-Gm-Message-State: APjAAAXvU5lmNU93LdE5mL36PYAkWreyuHmN7sZDVU7EsK8A5NxqSwHQ
        zQudchYaK17Yk4Za3pWF/fk=
X-Google-Smtp-Source: APXvYqyC0obciXCjHsiocHWqAKJ+joGl2ktC+hMUEPDZG7euSDCoYg+Aq49+MUQmRxpgZI2jARmyAg==
X-Received: by 2002:a63:fc51:: with SMTP id r17mr9600461pgk.292.1581789094682;
        Sat, 15 Feb 2020 09:51:34 -0800 (PST)
Received: from localhost.localdomain ([49.207.56.214])
        by smtp.gmail.com with ESMTPSA id g13sm7176375pgh.82.2020.02.15.09.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Feb 2020 09:51:34 -0800 (PST)
From:   Rishi Gupta <gupt21@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH v2 4/4] tty: documentation: document how to use ttyvs driver
Date:   Sat, 15 Feb 2020 23:21:09 +0530
Message-Id: <1581789069-5232-4-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581789069-5232-1-git-send-email-gupt21@gmail.com>
References: <1581789069-5232-1-git-send-email-gupt21@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The commit documents how to use ttyvs driver to create/delete
virtual tty devices, how to emulate various serial port events
through this driver etc.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
Changes in v2:
- Added this file from v2 only

 Documentation/virtual/tty-ttyvs.rst | 142 ++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 Documentation/virtual/tty-ttyvs.rst

diff --git a/Documentation/virtual/tty-ttyvs.rst b/Documentation/virtual/tty-ttyvs.rst
new file mode 100644
index 0000000..4321e05
--- /dev/null
+++ b/Documentation/virtual/tty-ttyvs.rst
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

