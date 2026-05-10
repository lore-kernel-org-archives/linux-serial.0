Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC25189F43
	for <linux-serial@vger.kernel.org>; Sun, 10 May 2026 02:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778381999; cv=none; b=WyhUjudqeM2cuUfbnsvIEaKw4LQOJAuVoPtEFpv25u7NdfQiEAEsA/u4Aok7smnUweVrhpcvuKsOH0PsirsCZgcS4HNKxIR8/R3jK+oXcalNiTW3uIrYfc56skOYATmb1U/u5atYWYtdm0bA5zlhGxZdXaCcF71U49uxXtefj9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778381999; c=relaxed/simple;
	bh=Mo4lZw6iAB/DhJr1V1ENUR/66bZlpTu1JJFcoqwp8w4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cJRh4I/dfxWCIGJ3xOLZCt79pM9zRh8/3HkjgyCntn2snz2lIcjL9xs97chPtEqObwxsvW3A6x9FS7DaoFq1ZlQxAnQBqJlXFe/VdISL0nbM3E/zlLnyDiQzR5hrRCw4IbqFWMrOIZjmldxDyeJq95QJrdEiYwMA1HW+9EtZhJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OB0dCSc1; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OB0dCSc1"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c8025f1c227so2330835a12.2
        for <linux-serial@vger.kernel.org>; Sat, 09 May 2026 19:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778381997; x=1778986797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j7NSkMH5q6IFbH9IYfnNAFy9xywavHepWkh/sS6Mjxc=;
        b=OB0dCSc1PZDmnVKIJlTnseA83ydRj8jPWGbWoPUDq3dLkXKRRvN6JFohj5x4Y+OqC1
         RIrkaT+aYjk22Mgk2peByHSYvd1fP6u/EJqaCqPEsD1T/W3JdgsZAEhjmGwV0UMUw2JO
         Q27yNf9TtC8/IxA70xIUECsBdj8T+h5Be7MjOQ3KvIDDnwLgwCWJXKf9CXHnu4Bhq/eY
         EtRjmYgGJ4IiWulqGnd6PhtpLH8DxljC2JNYg7NqSKFqpS9+YdMuwtxsB4bX8hd1cGvS
         Lks3ZuwEEKtDPvuKK84dH0eNMM/yXx4iP5IdThHZ+D40B/9c2mRO7xSog+Cm6Wwa1+23
         37GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778381997; x=1778986797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7NSkMH5q6IFbH9IYfnNAFy9xywavHepWkh/sS6Mjxc=;
        b=TS3ENLdytHCv+DnBg7cvpDWgUgGxqCwmAOweMVnap3rW6E1w3fEXUQqNErCoHRaZ51
         rMfXwn+lP72Lrin+QtMElqTkcJuDMATNw/rDlLM03udGKLwCifyoeoiD2QhJGkWHrJmk
         Tu/+PzYtIOU8Sd1HRXREXprgVT/CQJdbe8rtAs66xFXqR8qZLkDSzvOwqdxvJeBFoHqh
         5mbLynnGR1VD6NTGeMuR/K8hN6A+9JBIJ59gvCCJqFxEv4q4kV7dnYbAEyYC0FonJKSS
         uPT6EvYN51MDGMe5cWQPdffT/rYCOpJC9chnXlDElThE0/5EUqflwXHz29dkWH/QzWXz
         XMHQ==
X-Forwarded-Encrypted: i=1; AFNElJ9INsTKCrgeZdXoNN0AVfgOOJ0ZUAFFJ/DzuxFA4h595yZL/K2O5wtzAY4NRR8duOnxcE1WgEi62bmdDCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE5BIGfsANDSN+Y7P2WTYPGgwymY+pS8nnx2iEtEPrJTrI421h
	PV6N9ZrdmFCvLWRHSAf6sfsjOh/EXidV/y2/d9XMzx0VJ6EaTAqalqxa
X-Gm-Gg: Acq92OFdp2ooNEMRHdekC9yTWgZcQ16V3ZcL10/2KeFa+bYiX8OWojec2yIdfavbtR4
	DmfNZ7YSA2sJFDksWFYZdOXxSXi3SgHqDbtWIy2vhLr9civrjsbN1LKsAyqGxKjTqKDdlgkXy+h
	op0JRpaLgNjJrFnU7JVhpC5NRpLyXvw9yZn4CIAo6qjDzyU+JLz6lZusF+DjBv/0i6KunD8jU5a
	WmHaBLLezVCAImcJzw9YBKSB9J6z5+JSvhqHmSO0R9Kl3+gKkb0Xj+uRRnCPbu9EIccXGRSWPYl
	Cb6jYIowOygZPPqb5I6Ch6B7oHNOYc39J+OQsitpBSo1Vnsc4oo28W3t+661lUGUr0sucRaFQI5
	1GvWVI9dKl8aE0W6HXlVVCz2wNmSOT7nXdgG2AL+zRJGgQEj82iYWy1+S12wNe4kPExstThX1px
	VlhePu07pJ5hr6fI1myQ==
X-Received: by 2002:a05:6a21:999d:b0:3a8:236a:7df2 with SMTP id adf61e73a8af0-3aad44bcca0mr4234116637.44.1778381997472;
        Sat, 09 May 2026 19:59:57 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267727401sm5399559a12.30.2026.05.09.19.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 19:59:57 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	baijiaju1990@gmail.com,
	Cen Zhang <zzzccc427@gmail.com>
Subject: [PATCH] tty: n_tty: read termios under lock in poll
Date: Sun, 10 May 2026 10:59:40 +0800
Message-Id: <20260510025940.1884932-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

n_tty_poll() uses input_available_p() to decide whether buffered input
makes the tty readable. That helper reads termios state through
L_EXTPROC(), VMIN, and VTIME, but the poll path does not hold the read
side of tty->termios_rwsem.

tty_set_termios() updates tty->termios under the write side of the same
semaphore, including c_lflag and c_cc[]. n_tty_read() already takes the
read side before reading the same termios fields and before calling
input_available_p(). Protect the poll-side readiness checks the same way
so poll observes a coherent termios state when deciding whether to report
readable input.

Do not hold termios_rwsem across tty_buffer_flush_work(), matching the
read path which drops the semaphore before flushing pending receive work
and then checks input availability again after reacquiring it.

Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 drivers/tty/n_tty.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index e6a0f5b40d0a..c8e1882782db 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2437,13 +2437,17 @@ static __poll_t n_tty_poll(struct tty_struct *tty, struct file *file,
 
 	poll_wait(file, &tty->read_wait, wait);
 	poll_wait(file, &tty->write_wait, wait);
-	if (input_available_p(tty, 1))
-		mask |= EPOLLIN | EPOLLRDNORM;
-	else {
-		tty_buffer_flush_work(tty->port);
+	scoped_guard(rwsem_read, &tty->termios_rwsem) {
 		if (input_available_p(tty, 1))
 			mask |= EPOLLIN | EPOLLRDNORM;
 	}
+	if (!(mask & (EPOLLIN | EPOLLRDNORM))) {
+		tty_buffer_flush_work(tty->port);
+		scoped_guard(rwsem_read, &tty->termios_rwsem) {
+			if (input_available_p(tty, 1))
+				mask |= EPOLLIN | EPOLLRDNORM;
+		}
+	}
 	if (tty->ctrl.packet && tty->link->ctrl.pktstatus)
 		mask |= EPOLLPRI | EPOLLIN | EPOLLRDNORM;
 	if (test_bit(TTY_OTHER_CLOSED, &tty->flags))
-- 
2.43.0
