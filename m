Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794142257;
	b=HPEZEFyoySZabt1M0+A5AMG6gFidUtin4WeL+bkziEJN6+lsruBF3OB5iVOr1fTPKFjU
	 zhrB1Wpvf4fYBozp7mdKuGFCGDXwWBQ0msq0j0rr/+7CtKKqed0SKJ5ovR9x20NXA9EcG
	 kvk+rwsbdCBPTxkvuRC8duc6QfRdz3ew6sZliAAPUj5q2f8wgmnLonolSgTtlMcp1sr3a
	 GJ02n+YT+q/pMr9KY0aSbzkqjCcW4PIES9nk1tw9Le8s2OdO2uPpD419PpUIxL5ZsmtNP
	 ibeGgjnqYhlMmghoAm0H0KDcfHIh3hTW5o6Jsn8pmwyXfrYmFr2MwXievMYmcL3N8kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794142257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CBqySVJkYZ3V4pcutw3q75Mc5exUd/PgRrxhtsJ1kBg=;
	b=aobTV6WxObX/X+g5UhNFzNNErdmKHJ5LtXpW7lPICDYI9Yy83UfNOrvHNYzFnfvS8sjJ
	 ICcYM3uBlBlWqWH2stEAvUvqSMZPBuE1HX3iUBezArSp+cjRmxI1I1valy4MMU4QDVV7E
	 poXc1Omv6xcauxRMTa3zGsTy6m/0EuKX70YTRUpIjIaMsN6OYBaIr54NlgxcmLUh3QN5N
	 9VDKtPnwtkzI6WVzfqnsZNcknmoLUe0AmVxJCLj/IcXvJmm55j4Vtam5iADFSnYmWgV2u
	 EaQ2LIlohViWz0sb2+v1tVzcsjxKBkmSd7nZyT4wwIL/pgQKCW4Q039l3SeiK/fVqeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="uepg/btE";
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CE4606A334
	for <linux-serial@vger.kernel.org>; Sun,  8 Nov 2026 12:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0CE4606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uepg/btE
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-491f34b4e0fso21571f8f.2
        for <linux-serial@vger.kernel.org>; Sun, 08 Nov 2026 04:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794142255; x=1794747055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CBqySVJkYZ3V4pcutw3q75Mc5exUd/PgRrxhtsJ1kBg=;
        b=uepg/btEh1J6bzh+gCN9Zj151yxywAD+XZyJKu18FAlnmkYGvq9vMoe6aQHBM1R6uF
         AnFnlIyP2ySnYWchtG2uv4R6ZSxMvxqSAh33/wTEqSI1NGBHxaGoQKNrG2ro2fwHqQg5
         jfNoUQ/LZi9mi2IZdDIv8eaya8PVhQKP3xG7uYj8v29Fdgdjym5PRGWjQKk0DIqdeX2G
         bcmgmsb0hjv1ENLFfU+sILBcNSwGPGHniEziDKM2XXmbIGo9k+B6GskpKTTGXdQ7QHv9
         2laYe09lrVfLN/6gJtUR3JUO+IMnPbyAp2ZF9WQMGDTb976f4wZ+7N9NYUgofancqiEP
         QjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794142255; x=1794747055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CBqySVJkYZ3V4pcutw3q75Mc5exUd/PgRrxhtsJ1kBg=;
        b=Sv6Vy6EHisHDDCqnQIzcOphmzPTYIH205+4yhrdOfFDQ4dJ635jviWU/gotqWyG2cK
         k7Una5wpkI7o8vYirOaEr6WXklN3ju1y2XM7Abb1uNoj5iiH/DS80/Thp79QL0aK4Yd7
         GP7FElTF3X5R/Xdf3ThL6v7mJvWEBVCOlnkmYmQvpsIYh9GMMhNYi49eWRCvfT18zYEj
         9HjTD+Oh5NNjndKjuz/RhmuGuvZ1C9IktGTdO5imgy1mIjq7oMqyv+eHDR5hsukoVuY5
         /l9TroM5TeRaMbYYZkWHmwtqtYTJQRsTlmR+vz/oooAbPAU9F8G4spuX/0zp3yeuGjg3
         bHIA==
X-Forwarded-Encrypted: i=1; AL+hErGwiCHNU+ANSP/i6gbLW/h3+vQWT6KqAZjuOcpQgdfKB0bFhgkmBzBYh+kVQJMoB/EbA18CkD1l7u0EKhM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/29BLSXg3C+bDVUETViLLeI02EvJh28ousw+8/iScMF1uECnD5
	Q9L6BZxOMy0denvvqjid9VQAorFIMy5Z1bSd+L3XmQE0nCdJn7C0thkv
X-Gm-Gg: AYBFou0VVFIRkpmz/jETG1eln5eXazoEJJPwHjAGF9RFpB7tLvU7XFQBz5BjCnr5nj3
	N9mtanqO/PZxjTaMA9HXrN7JCxSEYqE1ojGSLw/rya9xYnD78vIBBXzBYfbLchBjeCodAMmhmVX
	plF9cLfW8ucmt/k+Hlm91ADPUmKplt8EH+pJWUXv28/FUa6qgo1dd0Qpqu2iVfyRFSp/9l7QR/c
	LgQzih+tNV/4YT2UNqRPT5SvCEcnSJc6Z+N4JNKsOoyQRx1H1y7FjzABcnkja3dDe5g8X/dV0He
	iaLgMJldSkZuOH++RnUWGzhMEo4Fd3Bfln4GyT/mU4LaY7MnBvZ3tXlc8y6i39QrJ+n4PvuaV6A
	2K5/UQl3rLs0WesRZlJVO0D9sRRSOkwtnjqVLgssWnDHL43K6baRtY6A6sotV35lq3t+i/w/N3l
	7GIhf+aqjC3oa4tmkt6ID9qTtwcUFnb9YxTNHViZR3THnAZ4gBMH9kJ7LfKJPsjEb50WDMiO0E8
	zzqngF0EZnSOSFT1YPBDwUSJ/v6nMuwmVKy7Ybj/qHQz2xeQ1EpwnoCnIuz7F4AZohM4Q1KURu+
	yJv+a2OgTkfNH1IRfoEbgAgjk2O8PWKo+7JHdTbZKsw=
X-Received: by 2002:a05:6000:2881:b0:488:89c7:31aa with SMTP id ffacd0b85a97d-495842b8bc6mr3133440f8f.39.1794142254769;
        Sun, 08 Nov 2026 04:50:54 -0800 (PST)
Received: from fedora.jkuat.ac.ke ([41.204.187.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-495e725c4ccsm2177680f8f.53.2026.11.08.04.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 04:50:54 -0800 (PST)
From: Bramwel Barack <bramwelbarack89@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Bramwel Barack <bramwelbarack89@gmail.com>
Subject: [PATCH] tty: n_null: remove legacy BUG_ON() from module initialization
Date: Sun,  8 Nov 2026 15:50:31 +0300
Message-ID: <20261108125031.33753-1-bramwelbarack89@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of BUG_ON() in module initialization paths is heavily deprecated
as it triggers a kernel panic and crashes the entire system for non-fatal
registration failures. If tty_register_ldisc() fails (e.g., if the slot
is already occupied), it should be handled gracefully.

Modernize the initialization path by capturing the return value of
tty_register_ldisc(), logging a clean error message via pr_err(), and
propagating the error code back up to the module loader.

Signed-off-by: Bramwel Barack <bramwelbarack89@gmail.com>
---
 drivers/tty/n_null.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_null.c b/drivers/tty/n_null.c
index 5a429d923eb3..886f6789f872 100644
--- a/drivers/tty/n_null.c
+++ b/drivers/tty/n_null.c
@@ -32,7 +32,14 @@ static struct tty_ldisc_ops null_ldisc = {
 
 static int __init n_null_init(void)
 {
-	BUG_ON(tty_register_ldisc(&null_ldisc));
+	int ret;
+
+	ret = tty_register_ldisc(&null_ldisc);
+	if (ret) {
+		pr_err("n_null: failed to register line discipline (%d)\n", ret);
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.56.0

