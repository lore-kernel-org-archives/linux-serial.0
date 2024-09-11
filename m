Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B4117DFFC
	for <linux-serial@vger.kernel.org>; Wed, 11 Sep 2024 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726079884; cv=none; b=CiaMqnRTAvq/hxpCEthCMQsVAKF3qCSlhWErDQaiLpHQVxMKh7WFAYns8qa6KBUXEY7/rtPKPoyCeoD9dnd8lnYCfu9zg+79j6SDCJ3DvhWIDb+NYvduRLb6F3zaXHNHa79frWgdHOECyu9/16SdEWciGAxZcRtLVx509RB33jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726079884; c=relaxed/simple;
	bh=720WqB0vXqiR7KaqW8XuBZZ/YnrreteG3lQDChgZIGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DMc00PCP4iHtb2oZ7pzem+Zdiyc6lVEkLQpXO7ZzulDi8QBSjNqZDecMACs7IA/jPt2KnvnzQlLPoJhjkt3CPSSwgvbY7ZG5V/+KWS9sEzDeV0+3vaU8jMZrMEMTzMKY4O6a/YQLM4/4Gp5GtKsCh5r8n1pKC94X4TxzvF17mwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hPTNJj2P; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hPTNJj2P"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82cdb749598so4849939f.1
        for <linux-serial@vger.kernel.org>; Wed, 11 Sep 2024 11:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726079882; x=1726684682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jD/fWH7izbc9nv5tphOU+iUvULm3JKen0/o1NQcnxpE=;
        b=hPTNJj2P64RmpaEuvooZKdFpA4I3Kd7hGkkZ5R9VmW0yLAKSDKI7qz0FMo1lpZvWaV
         q1ijiQkm6gC0NHJ/IdwrVZDwmYZ8NXTH3W+RWFQwzHiG1JyW/hZyvZbkAJqvYDQYnGo9
         EWk1PvSPQd14hsIiu8UA1u4z4s7oZAT1uKKqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726079882; x=1726684682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jD/fWH7izbc9nv5tphOU+iUvULm3JKen0/o1NQcnxpE=;
        b=l8Z7G2q6XAIZULz68auWh2dTJl4bIy9Ijcutx6qAZozs/Qsu86PGSCZmnrJm0UpuDy
         0lZVNH3YxZ/9ep7HAYlCUA6giEgt8I6w7C5Z/ZA3NpqgN91x4amwZxigETLElbq8Rqc6
         qFqMS6by/j0qGveNb0Fq2nV3g6uAxTH0acurvPGqzA5xv8BSFFbzAw5IkmjQpVaoJT7Z
         q4fY+h2XUbXa1F7GVL9hZkCWTa+8EGJ8Dx9xO3OAhSoSM3enMLb7+Dl40pFWIk9bbg1X
         FHWoxz5wVR+PWAPlaz9g9x+sYcAMNFppexOJS+eZApf29Qv9u5HMhDj7pkM6cACG6J/i
         carw==
X-Forwarded-Encrypted: i=1; AJvYcCXP/y9wImWNTPQB0HouJYb1tF6FJ9c03TdJgt99v1wlLT3jWsWu/NRGA27kI1c/qVm+2wUpvkqbhSqed0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4UfzdzSHtdXXWSbgIMy2Gp86nqwa5zHbbsuvfxUz7PyPF9J9P
	tE7kmaZoZHEa2We1Uox2fJWDr+bcjSiv+qhTWSvWEu9JPn+BVm7JJQ46m2TrpQ==
X-Google-Smtp-Source: AGHT+IFQn6XSvFm/TXyC2OLFo1OPMiJEq6iSd/tIUWNYHgJdMLX0o8SEBQxSSCkUTPbJbh4+IvJlYQ==
X-Received: by 2002:a05:6602:27c8:b0:82c:f2f5:388d with SMTP id ca18e2360f4ac-82d1f8fbe4amr86518939f.7.1726079881979;
        Wed, 11 Sep 2024 11:38:01 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-226.arvdco.broadband.dynamic.tds.net. [24.56.189.226])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f89aa5dsm127466173.89.2024.09.11.11.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 11:38:01 -0700 (PDT)
From: Raul E Rangel <rrangel@chromium.org>
X-Google-Original-From: Raul E Rangel <rrangel@google.com>
To: linux-kernel@vger.kernel.org
Cc: pmladek@suse.com,
	Raul E Rangel <rrangel@google.com>,
	Raul E Rangel <rrangel@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Ingo Molnar <mingo@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Yuntao Wang <ytcoode@gmail.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH v2] init: Don't proxy `console=` to earlycon
Date: Wed, 11 Sep 2024 12:35:14 -0600
Message-ID: <20240911123507.v2.1.Id08823b2f848237ae90ce5c5fa7e027e97c33ad3@changeid>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Today we are proxying the `console=` command line args to the
`param_setup_earlycon()` handler. This is done because the following are
equivalent:

    console=uart[8250],mmio,<addr>[,options]
    earlycon=uart[8250],mmio,<addr>[,options]

Both invocations enable an early `bootconsole`. `console=uartXXXX` is
just an alias for `earlycon=uartXXXX`.

In addition, when `earlycon=` (empty value) or just `earlycon`
(no value) is specified on the command line, we enable the earlycon
`bootconsole` specified by the SPCR table or the DT.

The problem arises when `console=` (empty value) is specified on the
command line. It's intention is to disable the `console`, but what
happens instead is that the SPRC/DT console gets enabled.

This happens because we are proxying the `console=` (empty value)
parameter to the `earlycon` handler. The `earlycon` handler then sees
that the parameter value is empty, so it enables the SPCR/DT
`bootconsole`.

This change makes it so that the `console` or `console=` parameters no
longer enable the SPCR/DT `bootconsole`. I also cleans up the hack in
`main.c` that would forward the `console` parameter to the `earlycon`
handler.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
I tested this patch with the following permutations:
* console=
* console
* console=ttyS0,115200
* earlycon
* earlycon=uart,mmio32,0xfedc9000
* earlycon=
* console=uart,mmio32,0xfedc9000,115200n8

One unfortunate thing (unrelated to this patch) is that the
`univ8250_console` registers as a real console (regardless if the legacy
0x3F8 UARTs are present) early on. This causes the `bootconsole` to get
disabled and replaced with the non functional `univ8250_console`.

[    0.000000] earlycon: uart0 at MMIO32 0x00000000fedc9000 (options '')
[    0.000000] printk: legacy bootconsole [uart0] enabled
...
[    1.141835] printk: legacy console [ttyS0] enabled <-- Booo!
[    1.156500] printk: legacy bootconsole [uart0] disabled

Changes in v2:
- Switched to defining an early console parameter
- Removed hack in main.c

 drivers/tty/serial/earlycon.c | 23 +++++++++++++++++++++++
 init/main.c                   |  5 +----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index a5fbb6ed38aed6..ab9af37f6cda35 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -248,6 +248,29 @@ static int __init param_setup_earlycon(char *buf)
 }
 early_param("earlycon", param_setup_earlycon);
 
+/*
+ * The `console` parameter is overloaded. It's handled here as an early param
+ * and in `printk.c` as a late param. It's possible to specify an early
+ * `bootconsole` using `earlycon=uartXXXX` (handled above), or via
+ * the `console=uartXXX` alias. See the comment in `8250_early.c`.
+ */
+static int __init param_setup_earlycon_console_alias(char *buf)
+{
+	/*
+	 * A plain `console` parameter must not enable the SPCR `bootconsole`
+	 * like a plain `earlycon` does.
+	 *
+	 * A `console=` parameter that specifies an empty value is used to
+	 * disable the `console`, not the `earlycon` `bootconsole`. The
+	 * disabling of the `console` is handled by `printk.c`.
+	 */
+	if (!buf || !buf[0])
+		return 0;
+
+	return param_setup_earlycon(buf);
+}
+early_param("console", param_setup_earlycon_console_alias);
+
 #ifdef CONFIG_OF_EARLY_FLATTREE
 
 int __init of_setup_earlycon(const struct earlycon_id *match,
diff --git a/init/main.c b/init/main.c
index 206acdde51f5a9..e668dda1c68f3f 100644
--- a/init/main.c
+++ b/init/main.c
@@ -754,10 +754,7 @@ static int __init do_early_param(char *param, char *val,
 	const struct obs_kernel_param *p;
 
 	for (p = __setup_start; p < __setup_end; p++) {
-		if ((p->early && parameq(param, p->str)) ||
-		    (strcmp(param, "console") == 0 &&
-		     strcmp(p->str, "earlycon") == 0)
-		) {
+		if (p->early && parameq(param, p->str)) {
 			if (p->setup_func(val) != 0)
 				pr_warn("Malformed early option '%s'\n", param);
 		}
-- 
2.46.0.598.g6f2099f65c-goog

