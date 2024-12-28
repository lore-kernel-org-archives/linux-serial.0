Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274A0C8DF;
	Sat, 28 Dec 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735398074; cv=none; b=ggnboTPBaN8h3hWdYp+rcBsSpVwrTMdKGECNIAHIoKu5jCFSzRpQewTzl7DgYwQr4uzYjMcBFQFQqCdqvfSBKq+hGgX5GU1BInqFzJFRaGEtfaWIev3Vgh74DykWPVt+88dF32hlykNDZbZ4rWu3EbhKeWsQ3+I4hhqHO03hFlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735398074; c=relaxed/simple;
	bh=EivJtJjg6TetCtMGVhAd9cqsZ3aaF7wh/bdqeGopHBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OujgriSWCTaIkkE9RIppR14kbzB78SMxk5h8ms1IySQNoHX6eh08Pe3Ba4ViF4QlOp/XsmpPk2YgwDljofyhj4IC1b/HGsx6tTxb7CBIpOAAzqyAhs9UbLejQRqHFDeNJrufquQfCie+MBW6iJCSIwlFPYPd70H8feOdBTe4amE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgWDjAEF; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgWDjAEF"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862df95f92so3477839f8f.2;
        Sat, 28 Dec 2024 07:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735398071; x=1736002871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkxTwm9fghaxkpIPqMsbbHmZHAbb9+mbREpcgRCMYzU=;
        b=GgWDjAEFTIK8/IDDB9QePXoRn/V6zYmhC2vyHB69f+Y9RkxE/j8MYcj6vmdlKW0PtR
         5zVIhy0DUpLvrbFk2wJKHHcFF0KZA+Saa0ZiG1CjC4p+M0b7d2Y4eu8WpzMIQvbLZLiW
         YBv0wqywdxd0s1b9NGTuJlYK4P6Y4MMF6ssfnZeXl+I9BH9B3ZmPX1LhyZuSlwUfMB3K
         Dl6osg0wkvTyGRZkFnixT21hnFbipVr2Fwgj0yDISpvopO5rjz6A4tv+6rteCjK97uwc
         AAqDp7Ug5w/Id/5PqFcrLvVEWdYBCiaXSi8TXAGP4L5F9rdRadpKLTk1MaVxrzdmi3pF
         rjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735398071; x=1736002871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkxTwm9fghaxkpIPqMsbbHmZHAbb9+mbREpcgRCMYzU=;
        b=vCbRXhEcArl91P6dELj3xR3SjwnzfYrCqF2ZnzMZdvjiqXxJKzLTZvySrsBmE9Vzt7
         QXyfOXCBUUZuHabz+0bd6rxTjUkhtkPv6ucpwRz9/aqxa/A1sx7Uy6l5JONAKvTV9MHV
         LpYpAvyM+unUjQ7RtVoHQ7Dsf1fQrX039avcAeCyheaG0SDnFLxzlSAZrzFoO+KaEq8W
         ku2ekjflShg23wvT/P02XqMS6C2/iX/yHQ5MUUsWRAQ439tqUnA7Udcg9/oVzdcxk3cw
         lR2SRpoHL6PTwyJolLom8/w+Jl2l+rIY4St0BntPorNC9C8HAOEDdBh11gB5GPNpZVEp
         eCUw==
X-Forwarded-Encrypted: i=1; AJvYcCUdNLDO/ixQyJwGWndXmmJZjNNtS92jjxi8yJgltwAKU01qQhQLdiJybLkDLXhE/7Om4GubUYHbdKKmRA3A@vger.kernel.org, AJvYcCUoK89rG+dvtTwZ2PJMz0TEKo3mDwICKINpRTwNppADXo6GcMojiTCsCqX/Rx0K5NZ8oREkmO+VV0P2WMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj7ZcpLHHqLmxu2Rbjb1CL5aWgKN63aL7PHgAgj8icBMoJdnwZ
	VeUl9qRqQwfnTfjpu0kXlsqNFD+dA9ejzZMyfgYIbAHOJd/YHDFy
X-Gm-Gg: ASbGncsXjMhesBCqJ336BZdnnGpX8LJtiYDPb0As0QS9d0p/KceUwM6tqUlnMs0fANw
	kbns5xNuPosevjw24yjSik6/tSSYLZSPsa3yHFqZ+bSamAXrdVGB2uZ5pgmExqMH/zjYkgfxYKH
	8NQdugG1DuNkPLadjjc6VeFA0BMNDSoI41zvQDfqicn/zn6LdtCmrwBOsqtOn5tqAJD3Ko7lQZ9
	X4hx89OXR7LsZgVQJkpDbg1vFLqwc0tvRMAkSPImyVuJFp+ESNhZY/dB71jN4Fmt2eNK0TCzm3a
	ohs=
X-Google-Smtp-Source: AGHT+IELtE/UJFR0lTmqWqz0ewdbiPVm01YMNQSh+QeeJw7KPmm9yKCxI0JLcjuWJV3v8tjapkAAMQ==
X-Received: by 2002:a05:6000:188d:b0:385:f7d2:7e9b with SMTP id ffacd0b85a97d-38a221f3785mr24599418f8f.30.1735398071418;
        Sat, 28 Dec 2024 07:01:11 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832ec4sm24779584f8f.26.2024.12.28.07.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 07:01:11 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] tty: n_gsm: Fix control dlci ADM mode processing
Date: Sat, 28 Dec 2024 17:01:00 +0200
Message-Id: <20241228150100.100354-3-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241228150100.100354-1-ivo.g.dimitrov.75@gmail.com>
References: <20241228150100.100354-1-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, code retries n2 times to open control dlci in ABM mode before
switching to ADM mode, but only if DM has been received. This contradicts
to the comment that dlci is switched to control mode unconditionally if
DLCI_OPENING retries time out. Also, it does not make sense to continue
trying once DM has received.

Change the logic to switch to ADM mode upon DM received. That way control
channel state will change to DLCI_OPEN way faster. Fix the misleading
comment while at it.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/n_gsm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index b92480051e3d..363afe11974f 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2224,7 +2224,7 @@ static int gsm_dlci_negotiate(struct gsm_dlci *dlci)
  *
  *	Some control dlci can stay in ADM mode with other dlci working just
  *	fine. In that case we can just keep the control dlci open after the
- *	DLCI_OPENING retries time out.
+ *	DLCI_OPENING receives DM.
  */
 
 static void gsm_dlci_t1(struct timer_list *t)
@@ -2243,7 +2243,12 @@ static void gsm_dlci_t1(struct timer_list *t)
 		}
 		break;
 	case DLCI_OPENING:
-		if (dlci->retries) {
+		if (!dlci->addr && gsm->control == (DM | PF)) {
+			if (debug & DBG_ERRORS)
+				pr_info("DLCI 0 opening in ADM mode.\n");
+			dlci->mode = DLCI_MODE_ADM;
+			gsm_dlci_open(dlci);
+		} else if (dlci->retries) {
 			if (!dlci->addr || !gsm->dlci[0] ||
 			    gsm->dlci[0]->state != DLCI_OPENING) {
 				dlci->retries--;
@@ -2251,11 +2256,6 @@ static void gsm_dlci_t1(struct timer_list *t)
 			}
 
 			mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
-		} else if (!dlci->addr && gsm->control == (DM | PF)) {
-			if (debug & DBG_ERRORS)
-				pr_info("DLCI 0 opening in ADM mode.\n");
-			dlci->mode = DLCI_MODE_ADM;
-			gsm_dlci_open(dlci);
 		} else {
 			gsm->open_error++;
 			gsm_dlci_begin_close(dlci); /* prevent half open link */
-- 
2.30.2

