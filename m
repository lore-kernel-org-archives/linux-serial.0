Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718DE3D9DB6;
	Tue, 29 Sep 2026 06:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664015; cv=none; b=lvJGRJ2HZ0koK2iaMo1voL3BkQxKnGgK7yQ3YQ3X4XblbfA0J1UD7y7tTGv8d0abejiMX/aCFBSMR/E4MpCFu7GhrY9uY1MN0z1+I/AwguKzT0vkJuqkPX+iE3mmJLozpdvLihHCnEz2WW442QmwE2qIQdBAl5BCyRcc1QQZSKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664015; c=relaxed/simple;
	bh=SNOQnXc5g57viKi9YicLCp9fP0mvSs5JJY8d9PWA2/0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TL6vOV5quAsJEcVa8dI4Yo7xuKLYtaJXfnvlYgpzNEuft2bDBIjyPbGjCFw35IY2/PAaT42PLJMbVXDSDZ1dXcBgODiwRX+kc2c+BDiqMrg0GBDiRsGYY77kWVlzs9kikILHd6p+ZAqIPKiOgh96T8GoaslQCZe3yYgI5Vbp9Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXNNarkw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXNNarkw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700921F000FF;
	Tue, 29 Sep 2026 06:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790664014;
	bh=SNOQnXc5g57viKi9YicLCp9fP0mvSs5JJY8d9PWA2/0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eXNNarkwm952e5SbjHP2ZV4Wfz9rUhcbj8cFwbGDdUIixTyTe/cpmlFXAdzF6H4vj
	 7vUGHP1yFVUMYwodLt1rmnUyzBGlFt0Wb5+h43za/VsdKbsoQifjps07BRMei0XRi5
	 0ihbKuubRlNjzXGyXJXoMiMhJPWP+oiDY3TRKLCts2d+ZJa+XmFzM8+HzIxv894NM+
	 yuKldFeLUeP78GCKYgclSM/D7rEOsfPpJyEmfpDPUCLm+83bZOJoP4sQoNJr8Bbp7F
	 PV5IDftXyvreoNYx6SKQHi6K+Npr79x8chEwba7WRCk07pgO/FmRsiObN/ds3JT/DD
	 zNTLIMXZsx0GA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/20] arm64: kconfig: let ARCH_BERLIN cover Synaptics
 arm64 SoCs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jisheng Zhang" <jszhang@kernel.org>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-i3c@lists.infradead.org, Frank.Li@kernel.org, lee@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, mfd@lists.linux.dev, robh@kernel.org, linux-clk@vger.kernel.org
In-Reply-To: <20260929061417.20733-8-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-8-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:40:12 +0000
Message-Id: <20260929064013.700921F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Extend ARCH_BERLIN to cover Synaptics arm64 SoCs.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929061417.2073=
3-1-jszhang@kernel.org?part=3D7

