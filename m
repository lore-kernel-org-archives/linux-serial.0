Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7143520C499;
	Fri, 21 Feb 2025 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740141878; cv=none; b=jdd0mHnVQr1KymsBMC1O6D2b2YfyY+1e9xbe7ZcH7ZJlCYQfcNv2tDAHfwYiUdaWYV27k6EKOsErB4M+9V8uAEpWz0wkpLRlxtbXNuRyArzExcdGSFD74cIhJUC40Jn9yGqRoUslEL7k0ZsPgJmOfvIe4Ozfw0zvaNwWQBzCVac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740141878; c=relaxed/simple;
	bh=8hZoOiIA7Cmx6ED226z+mj5j04CtB2cdnxfZGx00KTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9uazj/0cZ+dAOTxEYaCxVlWKRxWZyodaByKusMrwYwu/hbCNTEInoklHXv3KNXuAtDH0kMMNN6cZ1RTz1Gav3zQjn0plklAB2MZKWCRr+f5Tls9fplRl3K3Vz9bhDCLd1UVhAm7aSVP6AXOTOo3Zj56PNmclNyI6E6IPGVEp5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXAr1fRd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXAr1fRd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83BDC4CEE6;
	Fri, 21 Feb 2025 12:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740141877;
	bh=8hZoOiIA7Cmx6ED226z+mj5j04CtB2cdnxfZGx00KTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KXAr1fRd41lMue/kEsK2ef8avK8n1l1DYPNfLoLoTJvPvCWWVkhIRb2cOiLK5L8NO
	 ny96ah8h8FetZ648fcj0G4j7JAFwLsEOW1VkInGFHNLsZTymeOTyBKfTfIX+GAGLK1
	 jS8OdpTHA77zK7yH5XzQ9GWazQ4GDxbDBYGKnj88n1uXJS4Nlotq+SO/04p9iN8aDT
	 DqxkNjTBx/prjXvXTuwCb91Eg9tCWZhxNAY6GbjQc5JlNqueqxCnaTaot3I7aTNLh9
	 eQpgmyrlSC38WECDzcBCZhzDDkd7fKcBi66d/hbMBfNaDGl7yyo9YfPfJDDJvlvDyu
	 OtrXQQ9JP23Ng==
From: Alexey Gladkov <legion@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH v2 2/2] tty/vt: Gather the code that outputs char with utf8 in mind
Date: Fri, 21 Feb 2025 13:43:53 +0100
Message-ID: <c0d10193e61f977b518862d8f216bbaf234138fd.1740141518.git.legion@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740141518.git.legion@kernel.org>
References: <cover.1739881707.git.legion@kernel.org> <cover.1740141518.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we putting character to the tty, we take into account the keyboard
mode to properly handle utf8. This code is duplicated few times.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/vt/keyboard.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 38d4df932f73..517db498beed 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -376,6 +376,17 @@ static void to_utf8(struct vc_data *vc, uint c)
 	}
 }
 
+static void put_queue_utf8(struct vc_data *vc, u32 value)
+{
+	if (kbd->kbdmode == VC_UNICODE)
+		to_utf8(vc, value);
+	else {
+		int c = conv_uni_to_8bit(value);
+		if (c != -1)
+			put_queue(vc, c);
+	}
+}
+
 /* FIXME: review locking for vt.c callers */
 static void set_leds(void)
 {
@@ -454,13 +465,7 @@ static unsigned int handle_diacr(struct vc_data *vc, unsigned int ch)
 	if (ch == ' ' || ch == (BRL_UC_ROW|0) || ch == d)
 		return d;
 
-	if (kbd->kbdmode == VC_UNICODE)
-		to_utf8(vc, d);
-	else {
-		int c = conv_uni_to_8bit(d);
-		if (c != -1)
-			put_queue(vc, c);
-	}
+	put_queue_utf8(vc, d);
 
 	return ch;
 }
@@ -471,13 +476,7 @@ static unsigned int handle_diacr(struct vc_data *vc, unsigned int ch)
 static void fn_enter(struct vc_data *vc)
 {
 	if (diacr) {
-		if (kbd->kbdmode == VC_UNICODE)
-			to_utf8(vc, diacr);
-		else {
-			int c = conv_uni_to_8bit(diacr);
-			if (c != -1)
-				put_queue(vc, c);
-		}
+		put_queue_utf8(vc, diacr);
 		diacr = 0;
 	}
 
@@ -685,13 +684,7 @@ static void k_unicode(struct vc_data *vc, unsigned int value, char up_flag)
 		diacr = value;
 		return;
 	}
-	if (kbd->kbdmode == VC_UNICODE)
-		to_utf8(vc, value);
-	else {
-		int c = conv_uni_to_8bit(value);
-		if (c != -1)
-			put_queue(vc, c);
-	}
+	put_queue_utf8(vc, value);
 }
 
 /*
-- 
2.48.1

