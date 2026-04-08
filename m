Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D5334FF40
	for <linux-serial@vger.kernel.org>; Wed,  8 Apr 2026 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775658071; cv=none; b=qNCZh9/XJneXBStDNRVfmERStEnQp7iggK3E0LkLfFJImXZaAkTXeq/dwk4/m72yyg4POEsA3CAzF8XKkQZZYTzp42qTYdHckBVWkaQgRtQ7KPJiPeEAmAP2TlJXTauEeX7Vo5cQ2OEM9S3AXb1rxeVjlCHMyiNobp2RN94a9Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775658071; c=relaxed/simple;
	bh=GEsOH353p/1G/JzP0djxYvZlTie3JSvCRDJMrIeAh+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tD2aAY2HTDLLAcETPbLaGq3FvQwxS6tJnHTAIA/Y0DYvq+lBYJkcU8WVXSftRnr0DpR9Lo3WFYQMFl+TeIjOC/RgOKzFZpCpJKPuD+CwyzhziQon5fYxy655u2J3PPz8F9JK9+7j0U9DbdiWv8L3832GZpyCwhwyRNtgW+4el3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=phAkUg1R; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phAkUg1R"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d01d6b50cso5992098f8f.1
        for <linux-serial@vger.kernel.org>; Wed, 08 Apr 2026 07:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775658068; x=1776262868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CMF6apjPFsM64OzbUJQDdgH7IQW/+yy5CdRNlHUwV6U=;
        b=phAkUg1RnGbO7UHtnqFdsWio3AHfh+tRYGPMEP0cwVV4GsIM43eU7bDqTGGluv7rZy
         UJ+IcLxfLmQQTRKByWo/VdVmkETTltwhI2vk5SCrbobEGu1sIH0kE11q+uLrWMAA8K2b
         i+I5yemRg4ziTvcmTkID4Cwf0bV1h6lMhkkMyTKwI+Mg+G+B/pfLEBrSGLJmvtz+lxdG
         FFpRrhr/SJ/OZgy+84Q7QdMs6S11nK1ripAA9GtvMob7AORt/6uik+jz/lgS0cwvqO4R
         2skR/oTcGsUrRk42iFW+ymG89G/Cpu9anMcShs6gpaebNxewKGOjaVyu3Va4i+jKQaJP
         O4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775658068; x=1776262868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMF6apjPFsM64OzbUJQDdgH7IQW/+yy5CdRNlHUwV6U=;
        b=b02Geq1kJXwxvHclF1FjOW/zDWHNDmyUNjDCfdg/p5DZ/GZjOfbbNpEwgnqNsqPfbx
         mVTfgglWCPhecvxuHRZz9EJJ6u1BuM7Azjmn28e0Lx6uua5m3UQ1yzRN34O0Z1ZRkryO
         RJiTvYAqNvhCjuitipnGF4i0pSdDF/2carT7Odwq5VpJSP83iBZYk4lkyAi6jxDdptp+
         fhvRXo1xUJklDxJ7irJgXu0gsyJksgKe+FutoDIiH8lvWjp3mH+MH9usMVTS2aumFT+3
         GUCT0QZhDdongLo5wGXrQucQnwWhjV6EdVnHbiUpZ5etFCXoaT7jFcp3AFBWoHBmgIhC
         I0iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXee0e/jg/cruHq/cpXX48nlAP95S4Dp9Dbp2UUFxkJbUn/hohL570YJ+U2mzZcevBSpw+/e/HF/oW3mss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyInhhUY+KY6Vl84EXGNXEQ8ezCiCUD6uuO7oszcBaTLopxvR3Y
	fA2oBlH0M445nohT8qPE5e9ge0WC3EzhRnixY/cR9qbGgkSgVy8lbll8
X-Gm-Gg: AeBDiesYtq+xCXizY+trkAhCFOPPkMXXv24pzX/t6P+YTYHalhp9hCzteP2DpmqxGhz
	KTvuUGBuj+Jyi+eAKBhZ988K1eT+JDx+GLtg5e1RxSmqUOMGeTzj9Zo1j+1fN4bUcXGQvVKsJI2
	3XRD3bR3GSPu6hdXjn9lzn83lW8DAe/2EgQ7ZfI8UNAq1+9fD5Idh9xPEVKAbprBN3d257AwlC/
	rQHr9ZpVwWXgTsvhweWFWkuD3nWaRri5I2Rvtf+grhI0JcbaVP7cKdBQYwVKoxwsnIMhJqOnOvk
	YB+5eF561LihUGosV81cWP10O0ov8OrSjHR+PvFp9M7jS/6TKZ4PqpF2MUmXQnlJydTKLq7mmcz
	TqBpjdY/cNXBvBtrp60WfOxz7dBvUJNvxISaEnX9t/uwoKCazu8+hrUshnWIkuqqc9OE5jrdG3+
	RzfVTKgcyohR1N5Hw/OuhBHA/KLHGLa61e4KnkxbA00gBS2dk=
X-Received: by 2002:a5d:5f85:0:b0:43c:f7f6:6016 with SMTP id ffacd0b85a97d-43d292daa51mr31326678f8f.32.1775658068345;
        Wed, 08 Apr 2026 07:21:08 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:f65c:8080:131a:202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e1fe0b0sm60474467f8f.0.2026.04.08.07.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 07:21:08 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 0/2] serial: sh-sci/rsci: Fix divide by zero and clean up baud rate logic
Date: Wed,  8 Apr 2026 15:20:57 +0100
Message-ID: <20260408142105.310210-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

This series fixes a divide-by-zero in the sh-sci and rsci serial drivers
and follows up with a cleanup of the baud rate clock selection logic in
rsci that the fix exposed as unnecessarily complex.

Patch 1 guards both uart_update_timeout() call sites in sci_set_termios()
and rsci_set_termios() with a baud != 0 check. uart_update_timeout()
divides by the baud rate internally, so passing zero causes a divide-by-
zero fault when the hardware returns an unsupported or invalid rate.

Patch 2 addresses a related issue reported by Pavel Machek: the goto-based
early-exit pattern in rsci_set_termios() was obscuring the control flow.
Since RSCI only ever uses a single clock source (SCI_FCK), the multi-clock
candidate tracking variables (best_clk, min_err, brr1, srr1, cks1) were
redundant. These are removed and the goto is replaced with a straight
forward positive conditional block. ccr0_val and ccr4_val are also dropped
in favour of hardcoded 0 at their writes.

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

Biju Das (2):
  serial: sh-sci: Avoid divide by zero
  serial: rsci: Remove goto and refactor baud rate clock selection

 drivers/tty/serial/rsci.c   | 36 +++++++++++++-----------------------
 drivers/tty/serial/sh-sci.c |  3 ++-
 2 files changed, 15 insertions(+), 24 deletions(-)

-- 
2.43.0

