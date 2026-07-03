Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589543806C4;
	Fri,  3 Jul 2026 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068444; cv=none; b=GtNBco8LT9RLd+oG5MEfR9Loh/lOcmYPGbs/KDsQ6P4uQwtQfijQdirTs4IPMhph/JvK/pIq927bdCkR4cT+2aoj46sCe+bztJdtpz8CK+Sqz1SRjt7/ocVuai1jaxgUjzAcrXTe/BowQaHv5U/XluYPFQNuVZugu4R3pnVkT9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068444; c=relaxed/simple;
	bh=ZjgfKFaBKwUiQuPj5edkKu2DUZwuKZTsW20XPRPgCxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mua/arDrXZUzQR5nTtn1oXbnDCTnn8J/Nu+9YtgmB7lpF5rQiI2mX4MP7hxU+QdpPIXzp12uUPRRI5zVj+PdDCOkU8Ko4rEVgv2lwGUYSUYRf+UTOHmzEp+deOmZRxXZE5ZPGaE2WU/tpwO43jBHYHcBVLxpdZUbSS4fmqjxKTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3/VTc9j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3/VTc9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1ACB1F00A3A;
	Fri,  3 Jul 2026 08:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783068443;
	bh=wGrXjq9ga1ilKWke6gILF8Okc9rK1Hgo7gHI33E/SIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D3/VTc9jTjVH3B9NldIOOjAvQbQ67JdyOQTQ6ULPu0LIN/Bdwvi7SsQRMxYqUOQvs
	 2JEhYpGSsYisw+jl5lYAVtG76GoFb8/HRZYJxSUWaNJM5UsfgNzjna+gDH6IKwztc6
	 DTnNdYDqjhPdmr/+5wXhnM+O0qKB+RvQmbueAkpPnpkvLb0xTu2ohbmnleOQcwbHV6
	 7BKGy9xCsGgOqw1dHCkvoon5ZWFuCQjUcbYWybjz7E4vjYjxX745AQMbQKmB6c8UX4
	 MW28+ph8kYuiBqBlaOzIl8WVwEabzaG3yfIrGkxxAz0bRBHCWdRT3l3j4mi612kVCD
	 HpFhZTrCOq4YA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 2/4] tty: goldfish: drop unused goldfish_tty::opencount
Date: Fri,  3 Jul 2026 10:47:15 +0200
Message-ID: <20260703084717.176442-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703084717.176442-1-jirislaby@kernel.org>
References: <20260703084717.176442-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The field was never used.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/goldfish.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index 16edd71a0d8d..69367d878877 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -37,7 +37,6 @@ struct goldfish_tty {
 	spinlock_t lock;
 	void __iomem *base;
 	u32 irq;
-	int opencount;
 	struct console console;
 	u32 version;
 	struct device *dev;
-- 
2.54.0

