Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9969243385;
	Tue, 18 Feb 2025 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881813; cv=none; b=YZLRcI+NFwUPAkbMCmcHIwAGp7TwP0zKQ5jBfgEiTsM05hrGkV8DohfDj+rofWcu5hVm24SUbmvIxupwBd8VpeKrTJcomcZV9xTBpTZYWTa+ajYVU5EzmPAFyUboisVzxWlc5Q8KjoxHsxFibt65gSvfQFSN9cqqr+aUojWEqcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881813; c=relaxed/simple;
	bh=xhIKKKkwriZUtEfLeAwsmA0LtBIWhWuVv8QuJtN4UTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWvxAT8irxSE7TV+GSHTkVNCb2xTg7w1LHaVLUxFtncogsHhSvkChnCwDJBxv7UpEB7iv7KHVionlPjVNnyk3bnIAJ7vPNJc30nhpGYi6V30dRGUoNHMWh+72wro71CAEwPz0C5qenO0EvWCGlbNBG9YdHknvIZQ9e+asnZuCi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArGSMGyT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArGSMGyT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C46C4CEE6;
	Tue, 18 Feb 2025 12:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739881812;
	bh=xhIKKKkwriZUtEfLeAwsmA0LtBIWhWuVv8QuJtN4UTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ArGSMGyTJjRcCrZDB74snUuuaqn6qzIPRS5yUsI2pSPXh5YPBt+NOf7jrdsjR989t
	 oiy54vCRQ2k3bN24oucVFx1G7hcB8me1LYKHwYbaRo2qYufp4ttHfTjrHmhYkA8mTF
	 2uYYC55XQCCfZ7SfgWdIBryWEmjvhBXtCwBkBoZPQI9WCrR66MIqgIaXoESNlt2qMA
	 FpAUWR0AGciC2M3S06k9SyJTfVga/+GHs+90Q0LvDNFbeUX5kWztQ+iuVN+xr4eaqw
	 6ikGurHKJDIkg97vn/TIg3m2rrsJX8zYvc37hZVW+3bt2wpP4JTgANH7Wg5N7VIQxM
	 wHvcpdrP5K9Mw==
From: Alexey Gladkov <legion@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH v1 1/2] tty/vt: Use KVAL instead of use bit operation
Date: Tue, 18 Feb 2025 13:29:38 +0100
Message-ID: <01ee8849ef8dc49c93a77bc4961ad56b9d435b8a.1739881707.git.legion@kernel.org>
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

The K_HANDLERS always gets KVAL as an argument. It is better to use the
KVAL macro itself instead of bit operation.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 drivers/tty/vt/keyboard.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 804355da46f5..7df041ac4d5c 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -885,7 +885,7 @@ static void k_shift(struct vc_data *vc, unsigned char value, char up_flag)
 		if (kbd->kbdmode == VC_UNICODE)
 			to_utf8(vc, npadch_value);
 		else
-			put_queue(vc, npadch_value & 0xff);
+			put_queue(vc, KVAL(npadch_value));
 		npadch_active = false;
 	}
 }
@@ -1519,7 +1519,7 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
 	if ((raw_mode || kbd->kbdmode == VC_OFF) && type != KT_SPEC && type != KT_SHIFT)
 		return;
 
-	(*k_handler[type])(vc, keysym & 0xff, !down);
+	(*k_handler[type])(vc, KVAL(keysym), !down);
 
 	param.ledstate = kbd->ledflagstate;
 	atomic_notifier_call_chain(&keyboard_notifier_list, KBD_POST_KEYSYM, &param);
-- 
2.48.1

