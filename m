Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37171C174A;
	Thu, 10 Apr 2025 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294753; cv=none; b=S1QiRYjrnUCCORi3fpqFb/XJ/4Qt1HPcMkuwDcjXLIcOBHzcWRmFu5VAKjXUKMNCBWXcOA9fFdifezM2t6O9rtOImlx3mGNLshbrdTjXU/8sv6gnn+guaNhav983SScG6W+T8MeaSG6K0YFSHT3gFbC7KexRbTIEnTtNQldqLfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294753; c=relaxed/simple;
	bh=LL8nbhHsK/lDnT8ira4baVwLu3Ih8EQqYk76ReEqjIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fOGGBSoYzgDEnndUvKfJmvtvDzlPtSXt0YTRcHxUYEzWxzkmSujEHAv1nmNHhB8JE5O6Ituji0dFLSPuNsdx8eI3LT3eckxSxJY93maxQHLXz5ZOAbNPcF97Bn2AKnZFsgT+Lqfby7ls9GCUZpd6m57bR46KGpygUvFhMPFZ9jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoK0qpbc; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoK0qpbc"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-30384072398so756377a91.0;
        Thu, 10 Apr 2025 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744294751; x=1744899551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pg20oY4fk1g4YTuTud9xw6LT1kx/bgpyeNN+Nb2KPyM=;
        b=AoK0qpbce4fQ5tq3QZi5Axeql2qhOWF3L9kE154EI1SX4TX9g67yQQ1JtPAITxBVZs
         aW7OkXvDzkXWD8PlURBw+PLIgV0T6uWFZcU9l/C55XF/kHcIRrofHfsfDQueCOgeVywx
         EvA9m0OQUF/+9gz9UPlKK75fL5jHz8fQG3dZvM1gTREze58qxKcvNDOsQezA6k63Luuz
         a/qkz1R8vtKvugAD0cDuGOju+csi5o9X9LroM2/fApcNwY+zxV5eE5uir6OTnjxJYTC2
         PFgi7sOq1IXxjO7P1N3l2s5thDlXnBUk3OillQTPkxUsQOcG0eAt35OmUWhdyUzQK8Ml
         nhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744294751; x=1744899551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pg20oY4fk1g4YTuTud9xw6LT1kx/bgpyeNN+Nb2KPyM=;
        b=maXMyJC12vybVQpiCFT3U2mmuz6yZ98cYXOPKHEpEdaT97/Bedf+f8h5pQnt0oHuvg
         5ndVEuPGO+BD07Gt+tcXebgEsnlueKfEKyLW2sEPdgw+0rrXnbwSGMx9ykNMsJS+uwTs
         ZeqdQNjJ9V/dDqWe2eB2LtvN86Pzv67dgGX8ecyNoOOeKC+DC3WKl4s6A+mtAidFTVWE
         9mATtHh6+xVKlReBjl4U5D16br8kCIj73LS6km3iRSS7kiL90ufcasMx2/jXyBuboBgc
         934Fc2KwSiNC36EpRom/v31HMqugw0UAfzSWB7wvjHNNRplAr4cj6S6QZnR8qUQgNzqn
         cn0g==
X-Forwarded-Encrypted: i=1; AJvYcCUlG/NpiyFE6WjZ3UpcFs0ST30dpSp7AQIcdD1oAy3IRIGgPWt+lLsEo7yS1z5UU64qxxhD1B2FL8WXicGn@vger.kernel.org, AJvYcCX3oCaHd4SgSP8BQYygn8MXevjlDaxjTJKIwmQh8V76KDe4R3FbRgtqUjV4lfxZ22FqojkFJZwB6znRiNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF+Jyus4IxGEaRxwuracn4CC9EBnT2sH/36fCw/V0bdeGfgyeq
	4EaSD86iPavAqy9TP2nR9yrScBPJHThwb3O9GiFIKL5oeddGVrg1
X-Gm-Gg: ASbGncvbAEVr1/JPZ/3QYAFAZVgXqcHzZ95RWPzSYC+Khf7rriyhlExHYUva9fKM3W6
	bQcXPjbQmp+gqR4RYZvsaLQqiRt4itzBj4VAh3a4bKLAyVL/kNayN0rLHkIRDWhjgh2QUdjG5zU
	Y7CDIj10+P0QCwLZqVoPc1EmyZ+zVoSZ+hmI9sDmJXadr93RDc0911eabMcjIKLcYIqLkowTPQJ
	NyTsGyalWGGgOgBUYEuy5jzW4cH7utePbGw9HEymmBu5uV3BQG8eULlkpxO7veiqYi3Ld8OQsTO
	XH+AkebVUJlUEKw+HT/bJdO4FJhILNHeyXAdOT1n7wYYV1IuaRlOmheMWR5I+edFXkRrBDVmBLc
	aAdm3QuauQFOg8ugFwN5/N1TNPxc47FkCz2cnxg==
X-Google-Smtp-Source: AGHT+IHGSOe7rLWE6APRJd8oB/Q1p/06cytILMQ3d0nlRQ+N/y5HEXtyxiKwmIZjLfr75eK0oW+JWA==
X-Received: by 2002:a17:90b:5147:b0:2ee:aed2:c15c with SMTP id 98e67ed59e1d1-3072ba0e83amr4340866a91.28.1744294750880;
        Thu, 10 Apr 2025 07:19:10 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.flets-east.jp (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd11e6c8sm3716464a91.14.2025.04.10.07.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 07:19:10 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: pmladek@suse.com
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	bigeasy@linutronix.de,
	conor.dooley@microchip.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	ryotkkr98@gmail.com,
	samuel.holland@sifive.com,
	u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v2] serial: sifive: Switch to nbcon console
Date: Thu, 10 Apr 2025 23:19:04 +0900
Message-Id: <20250410141904.4750-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z_e5rWcJKUh7eozw@pathway.suse.cz>
References: <Z_e5rWcJKUh7eozw@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Petr!

On Thu, 10 Apr 2025 14:29:33 +0200, Petr Mladek wrote:
>On Sat 2025-04-05 23:59:15, Ryo Takakura wrote:
>> Add the necessary callbacks(write_atomic, write_thread, device_lock
>> and device_unlock) and CON_NBCON flag to switch the sifive console
>> driver to perform as nbcon console.
>> 
>> Both ->write_atomic() and ->write_thread() will check for console
>> ownership whenever they are accessing registers.
>> 
>> The ->device_lock()/unlock() will provide the additional serilization
>> necessary for ->write_thread() which is called from dedicated printing
>> thread.
>> 
>> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
>> Reviewed-by: John Ogness <john.ogness@linutronix.de>
>
>I do not have the hardware around so I could not test it.
>But the code looks good. With the added comment (reported
>by the robot):
>
>Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks for reviewing, I appreciate it!
I'll add your Reviewed-by with the comment for v3.

Sincerely,
Ryo Takakura

>Best Regards,
>Petr
