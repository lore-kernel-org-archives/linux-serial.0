Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEE41A76D4;
	Wed, 11 Dec 2024 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931601; cv=none; b=eolIPVHjfVdi98Ws4Bamyn1Ue0SwHKKsC9S4IILFKeNV1ti8iBYcpXX3O5/JvJ7TkblhZuYEkEb/jbJxt8qGp5dz/1ukG1r9I3qcJpQUnay2NvdeOtCWqFY9qeFKEw2iHfhCKhyQxBF5XMAZA8iiWc/4TVsSh2p9LjLE4M355Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931601; c=relaxed/simple;
	bh=79LkQbtpoHysSL1ZPUcwM/AH0XRMFLrbsWs+ZtI5+Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhmwawzIe5I203d/UgQImvuyJ8j96KLth9NURAH+mKHFpSUiqp5qNYV6y6IYte2JlpHfo9PEORKRHe+xzVC+4Hw08cV2HnZEF44Y3DJ7tTiEgBXuyypNSCFdVWzjI9QvO50cTkSISb1SKsAfl0RkwN+OjE5+CNnjMyupwaPM58A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvfRBKth; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvfRBKth"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6d87ceb58a0so55099696d6.0;
        Wed, 11 Dec 2024 07:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733931599; x=1734536399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzYWF+hB4zsSOaGK1QfNyR7COjKgIUgDaP88A8CU/NQ=;
        b=LvfRBKthZlomQApb9UONveeHrenIPtHuqKORWUcde3sXWexeRsyIR9zXvlOME6NcYT
         KuN+7uttUMjw4lEDW44GbazcmIn5VzkPAKuRSenovZ51OhkR9G3c2IQBdMfeWLnJHFQn
         5uGonoDsM+A8yan6z+3Am/4cHpMaC1Oy9h9/77hgXtLqFmnoogPBY9Vp7iyiTggY7xA/
         JZ3o+MXsFTIC5P5NP/ZA8W0VyEJek1B7BpzGK4KFskFnI8kGYhhSYOJR5wueAHVfcpUM
         fn8w+xUydx4qwWFGOhDYp+dY4Py23qSbiQQmiJYO6Q85zGHCJjHG387HeNgD76Ci49u+
         LSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733931599; x=1734536399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzYWF+hB4zsSOaGK1QfNyR7COjKgIUgDaP88A8CU/NQ=;
        b=qpTM0LkJOhbYXqERRT2d/5p540Oqbd7LYTHUBoDda0LbEuWtqC4oqGbEeBLUQQYql+
         qE518vkB101oWS0IzxCsIXxAkhNNG6dTlvmf1/bBGJgT8cCJQQ+ZqeCa/obI5/ggQM/c
         PMyFyVTvz2UIrsHHLhXVQ4Q5cXZyFI3Ztc0Ct7Ta9qj4A8DXvqfQ6PXKvS3GUTJl/F+m
         Da0TbCK8HA1u+A+Xeri1xBWKwKnKTgtL4HrwBHUQSjGbbDJ1BEmJ8caVkGXX/BRH3VWL
         t3yGzXzuTNe95SbkZ6kk2sJd+yPdB6RgYUuGDlY10nd7MVIDodlj5spY3jz7DgiU2HHx
         XfOg==
X-Forwarded-Encrypted: i=1; AJvYcCXfNEOHnok30uOOCR7xPtRkrHxo8eHGfWV4FvyFh3ZFGJCrLfEUEQdPn7ZIM6cL+2hRUuSGqwXiHKujQWLX+/E=@vger.kernel.org, AJvYcCXpIRF4T8BzKIzzf1DurOQZsR93EwgPg/LMQ7wI3Yo0Obm1VcPk/Oq9WXwBWIHCBqKpHjxb1w3eP+eTb9fR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9xALyMtWkycf6kozOCu9N+DKyqxwoW4lQjpmEcUOC1I6y+Chw
	Tk+ZefDhj94/jx76PHbmo+mRj+5Yms4vCXCslNcWVOyyOc0pFV6H
X-Gm-Gg: ASbGncuANPnhSWeLBHAi61pEfih8LHjWuT0xP/7nRYBUCvluQX5R0LxHFKBx9e6InWP
	2drPY7WmyPH8mRDw6jgy8fBaiLnPFJq1Cf5oDYbiTBd17q9v1BKrtCHKQbL3zBy3wJiiDIgF0GI
	A6tDdKhIhY73RRHnBcFsGSHjQqcQUUe/S+ff6NfmvmGvtiDo3WH3X9WnYSH6ALvd0IxuhR8rWQK
	h6JjX84B1joagDrAsUGEhrb1HoFseaJt6KlSlKm2OtxW5s=
X-Google-Smtp-Source: AGHT+IEY9BdyQjdhYXrGY2ovssNvMVUMde7K/zJfK2B88kJ4VBLQ+GTAD7ONkZv+gRoHj8pV56Qo+Q==
X-Received: by 2002:a0c:ec11:0:b0:6da:dc79:a3c3 with SMTP id 6a1803df08f44-6dadc79a656mr24470926d6.5.1733931598612;
        Wed, 11 Dec 2024 07:39:58 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:18::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da6966desm71334596d6.41.2024.12.11.07.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:39:58 -0800 (PST)
From: Amal Raj T <tjarlama@gmail.com>
To: danielt@kernel.org,
	dianders@chromium.org,
	jason.wessel@windriver.com,
	stephen.s.brennan@oracle.com
Cc: tjarlama@gmail.com,
	amalrajt@meta.com,
	osandov@osandov.com,
	linux-debuggers@vger.kernel.org,
	linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH v2 2/3] serial: Move LF -> CRLF replacement from serial console to kdb
Date: Wed, 11 Dec 2024 07:39:54 -0800
Message-ID: <20241211153955.33518-3-tjarlama@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241211153955.33518-1-tjarlama@gmail.com>
References: <gmail>
 <20241211153955.33518-1-tjarlama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amal Raj T <amalrajt@meta.com>

The current implementation of `poll_put_char` in the serial console driver
performs LF -> CRLF replacement, which can corrupt binary data. Since kdb
is the only user of `poll_put_char`, this patch moves the LF -> CRLF
replacement logic to kdb.

Link: https://lore.kernel.org/linux-debuggers/Zy093jVKPs9gSVx2@telecaster/

Signed-off-by: Amal Raj T <amalrajt@meta.com>
---
 drivers/tty/serial/serial_core.c | 2 --
 kernel/debug/kdb/kdb_io.c        | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 74fa02b23772..8e702f3deffb 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2738,8 +2738,6 @@ static void uart_poll_put_char(struct tty_driver *driver, int line, char ch)
 	if (!port)
 		return;
 
-	if (ch == '\n')
-		port->ops->poll_put_char(port, '\r');
 	port->ops->poll_put_char(port, ch);
 	uart_port_deref(port);
 }
diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 6a77f1c779c4..43a7c8ad741a 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -572,6 +572,8 @@ static void kdb_msg_write(const char *msg, int msg_len)
 	len = msg_len;
 
 	while (len--) {
+		if (*cp == '\n')
+			dbg_io_ops->write_char('\r');
 		dbg_io_ops->write_char(*cp);
 		cp++;
 	}
-- 
2.43.5

