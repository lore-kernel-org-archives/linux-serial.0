Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BFD377AA7;
	Tue, 22 Sep 2026 01:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040500; cv=none; b=sPbS9w9LdaFMihHaXkAPE+PZ7p4PJnDytPxabhiAO9E9n0SBxNyTepMNPKyiGg2ktmQwYFWlFnAFEFxC1+Dgxf83RO1AWFPf9fUwTdviJT68VGwgvfxCE1zWF2C9n6dcNWboWkcupm2h7RniMFwDAbdSigV9g15kOTM2wHlh3NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040500; c=relaxed/simple;
	bh=IDTPd/U2oV0Vo+v46Xy2gTCYZA3biDjLara5HxCRNu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iGvBQpWrTvPDBrCCjJq0yV9S1SwTmAGYromELCMBdOPteo+YsUnowG0XQrLsBypxDPIi/xGi9xaxwuCJskfNTS2A81Ip7PvGRh/pdLkWAHlDXPxF5zW1YADCcrhGXtucyn7Otvx+CycQIh4r8rVd1fe4i1TawWOfDdsfM2DDOqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBUYp/S9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBUYp/S9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9655C2BCF7;
	Tue, 22 Sep 2026 01:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790040499;
	bh=IDTPd/U2oV0Vo+v46Xy2gTCYZA3biDjLara5HxCRNu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PBUYp/S9bdxZuBni4H0O4UMekMbP5mMBlN0HlRGkw0Oh2xMfBjDGBxCbz+ZKS+/9T
	 WZSAGwdyRtugcB8GDnAIgre9Ft/BMHL4ZUy2za4co+nOcbROyz4OD/junLhQXaaYt7
	 fkkzzZAhNqPUzHX8yhHuuq69zsfwtRDztIAV8UY+7jTenAQte+zZ9aSgOWfi5WeSMB
	 xu+2NTWWElWjeI8IIcy+VGr267AqtLvLD43YyPgqsRaOm9NmTxfB3kXNKe56kT4DMV
	 uF+XerUo+OgTE3i9nJ4p0Pu63xuM28Wu18t79pvgzU4e0jR/OFG1kRlnKmfSGNQ6F/
	 EUmZOsC5Sl7rQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C2CC98304;
	Tue, 22 Sep 2026 01:28:19 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Date: Mon, 21 Sep 2026 21:28:19 -0400
Subject: [PATCH 6/6] vt: keyboard: publish the shift_down[] counters with
 release semantics
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mb-keyboard-v1-6-d170228b80c0@vt.edu>
References: <20260921-mb-keyboard-v1-0-d170228b80c0@vt.edu>
In-Reply-To: <20260921-mb-keyboard-v1-0-d170228b80c0@vt.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Jaidev Shastri <jaidevshastri@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790040498; l=1912;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=KnTNjEcgHMMpVCPx3XbhLE+RN8D0Cwj3lZFOas1PfsM=;
 b=GlDBlN86FER15lgRBvlYa0LSOQ81HR/YvfKC6lQD9Jtc/CmZOAIpmHp5AxhRbJQlcx8HrJ+He
 NuoQNEbI2kLBI/9wvBB/z6B+hyoeIbVELZ6tiaOPPsHObOH+SvV31yx
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

From: Jaidev Shastri <jaidevshastri@vt.edu>

k_shift() maintains the per-modifier depress counters in shift_down[]
and k_pad() tests shift_down[KG_SHIFT] to choose between application and
numeric keypad codes.

Update the counter with smp_store_release() and read it with
smp_load_acquire().

Found with MBCheck, a static herd7-based memory consistency checker.

Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
---
 drivers/tty/vt/keyboard.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 87970415a..e6112e0db 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -823,7 +823,8 @@ static void k_pad(struct vc_data *vc, unsigned char value, char up_flag)
 		return;		/* no action, if this is a key release */
 
 	/* kludge... shift forces cursor/number keys */
-	if (vc_kbd_mode(kbd, VC_APPLIC) && !shift_down[KG_SHIFT]) {
+	/* Pairs with the smp_store_release() in k_shift(). */
+	if (vc_kbd_mode(kbd, VC_APPLIC) && !smp_load_acquire(&shift_down[KG_SHIFT])) {
 		applkey(vc, app_map[value], 1);
 		return;
 	}
@@ -877,6 +878,7 @@ static void k_shift(struct vc_data *vc, unsigned char value, char up_flag)
 {
 	int old_state = shift_state;
 	int state;
+	unsigned char cnt;
 
 	if (rep)
 		return;
@@ -890,15 +892,18 @@ static void k_shift(struct vc_data *vc, unsigned char value, char up_flag)
 			clr_vc_kbd_led(kbd, VC_CAPSLOCK);
 	}
 
+	cnt = shift_down[value];
 	if (up_flag) {
 		/*
 		 * handle the case that two shift or control
 		 * keys are depressed simultaneously
 		 */
-		if (shift_down[value])
-			shift_down[value]--;
+		if (cnt)
+			cnt--;
 	} else
-		shift_down[value]++;
+		cnt++;
+	/* Pairs with the smp_load_acquire() in k_pad(). */
+	smp_store_release(&shift_down[value], cnt);
 
 	if (shift_down[value])
 		state = shift_state | BIT(value);

-- 
2.43.0


