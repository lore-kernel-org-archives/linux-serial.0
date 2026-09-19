Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B471C6FF5
	for <linux-serial@vger.kernel.org>; Sat, 19 Sep 2026 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789815646; cv=none; b=CqP3lQZHrb7qq7+072XPLRUkmFnqhnD/qBu3LtdYUjqTnRdEG2cjiUjPlLx+ROV0Xkbph5N6KrHQvvr/+UAaa6tIg3tSCtKWOVwx3mrUhoIqeOoPJR2BONjkwq3RBeQFeN2/AweTvmcBtqEhSYYYKE9/9snXPQXkY06y0IUmiYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789815646; c=relaxed/simple;
	bh=DNkK5lxW6BJbRZck3d0se7pQehLyw7oBHWT8qVoDdjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CiK3pa4fJJ6yLkiJIQoTzgoVc30BFiwmeGHZ+A4O1J/TpT3tfpXGfz08VX10fkzfee91/yXjQbKSQqywTIxqwxBS33CJpdfCQ3tGaPMZMzEs0tfbxAc/tH+O89K15oGBrrEO/dN8OPM8hXCWypvjjWFOQcmSRFbCOcKKOjoYKtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwHE7XCn; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwHE7XCn"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so1292436a12.1
        for <linux-serial@vger.kernel.org>; Sat, 19 Sep 2026 04:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789815644; x=1790420444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P4U+Su5olDyDmLov0j40b3fkb86q795927TVcmkINSU=;
        b=ZwHE7XCnq54HF54WBmMZaXKDfyMw/6yWcMFOp3rSxeDNWf6XnTxH7J7nHPlXcexy48
         ZmxhAzAkqIsZxXQz5ZzqpV9PafeyIjXYwviE5h1MvgybDrF4A5s6M6gz0fd/RNDOKTda
         s9dGPronhhDP9OgI4L3GesHHWJV8mRPyMlGv36UhuVIDdXTSjXjEEVpuIpxmZFPWNTmr
         ElBhTjnBzDROgwsZGfuOt1V/0rfwqoQOXdLd2Sjqarz996uSIPqhE89Pyjbdl9gNfu1M
         GIUNXDJ54chBQsBWxq8zBbG8c06ncjT3jut4f3BdlQNSr41F4VKcOshg9pEKZtGWVntZ
         K6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789815644; x=1790420444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P4U+Su5olDyDmLov0j40b3fkb86q795927TVcmkINSU=;
        b=bVfoF9HeHg7HAfH5vbkGYFsCkpdj1qM5S4RKZwByi15KXr/srMPkmO8d5M0QpR7nTh
         /6Bwh0rFcyIB6OziXM944NwkGjOlhT0hFH+qlMnrRhvjyEkggzf7Gs7CRuS0/1TL9yks
         pwnN0ewp2Pa/+lSX/+HRdzKM8vm6DIGHD6fL944HLGsVYagu0T9sssuq72IX0xiwEMUQ
         pWaOUNL+ceSAgRfZrclkwDOVpInyMW8CO9jIBDGpk/camktyhOWXotj8R86Vs8b4PMSe
         EIkwr3rgb6x4fXtCX9APTV9wcEu6ML3Bbd8EZ7yOXy0rvUkLAkCqS4U9AGaxPu/1NMOb
         WVeA==
X-Gm-Message-State: AFuF++nY3TPmH/HniVmIf7sPimEb8cKeUaeWL5ZxxJ/+1jsdQabXTiPS
	8GJFDQyNHTm03T7KSHlCQCwQOVZdIhi4A5nYQlmEV+3Vc3zO3BmjFiqS
X-Gm-Gg: AYBFou1Xu5qB41wDhG3aflgkY0eIzq9OadgBJ24Ai7z0qxIZQiUhXR2F6aq+c6+2q9q
	EMuLcRRZsIPEnZHVQyFql2g2KjeDUtTZQu+IRcmsvNHOdAKcDG9/ai3rwnDqC8fipXLbKARdxy8
	xllqaUuG8gPHHiQORCtQWwq9aVezOzsDCmA3WU8vMXnG8Pg2kWAaglD6pnskdCfmTsK6V9omi9V
	aVdz4SfIE9E6x1eDFCqIlJInt5SDaTtQh+OwzZDDrWI+jxwRKP+Egx8BMAu8z/N8N9zNBokJmbi
	JVCRttlt9Jv/x8+eP7KsOnLXhQ/hy7sFkRczN18Usx667NsF8HHYLKno9sHYWfejt4Zk/HrGT2b
	bnVRQPHiVdRzl/KW9fEZ4nZsDlvic0MmpGtBGe5WJshl4Ri0UA+XG/aIZVvoGUEkqD91qXr7iKg
	sazXPNPqi2uW3lOtYe1ZFmwTii+6I6PZkKpMkExHEWFcQIyeDLwJ4YHAE4nJbvtzT0x7tQDNBJQ
	+RHoSI+RtX7BBwMbtVgzoyNQif5oqvOsI0aXdocpzYrZV8T4Y/ByeHofm7pw/+wtaXFpDkm6ci5
	EUz0a5EGjg==
X-Received: by 2002:a05:6a00:c350:20b0:874:72b6:7daa with SMTP id d2e1a72fcca58-87472b6811cmr4827302b3a.37.1789815643955;
        Sat, 19 Sep 2026 04:00:43 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a6ae7d71sm938073b3a.2.2026.09.19.04.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 04:00:43 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	johan@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] vt: selection: Fix unsigned underflow and slab-out-of-bounds read in paste_selection()
Date: Sat, 19 Sep 2026 11:00:41 +0000
Message-ID: <20260919110041.3763078-1-benquike@gmail.com>
In-Reply-To: <aq5hK-fxgPUCe4cr@hovoldconsulting.com>
References: <aq5hK-fxgPUCe4cr@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In paste_selection(), the loop copies min_t(unsigned int,
vc_sel.buf_len - pasted,tty->receive_room) bytes per iteration into
tty_ldisc_receive_buf() and increments pasted += count.

Because the selection mutex (vc_sel.lock) is dropped inside the loop
Whenever the line discipline buffer fills up and paste_selection()
sleeps on tty->write_wait, a concurrent TIOCLINUX (TIOCL_SETSEL) ioctl
can replace vc_sel.buffer with a shorter selection and reduce
vc_sel.buf_len below pasted.

When paste_selection() resumes, vc_sel.buf_len - pasted underflows as an
unsigned integer to a large positive value, causing
tty_ldisc_receive_buf(ld, vc_sel.buffer + pasted, NULL, count) to read
up to 4094 bytes out-of-bounds past the newly allocated vc_sel.buffer.

Fix this by terminating the loop when pasted >= vc_sel.buf_len.

Kernel stack trace (Linux 7.3.0-rc3):
 ==================================================================
 BUG: KASAN: slab-out-of-bounds in n_tty_receive_buf_common+0xa01/0x1650
 Read of size 4094 at addr ffff888101c58010 by task kworker/u17:1/65
 Workqueue: events_unbound flush_to_ldisc
 Call Trace:
  <TASK>
  dump_stack_lvl+0x70/0xa0
  print_report+0x153/0x4c6
  kasan_report+0xf1/0x120
  kasan_check_range+0x11c/0x200
  __asan_memcpy+0x29/0x70
  n_tty_receive_buf_common+0xa01/0x1650
  tty_ldisc_receive_buf+0x66/0x110
  tty_port_default_receive_buf+0x6b/0xb0
  flush_to_ldisc+0x1b4/0x410
  process_one_work+0x6ff/0x1110
  worker_thread+0x4a8/0xb70
  kthread+0x307/0x3e0
  ret_from_fork+0x3ed/0x680
  </TASK>
 ==================================================================

Fixes: e8c75a30a23c ("vt: selection, push sel_lock up")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
v3: Correct the Fixes: tag. v2 cited 2f89e2299c58, which does not exist
in mainline; the commit that moved the sel_lock acquire/release pair and
created the window where the lock is dropped inside the paste loop is
e8c75a30a23c. Thanks to Johan Hovold for catching this.

Note that git blame on the two lines being changed points at
9256d09f1da1 ("vt: selection, create struct from console selection
globals"), but that commit only renames sel_buffer/sel_buffer_lth to
vc_sel.buffer/vc_sel.buf_len and leaves the locking untouched, so
e8c75a30a23c is the correct tag.

v2: Resend via git send-email with intact tab formatting and the
Assisted-by: LLM tag.

 drivers/tty/vt/selection.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 13f4e48b4..f1a3bc5b5 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -434,8 +434,8 @@ int paste_selection(struct tty_struct *tty)
 			bps = NULL;
 		}
 
-		count = vc_sel.buf_len - pasted;
-		if (count) {
+		if (vc_sel.buf_len > pasted) {
+			count = vc_sel.buf_len - pasted;
 			pasted += tty_ldisc_receive_buf(ld, vc_sel.buffer + pasted,
 							NULL, count);
 			if (vc_sel.buf_len > pasted)
-- 
2.55.0.1082.g2b9226bbc0-goog

