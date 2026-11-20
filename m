Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202502;
	b=cTJ1MU7kzItN9DT3T7UrOvCji4XrMEkoMoDm4w1DMBDJY2k/TL0qkmwre5B9lJW7Dnrf
	 0xebIeM1CZlxbe6sN+8xq+xMDbNkwz+RHhduGzAs7j0FMMHOJJS+GvDBqe/UawdihVW+H
	 8dIqC4nXAruBLFqNWq5BD29FbKKAuMq31pKhAeu0kArSrB78ER1SuB8FKpojEssrGqiBV
	 F12qay+Ms5ZeMQusnbyqxGtRA2/4R5JSRXqsz16QOv6GzMjcW/lDyETYnzRc08pkrovd0
	 CuTPIbcQ/RZ9ea6GoBrzKukQAhucXguN9mC/RCt5okBWtd6nxTg6/RMtNzgF/tLj2bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202502;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jib4yEZOxNTGCrU3sQSJlZtN3PzV8iyYHNYHUPiC998=;
	b=ep94PKsDAO3o/vNgkPAjqLAHr+U2WSASlmpiLlo+jUVtyqkmvk1fpUUpITPi2RHmqShn
	 dVz9Bb/A0G1+ODH/udeV5u5Kw2n+AHQN4odMGy1i2AGOG1fSMbTk+OoAV0Sowe/sOpFlQ
	 IR0CS/s5YZ2mYNyxfFD+Ie2fOOrrYsUP0xB3VPiF8KYU2MbLr1mSvb7MKMpxuOAWKLg0q
	 +0yMprdCBDQ+v9LuowwCbsCbeFVG7lMG6XT7pLMrNytY2CyGlPq8RHveyVtDfR9UBYE4e
	 ypb6jYyl4pnAGUR1nveMiW0tBqZKHZ23GUyBAb/kHfVUP4dPsOb2wKlg9I0U0j9fQaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hWBQy6VG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABCF606A6C4
	for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 19:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hWBQy6VG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2C31F000D1;
	Fri, 20 Nov 2026 19:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795202502;
	bh=jib4yEZOxNTGCrU3sQSJlZtN3PzV8iyYHNYHUPiC998=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hWBQy6VGC2QNWUjWUg71lRBMncHm3GGJWSn317wjI9KeTybSVLZvqi+sImdkBZICV
	 53Que8R7b25j/llSW7Mdfnxtk9uGO4iS3I2ixYYO6T7vLuyvMfm1fL8F4b12JzAq5I
	 ITW3UpIfz/9ZXtDjSuxcv3ZvRnMvLOo7b27Qw8jVN4Hf/XlwkO4mYhVjgJDLIzzsFk
	 tCM2VX/kJVVO5rr98++krhD2IyrYWWzEBPGecJeofZ9Da/+eUaw+woFMtvSFlecACC
	 5hmQfmR7wuKr08pOvR64pJEPRyERhUm5gSn5mqRvCnC+XWGEuXXWlEcTGLgpQfCqGh
	 itK+iDPLQjKgA==
Message-ID: <sashiko-outbox-225917@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/13] mailbox: add Zhihe A210 AP to E902 mailbox
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261121-a210-scmi-v4-3-4a795a0a9fc9@iscas.ac.cn>
References: <20261121-a210-scmi-v4-0-4a795a0a9fc9@iscas.ac.cn>
 <20261121-a210-scmi-v4-3-4a795a0a9fc9@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 19:21:41 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> Add a mailbox controller for the doorbells between the A210 application
> processors and the E902 management core. It serves as the SCMI
> transport to the E902 firmware.
>=20
> Channel 0 rings E902 and receives its completions. Channel 1 is receive
> only and carries E902 notifications. Both share one interrupt, and E902
> writes INFO0 or INFO1 to tell them apart.
>=20
> The E902 firmware keeps both mailboxes clocked and out of reset, so the
> driver does not manage clocks or resets.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-a210-scmi-=
v4-0-4a795a0a9fc9@iscas.ac.cn?part=3D3

