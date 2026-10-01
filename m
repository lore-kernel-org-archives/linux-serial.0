Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2279A50B42A;
	Thu,  1 Oct 2026 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790858610; cv=none; b=KAFLXZqWsmO99R+445FSawBBJP452+8/NwQSqKmHPeIZkHqyW8DNZcrfSB03E4+ju5WdzNamHTwzijWq/FO1fy+KLSm0+pzQtapy4aabjlrHPbPrWjis+nXSUX7xN2j6BnZYpgnn2Z/FtlZvimG9enSx1n8xHnFhtXpE7uJ3TQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790858610; c=relaxed/simple;
	bh=+BMV2bmWuakXKbprkCJ+hS+DYvxvYVrpN2vlmZh0vpQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bdDu3JR/o5xZcjWZfREr6EqeH/D/2/toR7GgQVY4LlaHPKIUx6GGf2pGKjiJVZIJSwrsgceencu//TIqxt4p8oAmPNO/m2H5bheFQvkmwiITw9qpSpa7/RJV/GsAVigBVOMWizUalX33MFOEKOdwfXIbtCaPg49txcTerjEKE+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNTC3SsV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNTC3SsV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8821C1F00899;
	Thu,  1 Oct 2026 12:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790858609;
	bh=+BMV2bmWuakXKbprkCJ+hS+DYvxvYVrpN2vlmZh0vpQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bNTC3SsVusTTtkT2sNdSLUSSYTTs1eXcQhe/svDCTiyNv5f6Rv98Pq39lg+H4T6tJ
	 XHD+bp79ROLzmYcy8gCY467fjpMMniF9fCHtTlhCoOp1WJFDL2Hpgfq9eAsbTlX1WC
	 UtoJRhqhEufpbeG2MhaXs2poXVVf2Wu4/DasHP+jvEorjTyOc6JrhIe9vtCsBcSE0X
	 E5Vy6HefnTSBML51zsDqqWVx6em7ET2nnBW82TFhZHvm+YxmtesaMUiMwoBag/6L4V
	 1viafu7G7y2udR8co+alS/K5wurViE0Kgobm2KUY4nMCiL2CJTfai8TkgAEhmWJ9hC
	 S7RpryrWDc8cA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 02/15] dt-bindings: mfd: syscon: add Ambarella CV75
 secure scratchpad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: linux-serial@vger.kernel.org, linux-clk@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, mfd@lists.linux.dev, lee@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261001-cv75-v5-v9-2-486cc289a4b8@ambarella.com>
References: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
 <20261001-cv75-v5-v9-2-486cc289a4b8@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:43:27 +0000
Message-Id: <20261001124328.8821C1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Long Zhao <longzhao@ambarella.com>
>=20
> Allow ambarella,cv75-sec-scratchpad as a syscon for the shared secure
> scratchpad registers on CV75.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-cv75-v5-v9=
-0-486cc289a4b8@ambarella.com?part=3D2

