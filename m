Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389A736E466;
	Tue, 22 Sep 2026 01:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040440; cv=none; b=ep7vSc5DAwylEOiOIJib5dKjs2AQxAgGV0h1JBauvClBX+WEllUNuPuqcGSYC8MFsT5kcMgs2EsmGaZlimTRCeZTc7IMr88NknxLKRxBjXIe8IG7Bnz17od/pgdP707lW2soJ4hh0dcrEZdwXNOoX5mn6XivQQ7Wb4Q5SZ7v8mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040440; c=relaxed/simple;
	bh=ERsm8yne7OE0oXzLqAtSUDwW8UVIyoGFIy32VZoQ+Fw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aG4e8GS5xm9m2DJpgJHLlKvoxxijT6rg7iZTTNZaxhYzpIgyVsbW+vBItQ7bqG6Z7Q3RTC4k96GaeB8CvU/k63J1sBPp4olINmZFYN0jVdtvIcEstd0m3qMXpZH8XR6v6xWdh45ZWsRrumqP0HmSb0EwSOR41hf+ZYhqhmqQlgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvXMqkQ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvXMqkQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE891C2BCF7;
	Tue, 22 Sep 2026 01:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790040439;
	bh=ERsm8yne7OE0oXzLqAtSUDwW8UVIyoGFIy32VZoQ+Fw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TvXMqkQ4I5N3zRvAmnuW3YnlelWWFnylmKXnMRTjBuB+jDX3rQCavSNqE7bTBmVLW
	 kvmHuV1DyvHY2nlcZ8gWvOqZNj+u8FOlUa/JZBVHF9JAgLeFNN97YKhy8OCx2R+bzd
	 guQk60MOwAxv5N+luBiWRWmJ87rIZIMfBeMP2S8Y7F0Xa+3xPDQmgWSWwzjgxXja3t
	 kVMhM1/WECrFd/ai3UNx976Mr/DarJ5KykPusIyC9OgJJDOrB3a7+PnYfhuZ5UAQ/0
	 ic/zym8+S9QOWy3JQVz0GGPmep7ADKW8b+mSwCuvkBfk2wCKBu/mrRWLr0NkOJ+Oc2
	 EHNhX24Qb6GeQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0481C982FF;
	Tue, 22 Sep 2026 01:27:19 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Date: Mon, 21 Sep 2026 21:27:15 -0400
Subject: [PATCH 2/3] vt: order console_blanked between blanking and
 unblanking
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mb-vt-v1-2-71b7990c26c1@vt.edu>
References: <20260921-mb-vt-v1-0-71b7990c26c1@vt.edu>
In-Reply-To: <20260921-mb-vt-v1-0-71b7990c26c1@vt.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Jaidev Shastri <jaidevshastri@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790040439; l=2137;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=kWl2d17xXxJJ8s7vN2eawZUFTwGBKmwR9FBaN+SterI=;
 b=puDUrOD62COIIKtRmhFJsjOVKQExiVWpSnLNaL38LxHzsnr0wLXrLhGLReZv6IpXKzqnU31R5
 BtS4vK8wEvZDCMqRemObqmiOpf4yhBv++LdnAqTOpEznhl1WXEyHGC8
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

From: Jaidev Shastri <jaidevshastri@vt.edu>

do_blank_screen() records the blanked console in console_blanked with a
plain store, after blank_state and the console state have been updated.
do_unblank_screen() tests console_blanked with a plain load before it
uses that state.

Store it with smp_store_release() and read it with smp_load_acquire().

Found with MBCheck, a static herd7-based memory consistency checker.

Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
---
 drivers/tty/vt/vt.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 3abbd6cf9..726402167 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4683,7 +4683,8 @@ void do_blank_screen(int entering_gfx)
 		hide_cursor(vc);
 		save_screen(vc);
 		vc->vc_sw->con_blank(vc, VESA_VSYNC_SUSPEND, 1);
-		console_blanked = fg_console + 1;
+		/* Pairs with the smp_load_acquire() in do_unblank_screen(). */
+		smp_store_release(&console_blanked, fg_console + 1);
 		blank_state = blank_off;
 		set_origin(vc);
 		return;
@@ -4693,7 +4694,8 @@ void do_blank_screen(int entering_gfx)
 
 	/* don't blank graphics */
 	if (vc->vc_mode != KD_TEXT) {
-		console_blanked = fg_console + 1;
+		/* Pairs with the smp_load_acquire() in do_unblank_screen(). */
+		smp_store_release(&console_blanked, fg_console + 1);
 		return;
 	}
 
@@ -4705,7 +4707,8 @@ void do_blank_screen(int entering_gfx)
 	/* In case we need to reset origin, blanking hook returns 1 */
 	i = vc->vc_sw->con_blank(vc, vesa_off_interval ? VESA_VSYNC_SUSPEND :
 				 (vesa_blank_mode + 1), 0);
-	console_blanked = fg_console + 1;
+	/* Pairs with the smp_load_acquire() in do_unblank_screen(). */
+	smp_store_release(&console_blanked, fg_console + 1);
 	if (i)
 		set_origin(vc);
 
@@ -4737,7 +4740,8 @@ void do_unblank_screen(int leaving_gfx)
 	WARN_CONSOLE_UNLOCKED();
 
 	ignore_poke = 0;
-	if (!console_blanked)
+	/* Pairs with the smp_store_release() in do_blank_screen(). */
+	if (!smp_load_acquire(&console_blanked))
 		return;
 	if (!vc_cons_allocated(fg_console)) {
 		/* impossible */

-- 
2.43.0


