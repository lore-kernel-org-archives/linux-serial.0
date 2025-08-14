Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09555266B6F;
	Thu, 14 Aug 2025 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156303; cv=none; b=c95QB88PxUYKWDspwzyWibi4d0uLOve+sMBrcU30NBTZXg+C+/ylPndQ6dctZOnW3LARf1/sQbxSja5pAGpdfa7+nIfVxt1Lpo4eYQpaShlseT7rDuIJmnSC5s+GFNBVVekhYc//j5uH0t9TKFyQZlXC6MYuVDVD0tpQKGwL6fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156303; c=relaxed/simple;
	bh=TmExkHaDrPFt082jnRuwqDdyWnPnTvNQyfEEU6G328A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sX3Yvu/6scdI9Ep16jBJC3E3SC5qHFerVhdFF7JbNmc6WTMwSvUrgc2c70E6ON/EN2to4K6l2vvaDl22kLaAJ4OA4uuyOdIAOPZcUVgsoKSKEICNn++Sc+WSYz0u9WkyczVvek8Y4twbqw1EFBHozXDZLyTamPhC0YulaDeq6gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pipac525; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pipac525"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747D9C4CEF4;
	Thu, 14 Aug 2025 07:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755156302;
	bh=TmExkHaDrPFt082jnRuwqDdyWnPnTvNQyfEEU6G328A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pipac525nZPCujd9tdudUvVn0NXZ1kXkZelqFN3B5bWFjDQYNhtGKW21CRLB04Ww2
	 YXU6k6QOTesnEGelvk5bnagNEzt5sdbA+WGW8n6dVzs0q15tadDBabGglOWnVMkPcN
	 Bxh6sBXBAI3rq3Zni/1mACUDNe4VyMGVXEBibewVQuk2vZS5ZZ5NeGjofumPUL054x
	 tX+hjeDEIofhfLGDSCaMcCJwQ9xD27qde/7IAxNnZdl09srSDmFPQjbzaCZWniOQGr
	 O7M9pqb0fc4ZLxwYW3R/SgXlWX+QRV+72qeScqDw3BuhQkdEt9dAflEpmqwLpLH5Bt
	 EInQ7/kcPLC5g==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 02/16] tty: introduce tty_port_tty guard()
Date: Thu, 14 Aug 2025 09:24:42 +0200
Message-ID: <20250814072456.182853-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814072456.182853-1-jirislaby@kernel.org>
References: <20250814072456.182853-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having this, guards like these work:
  scoped_guard(tty_port_tty, port)
    tty_wakeup(scoped_tty());

See e.g. "tty_port: use scoped_guard()" later in this series.

The definitions depend on CONFIG_TTY. It's due to tty_kref_put().
On !CONFIG_TTY, it is an inline and its declaration would conflict. The
guards are not needed in that case, of course.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 include/linux/tty_port.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 332ddb93603e..660c254f1efe 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -270,4 +270,18 @@ static inline void tty_port_tty_vhangup(struct tty_port *port)
 	__tty_port_tty_hangup(port, false, false);
 }
 
+#ifdef CONFIG_TTY
+void tty_kref_put(struct tty_struct *tty);
+__DEFINE_CLASS_IS_CONDITIONAL(tty_port_tty, true);
+__DEFINE_UNLOCK_GUARD(tty_port_tty, struct tty_struct, tty_kref_put(_T->lock));
+static inline class_tty_port_tty_t class_tty_port_tty_constructor(struct tty_port *tport)
+{
+	class_tty_port_tty_t _t = {
+		.lock = tty_port_tty_get(tport),
+	};
+	return _t;
+}
+#define scoped_tty()	((struct tty_struct *)(__guard_ptr(tty_port_tty)(&scope)))
+#endif
+
 #endif
-- 
2.50.1

