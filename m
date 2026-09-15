Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236623C060B
	for <linux-serial@vger.kernel.org>; Tue, 15 Sep 2026 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476968; cv=pass; b=AC1uFgJQOW/+7oCsLU9DvymXo7WrqRE1rLrQ2c+TYLOejSNpPNkUwHVRVmmMBLL0ZhI/RUxy/j15NkzbvzG8eNy6wGYHt/mrF6noshOP47APmzQzzUjlDlab0wEaLOlgZV/W5//B/qJlPxbHZUAdFiQ9yK5J2FuQ6C2ZxzRNz0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476968; c=relaxed/simple;
	bh=Y0udD6LX9UKna6N6Fff+A+d49UlfJkBefTWP4NHM5ZU=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=B8E7r1dUpGLoYjOBn+fC7Vko5nfQx5DIZZLRpYsroSpZpj43NyAaTuGC5Jk2a6bcyTVOnJSxoxFltu0ag5rLHpF3r4EkwCfLPZ5MPoUs1FkuYOCy6vhL97RdGNMdlgyVx5lB0AHXt1ocTNBFmBV7F3JU3UkjFu9jxu2+k8425UE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMxn/WNL; arc=pass smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMxn/WNL"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd38e0f79so17186485e9.3
        for <linux-serial@vger.kernel.org>; Tue, 15 Sep 2026 05:56:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789476964; cv=none;
        d=google.com; s=arc-20260327;
        b=sK4se2aIdctmi03OBqYvNz2FPo7WRbJKZkwkcm4EQtoeExeq/ArL9Gmw/jTG+4OPub
         ifp4huTUT8YcDAP0rcCdyH6QatZw5zEgHJmqiT7+I9uxbZoxIDW23T+qOS7E+zvvyGlC
         ncf14zT4NQOoTbjRQ6herR+3FRvIZKmgreY9iFu9IViG8eKg4AfpRA65aAx4+g72keP8
         CcuZ8EZUV8a+HNBJAhPtYQ1V5EOHNLPCTuIloqJZ0KkInTw1CKsjO3dmhnPuQGeRse9l
         E2S6eRnEsGUUL+R1ShNLtgNTiJOCCc+cDqJTvNJ5sO5fDprrwpjX5goaeVO0yOApki6K
         +EQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=tBDL8+opSOuA0+YA9pWqLSsPY9hQWYWN1oG7BrFDg5E=;
        fh=/P2pFq3aVtFWrryisuHHcIJ6TSac4C6Cw+qOvcUn0jI=;
        b=Wz5xJ/QxChLbWeIDOBJV8ymxDZDw0DK+3pkAaLQi59nhdLq4F+AS/B51x4N70BEEid
         uBn6O6jblblLFYnc7hsK9EqBF6uH4UjsdyyC5CKPLYpFB7loIX5GYwZwcZrn/khLYu4C
         YWeaMq3hmm1pcdJsXJ5/FQpUD0zIrro5QRuSVAFfIbHf8BbA0nfPxNSJkCf1/cR+oDXI
         f9biXq06Yhyeya8EIQqGyiV9LAtlmlKn6Bvnmvw9Tt2Qaw6Vp8wHceY1b8hriZp5dRTl
         zZ6bzL87IgeMDidMzIOelQOlV8LE4O8wUV3vJEPsXnxHlOcRdpSqTaXjqy01HKbdSqvg
         gwnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789476964; x=1790081764; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tBDL8+opSOuA0+YA9pWqLSsPY9hQWYWN1oG7BrFDg5E=;
        b=cMxn/WNLpPEIldTnLOsyVDg6SThx4lj7ay699VzWb+APvMoNcGsN4YWaKWSBA/q6UP
         R2qaGT6Mx6uBEcCrosnJX1NTNjo0fVqIi4EbQzJKkSqoAnvUcrkCBeM3pLOiZfn/I2jJ
         t2Lcqholby6l1Cy4j7/MT9EgywzYhBuQgu9O+H3o5b27u47qRpisB1HHwlFsJ6CQr/zo
         yjS17mlptDFGaDPFagXDHcUW3Mqol/x/eimXXBZQL+gV0F423m463+Yyp8FH/DEfObgq
         bpnv+cfDKXRnX3bOGYcQH/8OzlH2HDRjFIFbihBLE/rfwL4DkL0xjfOeewJRt+1EoziU
         h4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789476964; x=1790081764;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tBDL8+opSOuA0+YA9pWqLSsPY9hQWYWN1oG7BrFDg5E=;
        b=XtTRfIIApw/5N+SBQb5FDJ9UWXsZxueL/280zCD2OtDqAO7tOpm/MZZAuztQ5gNk+p
         PldR/rmfFJkJiyO5VAjEq/31rY+8WOhgkmQUZGAELk0/MV1BTxGpg90uK9sqOUwWUUxZ
         RAS24nZ4k0feCeHt03+vqVxSAEquicWL3ZjA5fDSsGThJJO8VV0j+Adys/LgWYTD66kk
         5xRtnexz5kNDvFJ1HtsC/MQbfF0Gqp+IgAA34hnF9HymQE5hahqlRPLV/LX4CZLEZkur
         2LKEmMk/v9k3ybXLPWlGHHEI7T+ysZ7y1JsN1GsNBRKt+8UBHGxtjPoZPZVhzvvuKTCo
         zEbA==
X-Gm-Message-State: AFuF++k7RfA9JyLgoUQAEqqH6pv2AhCfqP/3x66XdpOaoeazQ0rUJ4r0
	nRrds+tuu2YOBO5xeS2IEPukDfhyyd4iZ4WoUp1mYkhT5C4ygyQh37aTCv2Mdr6ukcctt0pR3GI
	xRWbG6hUsagC+wM7Ks1eugxgMh8dYap7ZvzfGwvj8A/il
X-Gm-Gg: AYBFou3MdjtawM3jgyLjpnf9t85xdKgoSU5tmdLjonprXWrebmYBf5R9YW7v+xfT5RL
	JtM1BqOtiGl8udybWWhDrBxmX2rfeCRu3AlWILjjM/S44/fOCSmOoXQxTdFeJRvmrwGo/iTadpO
	RfhFPhGMrGYtryrH9bSDdaG8/5OhS6McX2U3JEVDVMqMQJ/xKwDFff91y1UodMFGvfnnjvqZ7XA
	ieY3eDlEE60RZ6ts0yXtLSOv09VyKZ6+cV257GCD4rX2RDInuoNI0Z6S3RXdTli6qtbBHL1piv1
	zHi74y6s2ltTcD6gULFBBX/rtHGyIoYaUxjxfOj6ZWOepsOqzsyr9A==
X-Received: by 2002:a05:600c:8b74:b0:49c:ee20:e787 with SMTP id
 5b1f17b1804b1-49e7a658021mr176344625e9.1.1789476964076; Tue, 15 Sep 2026
 05:56:04 -0700 (PDT)
Received: from 830778650420 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 05:56:02 -0700
Received: from 830778650420 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 05:56:02 -0700
From: Ruslan Vagner <rusya92266@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Sep 2026 05:56:02 -0700
X-Gm-Features: AcwNN1UzLP-6VdKE3jGgxQN1-CkN6GXD7hrpwY_VJOk4S3NnegvIGUGey8hthBs
Message-ID: <CAF9RqJ7-yZCq+U7hULCe+8xYLHkgkDww0bF49vyu915xUYkoCw@mail.gmail.com>
Subject: [PATCH] serial: pxa: fix comment typo
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Ruslan Vagner <rusya92266@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Fix the spelling in comments. No functional change.

Signed-off-by: Ruslan Vagner <rusya92266@gmail.com>
---
 drivers/tty/serial/pxa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 10fc8990579b..b43db70820fd 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -99,7 +99,7 @@ static inline void receive_chars(struct
uart_pxa_port *up, int *status)
 		 * Specification Update (May 2005)
 		 *
 		 * Step 2
-		 * Disable the Reciever Time Out Interrupt via IER[RTOEI]
+		 * Disable the Receiver Time Out Interrupt via IER[RTOEI]
 		 */
 		up->ier &= ~UART_IER_RTOIE;
 		serial_out(up, UART_IER, up->ier);
-- 
2.54.0.windows.1
