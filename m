Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685597;
	b=PbSmIWNufpfJm2192jUJbVlXwMsjFvZjeYqTThceNwEiRZwjpxjbPFxY8OD7srESmwgl
	 jiplAabOPeYNDhWWzmzF0LCBMoNk9zcH/mjDYwOZE5tX52ykWCRNq14mF7LJaI4m2Gx0v
	 rgTNCFQKNGSuYJ/1T+HbwkfAamihhbjC0WydXmZZaOAFzHAMkHZIeSLJZMZo30LUEMmZ5
	 qLqti0XCl20BGnBs0FU0HGQyEIRE8z1JeH4TEj2kJHG9b8ISWL0y1hb5GT7ET4OSOK70X
	 VGGdIFEAVnG1OJRn4R9ZIp5qRnQtPoqLOKiD77Ig77jU7DYa648TRDwONZhAmquUv/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685597;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0maZhcO+Kn7i3g4r2O5jCteDMkImYrJ4vSnb07f3ePY=;
	b=cmBFfulKApPsxyjlpLQMD8bzXUgUty11HVuI1DdB6qC1prZ3i7ekkirhZmThPJe8hgw7
	 O+EVNhm8Q33W9sm5t470wYrAX/vBV2Tbn6+raA59iFojB72UFdW8C3QJFOqYHT5fy5UbA
	 2fv1HKmQp8BEmE+etCYOe9xfNjE/UdNdkK0YSl5VAUR9m/p+2bWafCya0SDPE71PLQMz2
	 3tG2ahMq8BUX5jkD/R7EhugUMBhhPwrrjmQoIAx9K2hkDT0pdbCrK4exD8kD6rLJQao6L
	 NX94TcNodPlel0ZhKGQRnXfhCtdJbMVujsp1HPwK9flOIELcKsCO5kbKBb71c1dshOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AiFFucAa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD84606A31B;
	Thu, 22 Oct 2026 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AiFFucAa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681391F01829;
	Thu, 22 Oct 2026 16:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685596;
	bh=0maZhcO+Kn7i3g4r2O5jCteDMkImYrJ4vSnb07f3ePY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AiFFucAaxW24BSUDqb+N9vuEsIKVg0Ey8g1fCzWTY5nAz8v5mZev3pM7LY686k1M3
	 3q98HDn7YxGGNhCIDIoaMd+oNEVv9BFBGIGZ6X5MqLIxTqV22TrEYaqs//fXzV4NDY
	 lkkaSW+5C+g/0D018oCTCH9qOkRaPGeWkQKJpX+qDQUR5NgjnxmF7cDVKG1abMyuso
	 bXXSQ3TNvvZ/tHGVbDu3xABZcEJxeWBsx+mlCrNQetNkmDIVcNpzdb8VorgmVtP27c
	 QTV4GVMTXGP7ChOUdCjAhgs+hfiH8y7GYYK+o7USOq+itHkyX66uOv4OpiEfaL1m8x
	 bdphYKsoPeHqg==
Message-ID: <sashiko-outbox-181781@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/27] thermal: rockchip: Add RK3572 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: mfd@lists.linux.dev, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-17-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-17-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:13:15 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Cunhao Lu <1579567540@qq.com>
>=20
> Support all five RK3572 thermal sensor channels.
>=20
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D17

