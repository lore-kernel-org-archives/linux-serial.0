Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301643;
	b=2DN56LyrRrOD3p/uMVat96Doldl1RT1sqiDPViA7/GmcrDGhh6AgaFsEpT0JJmqVppN5
	 sHYouH6IPuIw9l85vhTe7HDzXI6gFG0PPlcMaqGWgKlOsEIas4kUgZHjoraYW+B37SVF1
	 ROwszRt8JPV05zZPl8Ei54mZgz0aJjnUok/vv0Rp5NZ8/U01WcRgl94v/pHuDkSdB/vFU
	 8QLwPVBGkkk6F1hMBTyiZ0YisSaDGxeXlWLdUi10czSYExkCQxngwEKISB5ia75F/DqYf
	 8sGCqTmH3TNpz/N9MBLz/huH51WCjo5nI7WxMafO08T++kQKA6H3ZwskTJ+EKlsA5aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301643;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UnBbFNnT6qaH4zjhxV0w0THHTNwXNtUqtCm4qVti1JY=;
	b=zxuK0jpvgpIVmUE61fw0Jc2Jr/dsJIKedkq0rD9pPrRpDFBYlJ4SujCodIjr5RIVd2Zb
	 JQon+X7WxYyFmqdxYtuKgHmVTsKeN8mhjeO0qxtvA+JYLQa9wmh92hEP1PaLwWheV/3qY
	 Ksjqyb1yk1epsc+Rx4LXc1+kuvEF6cys0MpBqUzDPM+wwteuACqJHbcAlwOtOlAjPKrnh
	 GVRkklXRWP1zTO0kWeftvLXrgPzl12eHEQFTeU1F6/1IvfDtz9QR1Zo4n+Tt+ZMJ5KKTY
	 hrgNwm1hHUnSo9TKPbszhAolZ8IuJgIKQ7zNIgG/XYfFqhDwH9LDH57pBOS0ddXiBDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kt4nZ9EN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33331606A330
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 19:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kt4nZ9EN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBEB1F01825;
	Thu, 29 Oct 2026 19:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793301642;
	bh=UnBbFNnT6qaH4zjhxV0w0THHTNwXNtUqtCm4qVti1JY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kt4nZ9ENp3+sKYC8CqJ3C8a0HuVCuLUgo6v9k/5PmUCDjIXAbdbsVvD7y0kKRrPNR
	 oxyKKuYShJldGLkmazmq2Y3+l1gfGBauF6wneCECOsjiOCk6tLNhiDVko2IAp6GXT6
	 1dKdbdVY9qRjW9MexZrM+2ax5VnREuCJv6YFVsaO4+9+F0xUBp5LiaI4lQLmyISteA
	 OdC17nMJEpzbFUh2WdVEgAe4dX74LThATu3xK9vxGGFufARTD6y2DiD7kMUNEjU6im
	 BsqvTjSEsIC5xXf4KWm5Rityr6zNByQL1WvvYdZeHqT5ja0fsS6FyLeSS9Smmfwe0a
	 6+oZYc5GQO38w==
Message-ID: <sashiko-outbox-189867@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/8] arm64: dts: allwinner: h616: describe the UART
 integration
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-submit-h616-uart-fifo-v1-v5-5-53b433aebbf8@gmail.com>
References: <20261029-submit-h616-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com>
 <20261029-submit-h616-uart-fifo-v1-v5-5-53b433aebbf8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 19:20:42 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Identify the H616 UART integration on each of the six controllers. The
> specific compatible describes the fixed FIFO capacity, register layout
> and receive-trigger mapping.
>=20
> Retain snps,dw-apb-uart as the generic fallback. H618 includes this DTSI
> and uses the same UART integration.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-submit-h61=
6-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com?part=3D5

