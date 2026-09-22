Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE38489FA1
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 05:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790055653; cv=none; b=iVStq70Xy5GmmgsdXcLpC3PHPDCUloDkRDStRPYHpXfKQqFfvBmigUKp9dyR8C3ZTWHEGiANzF+zS+RODnzbfN11garmknXB3Q4TPFXsDILGC9XwBLLChs+SiyrhQT6hdTIhrl9QzjuhjR1UUBM/3V7yQRBm7Fz6RYWviK+UdFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790055653; c=relaxed/simple;
	bh=AWNi13wsydYFgvvhrXi5BnEEALFGwYeJobLpg2wgaE8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JBkhpkNrldOoclUX+67qo/a1YGtX8aRXsjMhU0IJ359jHqsRIxLkFdO3wCIWRdLNErbBUw3+/0JyQE+ItyXfnCThxxd/DNschmKq5c+5ZG6WVpOiCzEhtqnFCqatWpAgXbQJgZDkdBdd37yARuYFgl0fl65wSdhAaQZ8oSJqeZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7slasPB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7slasPB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505FF1F000FF;
	Tue, 22 Sep 2026 05:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790055647;
	bh=AWNi13wsydYFgvvhrXi5BnEEALFGwYeJobLpg2wgaE8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B7slasPBRmh7agE6oZOKqkuEssTVGW8qmiRvyqq55qzpHIDPpURuYGEIB6pZIQufB
	 UmxnVpYzJ13wFucBqoiAROY4TtH/XQKs5fc/WpsPqn+UGAzj90jQcef2LcmVLLQVHg
	 QzgH9gqE0pDOOm9DArAmziRAg7i6nrzDcpsdXzH0Sb7P7S1BnGFE51rb7kh7Vobb2G
	 xZvCPLI0CTIZfRAU2zXHFu9EyXS583QIVPKYU4EK4LkZSI576VxZc7zZHgePKIX4JZ
	 ilb8xJuWMDJK6R89VKHTBrWAtOxYgdjx0+K+mphtEFucgjF+2X2pmCoN71rJPE3vnA
	 7nKDq6lqK6q2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: max3100: Fix a data race on s->rts in
 max3100_work()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ginger Li" <ginger.jzllee@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260922053151.11260-1-ginger.jzllee@gmail.com>
References: <20260922053151.11260-1-ginger.jzllee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 05:40:46 +0000
Message-Id: <20260922054047.505FF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> max3100_work() reads s->rts when it processes a pending RTS update and wh=
en
> it transmits a character, both times without holding s->conf_lock.
> max3100_set_mctrl() updates s->rts under that lock when the requested RTS
> state changes, so the two accesses race and the work handler can program =
the
> old RTS state in the hardware.
>=20
> Take the value of s->rts in the s->conf_lock protected snapshot at the to=
p of
> the loop, like the other configuration fields.
>=20
> Fixes: 7831d56b0a35 ("tty: MAX3100")
> Signed-off-by: Ginger Li <ginger.jzllee@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922053151.1126=
0-1-ginger.jzllee@gmail.com?part=3D1

