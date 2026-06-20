Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC05175A7C
	for <linux-serial@vger.kernel.org>; Sat, 20 Jun 2026 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781974833; cv=none; b=HnOTDBx3soWZlw6lQoSsAiBMx5wNx2/6BSHJjduk4pP20lizDNSr+u2RoPn74eAO5SVPCZpeaCuzXEM2vfLtpeLBPotKd8+Bm6RX39jU95yz4zbmqXNk7V+38j3cyMIkkUGJfLJ/wubvCeXm5w1RdGpygQRhVr7t09nRTMWlfto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781974833; c=relaxed/simple;
	bh=0zTaGck00WCDmGFTrGRwlCgjeuIkm1YIgxiXoPhe/ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpxAsI7dIFFlCMGN75HoRpvJsJtE5hELDS+YJjFQHmg37kMw5U2UtzusN41S5BtSLOh4avhzQwIBZVup+iFMRuBtnIlS2FkW6QLwU01P8fScFoAZyyiZqejhKmuibCuor7OiUQ6EeUxErz8Dv+LmM6ZAMb43gadCztFD+dB6XG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYSh+4mI; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYSh+4mI"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-13809223fd4so3346913c88.1
        for <linux-serial@vger.kernel.org>; Sat, 20 Jun 2026 10:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781974829; x=1782579629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZItjPd3qFLxrRcJE2CSJDnMZ4oYVdjNoHqhzSxIojQ=;
        b=lYSh+4mI48NAuy5kV44fs33Ogru4GmyHrkazO4Z96i+GhYjlMXpDpL55cfG6Q6QaxX
         6KuE3EaLeIKAD3M/omzy9z9nUIPc1XTjp/ovtmOtEuRl2rENIpIPuuLjcD4msyRz6zD0
         Fxdbkhnm8M359BGmr6AbDE7xwOJwXz5ASQBzYRH+vg0coXlS1L/BzGiXONWF2WFNWLE7
         eANF5Lg6pPcAV5JJbGAz3LrZq3YUOGYuaBpc+A2wlyN+maDSJDcEWsYp+CJFicUS0K5O
         jF6buYkH4s3vI7cGxxK4EU+e44a3LXOgDBXKNsJxnoRYupreCJ+ObPLgQBVQV5XMXI4D
         m8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781974829; x=1782579629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kZItjPd3qFLxrRcJE2CSJDnMZ4oYVdjNoHqhzSxIojQ=;
        b=RJLR/PeZfzp8c/GnvH0o5dXZ6sVhav48ZDKPLnUUWQb+2uGIsyxt19R5zUXrF/IQIQ
         DhlCFplITaaBJAvdCMQhhmHwOOAjtvvVxkiXS+z+6nyP6I1Rv8IFaGzrgZCB3DMkFT0t
         5g8z1iHmkgnuYWBpPdp1WtSs5mT5RnhYGd7DBplfJiulP8i+KC3mJyDNSETiJvVO6H2n
         IjPLmoD9dvQhzt8K79hGnhNWZDLBGd55aXfZtyybEJMQF71rsTEuS5fE7xoAgiNp8hTj
         LmBvV+wWEwcoFdYVTsbn9vUH1eJezxuMyomdkNKzgC/Rg+sc93LSLnyQv02tsueO1Jeb
         4vOA==
X-Forwarded-Encrypted: i=1; AFNElJ9aGAulIQVZDbAeNFmoG4paTxO13HILQAtYgXc/d/LwMfELd0DnUuhD5tgk+hB2qaVNODoXF5Ea/SYZgUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5FR3J7lWXZjt4XUkklHyIACFLTnuJ3CJXiREfQtF38XtGswab
	hKUhYV+cEOx9jrnamEeT4yMvW1CPre/P8+DfNsdu6gI0CB7f5lAZVdYa
X-Gm-Gg: AfdE7clIo6PtJ1L17L+5vX2M6AgW4CHl8MK6YO0DVHLydG8nCcMsCs5pGc/8QIG6W3j
	R6dQzIdEcsS9tRj9dPXLBK0yYxbe9a745LgBE83z4y44Y6PrrkQiIQO0+OU26o4Q5wPmww8qtm0
	pfJmUlummgEEBIG62LHPf8EaQgHs+SIcFzMF/qpedBpkELw5yuTEJh8flqryWWIMYkx17HMjYJR
	dVvHM7FeTxBdqiLqMMpep88Aqnv2fRdG8n1LHIYWAm/HPL6uMqaryNFpT6BmK1U4Q0UoxDmGGyw
	RYvG2fdjP76lay3Z4zs1SMaUI4JFzoWyGEPzCN1V6vjxpx9SRzL63km+DeIbctZM2StrwREVr/e
	K+Y3/b7uEsK+7qKYagwp16IIle5zQluM1BQSnOzzB8IV79Le9LpCSSLADpe1jHIQk++1Zs0FZM9
	HDn6YTNYjXQmsVgCaIiOQWy6pyviI467wvzaTaEzh4kFSDtB4eDVPfiARszg==
X-Received: by 2002:a05:7300:6423:b0:2f5:3fb3:4a76 with SMTP id 5a478bee46e88-30c06e33471mr5574197eec.10.1781974828601;
        Sat, 20 Jun 2026 10:00:28 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1be7eeb7sm4139594eec.30.2026.06.20.10.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 10:00:28 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: "Starke, Daniel" <daniel.starke@siemens.com>,
	Xiang Mei <xmei5@asu.edu>,
	linux-serial@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH v3 2/2] selftests: tty: add base regression test for n_gsm line discipline
Date: Sat, 20 Jun 2026 09:56:17 -0700
Message-ID: <20260620165616.354233-4-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260620165616.354233-2-bestswngs@gmail.com>
References: <20260620165616.354233-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

n_gsm has no selftest coverage.  Add a base functional regression test
that drives the line discipline over a local pty pair, so no real serial
hardware or modem is required, and exercises the GSM 07.10 / 3GPP TS 27.010
basic-option mux from userspace.

The test attaches N_GSM to the pty master, then:

  - basic:     brings up the mux (SETCONF, initiator side), drives the
               DLCI 0 control channel SABM/UA handshake and tears it down.
  - getconf:   round-trips GSMIOC_GETCONF/GSMIOC_SETCONF and checks the
               configuration is preserved.
  - data_dlci: opens a data DLCI (DLCI 1) via the SABM/UA exchange and
               verifies the responder side answers, covering the control
               -> data DLCI path.

Frames are encoded by hand against 3GPP TS 27.010 (address EA/C-R/DLCI
bits, SABM/UA/UIH control fields, the reversed CRC-8 FCS) with the clause
numbers referenced in the comments, so the test doubles as a small,
readable description of the on-wire format.

It is a functional/regression test, not a race reproducer: it gives the
subsystem a green baseline to catch behavioural regressions, including in
the gsm_queue() control-frame dispatch path.

Wire it into the tty selftest Makefile, add CONFIG_N_GSM=y to the config
fragment, and ignore the built binary.  The test SKIPs cleanly when N_GSM
is not built, /dev/ptmx is missing, or it lacks the capability to attach
the ldisc.

Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
---
 tools/testing/selftests/tty/.gitignore       |   1 +
 tools/testing/selftests/tty/Makefile         |   2 +-
 tools/testing/selftests/tty/config           |   1 +
 tools/testing/selftests/tty/tty_n_gsm_test.c | 344 +++++++++++++++++++
 4 files changed, 347 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/tty/tty_n_gsm_test.c

diff --git a/tools/testing/selftests/tty/.gitignore b/tools/testing/selftests/tty/.gitignore
index 2453685d2..e3fcee15e 100644
--- a/tools/testing/selftests/tty/.gitignore
+++ b/tools/testing/selftests/tty/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 tty_tiocsti_test
 tty_tstamp_update
+tty_n_gsm_test
diff --git a/tools/testing/selftests/tty/Makefile b/tools/testing/selftests/tty/Makefile
index 7f6fbe5a0..ae546d0d4 100644
--- a/tools/testing/selftests/tty/Makefile
+++ b/tools/testing/selftests/tty/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS = -O2 -Wall
-TEST_GEN_PROGS := tty_tstamp_update tty_tiocsti_test
+TEST_GEN_PROGS := tty_tstamp_update tty_tiocsti_test tty_n_gsm_test
 LDLIBS += -lcap
 
 include ../lib.mk
diff --git a/tools/testing/selftests/tty/config b/tools/testing/selftests/tty/config
index c6373aba6..66a5ffc9e 100644
--- a/tools/testing/selftests/tty/config
+++ b/tools/testing/selftests/tty/config
@@ -1 +1,2 @@
 CONFIG_LEGACY_TIOCSTI=y
+CONFIG_N_GSM=y
diff --git a/tools/testing/selftests/tty/tty_n_gsm_test.c b/tools/testing/selftests/tty/tty_n_gsm_test.c
new file mode 100644
index 000000000..064231512
--- /dev/null
+++ b/tools/testing/selftests/tty/tty_n_gsm_test.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * n_gsm line discipline test
+ *
+ * Exercise the n_gsm (GSM 07.10 mux) control paths over a pty, so the driver
+ * can be regression-tested without the real modem hardware. The test attaches
+ * the ldisc, configures the mux, opens DLCI 0, drives a control frame through
+ * the receive path (reaching gsm_control_reply()) and reconfigures, which
+ * tears the mux down and frees the DLCI. It is a functional coverage test of
+ * the receive and teardown paths, not a reproducer for any specific race.
+ *
+ * The frame encoding follows 3GPP TS 07.10 (a.k.a. 27.010), basic option.
+ *
+ * Requires CONFIG_N_GSM and CAP_NET_ADMIN to attach the ldisc.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <poll.h>
+#include <time.h>
+#include <termios.h>
+#include <sys/ioctl.h>
+#include <linux/tty.h>
+#include <linux/gsmmux.h>
+
+#include "../kselftest_harness.h"
+
+#ifndef N_GSM0710
+#define N_GSM0710 21
+#endif
+
+/*
+ * GSM 07.10 basic option framing. Field encodings below are from
+ * 3GPP TS 07.10 (a.k.a. 27.010): the basic-option flag (section 5.2.6.1),
+ * the address field with EA/C-R/DLCI bits (5.2.1.2, command vs response
+ * C/R from table 1), the control field codings (5.2.1.3, table 2), the
+ * length field (5.2.1.5), and the control-channel message types (5.4.6.3).
+ */
+#define GSM0_SOF	0xf9		/* basic-option flag, 1001 1111 */
+#define ADDR_DLCI0	0x03		/* EA=1, C/R=1, DLCI=0 (command) */
+#define ADDR_DLCI0_RSP	0x01		/* EA=1, C/R=0, DLCI=0 (response) */
+#define ADDR_DLCI1	0x07		/* EA=1, C/R=1, DLCI=1 (command) */
+#define GSM_PF		0x10		/* poll/final bit */
+#define CTRL_SABM	(0x2f | GSM_PF)	/* SABM command */
+#define CTRL_UA		(0x63 | GSM_PF)	/* UA, the SABM acknowledgment */
+#define CTRL_UIH	0xef		/* UIH command/response */
+#define INIT_FCS	0xff
+#define CMD_TEST_EA	0x23		/* (CMD_TEST << 1) | EA, type 5.4.6.3.4 */
+
+#define MAX_FRAME	64
+
+/* Reversed CRC-8 table (poly 0x07), from 3GPP TS 07.10 annex B.3.5. */
+static const unsigned char gsm_fcs8[256] = {
+0x00, 0x91, 0xe3, 0x72, 0x07, 0x96, 0xe4, 0x75, 0x0e, 0x9f, 0xed, 0x7c, 0x09, 0x98, 0xea, 0x7b,
+0x1c, 0x8d, 0xff, 0x6e, 0x1b, 0x8a, 0xf8, 0x69, 0x12, 0x83, 0xf1, 0x60, 0x15, 0x84, 0xf6, 0x67,
+0x38, 0xa9, 0xdb, 0x4a, 0x3f, 0xae, 0xdc, 0x4d, 0x36, 0xa7, 0xd5, 0x44, 0x31, 0xa0, 0xd2, 0x43,
+0x24, 0xb5, 0xc7, 0x56, 0x23, 0xb2, 0xc0, 0x51, 0x2a, 0xbb, 0xc9, 0x58, 0x2d, 0xbc, 0xce, 0x5f,
+0x70, 0xe1, 0x93, 0x02, 0x77, 0xe6, 0x94, 0x05, 0x7e, 0xef, 0x9d, 0x0c, 0x79, 0xe8, 0x9a, 0x0b,
+0x6c, 0xfd, 0x8f, 0x1e, 0x6b, 0xfa, 0x88, 0x19, 0x62, 0xf3, 0x81, 0x10, 0x65, 0xf4, 0x86, 0x17,
+0x48, 0xd9, 0xab, 0x3a, 0x4f, 0xde, 0xac, 0x3d, 0x46, 0xd7, 0xa5, 0x34, 0x41, 0xd0, 0xa2, 0x33,
+0x54, 0xc5, 0xb7, 0x26, 0x53, 0xc2, 0xb0, 0x21, 0x5a, 0xcb, 0xb9, 0x28, 0x5d, 0xcc, 0xbe, 0x2f,
+0xe0, 0x71, 0x03, 0x92, 0xe7, 0x76, 0x04, 0x95, 0xee, 0x7f, 0x0d, 0x9c, 0xe9, 0x78, 0x0a, 0x9b,
+0xfc, 0x6d, 0x1f, 0x8e, 0xfb, 0x6a, 0x18, 0x89, 0xf2, 0x63, 0x11, 0x80, 0xf5, 0x64, 0x16, 0x87,
+0xd8, 0x49, 0x3b, 0xaa, 0xdf, 0x4e, 0x3c, 0xad, 0xd6, 0x47, 0x35, 0xa4, 0xd1, 0x40, 0x32, 0xa3,
+0xc4, 0x55, 0x27, 0xb6, 0xc3, 0x52, 0x20, 0xb1, 0xca, 0x5b, 0x29, 0xb8, 0xcd, 0x5c, 0x2e, 0xbf,
+0x90, 0x01, 0x73, 0xe2, 0x97, 0x06, 0x74, 0xe5, 0x9e, 0x0f, 0x7d, 0xec, 0x99, 0x08, 0x7a, 0xeb,
+0x8c, 0x1d, 0x6f, 0xfe, 0x8b, 0x1a, 0x68, 0xf9, 0x82, 0x13, 0x61, 0xf0, 0x85, 0x14, 0x66, 0xf7,
+0xa8, 0x39, 0x4b, 0xda, 0xaf, 0x3e, 0x4c, 0xdd, 0xa6, 0x37, 0x45, 0xd4, 0xa1, 0x30, 0x42, 0xd3,
+0xb4, 0x25, 0x57, 0xc6, 0xb3, 0x22, 0x50, 0xc1, 0xba, 0x2b, 0x59, 0xc8, 0xbd, 0x2c, 0x5e, 0xcf,
+};
+
+static unsigned char fcs_header(const unsigned char *p, int n)
+{
+	unsigned char fcs = INIT_FCS;
+	int i;
+
+	for (i = 0; i < n; i++)
+		fcs = gsm_fcs8[fcs ^ p[i]];
+	return 0xff - fcs;
+}
+
+/*
+ * Build a GSM0 frame: SOF addr ctrl len [data] FCS SOF.
+ * Returns the frame length, or -1 if it would not fit in MAX_FRAME.
+ */
+static int build_frame(unsigned char *out, unsigned char addr,
+		       unsigned char ctrl, const unsigned char *data, int dlen)
+{
+	unsigned char hdr[3] = { addr, ctrl, (unsigned char)((dlen << 1) | 1) };
+	int i = 0, j;
+
+	if (dlen < 0 || dlen + 6 > MAX_FRAME)
+		return -1;
+
+	out[i++] = GSM0_SOF;
+	out[i++] = addr;
+	out[i++] = ctrl;
+	out[i++] = (unsigned char)((dlen << 1) | 1);
+	for (j = 0; j < dlen; j++)
+		out[i++] = data[j];
+	out[i++] = fcs_header(hdr, 3);
+	out[i++] = GSM0_SOF;
+	return i;
+}
+
+static int gsm_setconf(int fd, int mtu)
+{
+	struct gsm_config c;
+
+	memset(&c, 0, sizeof(c));
+	c.adaption = 1;
+	c.encapsulation = 0;	/* basic option framing */
+	c.initiator = 0;	/* responder: the peer (master side) drives DLCI 0 */
+	c.mru = 64;
+	c.mtu = mtu;
+	c.i = 1;		/* UIH frames */
+	c.k = 2;		/* window size */
+	/* Short timers and a single retry so open/close handshakes and the
+	 * teardown complete quickly within the test.
+	 */
+	c.t1 = 1;
+	c.t2 = 1;
+	c.n2 = 1;
+	return ioctl(fd, GSMIOC_SETCONF, &c);
+}
+
+/*
+ * Open a pty pair with a raw master and the n_gsm ldisc on the slave.
+ * Returns 0 and fills *mfd (master) / *sfd (slave/ldisc) on success, or
+ * -errno otherwise.
+ */
+static int gsm_open(int *mfd, int *sfd)
+{
+	int ldisc = N_GSM0710;
+	char sname[128];
+	struct termios tio;
+	int m, s, e;
+
+	m = open("/dev/ptmx", O_RDWR | O_NOCTTY);
+	if (m < 0)
+		return -errno;
+	if (grantpt(m) || unlockpt(m) || ptsname_r(m, sname, sizeof(sname))) {
+		e = errno;
+		close(m);
+		return -e;
+	}
+	s = open(sname, O_RDWR | O_NOCTTY);
+	if (s < 0) {
+		e = errno;
+		close(m);
+		return -e;
+	}
+	if (tcgetattr(m, &tio) == 0) {
+		cfmakeraw(&tio);
+		tcsetattr(m, TCSANOW, &tio);
+	}
+	if (ioctl(s, TIOCSETD, &ldisc) < 0) {
+		e = errno;
+		close(s);
+		close(m);
+		return -e;
+	}
+	*mfd = m;
+	*sfd = s;
+	return 0;
+}
+
+static long now_ms(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	return ts.tv_sec * 1000 + ts.tv_nsec / 1000000;
+}
+
+/*
+ * Wait until the mux sends a frame on DLCI 0 with the given address and
+ * control field, e.g. the UA that acknowledges SABM (addr 0x03), or the
+ * CMD_TEST reply (response addr 0x01). Returns 1 if a matching frame header
+ * (SOF, addr, ctrl) is seen, 0 on timeout. Matching the SOF + address +
+ * control sequence (rather than a lone control byte) avoids false hits on
+ * FCS or payload bytes that happen to equal the control value.
+ */
+static int wait_for_frame(int mfd, unsigned char addr, unsigned char ctrl,
+			  int timeout_ms)
+{
+	struct pollfd pfd = { .fd = mfd, .events = POLLIN };
+	long deadline = now_ms() + timeout_ms;
+	unsigned char buf[256];
+	int left;
+
+	while ((left = deadline - now_ms()) > 0) {
+		int ret, n, i;
+
+		ret = poll(&pfd, 1, left);
+		if (ret < 0) {
+			if (errno == EINTR)
+				continue;
+			return 0;
+		}
+		if (ret == 0 || !(pfd.revents & POLLIN))
+			continue;
+
+		n = read(mfd, buf, sizeof(buf));
+		if (n <= 0)
+			continue;
+		for (i = 0; i + 2 < n; i++) {
+			if (buf[i] == GSM0_SOF && buf[i + 1] == addr &&
+			    buf[i + 2] == ctrl)
+				return 1;
+		}
+	}
+	return 0;
+}
+
+FIXTURE(n_gsm)
+{
+	int mfd;	/* pty master */
+	int sfd;	/* pty slave, carrying the n_gsm ldisc */
+};
+
+FIXTURE_SETUP(n_gsm)
+{
+	int ret;
+
+	/* So FIXTURE_TEARDOWN does not close fd 0 if setup bails early. */
+	self->mfd = -1;
+	self->sfd = -1;
+
+	ret = gsm_open(&self->mfd, &self->sfd);
+
+	if (ret == -EPERM || ret == -EACCES)
+		SKIP(return, "need CAP_NET_ADMIN to attach n_gsm ldisc");
+	if (ret == -EINVAL || ret == -ENODEV)
+		SKIP(return, "CONFIG_N_GSM not enabled");
+	if (ret == -ENOENT)
+		SKIP(return, "no pty support (/dev/ptmx missing)");
+	ASSERT_EQ(ret, 0)
+		TH_LOG("gsm_open failed: %d", ret);
+}
+
+FIXTURE_TEARDOWN(n_gsm)
+{
+	if (self->sfd >= 0)
+		close(self->sfd);
+	if (self->mfd >= 0)
+		close(self->mfd);
+}
+
+/*
+ * Configure the mux, open DLCI 0 and push a control frame through the receive
+ * path, then reconfigure to tear the mux down. This needs no hardware and
+ * verifies the n_gsm receive/teardown paths are reachable and do not crash.
+ */
+TEST_F(n_gsm, basic)
+{
+	unsigned char sabm[MAX_FRAME], cmd_test[MAX_FRAME];
+	/*
+	 * CMD_TEST control command: cmd byte = (CMD_TEST << 1) | EA, then a
+	 * length-EA byte (0x01) meaning zero bytes of test data.
+	 */
+	unsigned char payload[2] = { CMD_TEST_EA, 0x01 };
+	int slen, tlen;
+
+	/* Activate the mux; this allocates DLCI 0. */
+	ASSERT_EQ(gsm_setconf(self->sfd, 64), 0)
+		TH_LOG("GSMIOC_SETCONF failed: %m");
+
+	slen = build_frame(sabm, ADDR_DLCI0, CTRL_SABM, NULL, 0);
+	tlen = build_frame(cmd_test, ADDR_DLCI0, CTRL_UIH, payload, sizeof(payload));
+	ASSERT_GT(slen, 0);
+	ASSERT_GT(tlen, 0);
+
+	/* Open DLCI 0 and wait for the UA reply confirming it reached OPEN. */
+	ASSERT_EQ(write(self->mfd, sabm, slen), slen);
+	ASSERT_EQ(wait_for_frame(self->mfd, ADDR_DLCI0, CTRL_UA, 1000), 1)
+		TH_LOG("DLCI 0 did not open (no UA reply)");
+
+	/*
+	 * Drive a CMD_TEST control frame; the receive path reaches
+	 * gsm_control_reply(), which sends a CMD_TEST reply back on the
+	 * response address. Wait for that reply so we know the frame was
+	 * processed, rather than sleeping.
+	 */
+	ASSERT_EQ(write(self->mfd, cmd_test, tlen), tlen);
+	EXPECT_EQ(wait_for_frame(self->mfd, ADDR_DLCI0_RSP, CTRL_UIH, 1000), 1)
+		TH_LOG("no CMD_TEST reply seen");
+
+	/* Reconfigure: tears the mux down and frees DLCI 0. */
+	EXPECT_EQ(gsm_setconf(self->sfd, 127), 0);
+}
+
+/*
+ * Configure the mux and read the configuration back with GSMIOC_GETCONF,
+ * checking the value round-trips.
+ */
+TEST_F(n_gsm, getconf)
+{
+	struct gsm_config c;
+
+	ASSERT_EQ(gsm_setconf(self->sfd, 64), 0)
+		TH_LOG("GSMIOC_SETCONF failed: %m");
+
+	memset(&c, 0, sizeof(c));
+	ASSERT_EQ(ioctl(self->sfd, GSMIOC_GETCONF, &c), 0)
+		TH_LOG("GSMIOC_GETCONF failed: %m");
+	EXPECT_EQ(c.mtu, 64u);
+}
+
+/*
+ * Open DLCI 0, then open a data channel (DLCI 1) with SABM and check the mux
+ * acknowledges it with a UA. This exercises gsm_dlci_alloc() and the data DLCI
+ * open path, not just the control channel.
+ */
+TEST_F(n_gsm, data_dlci)
+{
+	unsigned char sabm[MAX_FRAME];
+	int slen;
+
+	ASSERT_EQ(gsm_setconf(self->sfd, 64), 0)
+		TH_LOG("GSMIOC_SETCONF failed: %m");
+
+	slen = build_frame(sabm, ADDR_DLCI0, CTRL_SABM, NULL, 0);
+	ASSERT_GT(slen, 0);
+	ASSERT_EQ(write(self->mfd, sabm, slen), slen);
+	ASSERT_EQ(wait_for_frame(self->mfd, ADDR_DLCI0, CTRL_UA, 1000), 1)
+		TH_LOG("DLCI 0 did not open");
+
+	/* Open DLCI 1 (a data channel) and wait for its UA. */
+	slen = build_frame(sabm, ADDR_DLCI1, CTRL_SABM, NULL, 0);
+	ASSERT_GT(slen, 0);
+	ASSERT_EQ(write(self->mfd, sabm, slen), slen);
+	EXPECT_EQ(wait_for_frame(self->mfd, ADDR_DLCI1, CTRL_UA, 1000), 1)
+		TH_LOG("DLCI 1 did not open (no UA reply)");
+
+	/* Tear the mux down. */
+	EXPECT_EQ(gsm_setconf(self->sfd, 127), 0);
+}
+
+TEST_HARNESS_MAIN
-- 
2.43.0

