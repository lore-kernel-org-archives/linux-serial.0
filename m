Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A9D3A1DB
	for <linux-serial@vger.kernel.org>; Wed, 29 Jan 2025 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738168052; cv=none; b=MbZthhXlYIUlrxGS+/0qXJfbJRuRueAmtHIohDS5LtqHaP2nvQdarQQoYMoaWGGEyL9oHplvb2f3PJQnEP0AYTSyuyi4e6x6j2bbcaCo1SWtBG+78f0sJ9OCVtM3lEGdEMqWXgw9FaL1qigTgTqYrXOXRkiGvtZTw37KnJpaOM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738168052; c=relaxed/simple;
	bh=iIZj2D2lI5hByktkHIVyTpeYdjbEhry1/9d07uIntBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T53Tcz92nYAQ4SeN6XUl0OJcbQpNozIPd2j+8uamhZ1MMsRSQpM2r9559QrLOfXeyNc4rq3D6Uo5TsCPsrlrvKicdffZBs3cl68UiTMcCBsLHsTg/CwOIswjINm1CcBwH74vXgVQ50xF1b1+KRZqv5+SwdBdgmSRP4d+9kyC+l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DYBr1L+e; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DYBr1L+e"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2162c0f6a39so18333635ad.0
        for <linux-serial@vger.kernel.org>; Wed, 29 Jan 2025 08:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1738168050; x=1738772850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6AqjmiYQ2r2JxBlknz3mDpl7pUK+MR/UX2y/MOk5lqw=;
        b=DYBr1L+eFOWsIMeu3bX/Ah288eJa0sw2TqXZpwLQ93f2zskGWhrd4BUG24ACrhyk3R
         TmuTjveSDFvrgiyPCApd+inlNxanDYkVveTqUKWSOk+Yx70NUNZSDtOdm7/yXJ8Rp4Ow
         zZRPI+vxfRBjR3Jf0ZuT9D7hX629bhotfNGak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738168050; x=1738772850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AqjmiYQ2r2JxBlknz3mDpl7pUK+MR/UX2y/MOk5lqw=;
        b=jMtyXO+EBlkm+1RWzU0BeNwfecbIUTUxHvIWlW1giQIn3+zwPISS5WP+LspbEq8OrX
         inDkiQ6CmRD9QUwF0ugzPpCOTkJOilbTtllQukRVMXaZN0a/5EO3qQZK8GcXhtpQIHK6
         SSlTTUu8DGt5+EkmbZ5h7vilVLdeBD5U7ZEBMNJdTjRLyF0qfwxj941FiTivOnTSLCbX
         XJy8ssvZ3sCPFl00n5jtUytkmiNHedbpQ8GimCs9OvkeNxVJEXjpxUQtJBqWmh/2znlL
         j0uMM1hnsJU2jIVDaYSxMhlR2uYePp5Nn5ysRgx30M1r123KUKPcN/AjQ85cFh7nNTKT
         1cHw==
X-Forwarded-Encrypted: i=1; AJvYcCXKCq0v8cC0mBthk0YtlVaw83XzGSJnE7/cpSHtqN28COZL+omYTsUsrDMaq2hoDPOX0pEUp6G+4J7rC6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNMU3JOTuqtMIDnAepm9+ptKyseH2Y2YiKSy5xAkvLNQpFohZk
	xZ4ayvcIeUMs+YMjSdDcoD+znuazUUCebCmI/fGUHz9v0nbiVisX//cPArkEbw==
X-Gm-Gg: ASbGnctlNl6IEHGHgslLLB2ovLN5oIeP7da+4o0wxODi7pB1kdYxmbQtXbWqt4TZzzP
	qrIRKPAe1HRM59VzA9DXp9L72G5VlyDhI5nVy8EYnIArg6bUjOecoouTOvyHifqvb4Mx8s+8WvQ
	JRlp0PNC5G/CZxhwj7m8ndMFyDq6+8f3Q2bkD6PjSVG+S1cuycZnJ+S68BcthPJqo6J1LzXq9Fr
	xG1JdLbYFDEe+tRfguM67KZtDzkk4F1F+a5kDjh4wb1T4Vcm9m+qBlG6yEDCsnycw6tlP/biVuH
	eQZV18xXXZPqq+pq7zGIGxE5lrMDUR/u7XI=
X-Google-Smtp-Source: AGHT+IE/VFwz1cAbCXuL77U+nqFDurQyZmhqNdQE3rMj9VMcAjYu039NpeF11AckPBSIZB8gTuRRng==
X-Received: by 2002:a05:6a20:3950:b0:1e0:c166:18ba with SMTP id adf61e73a8af0-1ed7a538802mr5899956637.12.1738168049961;
        Wed, 29 Jan 2025 08:27:29 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fa8a:f68a:6cb9:40b2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac496cb4810sm10577009a12.66.2025.01.29.08.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 08:27:28 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Daniel Thompson <danielt@kernel.org>
Cc: "Dr . David Alan Gilbert" <linux@treblig.org>,
	kgdb-bugreport@lists.sourceforge.net,
	Anton Vorontsov <anton.vorontsov@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	linux-serial@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Jason Wessel <jason.wessel@windriver.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Nir Lichtman <nir@lichtman.org>,
	Robert Marko <robert.marko@sartura.hr>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Zheng Zengkai <zhengzengkai@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] kdb: Delete never used KGDB NMI code
Date: Wed, 29 Jan 2025 08:25:49 -0800
Message-ID: <20250129162700.848018-1-dianders@chromium.org>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As pointed out in the review [1] of commit 39d0be87438a ("serial:
kgdb_nmi: Remove unused knock code"), it's not just the knock code
that's unused but a whole chunk of NMI-related code in KGDB.

Look back at the original series [2] and revert a few of the patches
that managed to land and had no other purpose. They've been in the
kernel for over 12 years and if nobody has used them during that time
then they won't get used.

I've validated things still compile just fine for me and I've tested
"allmodconfig" for a few different architectures. Hopefully I didn't
miss anything, but based on "grep" this is all just dead code.

I guess I'd expect this to land through Greg KH's tree, ideally Acked
by Daniel Thompson.

[1] https://lore.kernel.org/r/CAD=FV=VH5YWfTggGNt2KLoSPKqVTmWArEgccok3uFQ5BCA7cNw@mail.gmail.com
[2] https://lore.kernel.org/lkml/1348522080-32629-9-git-send-email-anton.vorontsov@linaro.org/


Douglas Anderson (3):
  Revert "tty/serial: Add kgdb_nmi driver"
  Revert "kdb: Implement disable_nmi command"
  Revert "kernel/debug: Mask KGDB NMI upon entry"

 drivers/tty/serial/Kconfig    |  19 ---
 drivers/tty/serial/Makefile   |   1 -
 drivers/tty/serial/kgdb_nmi.c | 280 ----------------------------------
 drivers/tty/serial/kgdboc.c   |   8 -
 include/linux/kgdb.h          |  11 --
 kernel/debug/debug_core.c     |  14 +-
 kernel/debug/kdb/kdb_main.c   |  37 -----
 7 files changed, 3 insertions(+), 367 deletions(-)
 delete mode 100644 drivers/tty/serial/kgdb_nmi.c

-- 
2.48.1.262.g85cc9f2d1e-goog

