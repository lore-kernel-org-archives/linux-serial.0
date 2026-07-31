Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA04441635
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514704; cv=none; b=IAus4dUC4rLH5rkTfYoR2OCTeSqzl0a+7cBps5ZQTg2dAwacN871MC6uHVSxqM0WvDYTuuln4Hsh8wuJ0Kr3kuRgWQrNUeUN07DCP4vuNTxqYXeByGdXRLcIIX8HSFA/HzcC+5zDNPKpqyiEA9Re1XhEkbMSsQSGRnDQxbZDMNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514704; c=relaxed/simple;
	bh=YOAC5Iz8b4Wfr8gFSlts5gUsGsYV93JUg+dXPJSubq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHe4Y+DqlFZ1mHqhOxeIh6JJ0dzZUDXBUSZ/M0MJKzONirvTgBsjPoEwYujewoN18enOHMwDv3EG7UVA0GXN0gNAH4w4cQwpgEoHfZ9RLZoDlUJOo7SKe6drj677B8nYOf/uelj/j3Ngw3jk7De/9IJMQOP/ozOIKQ0p8ptgwT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sX1a0SK0; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sX1a0SK0"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso985484b3a.1
        for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 09:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785514702; x=1786119502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EkiEIruiRSk3N9UIDQ+4txiR4UPtQnB+oM9OYfyxLPI=;
        b=sX1a0SK0Ddf1AB5GeYJVJTuMJ6cuSQSwFc8i2AOuXuLkYEHQas6DGP0PqU+X2G7EiM
         tzFqT5Ozs7EkEa0v4vDCTV3qcXFfZO2ERc5rZ+oaU6pQPLnoXa3YP5YU1eEEF4ocmx78
         I48pF0bNI2EqWcdGpDcLbpO/rS3uVeUytAAF4zch6IX0YyYuhDEABw/s+/DXU1gWvoj4
         8kTJYcYI87FVzjV89JpLGu53sIpqORGq0Nmt1dj5EMLXn++0de+/z757mv2K0N6xDOpu
         iTE9LKCu9zUwJdJbQnR/D2X7hDjUrrE0JuDtFN0W0WzdcyWlazzCmjBgKAJd4wvnLrFf
         +bLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785514702; x=1786119502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EkiEIruiRSk3N9UIDQ+4txiR4UPtQnB+oM9OYfyxLPI=;
        b=ea2nWqIwzjSmC1TETJQE83G+Egb3C1Wc2hY/W/1CNrUxIP1Zlud4M3l+nqYSLqtLrJ
         ZI/LU+P3s1PCz+KMR5Llro7It6OKMziSHBnDKVRUMDj/GelOBxSlIGyx6MmSewFooCRK
         FCpg/AOpkMd6oEFxWVWJLEeJpWc+hmVpWlFA5kor+MqAciNgKwjnJqpP9vji0upsraEi
         r9St2hIepLPpLTYOAn9Y5Q98LWzfJEtJ5V4CxuS8ghfoNDwocM3pUTk5u8kLeF4pG5/f
         ColAN+YNXsBlIX6pMTbaVZ2iKbyGm+SPqraDqSvTGznZiH7I/BSSqdIbQbmLGIxu5/63
         kHPw==
X-Gm-Message-State: AOJu0Yx9GK0MZvFbMr27IRxwR7YL3Thn6Yh3giNE+lwxKCwt8g2Qo5mP
	h99Cd3LhPFnBAjlYssd4ilXGisRLhObhphdWTgSQx+b8zonNg8GukAc=
X-Gm-Gg: AR+sD13VmtuTSWHOv/y7HjkOVp0D7rtLHU9R/2pttb+bzTR63UZilIQZi3reuMDFHdT
	hqSN54u8o/o53PaIsE70uqpFYMg+QjcWKog0/5k7OK04W3sh9iP4JkWAVseFizMoyADe7j4cN8m
	TexswJAlaApnM053iZRQe7DCOuwB+3eivf2BHrS/Xm/K1YLgT8ALHATnwbu8YEqzz+yV7JIR6ME
	nV/dWM0CbJu6qnptQu89ezpfeom3X1Jdp9oywXeS+zpat0kLWjWuAHnO5G44A22NmJ+yK/xx0kI
	qKnPAmndG1Pz6J6lxQOcGGpgIa3jioD/sKdvyehrfKHxh9JDYIVMRF1EeZ3YFlbbKT8jcvafmS8
	HzJxhrfdN8PYQ/vfcXKSgs6CqEAyLJ5/2zViV20N04YsXbv0o2m7GJ3YQ+CZiWp3g5YHsNJeH/V
	VriDiN2Qh/lw+dCByFDBHahTTGwj6VTNcBeAS/k+IG2ieKK9I3Wa9VBnon2uiBXEk1ssmVvRHBG
	EqUdBYjHcLACHNYVKRF1BSzD1TuF2gIHRmTulCBwpwZwoia9o6aaqxM/lutTIM89Ja2bq0gQFjv
	TlaHEhGB9JOjD1Doe55clA0=
X-Received: by 2002:a05:6a00:2d9c:b0:848:4ee6:4d0 with SMTP id d2e1a72fcca58-84ed7483c02mr2063804b3a.23.1785514702344;
        Fri, 31 Jul 2026 09:18:22 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc29e6f0sm647072b3a.39.2026.07.31.09.18.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 09:18:21 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH 2/2] tty: moxa: use pcim_enable_device()
Date: Sat,  1 Aug 2026 01:18:09 +0900
Message-ID: <20260731161809.45066-2-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260731161809.45066-1-mhun512@gmail.com>
References: <20260731161809.45066-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

moxa_pci_probe() enables the PCI device with pci_enable_device(), but
its failure paths and remove callback do not disable it. Repeated bind
and unbind cycles can therefore leave the PCI enable count unbalanced.

Use pcim_enable_device() so the PCI core automatically disables the
device when probe fails or the driver detaches. Keep the existing
explicit BAR request and mapping cleanup unchanged.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/tty/moxa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 680b2dd65462..02220ecf3b38 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -1063,7 +1063,7 @@ static int moxa_pci_probe(struct pci_dev *pdev,
 	int board_type = ent->driver_data;
 	int retval;
 
-	retval = pci_enable_device(pdev);
+	retval = pcim_enable_device(pdev);
 	if (retval) {
 		dev_err(&pdev->dev, "can't enable pci device\n");
 		goto err;
-- 
2.47.1
