Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6EC5427E1
	for <linux-serial@vger.kernel.org>; Wed, 14 Oct 2026 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987503; cv=none; b=hKg9h2ISHiF89OLboZS/qiGdCnoUXNa1fd8SjYQReq/ZSmRlS2/V3vEwl1WpXvvcV07BovlOnXBvgisScW0F92byVSJErzViSViZbNJVyMOmLj0DsvnOu3zx+Y3OTbBN2DeLyqIhsdw4G8l/vg605oFDPo4SPNlw3VoQPa/xE4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987503; c=relaxed/simple;
	bh=PGAppKY5I2J6gU0GwJ7rlWI4ZFu3X+4pesJK1DNvFDs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=EIgcLcR2M+pzuNOu9xFKBFD5ONlPCZ0rfoNfGFl7foA2VQGJXxA+FSmFMpYSW61uGnv+JZb5G+Rxwm9jkzTBEUYytGq3T/MrDi1th8HoKELo0UZeXjta//fGrQHYcxh97E4T7Ep3Wqv5NOY8uoLgzcJhsidJ1Z8OtRSbTj5JoTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=WHw9a5zK; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="WHw9a5zK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791987490; bh=PGAppKY5I2J6gU0GwJ7rlWI4ZFu3X+4pesJK1DNvFDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WHw9a5zKOw7KZpQQp4ZKG+HVEfuX+pr4x1kHevpdiwzgNWLABALR7Sp2ef7XFc9BA
	 d1MPz2ICp6Txj3YVbUFPTcuhUIDMvKsvghvDMIvMO8xT4eDvK30SRQsxwn0RV6h517
	 unxwwH1z8qV4WluwKaXGEyG8ay8ehAcv/5KZ0iBo=
Received: from localhost.localdomain ([14.116.239.35])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 488174E3; Wed, 14 Oct 2026 22:18:08 +0800
X-QQ-mid: xmsmtpt1791987488t4crwa0j1
Message-ID: <tencent_2353E6AB079AAE42E96384E4D9B2FA64C905@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeoUyWRaSeNUHq9KtmygGUN+XtYYGoDPj1g5eJ/5ph4aUmhDTG2d
	 qbTnBhi60iXpaJQfPiMM9xZhBMyGsD3o/WSLPf6nhCY/xUNNrmEIQ507U/B432TYkzieXlvt/fD/
	 QZsfyFNWuVfpWv1uvFDXuTpwyLwZTdGIwzKisas/wbt/xE2HtmAtzqSR8Pw/FJ2XYce6bc7fjAbO
	 kUI7cPXrYoPcStDJgHxF62SrSOBqL9LM8nXUmGN9VFFNkb9TdrRFqfvtc4OGU9qYFHhFC19Fbrql
	 hJjb9zy8oYdHMjcCgn4e79WXagHruN0c1GfZQ4m2yGI3LqMsCAi2Xs+ubBzO1SLu7yCS67TYT98b
	 vMtcq0xkYJIUmqZ0O+NQ5MQbmR8dSApy07/nKux9/NgvRkgc/TgGp6LiJZ0GPeQUoPDurSgKjR/l
	 tt0oB5LrjRKOImkqgWZ12Qm+wsWB0MC3xCS4QNrImhGEK8hSzcruVCOwcU/OLhLKf3glrh/XHStO
	 RN1JES6cffqBJbK1g6QYB7tAPfvW9AAHsaNtROTRRHwpAHX5VawCUjiahe17DjYGb8Hz3ZQYrTlx
	 zPvTglr4mDCdWaqiq2zPs+oeIPuA9zvRjrXF05GUglH/ljQbLCFwnqTgvqmTnz1uF/Cnttvsufcx
	 8zF4uKePYX/81/QzS7lz4aDu0DlHsHohMvCgQcGoKGO6ZIWCvJHAt/q3b5KpglrbCfmeBt8HdFjg
	 uJ/D8Kq3FYlYj7BtiAjIfK9Ji1Adc+R9v+82L52JjZyraiYLnB5rYixJcojGL0mWSuduiuefEio8
	 5vAl8rE1bJDB2ITIf+pmaLqBNa7e4RB4SwZwqEd6DwILEYtOJ4MB6CTzRbJyG8S01TWHhRw6ZUnk
	 4kk9YQ0qcQilQSA7312RH6Tsude8G3P5ANAHKVCbNrWcdZRDBGwdXGsnp9Dufp+iz7H1D6sidSZn
	 v0ogC2kVLiRm7RkSCdEwtW2HxvHDtjLyV6ELU65kGm/m3jgJsdBPtpYRCYex8c/U6+1zB/zsQbtF
	 00Trl76VYdtaWg16yZN3nZOaByp5ztgQXniWmVoQ==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: shatyuka@qq.com
To: sashiko-bot@kernel.org
Cc: linux-serial@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	shatyuka@qq.com
Subject: Re: [PATCH v2] tty: hvc: dcc: Detect JTAG connection only on CPU core 0
Date: Wed, 14 Oct 2026 22:18:07 +0800
X-OQ-MSGID: <20261014141807.2576470-1-shatyuka@qq.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <sashiko-outbox-169978@kernel.org>
References: <sashiko-outbox-169978@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review.

> Does the commit message have the sequence reversed?

You are right, the commit message has the sequence reversed. It's a
typo, I'll fix it in v3.

Best regards,
Jiannan Du

