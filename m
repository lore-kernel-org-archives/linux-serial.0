Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7C118B48C
	for <linux-serial@vger.kernel.org>; Fri,  2 Aug 2024 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722607796; cv=none; b=QTgUlJAh2HcXqrMobQN1mIdEtB3DfCOQPtD16+gKDY+rAa/u/2idt3Bnub5h0t2RnRGnEZ1Jifp3Vfyz9EOMnW62+HZG9E1m/8jQVgNcaEYS20AWyS0Do9U0o09birStLjq8BKYcpU/0IaWUQhjrXMuiPVzl3IQeF6uVmHJkCIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722607796; c=relaxed/simple;
	bh=jra6L/B4CTlR2NFq72iJu0OwzQ7WlwjqarLHxFb+pDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hLCe47mqIDnsJ7vSp2dCOdcSnhoKa60AI4FG8rOQxDCDadqSCiWWioNUgUibClxXAmak2tlJkNUNENVV/vxYW3vshyx85UInsCK4sk6Ucn7oo+CEfB3i+TjLsRz/s3utkOo+oSOJHzXfybGkjKBER0PW6DIEcRF9PwotLraUy5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=foundries.io; spf=pass smtp.mailfrom=foundries.io; dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b=hvvEoOcw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foundries.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="hvvEoOcw"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ff4fa918afso14772735ad.1
        for <linux-serial@vger.kernel.org>; Fri, 02 Aug 2024 07:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1722607793; x=1723212593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onbQXwbvGRZtHxO8bwST8GBr/BQhg0G2IIchYZX1q78=;
        b=hvvEoOcwX/zdst73gFS59zfoB+WqikNASoQbHtrN+BZUbXurV8eiJNUWhCVa2nFvif
         cbDZ6uBXelwQEXEZOXmuQPceNZDnO52kbE7OeGnTVTreDZLaNyD/f0CRpSkvOmnVSifw
         lGFFzSdwAW1xSTJCtsbBkvk50gZs4B88CZxSO4iD8Qip1kfyk3zYMteTU9a4Ej+944rF
         ptQ5t2Nwki5F4glQo1p2/3Vs3YGneQO7YNJcDeO6ninUKdsRiSnqy4IXypk4TRh4U3LG
         gUMGxMuivNcEKMymQpIb0yWY+17P3qp7acEn9Bu96YfBkpP4yVd5IHlCKlMaR0X4ab8w
         NUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722607793; x=1723212593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onbQXwbvGRZtHxO8bwST8GBr/BQhg0G2IIchYZX1q78=;
        b=uZGddmvfK+kywHyyNWAHy6rB5No3thK4E1eDq1wiR5b5pvhABHH4TuNb0nSDv0uwil
         CcK2nZWun26samk/2XGeP++AW6q/7NrGQgmi9idI70qbZFbFkFmQiTfdgvJcjmD3Qncz
         FZq7VQrStW77xerX1tBMZ1ggmBmP0uv8yrqu6F6wuAOn1WQXqpOiEIhEqEiYRXA3QP0O
         lrEtbZe20iG/Bh7FhezW0D555kavI6/YnkVU8eu+1d7N+cFryeKjHdSTPlx5jpTYR0gb
         biftZS0sOHkGKyPh19CX9RbrBXkH7Mx6l07sjjI4MDHeq1rpdFNO7clLmCEpUV4u4vKb
         vQhg==
X-Forwarded-Encrypted: i=1; AJvYcCWigt6507Rw2vgf1qPbDMnD8SxpJLpkDkFBtq+UzVK+au3fyQfVH1G1gEyfXT5qmOzmrPuknz/TU2Mnr59HHCSu3CYkrb6jHa1H87od
X-Gm-Message-State: AOJu0YwHZQLvVrJrOa120C1fp04SMvz/0gkTghAfM5xniHmQoe++kPpN
	Ff3thbfh4PPRhHNGqCIRMawv2RF/ZzlTluykSRFxutTJdAlhwV2M1VkSqEfu1hc=
X-Google-Smtp-Source: AGHT+IEJePKCgDb4w8BqZv94T5BRKWH09KZwYwkz4+WJxDFtkiMmhdjqhfnHlzdRaLq/4m/TiEmvjQ==
X-Received: by 2002:a17:902:d505:b0:1ff:49a0:46b1 with SMTP id d9443c01a7336-1ff5722e7abmr49769725ad.6.1722607792834;
        Fri, 02 Aug 2024 07:09:52 -0700 (PDT)
Received: from lola.lan ([2804:14c:3beb:8e:e577:62c5:62db:a016])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f6093fsm17638875ad.114.2024.08.02.07.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 07:09:52 -0700 (PDT)
From: Daiane Angolini <daiane.angolini@foundries.io>
To: max.oss.09@gmail.com
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	max.krummenacher@toradex.com,
	stable@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	Daiane Angolini <daiane.angolini@foundries.io>
Subject: [PATCH] tty: vt: conmakehash: cope with abs_srctree no longer in env
Date: Fri,  2 Aug 2024 11:09:40 -0300
Message-Id: <20240802140940.68961-1-daiane.angolini@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240725132056.9151-1-max.oss.09@gmail.com>
References: <20240725132056.9151-1-max.oss.09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> conmakehash uses getenv("abs_srctree") from the environment to strip
> the absolute path from the generated sources.
> However since commit e2bad142bb3d ("kbuild: unexport abs_srctree and
> abs_objtree") this environment variable no longer gets set.
> Instead use basename() to indicate the used file in a comment of the
> generated source file.
> 
> Fixes: 3bd85c6c97b2 ("tty: vt: conmakehash: Don't mention the full path of the input in output")
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Tested-by: Daiane Angolini <daiane.angolini@foundries.io>

