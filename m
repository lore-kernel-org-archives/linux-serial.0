Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C06442C;
	Mon,  1 Sep 2025 05:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706071; cv=none; b=c2MbM0HeIvW+9EWDOO5CRPf+NXtDBrvAWz5e0fX7Rn+uG773eYSorX/ajQo8QU7JybC7RREwgFNg+fLyl3BAU9Xr4Dw3VdjfcHU78fa3YwBuFgMCR9Ezyugjyiaq74QYUMmhkixMozJlK+uhWjIbVe9fYRIlxjo6F8pEUHAWHpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706071; c=relaxed/simple;
	bh=0On2SS5VOGYP+/RsAX7kQCgMgPC2Rpdqcwjvm8UVUCw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qqgHvuMpVXj9Z0XgN7ZCaWUEhrsbW+CvQ+nQwXt0CjL9zZfmQ3L3906u/s2QuRxEKhqd+EKeOWnak76WWvkrfGWhujX+joeS6ZUOTC/+HDkTDddXgbovTqzj9j5oh1UxEZj1lNRgt+BXiGbBRRIOOaeWrsbtdofon9sS4M5bRn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: by c64.rulez.org (Postfix, from userid 1000)
	id 5B704102AD; Mon,  1 Sep 2025 07:54:19 +0200 (CEST)
From: Zsolt Kajtar <soci@c64.rulez.org>
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: Zsolt Kajtar <soci@c64.rulez.org>
Subject: [PATCH v2 0/4] tty/vt: fix various 512 glyph font issues
Date: Mon,  1 Sep 2025 07:26:32 +0200
Message-Id: <20250901052636.8981-1-soci@c64.rulez.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having the 8th bit of a glyph in the attribute byte is tricky business.
These patches fix most of the cases where it went wrong in the VT code.
What remains is related to fbcon as well and so not part of this series.

This run fixes concerns raised on review and adds one more patch for a
problem which doesn't cause visible effects.

These patches were prepared to apply on tty-next.

Zsolt Kajtar (4):
  tty/vt: 8th bit location in vc_uniscr routines
  tty/vt: Prevent 8th bit corruption with soft cursor
  tty/vt: Fix unreadable kernel messages on vgacon
  tty/vt: use correct attribute mask in do_update_region

 drivers/tty/vt/vt.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

-- 
2.30.2

