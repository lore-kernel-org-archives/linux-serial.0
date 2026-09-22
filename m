Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A9D376BC1;
	Tue, 22 Sep 2026 01:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040499; cv=none; b=gU3ou+bn2QHEzCQkyJQ70x1kzfylhRl/g16b09FFUSuJvSSRXdTc5SwqCwhf69uDMpVD18oWKcp5UQVUbhv1GGKcYgqUvzOd61izfxumuGH6JOrZyK3FXoZ0OwqUH07ydduSSAOCrdgNLqyjfeaxa6gfWiROHmky6LbUnPjv2Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040499; c=relaxed/simple;
	bh=ppAigkjatF9Z22OzgFgBPTCvL1UwNCJh+kedCBmVN3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OHlsugF5FVR0i3Z048/vNzU5dvyp6gx6RGLplw4kbz/WvamQzuSYgeob2j4/61XTbAbeOIVQezsZE8xgW5VknthLjjYh0v1pCWA/S9jxFP+xWTnw6eO9UBbt9M1bLqibUZKfmBEqFQ+HtlpFCkYmT7TuMXkG0mBpfY+dNLizMl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coawoRHM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coawoRHM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75EF4C2BCFC;
	Tue, 22 Sep 2026 01:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790040499;
	bh=ppAigkjatF9Z22OzgFgBPTCvL1UwNCJh+kedCBmVN3c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=coawoRHMd1OwAl9lhdfCbZKO1f0Sk7AWLgF878IfAbc7s4WLnosiJrTpQdxtMRJjE
	 Bzvm8NdCjWsBwIDxYf9/hXchbP6FKPD3NiQxp/zu+dNl5NM5kYVtzOE6yijUqmQOqH
	 0MG/b4bcGe3f42DhX72ANgvySeNd8ivUV6Z9nOJSp9mMJ1zjhtqRJS+HWY9Is/PGWK
	 yX6e7om+PKRKWUD3DK5/qG4J7GgZHRWQSzJMVyXKSUbL7lYYWQFt9rSACRhCvnPqDv
	 fi5tbDYgVBR78Yw0m6Xi4ZxdYHwiQHJEQD3Z1Sdc5utiwizsd2pqjyp2IGGU2ZhobS
	 lqDWNEekKWNLQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1AAC982FF;
	Tue, 22 Sep 2026 01:28:19 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Date: Mon, 21 Sep 2026 21:28:14 -0400
Subject: [PATCH 1/6] vt: keyboard: publish shift_state with release
 semantics
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mb-keyboard-v1-1-d170228b80c0@vt.edu>
References: <20260921-mb-keyboard-v1-0-d170228b80c0@vt.edu>
In-Reply-To: <20260921-mb-keyboard-v1-0-d170228b80c0@vt.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Jaidev Shastri <jaidevshastri@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790040498; l=1864;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=DZORQFC62iK2iCZRnS/XkfCIg2hwFuw7UKYfnaQuUPU=;
 b=UPuc8ERycqOPiQnTgiSO+VF/BAaQwbTGdO2XpaeEJXPgAq6q81guYo1In6Qq9UMuTmzdgh+S4
 Lfm5Rt6i8lqDtWYfJUboPxbNdQPelQ5+vm/YJGZoqCYAZzQ/2tlA2bJ
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

From: Jaidev Shastri <jaidevshastri@vt.edu>

k_shift() updates shift_down[] and then shift_state under
kbd_event_lock. vt_get_shift_state() reads shift_state without the lock
for TIOCL_GETSHIFTSTATE, so the plain accesses leave the relation
between the counters and the summary word unspecified.

Store shift_state with smp_store_release() and read it with
smp_load_acquire().

Found with MBCheck, a static herd7-based memory consistency checker.

Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
---
 drivers/tty/vt/keyboard.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index c41d850b2..089f3b048 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -865,6 +865,7 @@ static void k_pad(struct vc_data *vc, unsigned char value, char up_flag)
 static void k_shift(struct vc_data *vc, unsigned char value, char up_flag)
 {
 	int old_state = shift_state;
+	int state;
 
 	if (rep)
 		return;
@@ -889,9 +890,11 @@ static void k_shift(struct vc_data *vc, unsigned char value, char up_flag)
 		shift_down[value]++;
 
 	if (shift_down[value])
-		shift_state |= BIT(value);
+		state = shift_state | BIT(value);
 	else
-		shift_state &= ~BIT(value);
+		state = shift_state & ~BIT(value);
+	/* Pairs with the smp_load_acquire() in vt_get_shift_state(). */
+	smp_store_release(&shift_state, state);
 
 	/* kludge */
 	if (up_flag && shift_state != old_state && npadch_active) {
@@ -2212,8 +2215,11 @@ void vt_reset_unicode(unsigned int console)
  */
 int vt_get_shift_state(void)
 {
-        /* Don't lock as this is a transient report */
-        return shift_state;
+	/*
+	 * Don't lock as this is a transient report. Pairs with the
+	 * smp_store_release() in k_shift().
+	 */
+	return smp_load_acquire(&shift_state);
 }
 
 /**

-- 
2.43.0


