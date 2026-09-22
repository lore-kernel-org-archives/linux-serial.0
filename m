Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAFD483BFC
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 05:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790055124; cv=none; b=jPbicrCW8TcAA+RKaXUk2IaaU3pinVUNTd/qVDk37h8SCD7IbPJMQhpqHynvML0n/NBgZXs3cGIY4Re8ZVHb0lNuL2+vSJwfwjbBydM4tnOOfCJJVHGwnmX/JRJ8crKgxf7QIHYpRB+PrPSGZ2EP+vkgkT0+D1fljc3z1Nf9BdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790055124; c=relaxed/simple;
	bh=9W73PBFk31No/dPdvPYnVyWpCEg5GiEfGzec0ytxXZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UioOx+ddIO9/16TBSW6hm0Yjh/BnytrgEiVd4fFYs/q7sLQ6YnJMuOk3TCoLXTxEhuaQoPxqnVub4wg1R4JognVsPfyWLvH6Sa28REJVuucKpj0UgCFHmokhn6dsgW4yhSxMHPIo4HZdEzpHwQ3HrLhw51BSDmeNFVX5euxzfj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRJaFEVO; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRJaFEVO"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4aa0f1766so2944144a12.0
        for <linux-serial@vger.kernel.org>; Mon, 21 Sep 2026 22:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790055123; x=1790659923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sYYFcWebz2QqJeTmaAL+wvnhshi1jNcW3pwc7wwdWkg=;
        b=jRJaFEVOGgoVdGHTdZzJsdDQYRmfPLZsa3rZzqulOVRZJrvDay8XHBl6qnieS2fCTX
         DaqdDHvPZgczLLlsdUOjbEISC0U4AdRsZxz5LQY3dLiHlFJvB/FWUxP+//ZCEAIlarzN
         ZxVT1AapDdPOHTrbI5rAtunmQTnFa0qhK8TVGANemwx8UsxqQy3mB9t4vgeRXhwBO+Qx
         ApUVnEkYfyLmbW4FOkhtzKjm0zZqHGq+WssIp05hqeso35Sz4ioeAB+GGtG4SPLpZvnM
         FsRzLJu4Ck/VLluIDQtMOCrr/83OBvyli6usTikRntgTIz4mAdPrXurLHqzauyVoCNm9
         LKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790055123; x=1790659923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sYYFcWebz2QqJeTmaAL+wvnhshi1jNcW3pwc7wwdWkg=;
        b=UavUorYQaGZdPfQUjCXjthurF5CNl+KITWHKM9xOTs9/GwP5f9XOcCSU4YeY7ReyU5
         edRVBqNchvvdhtSLfzFRlbUbdixzqensu5cv20ZFeDvdhUyHffNfg/3qVI8YjCYoF9qt
         3OL6USOzg3uGFdqa9Kowp8921fAjNhUQjzaI7M0hZFMLhXZKBK3xorBzw1+HOEF+M73f
         Z7DhGrmWheXNZDxQlUOwDlwHmIBTyR4wP2Yfl2NqhUQpRYi2yE6BeRdp3MV32txdK0di
         pRTHihDoKlYMOA66RS0O0oDwNWaV2R74X4d9xaPEZaZv5Rkjc2mvJTac0GZ+rwKA+nax
         OUyw==
X-Gm-Message-State: AFuF++nUXxbzGyl5+qSPRYEyPV0mXvMb7pbM4BEjQ8L8N4GdpJ1AIIGr
	ZsgoY6gOO9tczF9FFs+nSIlVwNoMC+zdNg/RKQ+uG0xV7FuBgh/uemyh
X-Gm-Gg: AYBFou1MmGVQO7kOZisjLiiMn3o+efDG6rA2ohlB5IqsiyIgGhLd+y8yk/mTvvP57tX
	Wcvh7PQWMD/qyfx++VJkd001OIZJ3y/7gB/Mfx561VXqRLrTVLBFVHffX3BfRiXsAoKNC7BPRjp
	o0J8H3BK85+j/jydP1WoCx9NSWXqQ7ve/ruqy2pNk1D6tLkiYmyievg2cC+aNsGOUe5Q9iGQO2J
	7DlMR8iIRI3XgDF32pJgil0qZF/uCvhbD82cdh7uJotWXkFgY6/QxHNgbt0q1lOEQz3/pjGYBOo
	pXn3uVXSU0pGPZOqMrYF9E6UL8KpoUDzXj43GJpMaf2Lc33pS2iuINqqMzGtLGvIPJY2HQfEANg
	bo6T+wDni5E+cXxwwRw7zmuXW2fymkT8tnlYC4uCIMrY092mjaM10VZe17FlJeG9MCiz2CROLyI
	63tSKE8x0uiOzpEt/mOTv/NSUpgxqwd7Rqro+2RScKXQp8ggSRcVenKZ3ZF5sTHSorPVt/OYvfN
	n9N7YCAvva6F5m4YCp4JTUzK5U=
X-Received: by 2002:a17:90b:2dcd:b0:39e:6a80:b79b with SMTP id 98e67ed59e1d1-3a0731edd77mr41512a91.43.1790055122630;
        Mon, 21 Sep 2026 22:32:02 -0700 (PDT)
Received: from localhost.localdomain ([202.189.109.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0673b64f5sm2556413a91.5.2026.09.21.22.31.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Sep 2026 22:32:02 -0700 (PDT)
From: Ginger Li <ginger.jzllee@gmail.com>
To: jirislaby@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org
Subject: [PATCH] serial: max3100: Fix a data race on s->rts in max3100_work()
Date: Tue, 22 Sep 2026 13:31:51 +0800
Message-ID: <20260922053151.11260-1-ginger.jzllee@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

max3100_work() reads s->rts when it processes a pending RTS update and when
it transmits a character, both times without holding s->conf_lock.
max3100_set_mctrl() updates s->rts under that lock when the requested RTS
state changes, so the two accesses race and the work handler can program the
old RTS state in the hardware.

Take the value of s->rts in the s->conf_lock protected snapshot at the top of
the loop, like the other configuration fields.

Fixes: 7831d56b0a35 ("tty: MAX3100")
Signed-off-by: Ginger Li <ginger.jzllee@gmail.com>
---
 drivers/tty/serial/max3100.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -236,6 +236,7 @@ static void max3100_work(struct work_struct *w)
 	struct tty_port *tport = &s->port.state->port;
 	unsigned char ch;
 	int conf, cconf, cloopback, crts;
+	bool rts;
 	int rxchars;
 	u16 tx, rx;
 
@@ -251,6 +252,7 @@ static void max3100_work(struct work_struct *w)
 		s->loopback_commit = 0;
 		crts = s->rts_commit;
 		s->rts_commit = 0;
+		rts = s->rts;
 		spin_unlock(&s->conf_lock);
 		if (cconf)
 			max3100_sr(s, MAX3100_WC | conf, &rx);
@@ -258,7 +260,7 @@ static void max3100_work(struct work_struct *w)
 			max3100_sr(s, 0x4001, &rx);
 		if (crts) {
 			max3100_sr(s, MAX3100_WD | MAX3100_TE |
-				   (s->rts ? MAX3100_RTS : 0), &rx);
+				   (rts ? MAX3100_RTS : 0), &rx);
 			rxchars += max3100_handlerx(s, rx);
 		}
 
@@ -277,7 +279,7 @@ static void max3100_work(struct work_struct *w)
 			}
 			if (tx != 0xffff) {
 				max3100_calc_parity(s, &tx);
-				tx |= MAX3100_WD | (s->rts ? MAX3100_RTS : 0);
+				tx |= MAX3100_WD | (rts ? MAX3100_RTS : 0);
 				max3100_sr(s, tx, &rx);
 				rxchars += max3100_handlerx(s, rx);
 			}
-- 
2.43.0

