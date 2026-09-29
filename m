Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4466435EF0;
	Tue, 29 Sep 2026 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664068; cv=none; b=KGEECXDB15ufHETiIkNHcYnMv6n5FXhcOviGSpf6mSNC1s+2IACPK4xHqRM7qJbW0v5WX+TdUDVqoJjCrV6yt2o8DeL9kdToPAjuEkyLOn0C7Dp0nfzorgzHBm8MSionrqGuwRmo91OmwuSxRFfjT+PodDxyTph64Wa8oT9soRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664068; c=relaxed/simple;
	bh=E2n6BoOJMgmyakjDdPqYQ+iPhpNJeurZaVznbkht3k8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tHEFyrGUeiqbd4mdo1/+tgNCXlkWe6Tdvy8cB4Bk7ZQbZsAIEWWc/dnFBln8+2W1551n0+dEKzfJnSv8BBZxqUr9NAgpKxwPdpqVKJnjxjMYFnCm1pbtTck7YhMl5olnecmzmI51L/FB6b+mhgipPR2+Pwm25HHNqxxdl49z6hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FseyX32b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FseyX32b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A573B1F000FF;
	Tue, 29 Sep 2026 06:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790664067;
	bh=E2n6BoOJMgmyakjDdPqYQ+iPhpNJeurZaVznbkht3k8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FseyX32bdSruDcwfTSifeaDlizHkZTOm7/fyKbbYFkzATzMxfaeMscJ1hSrmN1Dku
	 h+LwHM04/42nrBKBXLDctdz2DfJa1+ppGKH7QkSYOQoU2a8zobPmSFSrj1LW/eh2EB
	 0kpAFdXHThRyVeV+5Ria1bVGCYvMjHiGVtmpGE7i0v8fcj0FoWy820qoel2DZlZW6j
	 VXacazsjmvHxJzvP3OU8W2ptfGg46F8tEyigob3TICfDS4jH+R3rW+9VcSkNogCqVk
	 5cCwvpY8gTZ3vC9obbFnmVao++Wv9OdHMw2z3Z+WRX1uQ19vyK0bpj5+2UWwVfogb9
	 ua/2Xt7muaseA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/20] dt-bindings: i3c: Add Synaptics sl261x i3c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jisheng Zhang" <jszhang@kernel.org>
Cc: linux-serial@vger.kernel.org, robh@kernel.org, Frank.Li@kernel.org, conor+dt@kernel.org, linux-i3c@lists.infradead.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, mfd@lists.linux.dev, lee@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260929061417.20733-7-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-7-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:41:06 +0000
Message-Id: <20260929064106.A573B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Add the compatible for the Synaptics SL261X SoC I3C controller, which
> is compatible with the Synopsys DesignWare I3C.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929061417.2073=
3-1-jszhang@kernel.org?part=3D6

