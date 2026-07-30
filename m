Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037194219E7
	for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785437478; cv=none; b=dX3orMQBnQ2ap4uUXqENOmMufgchEwASv/tmbrndcplGMcPJ82tQ1Qy7dCjlEeYmpFidxPSfwX1hAq0HQqKHYknM6zUKRbox3arL77unb3LZC3KEd6muHJiZwUiVAZt4JW2nHrf9UHnlHvl1JyvEDl4AS4S71DX+2JHwPD/HLAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785437478; c=relaxed/simple;
	bh=QasLks235D3Eb0nbmLmVRu8yqlEceaufhX+B37Vh9zU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QJjZwvAIUSYN1uhc9A49BNyjMaaUkUHNfn8o4Z9KfKLlQlrPmA+pCCKTlkEigprzMiw9/fQ97zhwGgB6d3dUjg6aRVKfLPURk3yc6ykUZxitFAqSTo5OoBwgVKH6VTfhny0seVc0T5s2mdVJHs5Ad+aXdOQAbZ1ewNgdAzEDo6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbXSBPwl; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbXSBPwl"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e53581361so12491585a.1
        for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 11:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785437474; x=1786042274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QasLks235D3Eb0nbmLmVRu8yqlEceaufhX+B37Vh9zU=;
        b=dbXSBPwl/axs7jdG/NBdo19m0EnLk6VSS/imBSQ6U4H1gTcP0BWXunHCd+fhG4AX6w
         ncW3/R9auVY9V4P+fCFDoOxnL2RF99+ZuHn0upWPZF/kIV2+/uah8h5f/ca/xRNOT0Np
         bEV7CNGcQqeNvNuvnwgWKHyVhzaD208sTapD1GjMx7gdkTpumWofIS5DSzT1e5ljAj+x
         P8W2QUao4629ATFS4u07xX26ggH83i0oGmsPp3g3Q4nBWIe1AetNb/Qd5btvHJ+ZVjI6
         MBVNWkV4P2DHEwJoz+ncMgr+zznAI+hyfG6yJKCtRGNa65TdKaLpZCdsjCRzY36Aer8I
         8axA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785437474; x=1786042274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QasLks235D3Eb0nbmLmVRu8yqlEceaufhX+B37Vh9zU=;
        b=ZP2Mub/i7KwdvVt53M1pGnZ0DUDt8IMpRpOxapbucx4x2pjwwj2R6Y74gSEeH0J1rC
         wNwdw38yQzxl84IvhTLRfjpl0PYmdHS+CwUGVpAhXbkcSShuBsQhZt57kGS53j0gy+ep
         i9uQtWcBEWIHwyQHl5tvm/tG2usqDOrjLahat7bMhl61z9Cdl0o7aH+F+tt21VFRy33+
         qiAdKRJP2YpZWPLNwpjJR2fAVr22r0T4HHbhw42Sn7ffzCS6+IevygNg4bAffa5sZmA6
         7doJIjhLIa3znFOEnnEQfsaVsXR0FN1HEHo4Y940pgkhUC6mNAewEMuQvcylz8/b5g1s
         aOmg==
X-Forwarded-Encrypted: i=1; AHgh+RpsjQiHVdrk0hcebTKcjrC2Xjn+UrThCS669tMCB7vmkBSGS9s+1q6hZNroOWkq3yO6tT8w279UvFxtn40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF1uavM4Of/pFKa8Ks3/DUGTaJetC+dE2cwszRsAtnIaE/JMdM
	vXQKaAqtnMiJET3tvfWM07Qhxr01cuEafA5CvK1KJk/Ic+SjLb6IMe0=
X-Gm-Gg: AR+sD11YSJJEq6+mSURpzyATXQxnjEdwlH+8f+F2faPpR61bGTzeM7MZrpIAEPM8hhm
	Pfre3tzxGT+s8PVl+SHuVJ5WmaFesaavkLxWOYZ1BCog5WeK5POnE+OY0UGX/ypvdowMeKzUnDg
	RQqpkJU/W/o/KSnwsoBpGJbBqvrIPtiTwwve3rQJwIAS7rzqrQcuXMfDh4i23aR1I/GRxYCDPAI
	KnlEyanMY49PquGrV7oBSw8+QXboIZVxiWUUGBAgg/REqwTwgkv1w/0Gn4X5vLVNmmzXXg4XlrH
	0u4W6+IqI9fyOxwIqhwAaGBcmXjpMoQ0/L8iTYc6hiyIAi8445qnQfkIhSaeFZZapzVO4F2nWaj
	1AGJbKSAFnNzrC9ZO5fMB8Kr1n+e6JJU1yop0Qyt0mIiu8dul8zIxWnxGcv+mhWu1tVs+fa4A6P
	Bq9DGoGP8v45A7yq3pibXIXetCoxrs4ZCE2KiHCQ3o3haHJtMGh+xerrv6ITDOHC9Rl9rvMuqqn
	FCnUdBR1y5jx0aG32HxyJSZ/ZRf25JnseMjVC493w==
X-Received: by 2002:a05:620a:a189:10b0:92e:4a4a:4478 with SMTP id af79cd13be357-93485fc90bamr300178385a.31.1785437474388;
        Thu, 30 Jul 2026 11:51:14 -0700 (PDT)
Received: from NAUTEL-9N0B043.nautel.com (host-76-11-42-59.public.eastlink.ca. [76.11.42.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933d3220f1bsm470795385a.9.2026.07.30.11.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:51:14 -0700 (PDT)
From: Ryan Wilbur <rwilbur633@gmail.com>
To: gregkh@linuxfoundation.org
Cc: andriy.shevchenko@linux.intel.com,
	hvilleneuve@dimonoff.com,
	ilpo.jarvinen@linux.intel.com,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	manuel.lauss@gmail.com,
	rwilbur633@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] serial: 8250_of: clear stuck empty-FIFO RX-timeout on LPC32xx
Date: Thu, 30 Jul 2026 15:50:42 -0300
Message-Id: <20260730185042.28678-1-rwilbur633@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2026073005-clubbed-spinner-9e9f@gregkh>
References: <2026073005-clubbed-spinner-9e9f@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This breaks the build :(

Thanks, and sorry. It slipped by because my build had
CONFIG_SERIAL_OF_PLATFORM=y, so modpost never flagged the missing
namespace import. v4 will add MODULE_IMPORT_NS("SERIAL_8250") (as 8250_dw.c
does), I'll send it once I've confirmed the modular build.
