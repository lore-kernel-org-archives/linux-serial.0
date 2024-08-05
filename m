Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40415154C0E;
	Mon,  5 Aug 2024 10:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853254; cv=none; b=Wsjx5tbqbCg3n2iiFFs3GTsB4X8nYU7v/TfWhpxbs+eswtEboWMhmkAiuSnOrGQ5wnT3tMcYFNYSjCfht5ajioZbvmB23WgZUQT07ZilneaRBlaW9PXoQvsFQFlPlWrJ13/g2kT65oJ9dD5X91nhKXziXgywwZt1ig80knSv+pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853254; c=relaxed/simple;
	bh=aoNxYDeT+cp1L3QyLm4IuavyGfB6u8ex3oYTREvJU2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBEovwrwkh8htBdatgdR4pe4M8LQbkPBl2OoHrKuhKF4W4wa3AxiXGY+hliwWEByR2MigDE0HkKZMGz8+OHPs3MhD04y69QGT16gPGQh0Lul+QSsvN73cE8YWio42P5qxvIhNommZd+1UoE8eWerJ9KagJlzDIquQggqf1hju3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jo+Yi//b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jo+Yi//b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0B9C4AF10;
	Mon,  5 Aug 2024 10:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722853253;
	bh=aoNxYDeT+cp1L3QyLm4IuavyGfB6u8ex3oYTREvJU2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jo+Yi//brhxZulg7zpoOE7wtkjd57ozIiFfyiXSfksezziyc7HizwDdbOb/0Tk9PK
	 uWJqeo6NDnomwlMW1TdFka5bSrHU286XZ4zxq3TrgIitXMd3SfzyQqb3l1acR6Nc/a
	 w6LVOCn45ScTxE1hajFO9CXx9N8OIlTGLAZ83Upt8DOY+mayBulg7A7vGia3AqzBSg
	 CGuyPfLyXpjGCeQviP0pdWxwi3UWeadBdZ7frU/DvmgtH2NNNLHpXL736PXIKcpWEp
	 h97eKx3DJayB7rc3w52ghhpggJtd4dIbWe66XWfx3dg1Hby/S5tDoKJStzqOTNfapJ
	 sTiB+EnyASUGg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 01/13] tty: simplify tty_dev_name_to_number() using guard(mutex)
Date: Mon,  5 Aug 2024 12:20:34 +0200
Message-ID: <20240805102046.307511-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240805102046.307511-1-jirislaby@kernel.org>
References: <20240805102046.307511-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In tty_dev_name_to_number(), a guard can help to make the code easier to
follow. Especially how 0 is returned in the successful case. So use a
guard there.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_io.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index bc9aebcb873f..267682bcfea0 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -350,22 +350,19 @@ int tty_dev_name_to_number(const char *name, dev_t *number)
 		return ret;
 
 	prefix_length = str - name;
-	mutex_lock(&tty_mutex);
+
+	guard(mutex)(&tty_mutex);
 
 	list_for_each_entry(p, &tty_drivers, tty_drivers)
 		if (prefix_length == strlen(p->name) && strncmp(name,
 					p->name, prefix_length) == 0) {
 			if (index < p->num) {
 				*number = MKDEV(p->major, p->minor_start + index);
-				goto out;
+				return 0;
 			}
 		}
 
-	/* if here then driver wasn't found */
-	ret = -ENODEV;
-out:
-	mutex_unlock(&tty_mutex);
-	return ret;
+	return -ENODEV;
 }
 EXPORT_SYMBOL_GPL(tty_dev_name_to_number);
 
-- 
2.46.0

