Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2927274650;
	Wed, 11 Jun 2025 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636253; cv=none; b=F9lyGhfaPKY/uIURIGR0DSgy9RaeQhHl4G+bTcDVPU+4s0bx4JU5MIgA50jvgySlApZ8Vw6U0bzsaP5fsFEq8JBtb1TGbwPuDIfIo2O/DU9PmwwMAqJz5mZRp9k6KrR41k37c5n447wPtjwR/ipoRGYJ502NDNZ3mBknrsqpQUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636253; c=relaxed/simple;
	bh=tyMGFJEDosv2AewzwsSSsJRZRuSG65ioJg7V4YuZYN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4s/e6TwRSbthWaROkY6VnQ8cFXEoJqgZ0CEd7K8p6OrJTapuGNJyUgGsfhgC5gxUpz3KUFRIW1zErjN00AoOlDzpE1JF7SdFuSplamW3vT0oWqzDUbrXyhEZBByqKuRP/EeQxnNkfqI8d2LCsU4pkVRllJkFaQFx47+2Nj4ge4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2ovLDOm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2ovLDOm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E91C4CEEE;
	Wed, 11 Jun 2025 10:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636253;
	bh=tyMGFJEDosv2AewzwsSSsJRZRuSG65ioJg7V4YuZYN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d2ovLDOmCuPzSNM/4DBiYK4KPylviAUTRCaJFIyNzTKrUF48tUSSa/p0MKY5djlJ3
	 YbVVVB6XsF3OMI4tiaOxqT8TG0nuBY3luCNRDS9NU2fWFv72ATsaz4w1qdZszPtkMp
	 XSUYJhmZNRITeC8qp8yw8Dag4t3zrkmV1tDSifi+QjFTgGwwamxzSVjvjTcXkUAjGh
	 0N0jofKjShz2fdmQGKdZFURE6Z7YAycqhA6p6KcoDkUuT4tgnJ0UalcnVE35WM5sRI
	 BWqrqzatF1NVgcGT3+R9F/S6NJckD/TdRYToDgzrQ2zX1u78ZW7EvN4OGYYacguvMx
	 RQH0kFQwRmGng==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 28/33] serial: 8250: remove debug prints from ISR
Date: Wed, 11 Jun 2025 12:03:14 +0200
Message-ID: <20250611100319.186924-29-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611100319.186924-1-jirislaby@kernel.org>
References: <20250611100319.186924-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are useless, we have tracing nowadays.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index d42ceb6ffdc2..2bac9c7827de 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -71,8 +71,6 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 	struct list_head *l, *end = NULL;
 	int pass_counter = 0, handled = 0;
 
-	pr_debug("%s(%d): start\n", __func__, irq);
-
 	spin_lock(&i->lock);
 
 	l = i->head;
@@ -97,8 +95,6 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 
 	spin_unlock(&i->lock);
 
-	pr_debug("%s(%d): end\n", __func__, irq);
-
 	return IRQ_RETVAL(handled);
 }
 
-- 
2.49.0

