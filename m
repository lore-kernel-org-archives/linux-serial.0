Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E561E377AA3;
	Tue, 22 Sep 2026 01:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040500; cv=none; b=tVFN5X7yUA5LlHpRUZO7CGar5ajJR2Vn/kw/SRVG3mdWFXAT7CSw7OOEr+cr+ylC9AEroacuh0d8eEdIMiCJjc/5NJgLRZZmPIzWo3kRGH3u1AjpPWHHIdLKyYA21Z+71zqTVypcUkmzigdVFkKG2sylBeH9l7AS45Cszhebqv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040500; c=relaxed/simple;
	bh=fGbyRoiQA+YKrlUzwLgdZZGqfMjdbaJkZeiXHveswLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PaThedaH8shBK4k6i4yGCEJzYtq4uPIr/zdCC+laN79mS4YuktlUXyiLNEIreBURwiEYSjDXD18kLlkX1Vpy8hyGTu44UWtBeo3Y7kVAhVoY6gA9OLoKZMKc3KfMrCK0r6g+J6T067G8MSn7i0swd4QSZw5wCTp0SNIqXmvZnK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7WS1uFf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7WS1uFf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAB62C2BCB3;
	Tue, 22 Sep 2026 01:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790040499;
	bh=fGbyRoiQA+YKrlUzwLgdZZGqfMjdbaJkZeiXHveswLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=V7WS1uFfK7ruVNa3+CsK7gpeqcl9xnL6w8vcHxY88XuP0moZgGXfgJS5r9Vav9BQy
	 9erkWLnX0PcEEMMixJmGm4uysVezwXzas3xFTlmNngJ0bGn658T6UCw7WghrQNhmlT
	 McNDNB1itUmzE3DQ1JjmycJ6FsIDClg4mpkUVNyyIwguk3X+qzhta6vLKio8juzQIK
	 ipokRfMqKlf+8wMAXwuNCtLDis1gpiBGLiqhbaT0p2F4vMb0d2Ts+1L8tVkx2Y5c/M
	 TmaoS+WbzgxTyiN3r9QwKYW2dCTrj8/7GbWy2Rk7AXfmhCWLtfEqWULbkB0PFH6Rn9
	 A4Oam1CL9UULQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCFBC98302;
	Tue, 22 Sep 2026 01:28:19 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Date: Mon, 21 Sep 2026 21:28:18 -0400
Subject: [PATCH 5/6] vt: keyboard: recompute the shift state into locals
 before publishing it
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mb-keyboard-v1-5-d170228b80c0@vt.edu>
References: <20260921-mb-keyboard-v1-0-d170228b80c0@vt.edu>
In-Reply-To: <20260921-mb-keyboard-v1-0-d170228b80c0@vt.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Jaidev Shastri <jaidevshastri@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790040498; l=1670;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=Pcy9gXCqUcOIXjrml7UXFL+N6Nxn53Hov/Dv8U22J58=;
 b=/S5sFva/qHPrN7SkZipZS8wgJoIDFwKtAIrLhgQAV0p9/Gtkd2AibWMh0YcCmzStXavDablxR
 1ml1JWaxjzyDDA7cTOBcOPf/20vP8sN4/D6Xv9VHsfNULO8pSLdOFlW
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

From: Jaidev Shastri <jaidevshastri@vt.edu>

do_compute_shiftstate() clears shift_state and shift_down[] and rebuilds
them in place while it iterates key_down[]. vt_get_shift_state() reads
shift_state without kbd_event_lock and can observe the cleared or
partially rebuilt value.

Compute the new state into locals, copy shift_down[] first and publish
shift_state last with smp_store_release().

Found with MBCheck, a static herd7-based memory consistency checker.

Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
---
 drivers/tty/vt/keyboard.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index c2fd92e2b..87970415a 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -403,10 +403,9 @@ static void set_leds(void)
 
 static void do_compute_shiftstate(void)
 {
+	unsigned char down[NR_SHIFT] = { 0 };
 	unsigned int k, sym, val;
-
-	shift_state = 0;
-	memset(shift_down, 0, sizeof(shift_down));
+	int state = 0;
 
 	for_each_set_bit(k, key_down, min(NR_KEYS, KEY_CNT)) {
 		sym = U(key_maps[0][k]);
@@ -417,9 +416,17 @@ static void do_compute_shiftstate(void)
 		if (val == KVAL(K_CAPSSHIFT))
 			val = KVAL(K_SHIFT);
 
-		shift_down[val]++;
-		shift_state |= BIT(val);
+		down[val]++;
+		state |= BIT(val);
 	}
+
+	memcpy(shift_down, down, sizeof(shift_down));
+	/*
+	 * Publish the recomputed state in one step. vt_get_shift_state()
+	 * reads shift_state without kbd_event_lock; pairs with its
+	 * smp_load_acquire().
+	 */
+	smp_store_release(&shift_state, state);
 }
 
 /* We still have to export this method to vt.c */

-- 
2.43.0


