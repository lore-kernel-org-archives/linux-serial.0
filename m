Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF83E25EFBC;
	Mon, 30 Jun 2025 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751283722; cv=none; b=nVkXjd1Nofquza+AcuPgWw3fLvA2zLKakO8LNBABsh7m9xyVKBY+Rtk25DoCxID+TtBszOVIFGfJCzG1ydRIGoZl0b/D0kCU7dzIPNvPsxiQpdbvS9ZTEylX90Ye6BzDnycHQpqUetwQhYQhrMjHifEtiNLAPco5zfijXjO+KNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751283722; c=relaxed/simple;
	bh=FO51ABSuHOGNa4urR01Hd1w5txbouBf4qswW4i6xqv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j6uouBsJcWLkRKwOnaaEXxpBtjihJLzN9vWJiU5A9fesXgMKVsSBzFxfOL/gyeUW0zhDQvjCrR3sH59nSC1+VVWSeziklJ7i30FwQjOJqxtUkqlHvCNEBVD3JtJml09p3hsUUJ9a8aZz4SnLLTALBAWWpCzaRkyLuIXrwvbKr3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvUuHkmC; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvUuHkmC"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a577ab8c34so621520f8f.3;
        Mon, 30 Jun 2025 04:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751283719; x=1751888519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8jvy3pp04vKzvPchJ+mlkBLjd4Hm79oWF7qAKiCY2Q8=;
        b=JvUuHkmCJWIuaB3R8U8fbcsueztCH4UE4/aIzMaqoHQO+02ikbISAyyrfGb9rV6V4z
         g1qNEZxC8ZdhEAG+BzpkuEuvSJK/mwc02Tc9mRhf9ponBa8DglBhSaf3axv3MMbYCm1B
         +1meNxjhOqUdj9U91JgqEkRRyykn0krYa0gEO5UARVJNC3vhLJ43DEAhi03d0NMRlD5i
         d1H7rLv+28wUDTwWDt0BbMERly74ygUEH5BBNdqMRPTeWz1VG9vtxF3lz1tEE32I1Ntd
         vRFT8XrAdiL4ddCcmx5ddbHwUflpxNIOj6fpdEMGAf2GSNpMiunKY2YcGNpajqIMJcsh
         +VzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751283719; x=1751888519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jvy3pp04vKzvPchJ+mlkBLjd4Hm79oWF7qAKiCY2Q8=;
        b=EozpFp96Kc/KXDskkQ9E0yKxDUm/NLt7r3PVcSeWnvzLvOrxd9erJ09183/PvNFBGe
         ziJeRnmiqYKqcrrOyYXyrcBl/jtqCMxanIr5w202HFKoh6gEQcpjVSpUSB4WEv6+WlHR
         S8bCi+Zk5+n0/3IBNUhIRMfF4RTnZcdDl3VsVubatXnC5oPov4ExLOKZ1Csj2o7kOCvK
         Bx0nYuJf5zCZdcus33G08YzmnCjFV7pZclpsOMvDXSvRKFDfqHGqojGmHKe0cyVCIe/u
         vfivNsEiXdyggL1X5ArE9Y0nUWb2QeLyzSCC6yDwuRaOOuPQOsoHULLizsg9/2NEJ/cj
         Jegg==
X-Forwarded-Encrypted: i=1; AJvYcCVH2kIxBj5KU16rzl1N3LzYyfhdec5TK8VsUbOHTRYnOAEsOowh+An6a0zcgTecYniEwZdR7uGggWowh36y@vger.kernel.org, AJvYcCXdxhmNm4sU+yvsSy2ey+jbH5zK4skXrFbd0bp97n75XrxMlJi8IzdnvVgNkPvfMsbZqtdzcwMYy/bJkQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH//7pW9mUweBl1c3PviIIN8oyTtMWRFzUiW+HrntD0jF5BkuK
	zK4hfjYb2KnFb0TvFZ/o6uugX+dtwlP8sIGoEQ7OkB2RHZyAy15k26kVB3WbWSiP
X-Gm-Gg: ASbGncu8D0u1s3VU8dTa/VOhRZX7iaJlz5wxIq/gXXpy99XnsanNDTSE0iCoc0iHtO6
	Epcsuv622rbyWaB/kIoV6gkM9ir6KeeWOu8Li0qz99USL17iCzXApCF/D205nkXizn9Av1Cbn9w
	mz1hjWlMewKpN8LwiEH5qbcIV8A6qSoWaLmVI2oOycfJu/yfl8UpS9mC1VNKc1P6vaC/B5fDxDU
	KqobvwL6Iygd0fosfT8bnUgdGOxLYjpPTBl7XyOTpJeZ0LfEN3ZEull9JQJVwCSf7rJuM3SIZIH
	Ibjlz9NX02+ROUjSEDMWQ2y2DZs06GKRXcWhX5NEw2QHNjfd5R+AzQifTiQxJo6EnlRy7N0Khl0
	CitkaPvNdyp/1FQ==
X-Google-Smtp-Source: AGHT+IEmezVG1+j27QeYrX9JQ+mctaV9VM/JouAhXHfJ3pm7y7wF8l3UZkmO7hL/kj4nRD0FRdPj6g==
X-Received: by 2002:adf:9c8d:0:b0:3a3:584b:f5d7 with SMTP id ffacd0b85a97d-3aaf3c06454mr2452694f8f.5.1751283718694;
        Mon, 30 Jun 2025 04:41:58 -0700 (PDT)
Received: from thomas-precision3591.imag.fr ([2001:660:5301:24:43e:be8c:f80c:622a])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a892e595d1sm10277730f8f.71.2025.06.30.04.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 04:41:58 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] pch_uart: Fix dma_sync_sg_for_device() nents value
Date: Mon, 30 Jun 2025 13:41:21 +0200
Message-ID: <20250630114124.102326-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dma_sync_sg_for_device() functions should be called with the same
nents as the dma_map_sg(), not the value the map function returned.

Fixes: da3564ee027e ("pch_uart: add multi-scatter processing")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/tty/serial/pch_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 508e8c6f01d4..5aee3fdba8a1 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -954,7 +954,7 @@ static unsigned int dma_handle_tx(struct eg20t_port *priv)
 			__func__);
 		return 0;
 	}
-	dma_sync_sg_for_device(port->dev, priv->sg_tx_p, nent, DMA_TO_DEVICE);
+	dma_sync_sg_for_device(port->dev, priv->sg_tx_p, priv->nent, DMA_TO_DEVICE);
 	priv->desc_tx = desc;
 	desc->callback = pch_dma_tx_complete;
 	desc->callback_param = priv;
-- 
2.43.0

