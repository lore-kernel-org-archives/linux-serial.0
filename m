Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C667B3749EA;
	Tue, 22 Sep 2026 01:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040499; cv=none; b=figHa9HrO1jDvaTCUquuzpIp41TEc4BwQWRvkYCYLiq40IpSMJX/7d2oZeCDUdVQ6gE8fqZtc0+VvMfykthIK39xfBMkwb9+Rs42kCM89qreBx6c/qgabasdlTD5O9Ut0DXHwUzIpmVIzEMDj7iwajJGs6YmMKCz/L6WAt72XoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040499; c=relaxed/simple;
	bh=KVxIJYlmJlDAc+ya767V3Xib1Of5jx9U9dnR/a7E5tI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=myCY6DAmf5zN6yspjK4BEJv3kULYe/c6tkftQCUAiU3rbNc6wpRbQvFlrfiooZrelqMq2GCMSHyNIMLquLZjrUeXd2KUUXCGKZVwe6BjNg6AVqyzetiYFIC2I40HNHng//zDgtzpmRhMgCAFgoC8OEXgmMLzRiN3aAisBOZoG+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggL0nChS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggL0nChS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EEE2C2BCFD;
	Tue, 22 Sep 2026 01:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790040499;
	bh=KVxIJYlmJlDAc+ya767V3Xib1Of5jx9U9dnR/a7E5tI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ggL0nChSYmkp9fObZuCiHhrAeHQWO4XdntT0rH9gZsX6nGf1Ph4+1eMnmm1/RThr9
	 ow4DewBOe3eqr2GNAobqIk9HDthoCyfL+Svrtu+QPSzalgXtEnfw6tTGzWdFNgy0ri
	 wUG75bt/3CMIRL35Ke+bR5Fy2VQCIaBwxYBVy6ZqpthIxa77RjsoLbkag9MxKSb+62
	 DkRSxJ/d1wrw9KNFZeUUq80ClVzEQoZyHvZjBcQbqyy3Px58eNMuW34/BABHpwN/TW
	 O9PMzLiG9TEX5WahkAhX77YGuGcYuLyYWOUGpALFeDQMoAu5ZtS9UZdMvvIVe8Bipl
	 nTHpwjfawsiTQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9C3C982FF;
	Tue, 22 Sep 2026 01:28:19 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Date: Mon, 21 Sep 2026 21:28:17 -0400
Subject: [PATCH 4/6] vt: keyboard: publish accent_table_size with release
 semantics
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mb-keyboard-v1-4-d170228b80c0@vt.edu>
References: <20260921-mb-keyboard-v1-0-d170228b80c0@vt.edu>
In-Reply-To: <20260921-mb-keyboard-v1-0-d170228b80c0@vt.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Jaidev Shastri <jaidevshastri@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790040498; l=2353;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=jz9QWlgrM+e1IW3NtV23bxopg3rGmXRUjZjy2ORNDuo=;
 b=le4HBu17HaqoaiMIqaNTFlApg4kB1bR6lXBDVopy5d634aWIdAExWTKCWz3j3kAUVaRUlNyEq
 G+ESWeqdl7MCOw13YwOJ1dQEMe8cQI+UzyjAzEUhbq5I452VVS6xLdh
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

From: Jaidev Shastri <jaidevshastri@vt.edu>

vt_do_kdskbdiacr() and vt_do_kdskbdiacruc() rewrite accent_table[] and
accent_table_size. handle_diacr() reads the size and then walks the
table.

vt_do_kdskbdiacr() sets the size before it converts the entries, so the
size covers entries that have not been written yet. Set it after the
loop in both paths and publish it with smp_store_release(); read it once
with smp_load_acquire() before the walk.

Found with MBCheck, a static herd7-based memory consistency checker.

Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
---
 drivers/tty/vt/keyboard.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index d7db5e226..c2fd92e2b 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -447,7 +447,7 @@ void vt_set_leds_compute_shiftstate(void)
 static unsigned int handle_diacr(struct vc_data *vc, unsigned int ch)
 {
 	unsigned int d = diacr;
-	unsigned int i;
+	unsigned int i, n;
 
 	diacr = 0;
 
@@ -455,7 +455,9 @@ static unsigned int handle_diacr(struct vc_data *vc, unsigned int ch)
 		if ((ch & ~0xff) == BRL_UC_ROW)
 			return d | ch;
 	} else {
-		for (i = 0; i < accent_table_size; i++)
+		/* Pairs with the smp_store_release() in vt_do_diacrit(). */
+		n = smp_load_acquire(&accent_table_size);
+		for (i = 0; i < n; i++)
 			if (accent_table[i].diacr == d && accent_table[i].base == ch)
 				return accent_table[i].result;
 	}
@@ -1810,7 +1812,6 @@ static int vt_do_kdskbdiacr(void __user *udp, int perm)
 	}
 
 	guard(spinlock_irqsave)(&kbd_event_lock);
-	accent_table_size = ct;
 	for (i = 0; i < ct; i++) {
 		accent_table[i].diacr =
 				conv_8bit_to_uni(dia[i].diacr);
@@ -1819,6 +1820,8 @@ static int vt_do_kdskbdiacr(void __user *udp, int perm)
 		accent_table[i].result =
 				conv_8bit_to_uni(dia[i].result);
 	}
+	/* Pairs with the smp_load_acquire() in handle_diacr(). */
+	smp_store_release(&accent_table_size, ct);
 
 	return 0;
 }
@@ -1848,7 +1851,8 @@ static int vt_do_kdskbdiacruc(void __user *udp, int perm)
 	if (ct)
 		memcpy(accent_table, buf,
 				ct * sizeof(struct kbdiacruc));
-	accent_table_size = ct;
+	/* Pairs with the smp_load_acquire() in handle_diacr(). */
+	smp_store_release(&accent_table_size, ct);
 	return 0;
 }
 

-- 
2.43.0


