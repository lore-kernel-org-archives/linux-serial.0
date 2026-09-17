Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8C34E4309
	for <linux-serial@vger.kernel.org>; Thu, 17 Sep 2026 16:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661025; cv=none; b=MdwLZJe8om+3a2eleZ8JF9UAouXNxERoHSm2oJGbbxMSR+moZdqfDykF64MCRsafAELIxSEHE0qz7+dIl5TG617Rs9xkbiT78XuQpXPT7E7uVP2kFy2Mdc77FzoRX2VSA6iFVsozBDt49iEeqZ2O7TvSCgxFsZb6hYMKDfdnNGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661025; c=relaxed/simple;
	bh=YnkLPU3v6QSBSxljuJugQkLzFihr+s+HlFXXvh/FtY8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uRABhUUKFMye7rWbzYdn2PbfB8rUlx1kkw76jTmplfwu4j6VrY85AHg2d0Jeegccg6UEjQGlAvUYoBoCca38yyEoZPpI5ur7ZIpnEUEXXDQ7/pQjhTUO0+Q8aYvA4Ltr25Xxw5izCnRGyPRR9xlLJDdXfpJm4Ke0vAoGF1aiqJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwHLECxf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwHLECxf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E3E1F00898;
	Thu, 17 Sep 2026 16:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661024;
	bh=YnkLPU3v6QSBSxljuJugQkLzFihr+s+HlFXXvh/FtY8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dwHLECxfNcvF8R/E79iD8+uwoxmVjvys4Rd94FG+IyP7xbcrrT31sWUd3t7C1iL1x
	 ZsDySvnaQHx9FZP16nowtz5CH310qmopbLCXMF8/ykfqw6Uh08aNV2/1rpS8k9obai
	 9sLr/jOKF5+RAuIoM0YAMwL16t9HEvQu5IE1U/nPba5nkR7UDuIrnV2VVNs8nQRk0N
	 Mdjl5SNMQ91HV3ui346dYuQ9ydZIQR1wHylJA8soedqxClrNYZidwrT6HqYI35ahmq
	 IeI3I/KBZs+MqqCct5D5X4rhM5WWqFI6AM+jE22vhNDy7nCTe6womSNajmbYcR7NWW
	 HQND7oueqGPCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: vt8500: Fix clock reference leak in
 vt8500_serial_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260917155834.2161361-1-vulab@iscas.ac.cn>
References: <20260917155834.2161361-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:03:43 +0000
Message-Id: <20260917160344.04E3E1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> of_clk_get() returns a clock with a reference that has to be released
> with clk_put(). If clk_prepare_enable() fails the function returns
> without doing so, leaking the reference.
>=20
> Add the missing clk_put() on that error path.
>=20
> Fixes: 12faa35ae5cb ("serial: vt8500: UART uses gated clock rather than 2=
4Mhz reference")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917155834.2161=
361-1-vulab@iscas.ac.cn?part=3D1

