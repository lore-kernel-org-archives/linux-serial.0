From: Burton Windle <bwindle@fint.org>
Subject: [2.5.38] Warning: null TTY for (88:##) in tty_fasync (fwd)
Date: Mon, 23 Sep 2002 14:50:30 -0400 (EDT)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.43.0209231450130.5735-100000@morpheus>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: tytso@mit.edu

Are these cause for concern?

Sep 23 14:16:56 razor kernel: Warning: null TTY for (88:01) in tty_fasync
Sep 23 14:16:56 razor kernel: Warning: null TTY for (88:00) in tty_fasync
Sep 23 14:24:30 razor kernel: Warning: null TTY for (88:02) in tty_fasync

I see that they can come from drivers/char/tty_io.c:
     "Warning: null TTY for (%s) in %s\n";

I'm able to reproduce these at will.

Linux version 2.5.38 (bwindle@razor) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Mon Sep 23 10:07:19 EST 2002

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.19
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.12


--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.18/init/main.c:461


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

