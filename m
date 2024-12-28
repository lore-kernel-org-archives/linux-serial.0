Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AA814F70;
	Sat, 28 Dec 2024 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735398074; cv=none; b=fHqqNx3xTy0XrQboJ+wzoZs9Ofri1DmoMf53dh4utBi/fes9JxiaqMjziiNDZBiZCjHiLdV3EDhYkel56Yzr2MsSzmgZdH+uEk5d1ILNTVHKzYQgRYwU9oJ/eSkNRpECLljgqWO5Jp5Mn+BI1fXeYxRfxbhUViU2J2B2apjCRCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735398074; c=relaxed/simple;
	bh=maQK6SnknNFyzpbwfFuMMgBHRi4HuQKdh+kTfcosLe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u0+XJK478ugkLipzUM0D5O1OTHTstgQy1IbGMoFSB+q1271Nd+fu5fSfoBYyiGw9QSYhHxiMT/lrztLQ6gIZUzvrPq2LHTZdv4JObV/6V8q56pSZ5wQi/1Ay7nA+xDBThL7pFGutHnA3omwfjXhSNDTa9eTvfF9wR/wSuCD2BZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ym0FTW3S; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ym0FTW3S"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3862a921123so5385059f8f.3;
        Sat, 28 Dec 2024 07:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735398071; x=1736002871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3r5rknlp8C6dPP/+6B/6WMRRP6X+7HtxASZ9hD6NMY=;
        b=Ym0FTW3SByaLGe6ssrdjmZna0mvU59FY2DhYQ9GRgla0msmIz3RjbRXO4iKrD16ARO
         k59tR5fTsdK3px4koS72SJRFtxHM7LEIvtmCJMGELK0sWCJU036ppMDrO8HUVIpt6Mb3
         aHEp05b0v5tT7UEGwe3OUm7MosMgLYck5doshRqWV6vKTQIjeCSXlgJs4nebIHlATGk9
         Uk0f7+uhLMhJl4qfcWD+E1a6idHAoNLSiTw5EKOAASMTmv/ERJs8qczkRVcf4UFmIfM7
         DrBSrGphHvanzuIFAq5jfyplOv7LdloV50358NIoCnGynUVH1QV/Y4N9pEN2mbD732sE
         zoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735398071; x=1736002871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3r5rknlp8C6dPP/+6B/6WMRRP6X+7HtxASZ9hD6NMY=;
        b=LpDTTRdST6gF88+trPfqoLFjBZ0E2b9w8N8AcPR65DPxLasdIzESdyfsWcPI/luvpM
         Kr37VOdKtaLgiiZwClzXMabAUFn3rdSEq8YCkzpvAmDod8a/CEjEATzQE44lTchoIXH5
         4mZV6GEJQYxPnVcVphe9AChLbK8BIUehNF8hfaVKjStSwApZ66CXKWmsR0FmC0dThuFz
         AbQiQJFGh40SqNl/8270EOv5EK6vgLWyIk7RzDeTj818WJkFVxytjNR+K7XBMED7wCPc
         qspFqZXTtuJdK0/iJ50YwHVqFRBHtV6yW7chUkyBWyE4VlCjUCkA0ZIMQxvktL7fVYd4
         B4cw==
X-Forwarded-Encrypted: i=1; AJvYcCUOMfO6D/Cx+h6Fbsj9Jno71evPuTmAl09NlfaR+Q599/uDhAu8uHXtzir3wqzbdzCxQ/ENhaN8LMeSG9CF@vger.kernel.org, AJvYcCWw+RbbNNBTETjgWZDuWdzprFLgk03ccge688la6XJHJBp+XC2glvjLMIIvifZViO4cUmAp+HmIRKs52cw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8wsMzPGajAVdjlPlP0sIvh/rBArxdV//QP1FC2Rrh7vAIz0XX
	usCdDy+tc6pDq6e//zcCVm6wehsaWUz/FANKp+F4kwfU+O50MTKY
X-Gm-Gg: ASbGncvkJPh0ivrBso3S9R0+w0F6zrjZPUgK1xOm+aintdxqGa0vrkBx0DDO6TzcyHC
	J4kYL1EjxjcZxmmwwF8Q7c7HfIW/FrXOx5iQhxjbI/SsnAPLSwKUKtl9AXKFxM2gy3M9gdhP5oK
	tpO9imkxv9L/PifElbsx46PsNuojkUMjFWwVLz0bS8E9qzmPHf6vQnSbdqnbvkrK2rk6aHtr66b
	ZO6rteDaYtv7qf7dvfQbW9LAi5ZD7d6MHecd6q2l++JsGt2tnrRYSZsOMiXJJmjfnxW6WN/6KcB
	7dU=
X-Google-Smtp-Source: AGHT+IFlnbxfSsudsAl6xNhEBdGe2gHTrJpzWg0GoGsV6wx9nJyGfR9DqyqCWhcgn1z+aIiSuiACWA==
X-Received: by 2002:a05:6000:1863:b0:386:4312:53ec with SMTP id ffacd0b85a97d-38a221ea72bmr23221738f8f.17.1735398070552;
        Sat, 28 Dec 2024 07:01:10 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832ec4sm24779584f8f.26.2024.12.28.07.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 07:01:10 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] tty: n_gsm: wait until channel 0 is ready
Date: Sat, 28 Dec 2024 17:00:59 +0200
Message-Id: <20241228150100.100354-2-ivo.g.dimitrov.75@gmail.com>
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

Currently code does not wait for channel 0 open sequence to complete before
pushing data to the other channels. Also, if userland opens tty, it will
receive EL2NSYNC. Both issues result in hard to predict initialization
sequence and possible userland failures.

Fix that by waiting channel 0 open sequence to complete before attempting
opening of the other channels. Also, if tty open() is attempted while
channel 0 is opening, wait until sequence is complete before returning to
userland.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/n_gsm.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 252849910588..b92480051e3d 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2244,13 +2244,16 @@ static void gsm_dlci_t1(struct timer_list *t)
 		break;
 	case DLCI_OPENING:
 		if (dlci->retries) {
-			dlci->retries--;
-			gsm_command(dlci->gsm, dlci->addr, SABM|PF);
+			if (!dlci->addr || !gsm->dlci[0] ||
+			    gsm->dlci[0]->state != DLCI_OPENING) {
+				dlci->retries--;
+				gsm_command(dlci->gsm, dlci->addr, SABM|PF);
+			}
+
 			mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
 		} else if (!dlci->addr && gsm->control == (DM | PF)) {
 			if (debug & DBG_ERRORS)
-				pr_info("DLCI %d opening in ADM mode.\n",
-					dlci->addr);
+				pr_info("DLCI 0 opening in ADM mode.\n");
 			dlci->mode = DLCI_MODE_ADM;
 			gsm_dlci_open(dlci);
 		} else {
@@ -2308,7 +2311,9 @@ static void gsm_dlci_begin_open(struct gsm_dlci *dlci)
 		dlci->retries = gsm->n2;
 		if (!need_pn) {
 			dlci->state = DLCI_OPENING;
-			gsm_command(gsm, dlci->addr, SABM|PF);
+			if (!dlci->addr || !gsm->dlci[0] ||
+			    gsm->dlci[0]->state != DLCI_OPENING)
+				gsm_command(gsm, dlci->addr, SABM|PF);
 		} else {
 			/* Configure DLCI before setup */
 			dlci->state = DLCI_CONFIGURE;
@@ -4251,7 +4256,7 @@ static const struct tty_port_operations gsm_port_ops = {
 static int gsmtty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct gsm_mux *gsm;
-	struct gsm_dlci *dlci;
+	struct gsm_dlci *dlci, *dlci0;
 	unsigned int line = tty->index;
 	unsigned int mux = mux_line_to_num(line);
 	bool alloc = false;
@@ -4274,10 +4279,20 @@ static int gsmtty_install(struct tty_driver *driver, struct tty_struct *tty)
 	perspective as we don't have to worry about this
 	if DLCI0 is lost */
 	mutex_lock(&gsm->mutex);
-	if (gsm->dlci[0] && gsm->dlci[0]->state != DLCI_OPEN) {
+
+	dlci0 = gsm->dlci[0];
+	if (dlci0 && dlci0->state != DLCI_OPEN) {
 		mutex_unlock(&gsm->mutex);
-		return -EL2NSYNC;
+
+		if (dlci0->state == DLCI_OPENING)
+			wait_event(gsm->event, dlci0->state != DLCI_OPENING);
+
+		if (dlci0->state != DLCI_OPEN)
+			return -EL2NSYNC;
+
+		mutex_lock(&gsm->mutex);
 	}
+
 	dlci = gsm->dlci[line];
 	if (dlci == NULL) {
 		alloc = true;
-- 
2.30.2

