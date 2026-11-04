Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804114;
	b=T/S0ETm44S6hTtFAb6VIjvmWkdaavVi0GvA+bMaLON1NjYJgBxB5W1q2AnOpTRKQmsMb
	 MwKvxI/OCjmzqHhEeKG4SfuR4v/WHpHxOuQVTpr3PKwn15SegBiUqDtEPvE6QRY+YYhCF
	 w7U81U4sVZTBg+be1TtbKx/iBmdX5Uc5pdYpYk788mv6ZPuQoQYipe4Bkw9jn4028J/wr
	 S9lGZyCs3HTxI5udtj8xgLF4h+mGzdlUpON0gIQe2iFobNR3jQ1G99N9awoyxF7FrYOue
	 JIj6za6YgdLHKVVPk3B/fnQFPxLabWqU6jo4S4SWyXW68WBwLysrEYug2SFOpmzQ8Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804114;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LbgJP7smCfZTiKwhxy4FshBwDEcPWSMWIUi+ryjpBXE=;
	b=YM6cIFzKlibhwNuQ9SuwTi/jXyySJjPRrL9lDxo7feWNLp5O2ivscglpwmNM3bKSHkrT
	 DwMsA8edE1NJ0rqUCl87tlKZTxQjJAYmdwA+rWam6Bh5v13YIDkRlkSIewqhWbVs0WoV4
	 0MfhNgq+ixSrXqYPuhhXwEhBa9ucTbpP8KXcGXw0Jpyjp1awyRyIHWsNAam35OuSAzfHg
	 brYrXZOtAYjY8BgjkKQXH+dEy+nQfYAoR9YPSL47Zvx7zuTlurM1WzSx7iOeJ//WUEGic
	 zY37TdS6LGOdHHgiMW0qiAwAMk4hhjjyA9Rtv3NEu0FTsfxqqv7eOk9asszhffu7vdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZC3nXqM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E72606A31B
	for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2026 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZC3nXqM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3D51F0093A;
	Wed,  4 Nov 2026 14:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804113;
	bh=LbgJP7smCfZTiKwhxy4FshBwDEcPWSMWIUi+ryjpBXE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=gZC3nXqMxBEzoWu9FIhQePowYZdb8EgXeCQdTG5i+IHSrZsFMJR9s/jOYZNPmwGG/
	 epp34Mmo7jvih7hkhWPWnSXOkC8JQtKwGJKQVTzs5z8/0y8YoTJU3s0mO2NOHufMBH
	 U3PYniPuLWIK2JEi/jdxt3cdLGh1OJXKJUy0PO7On6aczbvjSiMmjo1weQ5IhIjJn1
	 Paz+rXA+h4XG6FIOvrGlit7UjfD4V35hsFiLxJ7qFqr+feuLoae8gxKZh3Zc0Xiabs
	 1JXxNCnv9QoOKiVPBbhOMaKbCVuPD+amLZGN7ddIhnaqOGhmHVpm6WPinxRKVwpIZ3
	 ZE3ku3g8Vj2JA==
Message-ID: <sashiko-outbox-197471@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] tty: serial: 8250: replace chan->device->dev
 with dmaengine_get_provider_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com, =?utf-8?b?b3BlbiBsaXN0OlRUWSBMQVlFUiBBTkQgU0VS?=
 =?utf-8?b?SUFMIERSSVZFUlM=?= <linux-serial@vger.kernel.org>
In-Reply-To: <20261104145211.3209669-2-Frank.Li@oss.nxp.com>
References: <20261104145211.3209669-1-Frank.Li@oss.nxp.com>
 <20261104145211.3209669-2-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:55:13 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Use the dmaengine_get_provider_device() API instead of directly
> accessing chan->device->dev to get the DMA provider device.
>=20
> No functional change. Prepare make to struct dma_device private to the DMA
> engine.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104145211.3209=
669-1-Frank.Li@oss.nxp.com?part=3D2

