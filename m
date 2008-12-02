From: Andy Whitcroft <apw@canonical.com>
Subject: [PATCH 1/1] serial: RS485 ioctl structure uses __u32 include linux/types.h
Date: Tue,  2 Dec 2008 11:00:25 +0000
Message-ID: <1228215625-18317-1-git-send-email-apw@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:34648 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbYLBLA2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Dec 2008 06:00:28 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>

In the commit below a new struct serial_rs485 was introduced for a new
ioctl:

    commit c26c56c0f40e200e61d1390629c806f6adaffbcc
    Author: Alan Cox <alan@redhat.com>
    Date:   Mon Oct 13 10:37:48 2008 +0100

	tty: Cris has a nice RS485 ioctl so we should steal it

This structure uses the __u32 types for some of its members, which lead=
s
to the following compile error:

    $ cc -I.../include -c X.c
    In file included from X.c:2: .../include/linux/serial.h:185:
		error: expected specifier-qualifier-list before =E2=80=98__u32=E2=80=99
    $

It seems that these types are appropriate for this structure as it is
to be exposed to userspace.  These types are available via linux/types.=
h
so move the include of that outside the __KERNEL__ section.

Signed-off-by: Andy Whitcroft <apw@canonical.com>
---
 include/linux/serial.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/linux/serial.h b/include/linux/serial.h
index 1ea8d92..9136cc5 100644
--- a/include/linux/serial.h
+++ b/include/linux/serial.h
@@ -10,8 +10,9 @@
 #ifndef _LINUX_SERIAL_H
 #define _LINUX_SERIAL_H
=20
-#ifdef __KERNEL__
 #include <linux/types.h>
+
+#ifdef __KERNEL__
 #include <asm/page.h>
=20
 /*
--=20
1.6.0.4.911.gc990

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
