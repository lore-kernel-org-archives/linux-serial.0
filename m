Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704602;
	b=GwFX1KP/5Fzq/oYyT29cYZN6xHfTv9AdOdyuvW6EqCFc8QmunGySAx6t5NZ5ltBkI/dZ
	 0yznXoVvrJq0ry6ZmZmqzJIUfRiSCf7FRddimjrbU18oBqb7V4Lr2IeZPvJiu8vb60Th6
	 4SuyjqYxWkV5ZzoD0dgrLG4y/IueYtXJ9wAWb7Bmp2mnVBhtXg4ac63iPDthYTiIfYVJj
	 ZBUlh9rzWDMwajsKOS8ZxmMSoO9rtVDXYZrXDQtA5EJy/f8Vef94m8X29HZWX08mPqWId
	 vULSzj4rPmfnzywLkcmZ2S2kI704M+2L2K6SY2vav29t6GS94DmimC9IIbb4ngjic2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704602;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3Zr8l5seTqWVjoaNOlBkrW3ZM4VD+DPY/fad+73Wu4M=;
	b=e/qUKwsaRSo3Sc49bdI2khMz4dom59MjSUqx108f1CN4faWw5Q7DRzVTBqCLtRQ2r+7Q
	 bJ2t8oYtegwUY63pWsQT+VrGyAWUJKAg83Oi/HX0xPRhKzDDFwwj1mhGzISNLZmC9SZIu
	 9nY3UyGajZqVbT+QUyJMRLjLlx58YfutGX3t/Ulf/1Oc6mXtxfAhNgPYBqd5VyB6Ey/8M
	 cQF8Ev70Yaj0o73RqsqSAZzca+Xl7VnyXKjB6ll1jwPOpWwNZ8RgTbA7J617lj0CYvq0O
	 TaK3mfJYMkMGTDODFhHTjZkotXm0cVSSm2EXNSQk9/Xr60Q7Azwi0YXZiuNMZIh9OTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQUIAzWm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DF3606C542
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 11:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQUIAzWm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E1F1F000C1;
	Tue,  3 Nov 2026 11:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704601;
	bh=3Zr8l5seTqWVjoaNOlBkrW3ZM4VD+DPY/fad+73Wu4M=;
	h=From:To:Cc:Subject:Date;
	b=IQUIAzWmunh8/eh/lM/8DfnCqfZN8IvITa+UCOVpWqVm5WJm1+RmGXSWv63NyOmwu
	 nUnz7k8m3ULrVN9NhgkWsTcooUEmI0m3lw0Opa0jm63fjFNLz7fVUJulvcf7jnE2iH
	 4Y/Urrqn0piVarK7bYfSV8O1+rBJz4eY5kPfpJySu6dPOfLp2VjEaSKHjhXZ8HjQDm
	 5ff8yyVVhVOA/QpQHVOSSnZB58byDt2T8r3ZXRSE8BvLjUWpH0B63aFC8sA5pj5+QE
	 +rT6LR2NHFxzfNMeXg7E+h1R2osBLj6RHusVW562+3SXmEaBgJ+5owNv3MVh96sMNc
	 wCOT7SqY59t3g==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 0/3] tty, serial: a couple of unrelated fixes
Date: Tue,  3 Nov 2026 12:16:36 +0100
Message-ID: <cover.1793704520.git.jirislaby@kernel.org>
X-Mailer: git-send-email 2.56.0
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

Three unrelated fixes which accumulated in my tree:
* 8250_exar: an error pointer could be stored into priv->gpio and later
  dereferenced on unbind, reported by Sashiko,
* 8250_hp300: a pure reorg to get rid of forward declarations and
  shrink the number of ifdefs,
* tty_io: compat_ptr() was applied to the wrong ioctl() argument since
  2013.

Jiri Slaby (SUSE) (3):
  serial: 8250_exar: check priv->gpio properly
  serial: 8250_hp300: reorder HPDCA code
  tty: fix misapplied compat_ptr() in tty_compat_ioctl()

 drivers/tty/serial/8250/8250_exar.c  |  2 +-
 drivers/tty/serial/8250/8250_hp300.c | 62 ++++++++++++----------------
 drivers/tty/tty_io.c                 |  3 +-
 3 files changed, 28 insertions(+), 39 deletions(-)

-- 
2.56.0

