Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45F6363092
	for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693872; cv=none; b=cJjEGhSIwyeUpI58sDRIWv0SGTNEzBjsUTzVKnfoSDtgwFbS5MxYnFX+T1Oox7jkrlBVdbjdXHH0FMq+NqyDA20Na8kRTXYb0cClR+abUtcAUoeZURxzRxLk5ozLyucpw2iL6QSv8ekFj5xmCituCzNHUpvgpo2u4LAQifPKABw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693872; c=relaxed/simple;
	bh=iIZjlaEpH3IaeaBP0OeSJtw3RsevAJcckKTLZcxEn5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cPUYE6l3bpwWqUsl4mv7vp9HqfVXdy5mmalMakNiAXX/wxTfnXc53IJJqNqSXeAObjsQsBHvLoJJj2n4E3fh/PY9uJDirvb9US+nTX7p5hdRZk2yZXi9ORcMAzXYjvzdtNG5ho2j2ZSDMBeQ1dCs6bnAC0fwTnPJTzRbtWSLUDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6rLKudc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6rLKudc"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891b0786beso10118975e9.1
        for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 07:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776693869; x=1777298669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zCQTEi8y0iS44jkCVEZLALmk/wH8gE9Ak1V9UeMwaJs=;
        b=l6rLKudcEKTevaybzudK2Zi3kjt5xLHwS4vhWMrbh7mKBXkzosF235P61EtyrRIYSA
         EezOqZ59YyRpHzTAZgx/reXoBnwVdjJqJlRDpmiZ2XzNHzfecKzalqj0kgQ4RE1Q9gl9
         5fwu8tCH58Q9jebzbIo2hM00e05ibAFtbg/dEYJBRUEdPvNhL59UcUwhoF4K4wECnu6i
         rGfEa96pltenpc4QToQS7bJnE+2B9x7xe+WJOM3KNMbA3/SzmEQWUPk5xm85mfM7qVCd
         oMaWtTwCp8H9uj9T3LjJpIISh8hG27sg0Mru0cyZj8dzJ6qJvwDU1eSDyK3CR3e/xkV3
         /1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776693869; x=1777298669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCQTEi8y0iS44jkCVEZLALmk/wH8gE9Ak1V9UeMwaJs=;
        b=plL9njI6z+4TPDrr1CB7o9+2bW5JKXqGTymw0BLBQaEzgPSo1Z3nbuDQIZJIfWeupa
         yrjaV5FWoQlr/PgtkcyRGftfSjtIem6pqlDa3r7Hrhnlwvte7IHAyHK3R4B/oN23JqM7
         YjntZSoMUtWMRdXkOretBdsT14zapNYrEz0BkXS2L4tnIIWP4daNreLQwCl+jwxOR+ba
         FHH3UWwMFsAGcawjBH767UGqilg3nujuA9SvZIHnJBvnAyHzjdAVe+Xy4k2X4o5zHDzd
         60CJlMnPv6lqTD4ZP84NVi8bd0a9C7OAxla/S+MbEjgn99z9W4xO6qGJbLejFxOyAY0u
         T4wA==
X-Forwarded-Encrypted: i=1; AFNElJ9mq6jMsQScRCEO5gfmiqSDqXRgLOSgzV6fs2986QfmlkUjBMNldEmr0SdUmHIgm4xbt6+/qiBHwIQ+INI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwugXXiKCP+h5ZMnV/P6SBlt0yLdbPRpL3dqldEc/ibEiozHR+9
	OukQWr3tL1fe/w6pnTku3pI7sFzo4nADhXqFOpvy4dTa0S4kF2aIwLxw
X-Gm-Gg: AeBDiet0bbQ5P5kv+ddjxyTm2cb4N42t6BMg0gPeDnIh99LJ+7jkESIHjTLL+QgsUzh
	+fTDxgZvIiBRK2zj1Fe4dCA5FgkCNXRfs3Wmr+qRTYU16efKmxpr9kM71rYtt4t2J9n/D0budXv
	Ux3jgiGXUwcQyzSqbMMNQVOKOW0HH5KFtz+CJbvK31FhToWu++M9DOZ8EZWlYpi2HuV3oryuIeO
	cv3yorZuDWq1KgaK/05uvM0EGIgKsQJakkzEpvSRKGUPMnpt8zoyycjOi2Gx4wUuBz2+j5P0aP2
	enJDSF8vtTaD9+TdK+FogCh/Ws9dz6zhZGuGX8xUPmZBTpb/1z6NXi/PkXKOJ4wMlStROlHiZPl
	1LaGWLNdytU1GwPQQ61VEa+DmXJ63dDSM6qTrvMAIvU6R1i0sFcKKMQslgQZnZ4VqiVNujz2gk9
	6pdmvy3QuX3P8NeJPWBQsv29CE6Nc0uJxiX6IyVNkaybdwffFQUui8WTIspmZuwerXQNNKHQ==
X-Received: by 2002:a5d:5f47:0:b0:439:b55d:b0e5 with SMTP id ffacd0b85a97d-43fe3dfbfdfmr21692332f8f.28.1776693868847;
        Mon, 20 Apr 2026 07:04:28 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:5f3e:f914:6f8c:72c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d525sm28377778f8f.31.2026.04.20.07.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 07:04:28 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 0/3] serial: sh-sci/rsci: Fix divide-by-zero and clean up baud rate handling
Date: Mon, 20 Apr 2026 15:04:20 +0100
Message-ID: <20260420140426.237865-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

This series fixes a divide-by-zero fault in the SH-SCI driver and cleans
up dead code and redundant variables related to baud rate handling in both
the SH-SCI and RSCI drivers.

Patch 1 fixes a divide-by-zero fault in sci_set_termios() where the
expression (10000 * bits) / (baud / 100) could divide by zero if baud is
less than 100. The expression is rewritten as (10000 * bits) * 100 / baud,
which is algebraically equivalent but eliminates the intermediate
division.

Patch 2 removes the dead zero baud rate guard from both sci_set_termios()
and rsci_set_termios(). On DT systems, uart_get_baud_rate() never returns
zero, making the if (!baud) goto done; check and its associated done label
unreachable dead code.

Patch 3 refactors the baud rate clock selection in rsci_set_termios().
Since RSCI only supports a single clock source (SCI_FCK), the multi-clock
tracking variables are redundant and removed. ccr0_val and ccr4_val, which
were never modified from their initial zero values, are replaced with
hardcoded 0 at their write sites.

v2->v3:
 * Added a patch to rewrite rx_frame calculation to avoid divide-by-zero.
 * Added a patch to drop zero baud check from sh-sci and rsci drivers.
 * Dropped reported by tag as the goto statement in rsci_set_termios()
   removed in the previous patch.
 * baud check removed by previous patch.
 * Added missing macro CCR0_RE while dropping ccr0_val variable.
 * Updated commit description for patch#3.
v1->v2:
 * Add a patch for avoiding divide-by-zero fault.
 * Dropped the check (abs(err) < abs(min_err) as it is always true.
 * Dropped variables best_clk and min_err as they are no longer needed.
 * Dropped intermediate variables brr1, cks1 and srr1; results are now
   written directly into brr, cks and srr.
 * Moved dev_dbg() inside the if (baud) block.
 * Dropped ccr0_val and ccr4_val, replaced with hardcoded 0 at their
   write sites, as they were never modified from their initial values.
 * Scoped variables err and srr locally within the if (baud) block.
 * Updated commit description.

Biju Das (3):
  serial: sh-sci: Avoid divide-by-zero fault
  serial: sh-sci: Drop check for zero baud rate from
    uart_get_baud_rate()
  serial: rsci: Refactor baud rate clock selection

 drivers/tty/serial/rsci.c   | 34 ++++++++++------------------------
 drivers/tty/serial/sh-sci.c |  4 +---
 2 files changed, 11 insertions(+), 27 deletions(-)

-- 
2.43.0

