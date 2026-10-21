Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792549216;
	b=PATvOEDbXyiksM/JK8X2g7u7gbbB6rKQ0LV6vmiqjtUiw2TU0CRZ4DawrFX4ogXxa9E7
	 PBedCpYy4RiVZ8KhzW44NonSOa6D7JEPPCL2Z+aA/N4OsCnPjp+l90Y4iT0bz+mxQ27QV
	 Kn3ncQWM425xQdyTOVWVcOwjeCgfKlxNY1NSbQStyF7vF4n8Lrd43LT+GzvFyDWS4pkaT
	 z5D1Qif11RTZ+kdIqJZopSLqlCwJeUXwcP46vPSvDlrWJzobHvd5VlpJcCk4VDQl2uQ65
	 8T5cTInNA8J9q+yJAbnb0NtJ2QYLzTP3A3cvMuyP98Our5D5naOlMgtdkJhTcCoSy4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792549216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4wXolCIQzcfX6BR+4Zq3Q7gMENB9jqxPtoflATyZXeo=;
	b=nLjWXQ0ykltH8BFpzVxpOJiVME/ZhVFXXGy0U4a2JHo1W40LGow4Yex2btPj9s9zYOBM
	 NiVNcfl4LrN2vmBFg8F4Y9BUJ1wEshoeijn0FADdSX+ekwGg0/mTX3PgbVaaH71uq2AJ3
	 br/eEL1lMYKmVT6oqaNNYF8TBLx0v8n88pfjzVgq1JpklrfRGEapCoDKDSRMiqQccCucF
	 lpwFEwkA94/ZhADWzx/ZRI2BkdZcIr0/+4vwB+Xy2EliD4xhHNkX2J35ZBBGyGqbWFSXj
	 U5x/Jfahg/ZuIzf3bsMpLy4qm6ng6etyoAHTxXsXOa2PQieUy9RAfyRzCksca7LjVTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iCMUOQDI;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BB2606A320
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 02:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54BB2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iCMUOQDI
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso54661a12.3
        for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 19:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792549216; x=1793154016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4wXolCIQzcfX6BR+4Zq3Q7gMENB9jqxPtoflATyZXeo=;
        b=iCMUOQDI6GpPQivFmQCZrzyI7yignYwvFkjRX1YadYK4VW+QrrzE1E9kvItNq3k7c/
         1RHh6MmBBC29sZ/YMgXB8LwZjoxGmTPWf4RKEdeLHBPgpn8V3DmXG3ygIVP8xRFilpyQ
         sP5Iw1MfC1+5BA/au7iGK5p/o7uMm/zE3DQP7KSdgtvfbZaWdIrPebl8GYTx5LJLgZcg
         N9Z8C6RFpzAs21v+UQM+weOBYOnF+zXmVb/7Td2k/VBjamUhPnamlxdPi7pEWeGMKwi8
         t/xQvvSvNCiypBrckC/bAIYGpthkSqS96RHuo+L5PfAeTb+3b2WSc2tABSZRP4pHOkZ5
         g7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792549216; x=1793154016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4wXolCIQzcfX6BR+4Zq3Q7gMENB9jqxPtoflATyZXeo=;
        b=mD9207bCWgCTMVRSkzBK2ERojAEkVytWiR1SswH/ijHzJVyVjuNX3gNNoYr36z9ay0
         xYLRMFv1c/Y8n97ZET/CstX9iAugR1DyT/wmmaYloO5SuNzD4+Gcvb3E1oD7yEbM647U
         5gfcwsiOimZroUP9quIKGBCoxAwTHFLYNJNyLDvIWrgnR4rWUhtPOfMd4xcRa28H/36m
         oc/danlOCj3GixmKNsUc5dNj1KGCJjr2NHq8/IeO0RAc8b89CWVLDAucNKVeFm1w6/1t
         p64aAefYyoexJipmUe4UApkUEuDa37qTNvmZqfK85X1pco+91fUVt+b8uZ9IURRoO4P9
         3KOw==
X-Forwarded-Encrypted: i=1; AKwUvBxntQ5rrs7RY8y56byylMfl78TK0omchUSsRtEApx3hcu3lYAKWPi3N/6HCiWVkHKdh3kw5BVchk7AtBgc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+XrzUKuD1aguuMWc/R+QjEoDRT8lbuFf5qAazubi1z3p2dY3M
	Kc389Ad89kK5dPs9gwZrxr8UdY+lMmK4qKYhNX494l4dAcikJZkBXLuM
X-Gm-Gg: AYBFou2Pg7ZgCbIP4phXVyGuKAaS8wW0r1Fto2DpMgAnSiXV5A+i2oSAriT4quFIjcn
	4reJRPsxSxpjajnygDgXKcsF48uZF9Qdb79XDWh47l5OS6Sayl2vzUEGmF7GdYPbFlMHSwTYFLs
	BihwBhrK4F6DriuGHornjWG5ZFwKt1fVdmqCEgTb4wyOAWlBRtrAIp0i/aQaN4R7ZKYB+hskbWW
	Xj71tRpHn30g6xWDSfOr/O1XefF4lO1DukANTmeKiQfLpbWGD7Sh/MMgLd5pG3H7evIE2Ihf9Ms
	wh4kluB90eLsjJzqy62aMjGYedvVDjhB7pBGAZiZ8WLkZwq6YKW46UkBo6AMc8/EL+L7grDjWEE
	VYTabDi4A0vgmhigztdvUif8APouEOgejtifQUW7UOGTPh+WrYD7Y/3xiCSQ8/o4OKmRoMnuZuw
	B+uXQMGGvAVOcPBxyXWvCBEDt+4q39U7XaIwUYIYlOdcwVwVzOE7b6q/T2v9Z51vjIJtQ6dFLsO
	JRtcPa5jzFQm7H9Z+p12KDrv1bjAUUQgLUlc/rjTujxO3jDIUBkG7CU2yWecCRrsvThM4t5
X-Received: by 2002:a17:90b:4b03:b0:3ac:80dc:f40c with SMTP id 98e67ed59e1d1-3ad86e9eb76mr588413a91.14.1792549215633;
        Tue, 20 Oct 2026 19:20:15 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad802917c3sm1979077a91.7.2026.10.20.19.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:20:14 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH v3 0/2] tty: sysrq: fix the reset sequence state kept per input device
Date: Wed, 21 Oct 2026 10:20:05 +0800
Message-ID: <20261021022007.1717207-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

Sashiko's review of v2 asked whether clearing reset_keybit could leave a
device with a permanently truncated reset sequence.  It can, and the
answer turned out to matter more than I assumed when I first looked at it:
with the default sysrq_downtime_ms of 0 the truncated sequence reboots the
machine on a single keypress.

That outcome is already reachable without the v2 change, on a device that
has not parsed a sequence yet and therefore starts with an empty
reset_keybit.  But v2 extends it to every device, because clearing the
bitmap turns what used to be a stale superset of the old and new keys into
a proper truncation.  So the race is fixed first, in 1/2, and 2/2 is the
v2 patch unchanged.

Changes in v3:
 - Added 1/2 so that a truncated parse no longer sticks (Sashiko).
 - Added Fixes: to both patches.

Changes in v2:
 - Retitled from "Input:" to "tty: sysrq:" (Greg Kroah-Hartman).
 - Delete keyreset_timer, otherwise an already armed reset survives the
   reparse (Sashiko).
 - Added Cc: stable.

Zhan Xusheng (2):
  tty: sysrq: reparse the reset sequence when its length changes
  tty: sysrq: reset the per-device key state when reparsing reset_seq

 drivers/tty/sysrq.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)


base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.43.0

