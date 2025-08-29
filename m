Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5222566;
	Fri, 29 Aug 2025 19:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756497329; cv=none; b=D8nFefSWdQCsLiRUDRfuOIvqNFUjwV8xw97qNgBuKJQdOi2vzWMDrQrBi9OPnvKo/PNo43akKMrG68lTP223JUspHGEDRBSsqGhWH6nvqCQOZ/zsJGdrzZPwRqqHz2N+jAS8NTMx4/anKe02VA9UbH2KR2N/mEmN65eMhLLIbW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756497329; c=relaxed/simple;
	bh=OmuktVN/aEoBARUaD+JbEVwzeH0WNrHXN2lOQdJi6D4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=luSlRBal6tydtAJolgIKlh5Bd3xBKvgcxn1++lUTQO3NEvBHo/4bGTDt0voVhDaOHdHdoqAQJJ31lRTf9k7WDkdvIxngUnSGd/+8Ny0L1mJnnfLByQQNt1hJI6gPuzodiVlUL83H30hLY53fU74xy9QnhlNy9/uDq26bssZeECE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: by c64.rulez.org (Postfix, from userid 1000)
	id 1F8CF10336; Fri, 29 Aug 2025 21:55:17 +0200 (CEST)
From: Zsolt Kajtar <soci@c64.rulez.org>
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: Zsolt Kajtar <soci@c64.rulez.org>
Subject: [PATCH 0/3] tty/vt: fix various 512 glyph font issues
Date: Fri, 29 Aug 2025 21:49:05 +0200
Message-Id: <20250829194908.24852-1-soci@c64.rulez.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently I've run into an issue where a monochrome fbcon behaved strange
with a 512 glyph font. That's mostly a fbcon problem but will need
changes in vt as well. However this series is not about that yet.

Instead it's about 3 related problems which were found at the same time.
These are specific to vt only and are a problem with vgacon.

These patches were prepared to apply on tty-next.

Zsolt Kajtar (3):
  tty/vt: 8th bit location in vc_uniscr routines
  tty/vt: Prevent 8th bit corruption with soft cursor
  tty/vt: Fix unreadable kernel messages on vgacon

 drivers/tty/vt/vt.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

-- 
2.30.2

