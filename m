Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02724562B7
	for <linux-serial@vger.kernel.org>; Tue,  4 Aug 2026 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833919; cv=none; b=XHb4yNDGVGPkLCSM4BFPyZhiEmzRnoVmaSctkgpR2Lyn63se/bsRZyXwjymy34+L7a3QzooudDM41RXaWfg+sVgZuecoTegMpx1vUJ8iFNdZWOmpVAp0lPOA/1NsqCzjXYk+B14lgToqXaxR00ADdCjWzBvFelNK09uV+5B45h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833919; c=relaxed/simple;
	bh=9b5hv7NuP99bZVltiQNQtGI97d1HD/5btdiVcCguw9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NcN6dQRR/uZ08IpyGuNCb313gu2sLXuKopE+loJAhUd9EsmjBRpPVE1L86EpOXjKQmL+91u9aQNy285PQ5eNpUrvzynSCBF1EpsggdlWIWwQ4HyZJL2O0es0PGS6Xxzv6CqJ1Q2ELOpUfU80Pqr6xLtug9Db1WgSKYqqlXEGA6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=QGWkeRKy; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="QGWkeRKy"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47db714766aso423612f8f.0
        for <linux-serial@vger.kernel.org>; Tue, 04 Aug 2026 01:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785833916; x=1786438716; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E/NNfpHYJNt2yLJFPy+XHHqBnXci9iT/8pZeLdqQo8E=;
        b=QGWkeRKyOn52TmXveo0fZkN0UVEhX8jouO50FS9G16mANBy2GZAOIgUFl1Ie9PgQIK
         s8WECXi2eDfilCTO9orEGiyl5PSJJiEKDh+OKkuV81le3tHImifP5Zajd52crdqY6riK
         zAgUHdm5Xi/0YNyTj7FKfWBsf73mXKMroA8bsFequ/pLQKhWz5M8gw04il+JAJYlyUbN
         I065UYFRyaMhxUFHtGzNcHvNSksVP738dU3rn9TRxbeGuI93hchIxfcjQ0R05ezy1ZY4
         CaA+75iWXiwLycZwn+nGCCcAN765yRxiRRKlcoJitu9IPHCPedB7SMdeoRyxTXfd9Iz7
         cA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785833916; x=1786438716;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E/NNfpHYJNt2yLJFPy+XHHqBnXci9iT/8pZeLdqQo8E=;
        b=OOpC4VtVH5iGw8NN68JlnVFm0dSbVZG1G9B78mBWI0tE59jLunWJ7i5oVDgjFAQ0kI
         BKHGp+nh/Ss8AlfAvUe85jxKKdqUewQsxZVcYZino50F3UOoo2x7rT+VC1UJB9SLOxxH
         N4V9iMUSH7czp7IS89edx9K+DITer0Yfy1vft9J6s7AyvYF0Y7Gzw5EvoXtvWUZvXef4
         69oeSl59e6SfpUsbjm0tiDPTQlWhP/hrdeTlLHfv1Cx0c/4NyoJnIhn4CakwYB7uIRYY
         ElpynU44ClCqNUy9pGkuBxGpYXmtGjIVkDVdur2qowjFQxivy0fqvvYSVTORWG15w7G0
         uhSQ==
X-Forwarded-Encrypted: i=1; AHgh+Rob29nx8UcM3wwak1ZjbxWxNAiMuaI21Q/b26SyiWaZHpDlMGkIxM+kpkpZDmHdCpMYOHkP/QaBgqu7kaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzUR+flxjiY23xQPALfpePQxlwuSAYjgTuuD7dhQsZwti6rM5f
	Qkd/UDFRLTI7WlBi/zpk27fP5ugrn1tczW0V/ZCbZ3MMrJhUyuz0xGjJQJkyYtw4HNw=
X-Gm-Gg: AR+sD13eiHPH5gdyREQyWGDADvyLtYqdy5JJC75ifQOGB8kjV3BC4scMvrUtDqC3g9e
	QL9mjWSxBt+1lyrqGocp4tSofHK3dNvvWtWhRtx3lfIwu2/FBWgIgGgVkx923DHrX7qFGJxwJ2o
	Qu+ShzDnMtVjjYiYvMOtQhPif3Mz+SGhwlmA5chrUkIkWmBY41+I3LvtbUKT76QbUH+7WgK6Jhd
	JhtofDXBwBOW/dj0PfdwbKXUfECocCeurWF1yZNyJalWSqbrHbaOeQzvkuK/UffRJ+Ecc+Uvm3t
	AhDZ3JWoKNNbYdYBHxzJzUbyURJ/zQZFL7LOIEjfIPqeKccOX+qZ8GvJduGMHFUi1ol6eexSiLG
	MDM3mlTZYQzyi5JXIfwy224vPk7XxifIbNfFDS8AUtMq7iZAatH/ApwiDmY79ndoO6QLDmeY2jW
	jNTzSAzbMM9rEKpYoHxP9tKxToNHE7/0r0w3XKUmrxDECu4YfaJR5C3wt4JtMTlnpxZ0owj7ct8
	+yCr9pfDWkhhqqmgXmiZIt4e++PgkBIzihQIeuAwvQEyyNcQ2NVPtqXEsEWMSY=
X-Received: by 2002:a05:6000:240a:b0:47d:f508:3364 with SMTP id ffacd0b85a97d-47fe81d732emr5887066f8f.15.1785833915981;
        Tue, 04 Aug 2026 01:58:35 -0700 (PDT)
Received: from localhost (p200300f65f01710496a76592f11363a3.dip0.t-ipconnect.de. [2003:f6:5f01:7104:96a7:6592:f113:63a3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47fe9a3f516sm2984118f8f.17.2026.08.04.01.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:58:35 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Rahul Bukte <rahul.bukte@sony.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v2 8/8] serial: 8250: pnp: Annotate init and exit functions for conditional discarding
Date: Tue,  4 Aug 2026 10:58:00 +0200
Message-ID:  <efb88ec9bfcd7840b0d43f71a4b19b4b54b7a182.1785832297.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1785832297.git.u.kleine-koenig@baylibre.com>
References: <cover.1785832297.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1067; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=9b5hv7NuP99bZVltiQNQtGI97d1HD/5btdiVcCguw9s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqcamlu5p3PXOIMm7ZGkDo+M8cuQ1Oq+++/vUWW DOgHUM0vvKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCanGppQAKCRCPgPtYfRL+ TuPHB/4u/hPqhhxuhOxZ18/l8nozrCvf0HZOeFE79bSNKEV2sJNIb7lBbB9SJ+uH1R2r3InZSVF HxcZdVlc/VkzRj3hAhegGeysrH5sdk/F6wVrgYeGDBM19Y1CMaQyrPzhlueaEKoKKbZI0bIpc+o 3g8oAtWZDLsaLY+ehbAwEWHm1C7hT/MN8ZpQmshcQohrtOWQwVwdIdN8a6RLffy9mt6mm1vnwEe BNm1awiZUVAR8tgM4erkb+Q35J8fVwl0vAlKwCr8WF5RPw9Sn9NZPBZnVyPAh7DH4BHwQPiBJ0f hf6OY6tW7IFrmTRhxtn6PjXYGLXFrHwhTG46iVZK7/ySHWwh
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

serial8250_pnp_init() is only called from serial8250_init() which is
marked with __init, so the pnp init function can also get the same
marking. serial8250_pnp_exit() is only called from __init and __exit
code, so __init_or_module is appropriate for that.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/tty/serial/8250/8250_pnp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 6bfdeff5fe22..7decf62400ab 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -526,12 +526,12 @@ static struct pnp_driver serial_pnp_driver = {
 	.id_table	= pnp_dev_table,
 };
 
-int serial8250_pnp_init(void)
+int __init serial8250_pnp_init(void)
 {
 	return pnp_register_driver(&serial_pnp_driver);
 }
 
-void serial8250_pnp_exit(void)
+void __init_or_module serial8250_pnp_exit(void)
 {
 	pnp_unregister_driver(&serial_pnp_driver);
 }
-- 
2.55.0.11.g153666a7d9bb

