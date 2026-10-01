Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC7F4FE2EB;
	Thu,  1 Oct 2026 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790858588; cv=none; b=fHEchkB7apszMGliqh1Pe1pBdEgW1EwDqgakv7g9nmTgie5YGdZuwuoX1DgbaZ9JvL3xvSwbvHVlma13WvQpD0SJjhG1OTDDw3BPJ25ZRzvMid7GHWcotmV3FJNkP1jcQOYSS0fW+pMglRITheiRId9sgyRcZzrjVxH1HwaNz3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790858588; c=relaxed/simple;
	bh=j7JODZ+GYesHbWdaZiEMp5nO00/Jibpb4vIRzZQAK8w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tibV3BgXk0JqmK9sSSQ8cAraEKi9rpL73QgSdVY1NQaycQyIlWCfdsrVX8GFvCnzu5hfOyheAnfK1DSNAtrbxFCJDllzAXnxIuZrea7PwgyHDo+BLEYHulRgjsX+EhwhXJBXwTl/RLOY9dJ2jEduwR2xhy1RnzCq/JbF5Hyp2x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJbnT/te; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJbnT/te"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95491F000FF;
	Thu,  1 Oct 2026 12:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790858587;
	bh=j7JODZ+GYesHbWdaZiEMp5nO00/Jibpb4vIRzZQAK8w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FJbnT/teU9jGbe74IsoGW0D/PGliDiM4Ghh9c0+GXyQr+ZNNkLPOQaBadY9L1tp6t
	 N6n/Dl48Tb9ZU6SMGON47el3JUHRF3I2wAY8bx6RnjxSKxKY4RpHIShPBf3/uTRQ4g
	 lT9njl7HCSfOvn1HTNHU66EzJe6Gym5DzJAIGoChF8gOTql+vsjmn73+pk1/020d+X
	 BzZ/Xn7VOvmHHX7GTXnPU0/oEsXTnflhZWlMIYLwh0USnRW7j5UnGqcyMrTCdqtl3l
	 MRZ9RCmqw0WfraT/EFvAyoUosBiviQnZlGZvT36mhR6lNIqs4UdpaRYUyqu5EkRQss
	 5TTgrWWz4dkVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 01/15] dt-bindings: arm: add Ambarella CV75 platforms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: linux-serial@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, mfd@lists.linux.dev, lee@kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
In-Reply-To: <20261001-cv75-v5-v9-1-486cc289a4b8@ambarella.com>
References: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
 <20261001-cv75-v5-v9-1-486cc289a4b8@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:43:06 +0000
Message-Id: <20261001124306.D95491F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Long Zhao <longzhao@ambarella.com>
>=20
> Add the Ambarella vendor prefix and CV75 EVK board compatible for the
> initial SoC bring-up.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-cv75-v5-v9=
-0-486cc289a4b8@ambarella.com?part=3D1

