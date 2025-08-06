Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39C428BAB0
	for <linux-serial@vger.kernel.org>; Wed,  6 Aug 2025 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754480779; cv=none; b=Bz1BVVO0FLWuYSZz9Ko6p7ANSiL141SKErHcC2sN7twfyjaoodgRl9Nbu4EIQ4uj2PYUjv1nFlx/44CtJxpeQn4vvd1ElTBf/7jt+movvob2X4YBk39IL6LHGWYxvq5ZyELsagVZIlInAdicUv0V6NqipYDoin5axuEx7TzIvJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754480779; c=relaxed/simple;
	bh=Fxa7WIPYBSoJoS4PyzclqGgPzfyBj56GoeXvqUyHqOs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LFzrsQ0xmJziYrJoBy1zHHw5sg6vLOfyTO44GeK4iGl2S9OvbpiEdO9BwljlezmaGm9+OOPUlZUmfhMub1h/eMJ5uFXvCJs7Z1WYuHb9gC1HMZon1eyMREIx4nDb+jqLh5Y31TNaPbYhZUA7YSO7a42FDtN21Pu6Bkj8ZORgZmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CwxsbImP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CwxsbImP"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-458b49c98a7so32154895e9.1
        for <linux-serial@vger.kernel.org>; Wed, 06 Aug 2025 04:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754480776; x=1755085576; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1/knRBN0t/PO4IhYBTGlAeQhM5GVK57F/vQLxJJzqBM=;
        b=CwxsbImPp6WIQGLXn0TBN5aWS1rFGXz0ft2VN9qFLrkdiomrOLnSvqGyXn4BocT8H2
         BUFwB3oGFEsjJ3X6zfGIzhSnWeOt7FkBSZQiIdyOt2wIrdeDPznKL8zf+utah2picdX+
         Sb6vv+h7FFYoevDgGamFvdEc7Z9PPEasS1wHvfDO5s+vIyBsMcDxY1ZW09qEdxCYIXWP
         AgsMwuZeIzX6ATsoPlt7vc3uNzLBgdeoAo/EC9ZP2XpLkv8ou5+wIewTF/5FKbl46r1A
         VdMRCihCR/pU4Fp4p0iwiC0GfOqu65H7nr7ho6+5Ual3wmVTszLg/WVGP3X42KoD8wng
         +ACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754480776; x=1755085576;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1/knRBN0t/PO4IhYBTGlAeQhM5GVK57F/vQLxJJzqBM=;
        b=Qh38avYSaGjuJheqhZt7xwNLktTYR62zVMNZoQmR6adFneQwo/9ZmxquhR9yWgRF8i
         K6JDZ6m58HpP5qHglvu0Z+P85kuIG+w6tT58XsQblEQcUU+5HWz+boIVtAnwLv7rYKGq
         cytzdaaQxR76bgHyiY1S5Uez75EqprLJH+eK+tKhyhs13yJi1IVF0NydlU4aaK4161XM
         E/wUI7iJRDE+9CqcrwLhjkORUITPfcAa3Q0lVg49kr3oX5+cu0ewaoyB0D1unOOl5OKA
         EyMViXsXGTceCZ0DvHnGr3WgmJvOtDPV+CQhGB9vR8k4O1GHQSQ4OnbAg7+ULPEf/1w9
         ymlA==
X-Forwarded-Encrypted: i=1; AJvYcCVC8YflJ26hcM4IBeQRcVcbw1fbiqLGkTD2/edD350QfBnupM0RnFiQsFPBgluc8mylNBy0vqB+RSXArd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdA3qcD1bd7xNxe4ym+dvRqOt+6jEBAUVflY2SogCpo82sXl2t
	eSPYP+jg1+/FGu33hK3+vpY3CqYElNA4o9Z9ackjPubyyxL3L1KLRAaa1G9dRA+FXV4H1T0M7gB
	Xmh2W
X-Gm-Gg: ASbGncseaKiLh1HPN5Bto8mUx2K8yRdFCqXsT6SvzWn7bVmKK9ih83z5BN036QTO39r
	MZ3MjaQ0MNaByusZd40qni6Et58ezIDYbylLLdkoPPWOSfEFV3JbA1X25x/tk7B/U31X4mS/gKm
	JSvbk7jyJ2XYASc28u9fe05iorri5GVXdHr1nOLTm+Ml8+8AhajkQTyukC2o5vCC7rhp7b1EHWO
	5vVGuAUPqrJHrw0nhj3JmveXy7EF2oAGP1S5MDLuPNS6gdD+YN1EvbdbB8/Idu6TRzWdbToM5B5
	bP+hC7BhDpVQQQQ+eI+JgnXPsezd2tSLRGdHvCt1VyZ2fn+Cjf30nrGnPs07Hz63j8MFmqG3cLl
	VBIada/DfA2/Amk5ygA3z1CGrx/TR5ntO1Iy2TQ==
X-Google-Smtp-Source: AGHT+IHp4t97LH3g3myvsPF/lVT9OiZdwNWuTbfp/8P8OoiBNQhRDIsU1Ck8258WRDJRYx8siI0mmg==
X-Received: by 2002:a05:600c:474b:b0:459:dde3:1a37 with SMTP id 5b1f17b1804b1-459e7103474mr20600785e9.25.1754480776097;
        Wed, 06 Aug 2025 04:46:16 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459e0e70218sm75901695e9.20.2025.08.06.04.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 04:46:15 -0700 (PDT)
Date: Wed, 6 Aug 2025 14:46:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] Input: sysrq: delete unnecessary check
Message-ID: <aJNAhHtKkhWjosDV@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code checks if (write) is true twice in a row.  It's more
readable to delete the first check.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/tty/sysrq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 97f8a9a52285..1f78b0db3b25 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -1133,8 +1133,7 @@ static int sysrq_sysctl_handler(const struct ctl_table *table, int write,
 	 * Behaves like do_proc_dointvec as t does not have min nor max.
 	 */
 	ret = proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
-
-	if (ret || !write)
+	if (ret)
 		return ret;
 
 	if (write)
-- 
2.47.2

