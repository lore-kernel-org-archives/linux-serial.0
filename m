Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2009436CA7D
	for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846936; cv=none; b=ncwqUYUCFdvgLXYqW/BXkw/0YU5C7YkTxgAy6/7BGGHYtKou8HQilGDFvf1IX0QhNUJI+IfljtUbRcXtBFwc9txo2wCsjXjsb8K+vTzInDV2NO+DPCqBQqecKgD72wupTOVsgD+W87RT9Wvnc8Cc57mfPjtn/4xFv5FeS8Ycw0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846936; c=relaxed/simple;
	bh=h/WB+hR/anHyT+SzoBQFwmDv8A8kpm7m3RVwaDTL2qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KD5xUk8niLrfvQ3AZa8AAJx1h4zXVlNEz8nHxupsRr7sH9Fno4PiBfTqKWZt8JwR0oXpZKumlVpElQkiO2MFrO1ZiR806NxvLNLuZtHCbQVi0X7tKfuMMqsN2k1YE7xuf2np/RR0tzS5pWra7U7EtJcQTCVaneB6ZQf+pqy26xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XR9NB8fi; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XR9NB8fi"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so844725f8f.3
        for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 10:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846932; x=1762451732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpqM7R8t1LjT1e31UVuLTSZ7tEVjNoHsGLOYlh8Q1Lk=;
        b=XR9NB8fi7Ziaui3V5/Wqg92z4H6KHvGsDgot4efrfCicu4b6E9JG1GunqqicPpbytQ
         DBUDXRK58bzGbLWo+u51FfhthD7497PQP7KznEHsxfpeQZ2/iSdQAjkqQNScZpjrX6wa
         oUcmFGGNxhQeu3w2n5Zh1wrpcDl8OR0Hz17wmo0jdxG5br8CMWU21e1CyVaxTE/RYnIb
         b+SJnM0aO9D1LGztZ4TcBlGmagL5Z5suBfCQIOu2Jk+90Mwr4ZJ6zdH8u++q9rE18OIH
         T73s4BmFauPBN5nf5kczm7A+DG33vS32inm9lKDZnD1jgWvKIADflChcN0NJqZL4VduA
         nJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846932; x=1762451732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpqM7R8t1LjT1e31UVuLTSZ7tEVjNoHsGLOYlh8Q1Lk=;
        b=aSP8r/jNdy4EWVzEBAQe4fz7GhoyqOE/1GqznNzSBF8uozHnT/jl8gAj1iDREx2Lhw
         nJH+fPaxQ8hkAFGicTyRWFNMxmxCxvwUL8YrPwIKVyNcfKarZ+lxRdFPrSyrF17DWpa3
         cDhYg2DMFZaDheKaw42bWvy1FJ3+++XApmP2KyAmdr1qk3LjY5RQg6yRyIZa9L2wD6Ie
         N1J8+1A4L2ym08QgEVGoK7VMCAOSI41lU97Mq6YzwFUFZI5b3sHF0GeRPlNcLlAreS8J
         HA00c41sShFPnW3zrgcz1qeTlQL8vvod6CJG8ueeIOS/Y1L+KUA4MsvnteLvuxyS//sk
         SaXA==
X-Forwarded-Encrypted: i=1; AJvYcCWfeWSQI0DMzYnvxr2knCSrXb2HD3q1yxDnogSbsJgnjNOQhzsjoIcp8WUxSOptd8etErk1+/Xm/EzWePE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp5MNtFDkjlpLjLwSUbySSubnxznIBuDMpeDPe4osA7p0vhjZf
	Q/UTHsG6upP7ICVJZawsxa3QnRQG+RPydLYkkbdZu6gjrWNcGHYeVems
X-Gm-Gg: ASbGncukWwAUDmlBuWUo6wnT1yvNWqYKi/3SfYPVq7Hm0X9hx5RKhreFdajfkKeh+hY
	vbNHZd4kqUM+uJul/EPL44MTQjE5je0i1pT9DsYxmXIBsEtgpTORReTBuArkMvWfdEuvMVThtt8
	CTXEtK60VbG6DItX8RhwMqW537wtP8gY7x1SZ3GqWEO0+CGALHiU7pmNqCDCTIdLM1JoaJV/8k+
	DtIEb0HTeEeo4czunXi4m6Byo88o6JSBD4bQrLgnawTq2HabsjlR/O6yuwUGLXYdxu9Czf5xGwi
	I7QbFkNnwQRWgA4Drify4QdJSKUjuFUmO9bhEZnq7rJkToJV/1FVKDWmFEvrDcsh3aTEvkCxxK8
	Kx2B0baqjbVP4CvLpeZrMcbzAgCA6vOg2nNufQvEhEZcA/r7+CJ7ZaXlQV74DrTaFtZ9OX6A1PH
	yiCacGZ/RbO1vlexaKtiEPazWsQUrAwpRwUXH70mVtGd7mRHWcgL0Ls6dAbBuquylLzzRtTTQ=
X-Google-Smtp-Source: AGHT+IFB4CtW/QHwxBewuQQ+kfNYXHph8zhhcP0AJhTDvVbB8Po9WDTizjGc7lFwCMRyRyZ8mFCw8Q==
X-Received: by 2002:a05:6000:24c3:b0:3e8:ee5d:f31e with SMTP id ffacd0b85a97d-429bd68376cmr479687f8f.25.1761846931811;
        Thu, 30 Oct 2025 10:55:31 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm33384041f8f.38.2025.10.30.10.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:55:31 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 06/13] serial: sh-sci: Use devm_reset_control_array_get_exclusive()
Date: Thu, 30 Oct 2025 17:55:10 +0000
Message-ID: <20251030175526.607006-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
References: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Replace devm_*_get_exclusive()->devm_*_array_get_exclusive() to support
existing SoCs along with RZ/G3E as RZ/G3E has 2 resets.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e9345f898224..d07424caeeab 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3533,7 +3533,7 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 
 	data = of_device_get_match_data(&pdev->dev);
 
-	rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	rstc = devm_reset_control_array_get_optional_exclusive(&pdev->dev);
 	if (IS_ERR(rstc))
 		return ERR_PTR(dev_err_probe(&pdev->dev, PTR_ERR(rstc),
 					     "failed to get reset ctrl\n"));
-- 
2.43.0

