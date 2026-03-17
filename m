Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497B737F8A3
	for <linux-serial@vger.kernel.org>; Tue, 17 Mar 2026 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773735565; cv=none; b=Avhc1jDLMuEy8Q0cJJGKTpeUU5fzfz9FCgg/ruGdLBi9fPAVD/XBYWMZltNohum/ikIR1cJiaHF2o43UZyM+7FZ29iqTXOC5SYtKnJWH1D03Cls06mZascvRJE+b+N8XofnAUy9RCI4DhmyWldaAupOQUinGuwRwov5LuYJ9Q+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773735565; c=relaxed/simple;
	bh=sDC9oDvc/OJAaa+e5V0XuBgvyMKqaQRilJEckYEabvI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rasqUvKalOMD1xXZIfvengxe212QwKkEGaF/CsAP/dFAhf0llEdF90i3dVDLKjpI5mQBzeLl7RuYyCH8h+/1VlIJFXMUWJspTAa+YWPAByN4Q8RZ1m4bmXMQ4zLu/2UbkmddcZDwIG9p/bxTq0vVYn2bcbAVR0mY/Y4HxMX8B/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5/1wnB5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5/1wnB5"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aecab39ad2so3886185ad.2
        for <linux-serial@vger.kernel.org>; Tue, 17 Mar 2026 01:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773735563; x=1774340363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dNbJMuxcQ79SI5b8CBURPPEntzzoIjBKKbyDWP6M+iQ=;
        b=A5/1wnB5bT7W04drVcc0qVR0t2JcezLwCWQUrB2fEH2LyPg8winHumbj63B6lJRPp5
         BseOfK1ttf0GnqoAq44PzlJMm01UkGcfbcJhphx7XhphSbYIywKAnFvvzcXy+ebRr2Hh
         lHht/agtCkItgEtcKArvOUMAjfb4kBH6UElsaCLZA2dWzSwJwxOvMkDmWszyfijhNGoa
         WameJ5Q3f4TS8t9URKejVAlVfuHZ+W27Xvgk+Ue3kH7cgDm3pg2Fmp84XHKthRycuqF1
         uI4c1XhFBririSpgaItD2pkvo3eqgnLg8nPE6K16NiTEFm4af6fk2bWiskn0dLCfZdWd
         /3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773735563; x=1774340363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNbJMuxcQ79SI5b8CBURPPEntzzoIjBKKbyDWP6M+iQ=;
        b=gB7bT13Qxku8XbkWevkzmjXtgnEa/eqQOvSHYOhftzK0WDklQj0KYUewTLznvvFibT
         2JEk6sibzkwn+1XWaUQNOJuOilv+8Nj4/puiEvsHuGoDgxncMUi3FxVVegbkenZYR+HP
         qBQfjh0aMHfM10244IM5E4KvYW3d3cGHskCJKNpz57H6wSgOi3cRfwIA8Ok615fjNq3+
         gsltwmCDaO31oMIURU260YeoPZvisYOc2wh6RkQXmuufAPhrxFuir+mZswMngoGI+Q63
         Pn/234pAESGpjqS6HOLq0vLB7yhiPLKfdgI6hyV5lBcJyXgA30F0E+e7EOek/gwfs2nM
         EugQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdyUfq4Iql4h1ysapmlThUBo8OcA3qauUAAwwRI/ppKuOFBd+uYIgdVAKMSpzo16YdoICu9KFdEs134XY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD/eDjosTCapYtTeVSF7yhNrDN0C4bXgo+wAAaoP2dz8A387eL
	Ysm/eTolIyUy9c4CHSAD+LLfo+4syOTZnRPXqFjWuFtH8MqvwV79lOtS
X-Gm-Gg: ATEYQzzV/aGBHD56oN+QEmOCCkD4InuRf5hFn3KFHNzTQkO3t7AbVJTbdKnpVnUuH/V
	CvNC4GmbQSeamm+DCKC6IST3MwAhX+Z4sZznYFfnRBcpxIJcu68aYu/dIUJLnpsayXibZZ/tTL2
	EeswC+ukgvJxRPKj+GArAJXf2KSg54t5S7A7A+InmzFkjuPUoRSMbceg1T9YQq/dlN8CCnjTfUJ
	JnQ1tjCSVGjMCgxdEyUwGbhKfUoBo8mDb5MvOVpIQ2PJlJT5JWb9VUcVIUhddal1hmGXUkwHU1r
	EmCsB/0sXeS7QVI/8j9N+8qplAveiS7MHZHf/YP8fX4prE8Lb2rllHEM/h+GJEIXkXwMTq0uu4y
	AeHTcDFA/8PPeojF6crAiFIbx/eDpcNDZrCXL1nK0lRhxYrF3JMwpOaAoOAg1Fi4e20tgeQlDVY
	uWh0PsyiJ1kqn6L0ww85HVnSsRMYcuiexC6gwdmg6PL9M5UwiN
X-Received: by 2002:a17:902:f70f:b0:2b0:5075:96fb with SMTP id d9443c01a7336-2b050759903mr61350665ad.2.1773735563498;
        Tue, 17 Mar 2026 01:19:23 -0700 (PDT)
Received: from localhost.localdomain ([36.112.120.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece81dc18sm134793605ad.69.2026.03.17.01.19.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Mar 2026 01:19:22 -0700 (PDT)
From: Ziyu Zhang <ziyuzhang201@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	baijiaju1990@gmail.com,
	Ziyu Zhang <ziyuzhang201@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] tty: n_tty: annotate lockless read of ldata->icanon in input_available_p()
Date: Tue, 17 Mar 2026 16:19:11 +0800
Message-Id: <20260317081911.24390-1-ziyuzhang201@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

n_tty_poll() calls input_available_p() without holding termios_rwsem to
check input readiness for select()/poll(). input_available_p() reads
ldata->icanon, which can be concurrently written by n_tty_set_termios()
under down_write(termios_rwsem).

This is a benign race: poll/select readiness is best-effort, and the
actual n_tty_read() path re-checks icanon under down_read(termios_rwsem).
A stale icanon value in poll only causes a transiently incorrect
readiness result, which is permitted by POSIX poll/select semantics.

Since icanon is a bitfield, READ_ONCE()/WRITE_ONCE() cannot be used.
Annotate the read with data_race() and evaluate it as a boolean to document
the intentional lockless access, bypass __auto_type compiler errors, and
suppress data race detector warnings.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603162328.vY9JOJWL-lkp@intel.com/
Signed-off-by: Ziyu Zhang <ziyuzhang201@gmail.com>
---
 drivers/tty/n_tty.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index e6a0f5b40..0a0d8d70c 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1909,7 +1909,8 @@ static inline int input_available_p(const struct tty_struct *tty, int poll)
 	const struct n_tty_data *ldata = tty->disc_data;
 	int amt = poll && !TIME_CHAR(tty) && MIN_CHAR(tty) ? MIN_CHAR(tty) : 1;
 
-	if (ldata->icanon && !L_EXTPROC(tty))
+	/* data_race: benign race, poll readiness is best-effort */
+	if (data_race(!!ldata->icanon) && !L_EXTPROC(tty))
 		return ldata->canon_head != ldata->read_tail;
 	else
 		return ldata->commit_head - ldata->read_tail >= amt;
-- 
2.39.5 (Apple Git-154)

