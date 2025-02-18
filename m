Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185E4243943;
	Tue, 18 Feb 2025 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881814; cv=none; b=VmNxfzEe/jFm3Ae9QFX7COzXNLttBR3BIa8Wl3BVX1gk63CV+Pk7HaUW5O/ZkiTT1N2jV54FJbUFAGGhXIlWWBrOTOgIrMh1AQdtSrrRK848cg56iD5GnF8Mbyu2HsNGxrCXQFZdrq6xHTfnqPNozpdmXyXkPniNAHa5uU5HzSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881814; c=relaxed/simple;
	bh=iTDFJWOVtK7nOXHhqE9lbiebet3iBXUW2w1x5ktw0dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WczJjEJE4Q/8ejUnYfgAV/H+FZHV43aDmrOFoA39K7o2/XBGnBFhdVt+SezfXkLb8myKEE2SVHqy/3KTB+IUwL7Y4ozA8Cf1NUbHLobuNv3Re+k/UZQQhFuUpbUKcplkRxhC3EJ2Oxf8ZncqOSGyP0kg03/dchsUu13BCgg8IAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hH6dMI0W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hH6dMI0W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50C8C4CEE8;
	Tue, 18 Feb 2025 12:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739881813;
	bh=iTDFJWOVtK7nOXHhqE9lbiebet3iBXUW2w1x5ktw0dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hH6dMI0WXlfTfeRDyhQlDkWkdKF8HSRGhT/JKP6c7NrtXJPo9koZNTMDD/OPhccjj
	 UwpkzGF5vbM+pLRc+RE1GkuERtN0ZsITqe6WqDr4LaZ4+lpcoDufoXHk32E9e9XDzi
	 KG53Cpa5FRCehBIVE5Tgl+RA/V8QH02yxsDgpm/lru7MwMa6QDp+kaETPg51+eSqea
	 NtUik8yJmWqMk4pcRDkMUk/MOGD64b0ZbQMvTvggS1uR3Vm2gEXQ0l+SLtkdPrNBTN
	 eK9sg93OaT2s4nC6H8qFOHjV+LUA0HQEen3xExIEMdeksnE3n2kebjgRDJIoIsMkEt
	 3oHTF0jhhqRDg==
From: Alexey Gladkov <legion@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH v1 2/2] tty/vt: Gather the code that outputs char with utf8 in mind
Date: Tue, 18 Feb 2025 13:29:39 +0100
Message-ID: <35c2ae96b68b64ee71b636df0e0c1907e0766a24.1739881707.git.legion@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739881707.git.legion@kernel.org>
References: <cover.1739881707.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we putting character to the tty, we take into account the keyboard
mode to properly handle utf8. This code is duplicated few times.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 drivers/tty/vt/keyboard.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 7df041ac4d5c..eb32bf00fe7b 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -376,6 +376,17 @@ static void to_utf8(struct vc_data *vc, uint c)
 	}
 }
 
+static void put_queue_utf8(struct vc_data *vc, u32 value)
+{
+	if (kbd->kbdmode == VC_UNICODE)
+		to_utf8(vc, value);
+	else {
+		int c = conv_uni_to_8bit(value);
+		if (c != -1)
+			put_queue(vc, c);
+	}
+}
+
 /* FIXME: review locking for vt.c callers */
 static void set_leds(void)
 {
@@ -454,13 +465,7 @@ static unsigned int handle_diacr(struct vc_data *vc, unsigned int ch)
 	if (ch == ' ' || ch == (BRL_UC_ROW|0) || ch == d)
 		return d;
 
-	if (kbd->kbdmode == VC_UNICODE)
-		to_utf8(vc, d);
-	else {
-		int c = conv_uni_to_8bit(d);
-		if (c != -1)
-			put_queue(vc, c);
-	}
+	put_queue_utf8(vc, d);
 
 	return ch;
 }
@@ -471,13 +476,7 @@ static unsigned int handle_diacr(struct vc_data *vc, unsigned int ch)
 static void fn_enter(struct vc_data *vc)
 {
 	if (diacr) {
-		if (kbd->kbdmode == VC_UNICODE)
-			to_utf8(vc, diacr);
-		else {
-			int c = conv_uni_to_8bit(diacr);
-			if (c != -1)
-				put_queue(vc, c);
-		}
+		put_queue_utf8(vc, diacr);
 		diacr = 0;
 	}
 
@@ -685,13 +684,7 @@ static void k_unicode(struct vc_data *vc, unsigned int value, char up_flag)
 		diacr = value;
 		return;
 	}
-	if (kbd->kbdmode == VC_UNICODE)
-		to_utf8(vc, value);
-	else {
-		int c = conv_uni_to_8bit(value);
-		if (c != -1)
-			put_queue(vc, c);
-	}
+	put_queue_utf8(vc, value);
 }
 
 /*
-- 
2.48.1

