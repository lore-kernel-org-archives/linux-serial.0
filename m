Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD13C4321E
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 08:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359494AbhKZIXy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:23:54 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33076 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359392AbhKZIV3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 03:21:29 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0D4001FE0A;
        Fri, 26 Nov 2021 08:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637914577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sBHUseqSVjnLHclZXleZ53xI42etbmeaS2EDaYG5FUE=;
        b=sOcaEGTLxH/BSf2+egitCrEEgCz5G/9dEDDKTNjKG3d9QTgWCSxEE/ZeTp0rbOMbNJ2c+y
        zKppztLF1crHkb1zEVBFVFUIAYaRzkVZbQZG8Tkd/jaN7n83e53TbHeKYeFMBXHMjEmLVZ
        QV8MjxiCSikEvYQdTW8P2OtqkWEy8/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637914577;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sBHUseqSVjnLHclZXleZ53xI42etbmeaS2EDaYG5FUE=;
        b=NPRBwoOFCeCjE0mHBMcJZ68TMFTevlF1zeYQw8qfgbffYXIX2Zqn6ZC59QDzyUGHoSLeyZ
        xq4l3D3nSKMQsZDQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D1B40A3B89;
        Fri, 26 Nov 2021 08:16:16 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 23/23] Documentation: add TTY chapter
Date:   Fri, 26 Nov 2021 09:16:11 +0100
Message-Id: <20211126081611.11001-24-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211126081611.11001-1-jslaby@suse.cz>
References: <20211126081611.11001-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We now have all the kernel-doc comments in the code ready. So add a
couple of documents dragging those into generated docs from
Documentation/. There is only some sugar text around included
kernel-docs here.

It's a complete chapter, to be extended later as desired. This is a
solid cornerstone for the time being, I believe.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 Documentation/index.rst             |   1 +
 Documentation/tty/index.rst         |  63 ++++++++++++++
 Documentation/tty/n_tty.rst         |  22 +++++
 Documentation/tty/tty_buffer.rst    |  46 ++++++++++
 Documentation/tty/tty_driver.rst    | 128 ++++++++++++++++++++++++++++
 Documentation/tty/tty_internals.rst |  31 +++++++
 Documentation/tty/tty_ldisc.rst     |   6 ++
 Documentation/tty/tty_port.rst      |  70 +++++++++++++++
 Documentation/tty/tty_struct.rst    |  81 ++++++++++++++++++
 9 files changed, 448 insertions(+)
 create mode 100644 Documentation/tty/index.rst
 create mode 100644 Documentation/tty/n_tty.rst
 create mode 100644 Documentation/tty/tty_buffer.rst
 create mode 100644 Documentation/tty/tty_driver.rst
 create mode 100644 Documentation/tty/tty_internals.rst
 create mode 100644 Documentation/tty/tty_port.rst
 create mode 100644 Documentation/tty/tty_struct.rst

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 1b13c2445e87..2f99cedc95cd 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -138,6 +138,7 @@ needed).
    misc-devices/index
    scheduler/index
    mhi/index
+   tty/index
 
 Architecture-agnostic documentation
 -----------------------------------
diff --git a/Documentation/tty/index.rst b/Documentation/tty/index.rst
new file mode 100644
index 000000000000..21ea0cb21e55
--- /dev/null
+++ b/Documentation/tty/index.rst
@@ -0,0 +1,63 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===
+TTY
+===
+
+Teletypewriter (TTY) layer takes care of all those serial devices. Including
+the virtual ones like pseudoterminal (PTY).
+
+TTY structures
+==============
+
+There are several major TTY structures. Every TTY device in a system has a
+corresponding struct tty_port. These devices are maintained by a TTY driver
+which is struct tty_driver. This structure describes the driver but also
+contains a reference to operations which could be performed on the TTYs. It is
+struct tty_operations. Then, upon open, a struct tty_struct is allocated and
+lives until the final close. During this time, several callbacks from struct
+tty_operations are invoked by the TTY layer.
+
+Every character received by the kernel (both from devices and users) is passed
+through a preselected :doc:`tty_ldisc` (in
+short ldisc; in C, struct tty_ldisc_ops). Its task is to transform characters
+as defined by a particular ldisc or by user too. The default one is n_tty,
+implementing echoes, signal handling, jobs control, special characters
+processing, and more. The transformed characters are passed further to
+user/device, depending on the source.
+
+In-detail description of the named TTY structures is in separate documents:
+
+.. toctree::
+   :maxdepth: 2
+
+   tty_driver
+   tty_port
+   tty_struct
+   tty_ldisc
+   tty_buffer
+   n_tty
+   tty_internals
+
+Writing TTY Driver
+==================
+
+Before one starts writing a TTY driver, they must consider
+:doc:`Serial <../driver-api/serial/driver>` and :doc:`USB Serial
+<../usb/usb-serial>` layers
+first. Drivers for serial devices can often use one of these specific layers to
+implement a serial driver. Only special devices should be handled directly by
+the TTY Layer. If you are about to write such a driver, read on.
+
+A *typical* sequence a TTY driver performs is as follows:
+
+#. Allocate and register a TTY driver (module init)
+#. Create and register TTY devices as they are probed (probe function)
+#. Handle TTY operations and events like interrupts (TTY core invokes the
+   former, the device the latter)
+#. Remove devices as they are going away (remove function)
+#. Unregister and free the TTY driver (module exit)
+
+Steps regarding driver, i.e. 1., 3., and 5. are described in detail in
+:doc:`tty_driver`. For the other two (devices handling), look into
+:doc:`tty_port`.
diff --git a/Documentation/tty/n_tty.rst b/Documentation/tty/n_tty.rst
new file mode 100644
index 000000000000..15b70faee72d
--- /dev/null
+++ b/Documentation/tty/n_tty.rst
@@ -0,0 +1,22 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====
+N_TTY
+=====
+
+.. contents:: :local:
+
+The default (and fallback) :doc:`TTY line discipline <tty_ldisc>`. It tries to
+handle characters as per POSIX.
+
+External Functions
+==================
+
+.. kernel-doc:: drivers/tty/n_tty.c
+   :export:
+
+Internal Functions
+==================
+
+.. kernel-doc:: drivers/tty/n_tty.c
+   :internal:
diff --git a/Documentation/tty/tty_buffer.rst b/Documentation/tty/tty_buffer.rst
new file mode 100644
index 000000000000..a39d4781e0d2
--- /dev/null
+++ b/Documentation/tty/tty_buffer.rst
@@ -0,0 +1,46 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========
+TTY Buffer
+==========
+
+.. contents:: :local:
+
+Here, we document functions for taking care of tty buffer and their flipping.
+Drivers are supposed to fill the buffer by one of those functions below and
+then flip the buffer, so that the data are passed to :doc:`line discipline
+<tty_ldisc>` for further processing.
+
+Flip Buffer Management
+======================
+
+.. kernel-doc:: drivers/tty/tty_buffer.c
+   :identifiers: tty_prepare_flip_string tty_insert_flip_string_fixed_flag
+           tty_insert_flip_string_flags __tty_insert_flip_char
+           tty_flip_buffer_push tty_ldisc_receive_buf
+
+----
+
+Other Functions
+===============
+
+.. kernel-doc:: drivers/tty/tty_buffer.c
+   :identifiers: tty_buffer_space_avail tty_buffer_set_limit
+
+----
+
+Buffer Locking
+==============
+
+These are used only in special circumstances. Avoid them.
+
+.. kernel-doc:: drivers/tty/tty_buffer.c
+   :identifiers: tty_buffer_lock_exclusive tty_buffer_unlock_exclusive
+
+----
+
+Internal Functions
+==================
+
+.. kernel-doc:: drivers/tty/tty_buffer.c
+   :internal:
diff --git a/Documentation/tty/tty_driver.rst b/Documentation/tty/tty_driver.rst
new file mode 100644
index 000000000000..cc529f863406
--- /dev/null
+++ b/Documentation/tty/tty_driver.rst
@@ -0,0 +1,128 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================
+TTY Driver and TTY Operations
+=============================
+
+.. contents:: :local:
+
+Allocation
+==========
+
+The first thing a driver needs to do is to allocate a struct tty_driver. This
+is done by tty_alloc_driver() (or __tty_alloc_driver()). Next, the newly
+allocated structure is filled with information. See `TTY Driver Reference`_ at
+the end of this document on what actually shall be filled in.
+
+The allocation routines expect a number of devices the driver can handle at
+most and flags. Flags are those starting ``TTY_DRIVER_`` listed and described
+in `TTY Driver Flags`_ below.
+
+When the driver is about to be freed, tty_driver_kref_put() is called on that.
+It will decrements the reference count and if it reaches zero, the driver is
+freed.
+
+For reference, both allocation and deallocation functions are explained here in
+detail:
+
+.. kernel-doc:: drivers/tty/tty_io.c
+   :identifiers: __tty_alloc_driver tty_driver_kref_put
+
+TTY Driver Flags
+----------------
+
+Here comes the documentation of flags accepted by tty_alloc_driver() (or
+__tty_alloc_driver()):
+
+.. kernel-doc:: include/linux/tty_driver.h
+   :doc: TTY Driver Flags
+
+----
+
+Registration
+============
+
+When a struct tty_driver is allocated and filled in, it can be registered using
+tty_register_driver(). It is recommended to pass ``TTY_DRIVER_DYNAMIC_DEV`` in
+flags of tty_alloc_driver(). If it is not passed, *all* devices are also
+registered during tty_register_driver() and the following paragraph of
+registering devices can be skipped for such drivers. However, the struct
+tty_port part in `Registering Devices`_ is still relevant there.
+
+.. kernel-doc:: drivers/tty/tty_io.c
+   :identifiers: tty_register_driver tty_unregister_driver
+
+Registering Devices
+-------------------
+
+Every TTY device shall be backed by a struct tty_port. Usually, TTY drivers
+embed tty_port into device's private structures. Further details about handling
+tty_port can be found in :doc:`tty_port`. The driver is also recommended to use
+tty_port's reference counting by tty_port_get() and tty_port_put(). The final
+put is supposed to free the tty_port including the device's private struct.
+
+Unless ``TTY_DRIVER_DYNAMIC_DEV`` was passed as flags to tty_alloc_driver(),
+TTY driver is supposed to register every device discovered in the system
+(the latter is preferred). This is performed by tty_register_device(). Or by
+tty_register_device_attr() if the driver wants to expose some information
+through struct attribute_group. Both of them register ``index``'th device and
+upon return, the device can be opened. There are also preferred tty_port
+variants described in `Linking Devices to Ports`_ later. It is up to driver to
+manage free indices and choosing the right one. The TTY layer only refuses to
+register more devices than passed to tty_alloc_driver().
+
+When the device is opened, the TTY layer allocates struct tty_struct and starts
+calling operations from :c:member:`tty_driver.ops`, see `TTY Operations
+Reference`_.
+
+The registration routines are documented as follows:
+
+.. kernel-doc:: drivers/tty/tty_io.c
+   :identifiers: tty_register_device tty_register_device_attr
+        tty_unregister_device
+
+----
+
+Linking Devices to Ports
+------------------------
+As stated earlier, every TTY device shall have a struct tty_port assigned to
+it. It must be known to the TTY layer at :c:member:`tty_driver.ops.install()`
+at latest.  There are few helpers to *link* the two. Ideally, the driver uses
+tty_port_register_device() or tty_port_register_device_attr() instead of
+tty_register_device() and tty_register_device_attr() at the registration time.
+This way, the driver needs not care about linking later on.
+
+If that is not possible, the driver still can link the tty_port to a specific
+index *before* the actual registration by tty_port_link_device(). If it still
+does not fit, tty_port_install() can be used from the
+:c:member:`tty_driver.ops.install` hook as a last resort. The last one is
+dedicated mostly for in-memory devices like PTY where tty_ports are allocated
+on demand.
+
+The linking routines are documented here:
+
+.. kernel-doc::  drivers/tty/tty_port.c
+   :identifiers: tty_port_link_device tty_port_register_device
+        tty_port_register_device_attr
+
+----
+
+TTY Driver Reference
+====================
+
+All members of struct tty_driver are documented here. The required members are
+noted at the end. struct tty_operations are documented next.
+
+.. kernel-doc:: include/linux/tty_driver.h
+   :identifiers: tty_driver
+
+----
+
+TTY Operations Reference
+========================
+
+When a TTY is registered, these driver hooks can be invoked by the TTY layer:
+
+.. kernel-doc:: include/linux/tty_driver.h
+   :identifiers: tty_operations
+
diff --git a/Documentation/tty/tty_internals.rst b/Documentation/tty/tty_internals.rst
new file mode 100644
index 000000000000..d0d415820300
--- /dev/null
+++ b/Documentation/tty/tty_internals.rst
@@ -0,0 +1,31 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+TTY Internals
+=============
+
+.. contents:: :local:
+
+Kopen
+=====
+
+These functions serve for opening a TTY from the kernelspace:
+
+.. kernel-doc:: drivers/tty/tty_io.c
+      :identifiers: tty_kopen_exclusive tty_kopen_shared tty_kclose
+
+----
+
+Exported Internal Functions
+===========================
+
+.. kernel-doc:: drivers/tty/tty_io.c
+   :identifiers: tty_release_struct tty_dev_name_to_number tty_get_icount
+
+----
+
+Internal Functions
+==================
+
+.. kernel-doc:: drivers/tty/tty_io.c
+   :internal:
diff --git a/Documentation/tty/tty_ldisc.rst b/Documentation/tty/tty_ldisc.rst
index 65885d97595c..5144751be804 100644
--- a/Documentation/tty/tty_ldisc.rst
+++ b/Documentation/tty/tty_ldisc.rst
@@ -6,6 +6,12 @@ TTY Line Discipline
 
 .. contents:: :local:
 
+TTY line discipline process all incoming and outgoing character from/to a tty
+device. The default line discipline is :doc:`N_TTY <n_tty>`. It is also a
+fallback if establishing any other discipline for a tty fails. If even N_TTY
+fails, N_NULL takes over. That never fails, but also does not process any
+characters -- it throws them away.
+
 Registration
 ============
 
diff --git a/Documentation/tty/tty_port.rst b/Documentation/tty/tty_port.rst
new file mode 100644
index 000000000000..5cb90e954fcf
--- /dev/null
+++ b/Documentation/tty/tty_port.rst
@@ -0,0 +1,70 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========
+TTY Port
+========
+
+.. contents:: :local:
+
+The TTY drivers are advised to use struct tty_port helpers as much as possible.
+If the drivers implement :c:member:`tty_port.ops.activate()` and
+:c:member:`tty_port.ops.shutdown()`, they can use tty_port_open(),
+tty_port_close(), and tty_port_hangup() in respective
+:c:member:`tty_struct.ops` hooks.
+
+The reference and details are contained in the `TTY Port Reference`_ and `TTY
+Port Operations Reference`_ sections at the bottom.
+
+TTY Port Functions
+==================
+
+Init & Destroy
+--------------
+
+.. kernel-doc::  drivers/tty/tty_port.c
+   :identifiers: tty_port_init tty_port_destroy
+        tty_port_get tty_port_put
+
+Open/Close/Hangup Helpers
+-------------------------
+
+.. kernel-doc::  drivers/tty/tty_port.c
+   :identifiers: tty_port_install tty_port_open tty_port_block_til_ready
+        tty_port_close tty_port_close_start tty_port_close_end tty_port_hangup
+        tty_port_shutdown
+
+TTY Refcounting
+---------------
+
+.. kernel-doc::  drivers/tty/tty_port.c
+   :identifiers: tty_port_tty_get tty_port_tty_set
+
+TTY Helpers
+-----------
+
+.. kernel-doc::  drivers/tty/tty_port.c
+   :identifiers: tty_port_tty_hangup tty_port_tty_wakeup
+
+
+Modem Signals
+-------------
+
+.. kernel-doc::  drivers/tty/tty_port.c
+   :identifiers: tty_port_carrier_raised tty_port_raise_dtr_rts
+        tty_port_lower_dtr_rts
+
+----
+
+TTY Port Reference
+==================
+
+.. kernel-doc:: include/linux/tty_port.h
+   :identifiers: tty_port
+
+----
+
+TTY Port Operations Reference
+=============================
+
+.. kernel-doc:: include/linux/tty_port.h
+   :identifiers: tty_port_operations
diff --git a/Documentation/tty/tty_struct.rst b/Documentation/tty/tty_struct.rst
new file mode 100644
index 000000000000..c72f5a4293b2
--- /dev/null
+++ b/Documentation/tty/tty_struct.rst
@@ -0,0 +1,81 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========
+TTY Struct
+==========
+
+.. contents:: :local:
+
+struct tty_struct is allocated by the TTY layer upon the first open of the TTY
+device and released after the last close. The TTY layer passes this structure
+to most of struct tty_operation's hooks. Members of tty_struct are documented
+in `TTY Struct Reference`_ at the bottom.
+
+Initialization
+==============
+
+.. kernel-doc:: drivers/tty/tty_io.c
+   :identifiers: tty_init_termios
+
+Name
+====
+
+.. kernel-doc:: drivers/tty/tty_io.c
+   :identifiers: tty_name
+
+Reference counting
+==================
+
+.. kernel-doc:: include/linux/tty.h
+   :identifiers: tty_kref_get
+
+.. kernel-doc:: drivers/tty/tty_io.c
+   :identifiers: tty_kref_put
+
+Install
+=======
+
+.. kernel-doc:: drivers/tty/tty_io.c
+   :identifiers: tty_standard_install
+
+Read & Write
+============
+
+.. kernel-doc:: drivers/tty/tty_io.c
+   :identifiers: tty_put_char
+
+Start & Stop
+============
+
+.. kernel-doc:: drivers/tty/tty_io.c
+   :identifiers: start_tty stop_tty
+
+Wakeup
+======
+
+.. kernel-doc:: drivers/tty/tty_io.c
+   :identifiers: tty_wakeup
+
+Hangup
+======
+
+.. kernel-doc:: drivers/tty/tty_io.c
+   :identifiers: tty_hangup tty_vhangup tty_hung_up_p
+
+Misc
+====
+
+.. kernel-doc:: drivers/tty/tty_io.c
+   :identifiers: tty_do_resize
+
+TTY Struct Flags
+================
+
+.. kernel-doc:: include/linux/tty.h
+   :doc: TTY Struct Flags
+
+TTY Struct Reference
+====================
+
+.. kernel-doc:: include/linux/tty.h
+   :identifiers: tty_struct
-- 
2.34.0

