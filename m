Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF9D16D4FC
	for <linux-serial@vger.kernel.org>; Fri, 26 Apr 2024 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152280; cv=none; b=XFahu/Du8hfQEnAwnkuHCvctFALVloM+Rf6ROGx9LvdclSbd8Xr75pqARJCReCqkHUBUC7YDgd3f/hq/1IPH6StkR9CgcfEaac38pX8C+PGg4bwmLcgGU7CCgdvSEcgWphxaBAfNvY7mUKydhxUBRfrK1jOhetZ6ESYAzddh69M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152280; c=relaxed/simple;
	bh=qc/JvWpjevARSmtI2Z/SPg5dqcpbBUtwW96LFF9lvso=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q1W69oW/i39538tBfw5zRaQWNFRSKdsH+8/W3neAJttlATgYvRNTUNs7eY4oIC+xriIaQse+3piSKUlipIu/orCjxL/74+Sc59/o9LsIEgYVffwRi2SKj2uq91UOJxjM3RvPGLhOHdcoxs9M8T1tlRdbVkC2CHcmFXLAlQ/3YTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wKZ1DFP4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wKZ1DFP4"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41b79450f8cso10150575e9.3
        for <linux-serial@vger.kernel.org>; Fri, 26 Apr 2024 10:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714152278; x=1714757078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qqKoN3Cs2CMvL9+4IpXPpoLPFKBjdTNuQHYkWXdJ8k=;
        b=wKZ1DFP4BVZBkwkt78hcF8rQc3aguqKy7a/3a+XSQl9KdHE3U3bcAMgMHNIYT0ysYD
         D8YEtRV8h4ICXC3wp3e3U32F30ZNENZ6G3cAnAdWjVGrK93OmthMuNVOjiCg+9+cP+oa
         tkyknrVzK7bkTF8+o58HjgPAB6nNefGptk/9eV50nO8Nalugrno2QrFZLBwtGnJPjaWd
         /k5RQkMRW/dUB7AtiNlCDf1Uk2/qTY2eRc+i2KK0RhUM8w9LzcWx+XdWiItLjglTIRSL
         Iw2I8LBTDweJg2WZowGGUj1xK0tHiE+xWsPBP9OpV2pk2CsncoxwDnSzCOZ4m7C8re32
         vIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714152278; x=1714757078;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qqKoN3Cs2CMvL9+4IpXPpoLPFKBjdTNuQHYkWXdJ8k=;
        b=c0z6/W+VbVsSDEI07TPQpLP5N1oXLfxiIAfdYqS5iNM7zmQe0+ju8Sm19/begs0iew
         WMKKNTxJ0g77+28UkDPj2zeTTMLl0qVaruO+FDPygq7sjITSB0T+ECn2dJ6fZT+JIBen
         V5xaKi3cZNTlB55keiYaPmhF9pCv4TSaHT0+Ad8OFj5o6PSCl/kzqMClnrqmQNFoINW7
         nQrURbh3K98RRS25RxUplDPJW3lY8ZW9CVtBJBS/CSZyzTFs1qK5zsmch3RCzlqgqCP+
         KtbuycN5OjDz5FVPZHBGL9UpZo59T8799jetT+4zGamTfw5zkgLq+HfpU4hY30BszEg6
         OSTg==
X-Forwarded-Encrypted: i=1; AJvYcCXkKYZ97dgaWbE+g46JenPcOnv/acI3SWBaDrnHt5ZTQ7oEmwf1WNXUqfgU1fXciFf+l/qe7TIBSIVNfMpIlGg7OnVJLi4+YQ75hxkH
X-Gm-Message-State: AOJu0Yy/LltqNhLhTg4sEqXBfKbOYis9a4pU/zMnIA2Q37SERqREapeW
	rQ+HzC0t3vgNxPJU6Mls2w1sF5D0udF8ZIF77KcCHd+E+IOcsAWSveMLcMETOEI=
X-Google-Smtp-Source: AGHT+IGiLctEE5oagDVIXdCcyOY9hQhgwc3V8m4ovCCyUNb1qls37u6auNYTNu3nuXEcmxVuCzgDxw==
X-Received: by 2002:a05:600c:1f95:b0:41b:13c4:b9f with SMTP id je21-20020a05600c1f9500b0041b13c40b9fmr2238549wmb.24.1714152277603;
        Fri, 26 Apr 2024 10:24:37 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id z2-20020adff742000000b00343ca138924sm22893737wrp.39.2024.04.26.10.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 10:24:36 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Liuye <liu.yeC@h3c.com>, 
 stable@vger.kernel.org
In-Reply-To: <20240424-kgdboc_fix_schedule_work-v2-1-50f5a490aec5@linaro.org>
References: <20240424-kgdboc_fix_schedule_work-v2-1-50f5a490aec5@linaro.org>
Subject: Re: [PATCH v2] serial: kgdboc: Fix NMI-safety problems from
 keyboard reset code
Message-Id: <171415227582.138568.453198683698011375.b4-ty@linaro.org>
Date: Fri, 26 Apr 2024 18:24:35 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 24 Apr 2024 15:21:41 +0100, Daniel Thompson wrote:
> Currently, when kdb is compiled with keyboard support, then we will use
> schedule_work() to provoke reset of the keyboard status.  Unfortunately
> schedule_work() gets called from the kgdboc post-debug-exception
> handler.  That risks deadlock since schedule_work() is not NMI-safe and,
> even on platforms where the NMI is not directly used for debugging, the
> debug trap can have NMI-like behaviour depending on where breakpoints
> are placed.
> 
> [...]

Applied, thanks!

[1/1] serial: kgdboc: Fix NMI-safety problems from keyboard reset code
      commit: b2aba15ad6f908d1a620fd97f6af5620c3639742

Best regards,
-- 
Daniel Thompson <daniel.thompson@linaro.org>

