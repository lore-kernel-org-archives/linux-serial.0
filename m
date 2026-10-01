Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F9A47140E;
	Thu,  1 Oct 2026 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790858872; cv=none; b=YyQoUq8iZU3/FeVRppG4tejpxxST81IZNd/vxvOih2DzNUcxOS9H/h4b++6sTsTW7+TNvnZ5fb3Qh7NOV1zs1RNpo8Gg2Wke1Hlbp7D3DfHFat0TLIq04cGmLJKAAVhfSZGd9eT5wtnK7WArsOJN/tFGqXtmJlaiD3FWovU1UB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790858872; c=relaxed/simple;
	bh=HS2bcbyWcCw5TlSPcbprfeN0as2pu1VVH+F3NFV5lRA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WEC/gnfQkxLTNfo3GT+ajqQ1wIO5e+LpcP8GH5ICfQXOeriTZWh2JDO1UuREBeaynr5Yt8vjBAvbJKDLLtMmx8NJHyNr5dpHkx3aY6w4CNo1kEMKydcY0anV2pbc33NlwMo5PaMvy5BVj0XShx3C7Z/Q6ATwC6TSZX4DH0jQDGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZ0xwxfJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZ0xwxfJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7E41F00898;
	Thu,  1 Oct 2026 12:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790858870;
	bh=HS2bcbyWcCw5TlSPcbprfeN0as2pu1VVH+F3NFV5lRA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PZ0xwxfJb4eLE5wnlQLBH0K344SW2o4zsZ4BSEPdjz5zCb4B/2JzfreWAUiGA7/NU
	 6N3J7GFUuHLkYTzap46Jyz/iuTxRSHvQ6MjId23mssnWkDjH+OXYnJ2WIFIQsP9yw3
	 DQ/HW0Ic8Z+c629CU96wVWe1lI95RVKI9bWmXft7NJo6FAYhCHZTdA5v4GO3Pzc9jx
	 LSY0On/kDWzH8wPg0zvWfj7rEfIGzYtb1Jv9j3nFytRXhLw470ygOwas3sJfG3vnn4
	 Az8eoGLG/iRy9xFzAN422DKjCRr7CRruFD/QbZJJEEmuFcXPu6o0wlJzyo1Sm4+JOn
	 Wb/HoxoSJYgWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 06/15] clk: ambarella: add CV75 RCT clock controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: conor+dt@kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, lee@kernel.org, linux-clk@vger.kernel.org, mfd@lists.linux.dev, robh@kernel.org
In-Reply-To: <20261001-cv75-v5-v9-6-486cc289a4b8@ambarella.com>
References: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
 <20261001-cv75-v5-v9-6-486cc289a4b8@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:47:49 +0000
Message-Id: <20261001124750.2A7E41F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Long Zhao <longzhao@ambarella.com>
>=20
> Add a table-driven CCF driver for the CV75 root clock tree. Register
> the core PLL, AHB/APB fixed factors and UART0 composite clock, with
> osc supplied via clk_parent_data.
>=20
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-cv75-v5-v9=
-0-486cc289a4b8@ambarella.com?part=3D6

