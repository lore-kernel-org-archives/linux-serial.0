Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795682769;
	b=GFFqbJyXt1IaZm9NFLviwlRPMfzgnmw4NBc4palfFYVSoPuMxgZHjAiithMTavXFMpcY
	 IvzoXUfSPNANTFeR9rwztVhVrUm479d4y+v0Tmz9+NOAneE3kxf0A3BiUV+2tK08UscLI
	 iJqtHkyc+frjg2bjSc6nU6TQaI4VNn2FQr9Vbg04lZ30t4Evmo4ahqfP4qHCswy7Kd65O
	 3WH/ehO7YBgT+HTHU8ZUHVGzcAf+aRipiyjpP+pJQ7BvlxOT6DUTd/RTtAZIS6ePb9qxD
	 vgUZ/dR1yAomCwyy7c/Vt9c3ZGNYRJ6BTHLrLE/fTprFFShd50f5G3TjgPzHM6xJpsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795682769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=jIjy7oXjqNe/7gm7TLs3AKZq0G6ZEoHOSp4CNqXrGfs=;
	b=xwaFrpLcYlEfI3X22BZrHqbAoNXyEEryX9W/HtL8H4/2CSX/Nl8N6AL0bblCKDJqGRxp
	 ASdxk+7v0GD5+8+o3KmUNwWVATCMH0MusFNErc1YDr0b/bPXYSQITcozsCjxg3Na7XgZr
	 U/GhHtPW4qjeX0xY/dqhOn3xLL6FOJFSVKUkP0hBri2MV4jrjPXo16Oy1k25tcBQ3abXO
	 eTM4ZTxQVYru/xXh1r288BWPKfJG7KxwnYFS+FZPDnj1AtsmkmT++RznLqJe83/WXtFT5
	 9JWHEEdXL9ZCDAncJ8NjvcE58euwgrHTTjzptbuckiFyzlGbXPDbQn82eduIwUaLylA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EfLDrA5O;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70037606A323
	for <linux-serial@vger.kernel.org>; Thu, 26 Nov 2026 08:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70037606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EfLDrA5O
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-14394530ec6so218472c88.1
        for <linux-serial@vger.kernel.org>; Thu, 26 Nov 2026 00:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795682768; x=1796287568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jIjy7oXjqNe/7gm7TLs3AKZq0G6ZEoHOSp4CNqXrGfs=;
        b=EfLDrA5OwNXIvq6n6kx2yPR6+jKl4+ne2z6pNVr8F9YcgTVn8JeclvRCEu1sWR3oX1
         VwHbStjZj6niPnXHuJL8iXvCwmysm4Vqi8QjBhzK6cPHRux/RUzXYFqzKsbyzqOjotV6
         Gg4InTBiflxoC56JIYXH7wxw+eXaOaure0yiPo+J7obe4QDNn/ZwcofibZidOXYe3LeX
         sL5tFJ8IqDIrFGlG4oWkWiQAutQpIwpPZUOL3pFF/cSL5us8zQZyj0et1Xx6gCiVIJdK
         y4/iOL6MhS2ktD/b2wf6Xojdql1tDRFSb+Q6HGdqXBHJV6827QAHigUEx5OY///k4yOr
         YD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795682768; x=1796287568;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jIjy7oXjqNe/7gm7TLs3AKZq0G6ZEoHOSp4CNqXrGfs=;
        b=vTzh3lC0SCSiMgFoLhyGX4ISSbN6KoNQKKrmgakALNvqiq2VqRrLXt/nVJS3vrtrcm
         UA30ze7MEQWarwfK97zP8x5vjMtlRCYvVYYxZDWPTbMaX/tOUlfO27mWdW34HRTHE/eq
         1mytAVb7qSwfIuHFLjUYAMizL6Dt2q1I6Y5R9AI0F6ec0Se+RLvr5+89eQkjiNSU7db3
         BZZnb9jGnTCvduED/5DHHFbzo+qp+kqww0JrU4fvElNgtKgk+q8MqsQ6wb/apRfZoP1R
         JAZHyxDfyFTtfsnHWVQQO7uQLvQRbGU738i3PxKzuji9PEemk8Q8GRbk9MbLA6vv8Wfs
         usIw==
X-Forwarded-Encrypted: i=1; AL+hErHzxCuSxRul2L8ZAab3BZRWvhtotrVCQsuWd7AcwYZ20VCNLwwNO7+mVQ6FGsm/Nsmca5DttgyK7oOeB+M=@vger.kernel.org
X-Gm-Message-State: APuU4Z8zcUsBlMRL2RkFjkBIK2I2bB4PG3EL3eqRFts6UjaDF5QZdle6
	fEBrrxT/KmfER2s8WTS3F0n3HYQ/58Jup0uE05mwBQpr+qX0NeCsxzrD
X-Gm-Gg: AZFdTZdIqaDYLbvjPvTEwjMjHUZO/dspXFw5Y2DVFEk2251CHt/TZ0RLv5LJcbxePXm
	iP6A+j4KhiHxWmKtJjOFUBUaN/2Si5I2w89nxLHxFwhDz4Jyo+YjaDWvDURpNrqyURixfbIMfHK
	yDgZU0Yj+xTP0wBBhlrA449cjLj/LjLtOJ6aT/YxnGseT2eZUdu3T63qVxL33AToIKQxUSp6NgX
	TiC3ZTzyW2+VhhmcTiQKFX5ZSgynYDnwwg49fn5hY8uhAkvlBVByc8Vz0TXQeoWZBd8E7PN7L4L
	ORJkSK1I/H+++lHe7xr3GPHH/Yx6KPFNVXBiusQocNQhgbUSkIeSpLF1Ga8mBoi70ifFKOAZG0Y
	uQggVgcJGeP1cDDed0Qva3doVR6mpznLJyddbRQR4yRb4STs7A2FbM/dK71feg4fflMYpHT4AUh
	yux7b8TxTLDvYq2feo/FLuCG2wkRRUcuKFyC5gv0gTN2Nd3HzKGyaoMzDPkFzAgsI2mBtECvYGR
	nX85d13u5ZraYUgtQuebarkr1CwR0zIWMEDrBeIDskjWPoZn1AK8GUy8hUSFL9xX+/m+tmJTsP8
	du+79VQKrY0TMIL2XeZo7OctoP4=
X-Received: by 2002:a05:7022:3f01:b0:160:90a3:ca8c with SMTP id a92af1059eb24-1b55689f73amr22735281c88.7.1795682768396;
        Thu, 26 Nov 2026 00:46:08 -0800 (PST)
Received: from [127.0.1.1] ([2603:c021:8021:f000:0:1865:8c38:18fc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55684c85fsm71200574c88.14.2026.11.26.00.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 00:46:08 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, TAKANO Mitsuhiro <takano32@gmail.com>
Subject: Re: [PATCH] vt: Escape the CUR_ prefix in the cursor kernel-doc
Date: Thu, 26 Nov 2026 08:46:06 +0000
Message-ID: <179568276623.2784380.14004398028038099132@gmail.com>
In-Reply-To: <32321472-2593-4a5c-a347-952188c05333@kernel.org>
References: <20261125182903.2396749-1-takano32@gmail.com> <32321472-2593-4a5c-a347-952188c05333@kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: kpatch-send.py

Hi Jiri,

thanks, and sorry for the noise.  My duplicate check searched for the
lines I change and for my own subject, and Randy's v2 rewrites the same
three lines in a different shape (%CUR_* rather than double backticks),
so the phrase did not match anything.  Searching by the file path would
have found it at once; I have added that to the check.

His version says the same thing in the way the rest of the file is
written, so please drop mine and take his.

TAKANO

