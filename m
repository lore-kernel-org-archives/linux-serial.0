From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 63/75] serial: RS485 ioctl structure uses __u32 include
	linux/types.h
Date: Fri, 02 Jan 2009 13:49:04 +0000
Message-ID: <20090102134902.13472.99440.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37668 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755428AbZABNst (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:48:49 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

=46rom: Andy Whitcroft <apw@canonical.com>

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
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Alan Cox <alan@redhat.com>
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

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
