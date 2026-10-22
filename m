Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685604;
	b=B4rfIxyO3inlw/dNoraYxH4rdxCchn1SwwUI87ps1YQI7adG0t+2bOeoDjWNaq8ctHJw
	 USeefl0hMmSoswkydcGmm5jfk6QcFc5rHca0SrJpMUP1T5loFSkTKlvn964j/OC/ebp3/
	 erKw11yvnzJ1QOd3lRPRMoAcDs0vy3hV5Hcf/e98qvHtpebdKI2O6UinhXqve2Jo1jwtR
	 gfybZWGXl2VyOQ9AzkHz9vrkI14+kF6y5nfKNbkwsbNUAOyOoo+mmVhkzFAzw6UonJxCm
	 zvM8XzQEwe71BFPnqDrwL/VyCQ5ek9sawJMu3hOWPNe/HgiAfCAyS1Mq3T2WC5h869w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685604;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7MEjLAWQkCiIhJUBGWgXXcxD0dJPmiNElz8Jzn/Zn3Y=;
	b=PIjA4CwmXxV2tE3/3uxoObX060IYz8ZTEoFoB+Hi2BFbvJRTQ7DzcIYUl9NsWr3Xt5Sx
	 e4O/mmignczQRIT2baQrB4EXeTKxZqige3pYQgHOO90He1VL/eFWJpuBMd6XLUFzyvzQi
	 o3xT2hO60fP7ZyyLbONDlVo26MxSZqekWI1MKd298wv5Zq20j/qbT1LjQeGX/lyeD4bhv
	 ukvMBZRhA9RtWl0Z//ay2qqlaYvLjiQVd/rnbVFulC4wg96HgJQANKTtJnT9eqnun1EQo
	 RyeqXutvonsUMbeKnTx5B6If+eV74m0GqQyUYexz0496I2YRXjbP7gCwytYVGKrAPig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMpdRuES;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD34606A330;
	Thu, 22 Oct 2026 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMpdRuES
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BD51F01825;
	Thu, 22 Oct 2026 16:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685603;
	bh=7MEjLAWQkCiIhJUBGWgXXcxD0dJPmiNElz8Jzn/Zn3Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PMpdRuESpaQ17DQfaUGVoGjQpBOl5k+yM05bFSZBO1j3VPPi3dBFKFPaqMk7FgV+X
	 xPwRZsK4zBScsq5FcEqr8QRyP4dk5Mkp4QmyltakN2VFxs7rFiBZynW3bj8N47tvSN
	 v9iqwSHXuEOdE+nYNnR6kXLX/XH2MhbTk1WtDAGhO0kk3cr1mJVKio2u7W3kSpL0A/
	 MDZr9Kiak5bbiG21phXWlhA5omiBH+CjiirYz24nmIv2XQfnVnuAxGfes/cbQd2dns
	 YjZff+elylNQMV+kD3Qmt3yNMiJSGzIh8xIye6Gm27mlZVwozAqABMmJjHvUx2YFLg
	 Rp2OvmrIOCpYQ==
Message-ID: <sashiko-outbox-181788@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 24/27] mmc: dw_mmc-rockchip: Keep RK3572 NVM domain
 powered
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: mfd@lists.linux.dev, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-24-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-24-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:13:22 +0000
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
> Power cycling the RK3572 NVM domain causes repeated SD recovery. Keep it
> powered during runtime suspend without disabling controller runtime PM.
>=20
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D24

