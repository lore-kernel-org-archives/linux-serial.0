Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49D0374745;
	Tue, 22 Sep 2026 01:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040499; cv=none; b=Rdja2h76P4M3wjOflDPgwiPcVjCN2YLmVRPpbWGGr4Q3Heih2xyAtoRnBZHNiflL4VTehnslmmelUPH50ggn1GQT5Tad8Gg6SdqDFzzXyO+3NV8jh2NZUQLyCBm+Vw5ud9Oqb1/8jw1wVn8bCPKayKRmpZqAwhHM7mMWbCrcLGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040499; c=relaxed/simple;
	bh=fmZQKb1CLTlUV+ISJn/sBAq7bdq2mDqISoqzcVqgGcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HHBY14j9VoUwqrIFfKDYFvoAsgcPID0eSqxr4af1+OQahaL1WiBFBWZ/0TxDUVTmtuWtS2SeoL/4lzczSbepCDmY8vcvhd4Hc+J1fU/1/rHmfyBtA3HlFChq80Y+46iOBSLXSIco3qeNJKwJRhylIhUOipiE8d/vs2KmMoNWcYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZWJHFtA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZWJHFtA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84A98C2BCF6;
	Tue, 22 Sep 2026 01:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790040499;
	bh=fmZQKb1CLTlUV+ISJn/sBAq7bdq2mDqISoqzcVqgGcs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CZWJHFtA9ev5su5mYD3K3f8Jxkq3ppfGQ/48G3cvp1geZ8d/Uje9TS8t1MDYPlC1G
	 YwBz9BIVHo1aR/vs9Wq5b919Oevs9o+ATsVXHze6d3TOunGrd+crw8BJtxMoYnxx1T
	 SlZlApcH/xp/Kat87TorWAg0loasek/XZN1DxtQKjJ+/IvI9FkyudFtV0kyxXHmqkb
	 H/wbmpSXQYEypscud1787jTXRFEcQ8bgXe4U9m8W5N4PIPwDkxPRNlGJ7YXZcnFjsV
	 G7QdESG31Cde1UWuzA30MFSqwaUMbMCpAnshgVLRWCaMLC56v8jKjLvwl1UOtO0zDR
	 osY8SRbtTwRPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B236C98304;
	Tue, 22 Sep 2026 01:28:19 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Date: Mon, 21 Sep 2026 21:28:15 -0400
Subject: [PATCH 2/6] vt: keyboard: publish npadch_value with release
 semantics
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mb-keyboard-v1-2-d170228b80c0@vt.edu>
References: <20260921-mb-keyboard-v1-0-d170228b80c0@vt.edu>
In-Reply-To: <20260921-mb-keyboard-v1-0-d170228b80c0@vt.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Jaidev Shastri <jaidevshastri@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790040498; l=1592;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=fmmEErRcPyO4zz0N6xCFkyoCjOBlv003JbWU2K7PoDE=;
 b=8byxCaFtSMphNyhtVoZMMVV38Hep9HPKKIzRXsDbE0X/YH1E+1pphIikQuhQvcNJ8X9VZ310/
 pAThflcBo8zBTG2Hk64zw6dFBo3vZP4WY7+LlNVTQ8eAZlA0IfwXr9M
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

From: Jaidev Shastri <jaidevshastri@vt.edu>

k_ascii() accumulates the numeric keypad code in npadch_value after it
has set npadch_active. k_shift() tests npadch_active and then emits
npadch_value when the modifier is released.

Store the accumulated value with smp_store_release() and read it with
smp_load_acquire().

Found with MBCheck, a static herd7-based memory consistency checker.

Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
---
 drivers/tty/vt/keyboard.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 089f3b048..6f3472cd4 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -898,10 +898,13 @@ static void k_shift(struct vc_data *vc, unsigned char value, char up_flag)
 
 	/* kludge */
 	if (up_flag && shift_state != old_state && npadch_active) {
+		/* Pairs with the smp_store_release() in k_ascii(). */
+		unsigned int npadch = smp_load_acquire(&npadch_value);
+
 		if (kbd->kbdmode == VC_UNICODE)
-			to_utf8(vc, npadch_value);
+			to_utf8(vc, npadch);
 		else
-			put_queue(vc, npadch_value & 0xff);
+			put_queue(vc, npadch & 0xff);
 		npadch_active = false;
 	}
 }
@@ -939,7 +942,8 @@ static void k_ascii(struct vc_data *vc, unsigned char value, char up_flag)
 		npadch_active = true;
 	}
 
-	npadch_value = npadch_value * base + value;
+	/* Pairs with the smp_load_acquire() in k_shift(). */
+	smp_store_release(&npadch_value, npadch_value * base + value);
 }
 
 static void k_lock(struct vc_data *vc, unsigned char value, char up_flag)

-- 
2.43.0


