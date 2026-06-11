Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77A148A2D0
	for <linux-serial@vger.kernel.org>; Thu, 11 Jun 2026 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781202762; cv=none; b=heSw4QZiaKrE7FyO0AWOGx3WxEQACatB/IkxtYg915JZBXlcvy/B26XEfb7mebZ2+gm/rA8ldvSIIIifUlbuch4ROq4JkppHAG2EMKeLfY+DOToHFd5gwlbdkrFDxH407QWA7M1KQgb8s1vwEPxI1S/SrX6JRSKYHWpEuZCo2FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781202762; c=relaxed/simple;
	bh=JxjFLmGSkxL2QK9NhTjVfz9A73V5jJkELyAVzeREtkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=khiPdjt6av7BBNqsWLX/BEqncsn1Ad/fEyePugPM9+ZoO592Kda2WDmynKnmRyv+01jvaLdF+vsML9p9Sop86O+KDRkFIr7MP1WqVe7NunR8gFSZx3vQ7zOTKmT5USbRn8mbiRfYuInQpoP/bIrqrQMebTfqbflpsyUz2iEubpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SF7/aDvF; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SF7/aDvF"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-306f36df4feso174902eec.0
        for <linux-serial@vger.kernel.org>; Thu, 11 Jun 2026 11:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781202760; x=1781807560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/OYIv5jkNLJF0xrYSzTRgn/p5XiUqFbMQyOiAXKQiOQ=;
        b=SF7/aDvFP7M8/D89ObZitvIc6o76StkHpLJ/73cyfbSgHYYGJoIi4gWcLzMPee394Z
         p8pL/FHWh9fmLRTiGrK53NHU4VlZcdk+P2cNyAuIXM60/vmCh5ILySq8upXHtLrCsaqm
         +cB7Kl0ywiVjN92inCJpoJfa9H8KjVDPBgV9d1+OT2L1EmD9rGsOu0sf26TOeiI8NYV+
         jYw6mBOENJT93YTkAQGNugCbM8KDAjrxh7g7T7B/+VtSN7zn46JXatSnfTXqGz5dpMdh
         wdNeFRdwkXro/i/OQR7M+6BFw8nTCrXdio+es04FD1QCUzwu7KAkeG0nyQKRs5z2DmiO
         itNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781202760; x=1781807560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OYIv5jkNLJF0xrYSzTRgn/p5XiUqFbMQyOiAXKQiOQ=;
        b=Pu1z8uIzQw2cHLL6TWESWyaVuSruFjmCbx4qAzbfhSXkHyZhAG/sNYsl73BnqkYce0
         10ROLzBBfAonylTtge6RPoW1I+SlQi+vSUHBXPw3JSXjzEYGj2Qi5rsJGejsvQeGT4PV
         JepDyddcfYIEvIEGX+TMzi6O1dY4QXklIMONm5PXmJb9ufEcVk/mQZoll/+gRKzQ3UcC
         pL/if4hk8zwxixaJpNBVkLiwD89Um0Z9QcYPVKeNB911pRnZFszx4BREcnsTrs1owpcC
         s2iCLQZ6zsxXBM2JlmQZvvK/jCIxqyAE7sT+CSVdp+Du6irCzLc6uMFv6ATOZrDQ7lcg
         /yWA==
X-Forwarded-Encrypted: i=1; AFNElJ9bySLnyNEBf6CsHsrtgRw+vqHO0Sswc5lJcc6V3hthw5EH8KQPIrbtCRwUOGuQ1QqhS+yXGccd6SbG8ac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+DEa7FgL5PdikP7IvVk0dwCns0I9q+iiUwb2QcvGEaNPoMc0I
	8mGYSet94QNT7N1zTJ8J6nycRmSBKu9re6QhWsfLSgcK/vlf+iMMKYMbucZH+Xa0
X-Gm-Gg: Acq92OEK+dnEnhaYMc1gIcf6Wk1hkAVQThWahIpgOG9ZwogUP6d3aRPXw7jmNyHjyfF
	rIdozgcNg1c6Er3msO28tFCeezcRvD4/mDbU3/35ITk5USZ5GXixonev3Bo1euRvJNOIyN1rkNX
	fcv8ycsxG/+Cdwr3MGhgpzZzVbLDe5OdFv8oyOT0XZdGLPintdwwcBx0MWvzfrKnH2YovG0eo0B
	XmFoWgCHEn3jLI/ca0kJQvNcmUfyLPfPuXZXqsjXrhDH8UGGovu7EuOAjQcBu6A8W+z0hKk3JuF
	2aRwlAu+AgcmII1vSVMgguQwZ6+pfQiLYOlwE+PM4Qjji6iuuJ1YQnPeCG3YqqWZdUYmZlgzR/L
	29FzL1DOvToaNbVw6WZAuhP2Q2O32U9burrhjU0jb23UQCKCm6SWbZqG5idZpyi8Yv/BDDcokMP
	7B2y/JZZeoBjKczI1RDq0dAe28hZX2vemFgnPmGIPvusqeOOixrPNvixRwFt7Uxf6lH6jZ
X-Received: by 2002:a05:7300:b0c:b0:304:e587:50b8 with SMTP id 5a478bee46e88-30805b954b6mr1578003eec.18.1781202759763;
        Thu, 11 Jun 2026 11:32:39 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30806e8a402sm3058073eec.17.2026.06.11.11.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 11:32:39 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Daniel Starke <daniel.starke@siemens.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH] tty: n_gsm: fix NULL deref of gsm->dlci[0] in control message handlers
Date: Thu, 11 Jun 2026 11:32:18 -0700
Message-ID: <20260611183217.2488508-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gsm_control_command() and gsm_control_reply() load gsm->dlci[0] and
immediately dereference dlci->ftype without checking it for NULL.

On the receive path, gsm_queue() validates that gsm->dlci[0] is non-NULL
and DLCI_OPEN before invoking the control handler, but the value is not
held across that check: the receive worker runs from flush_to_ldisc()
without taking gsm->mutex, while a concurrent GSMIOC_SETCONF ioctl can
enter gsm_cleanup_mux(), which takes gsm->mutex, releases gsm->dlci[0]
and sets it to NULL. If the mux is torn down between gsm_queue()'s check
and the re-load inside gsm_control_command()/gsm_control_reply(), the
handler dereferences a NULL dlci.

A peer that drives DLCI 0 control frames (e.g. CMD_TEST) while the mux
owner reconfigures the line discipline can therefore crash the kernel
(line numbers from decode_stacktrace.sh against the crashing build):

 Oops: general protection fault, probably for non-canonical address
 KASAN: null-ptr-deref in range [0x0000000000000208-0x000000000000020f]
 RIP: 0010:gsm_control_reply (drivers/tty/n_gsm.c:1497)
 Call Trace:
  gsm_dlci_command (drivers/tty/n_gsm.c:2482)
  gsm_queue.part.0 (drivers/tty/n_gsm.c:2852)
  gsm0_receive (drivers/tty/n_gsm.c:2972)
  gsmld_receive_buf (drivers/tty/n_gsm.c:3629)
  tty_ldisc_receive_buf (drivers/tty/tty_buffer.c:391)
  tty_port_default_receive_buf (drivers/tty/tty_port.c:39)
  flush_to_ldisc (drivers/tty/tty_buffer.c:495)
  process_one_work
  worker_thread
  kthread

The other callers of these helpers (the keep-alive and negotiation timer
paths) already guard the gsm->dlci[0] access; only the receive path is
unguarded. The CMD_CLD handler in the same switch already checks the
loaded dlci for NULL for the very same reason. Bail out early when
gsm->dlci[0] has been cleared instead of dereferencing it.

Triggering this requires CAP_NET_ADMIN to attach the n_gsm line
discipline (gsmld_open() uses capable(), not ns_capable()), so it is a
local denial of service for a privileged mux owner racing its own
control channel; harden the handlers regardless.

Fixes: 5767712668b8 ("tty: n_gsm: cleanup gsm_control_command and gsm_control_reply")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/tty/n_gsm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 214abeb89aaa..860cfb91d510 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1457,6 +1457,9 @@ static int gsm_control_command(struct gsm_mux *gsm, int cmd, const u8 *data,
 	struct gsm_msg *msg;
 	struct gsm_dlci *dlci = gsm->dlci[0];
 
+	if (!dlci)
+		return -EINVAL;
+
 	msg = gsm_data_alloc(gsm, 0, dlen + 2, dlci->ftype);
 	if (msg == NULL)
 		return -ENOMEM;
@@ -1485,6 +1488,9 @@ static void gsm_control_reply(struct gsm_mux *gsm, int cmd, const u8 *data,
 	struct gsm_msg *msg;
 	struct gsm_dlci *dlci = gsm->dlci[0];
 
+	if (!dlci)
+		return;
+
 	msg = gsm_data_alloc(gsm, 0, dlen + 2, dlci->ftype);
 	if (msg == NULL)
 		return;
-- 
2.43.0

