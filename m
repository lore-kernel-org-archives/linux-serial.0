Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90DF376BD7;
	Tue, 22 Sep 2026 01:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040499; cv=none; b=UAbG5E2tRXLX9zr0QgCzzzHB0gkAuyLwXqUxacwHDgCdN6YRsegdwIZD3kvJX4CfGL/D71kDpKrYwAQt3fMWApA0BzuI/2MEAG0LN+zfcYp1LWe6V6CkbmZUqgerNYHLVZOhRbpNVa6LuL+GEAAa307BkcA1DYZmthTOFF6n97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040499; c=relaxed/simple;
	bh=GyybeRC15agMtDiYIn4jTELsR928b09LKcug1Vvtd7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cI6V7QPFx5xcmZcE3Ffe/Q/v32HuTsjEgYcI7Q49KvAl9xzOSCRZM3tsNDEiXDOQySH1tg4u0xUieUhBjfevD+ze2sWcccRmqb0WEGQg562ceG8sDJM/KSWvQX5k5MF4qihk/ynRtEGkjOBnNnh1J91QOHinXUWw7m8dVQ3JW84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNvCTzYw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNvCTzYw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 921E4C2BD00;
	Tue, 22 Sep 2026 01:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790040499;
	bh=GyybeRC15agMtDiYIn4jTELsR928b09LKcug1Vvtd7M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GNvCTzYwgep0pvQxyu0lYXChC2lPB1tqmB4Doql62sSk7Pkde5+u1roPy1td5Cnxv
	 sozFnqDkgqudtoSLRwxZZ53HyUbk3ZU1y6Y+acJLHpRQM9xMWkUQf3S30Nc7tm9lL4
	 EPJwQpqVei8x9npH50RbnF+kMZgJHISBbIEjCh043uVkI8kF1nE2wRhuPYkkz/WCIM
	 sCfqlmJNEylDuxvH/ZBBSn0hVT+tm+I2ZLeFoVu7L+9y+6MuM9q+WmsvOSAodzV/XT
	 8p8PUl4CqHPth3mSKIUw1oDR/tQr17OG/QMYJEZ0kvxnM52dwduzc+w7uRwehZFlYh
	 VwRdn7G06yBnw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABD0C98306;
	Tue, 22 Sep 2026 01:28:19 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Date: Mon, 21 Sep 2026 21:28:16 -0400
Subject: [PATCH 3/6] vt: keyboard: publish dead_key_next with release
 semantics
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mb-keyboard-v1-3-d170228b80c0@vt.edu>
References: <20260921-mb-keyboard-v1-0-d170228b80c0@vt.edu>
In-Reply-To: <20260921-mb-keyboard-v1-0-d170228b80c0@vt.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Jaidev Shastri <jaidevshastri@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790040498; l=1229;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=Zt+gxI5ocGWwJ74nIWECJ+/LdypxLyX9sdrY+y+9ulM=;
 b=9M/duHJeMb15eWfiTq1xttTPwr5lz2qfehv4hzEQucqHB0Cihsliy9ePf4U0cMqNni3EhBjB2
 UMIETRRa7wDAReKXSs1pA1WWlC6rrAmlc7l1rTjPYb4qjBn96OupyD/
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

From: Jaidev Shastri <jaidevshastri@vt.edu>

fn_compose() arms the dead-key state in dead_key_next and k_unicode()
consumes it together with diacr.

Store the flag with smp_store_release() and read it with
smp_load_acquire().

Found with MBCheck, a static herd7-based memory consistency checker.

Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
---
 drivers/tty/vt/keyboard.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 6f3472cd4..d7db5e226 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -618,7 +618,8 @@ static void fn_boot_it(struct vc_data *vc)
 
 static void fn_compose(struct vc_data *vc)
 {
-	dead_key_next = true;
+	/* Pairs with the smp_load_acquire() in k_unicode(). */
+	smp_store_release(&dead_key_next, true);
 }
 
 static void fn_spawn_con(struct vc_data *vc)
@@ -672,7 +673,8 @@ static void k_unicode(struct vc_data *vc, unsigned int value, char up_flag)
 	if (diacr)
 		value = handle_diacr(vc, value);
 
-	if (dead_key_next) {
+	/* Pairs with the smp_store_release() in fn_compose(). */
+	if (smp_load_acquire(&dead_key_next)) {
 		dead_key_next = false;
 		diacr = value;
 		return;

-- 
2.43.0


