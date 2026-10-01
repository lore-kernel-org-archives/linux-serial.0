Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA894B95C7;
	Thu,  1 Oct 2026 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790858582; cv=none; b=RC1Th1nBzpT8LgmeFSRbjTcaD+FMnG3zKSj/jinvdrHyLjW8Oxe8tPxalv1y32/ZrOnVVWIDX/E8Je0TRQafmxRK4jOhQyMkGa6cLxhjW++GZ+c8D7EKq8iJieq2IXIxHT1NxqmQJzCNQUoniRqqiGDoAgnh/7SIWjZ/OSbDXtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790858582; c=relaxed/simple;
	bh=tlM53ucKvyD5/JCwc7/LudijHoJHZCgbWYtlvRDK4Po=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nhz2uTKu3lzF8CDaPTh2HdY5lA3O/CJIJ4mG1phWdgxP+myo4Vbj41AmrtHgW5vpliF3Fy8U03szOdGcpv/pQuAn2WA0IGTQmvq9dHgwgTlHkJMuUQEckWgOiPbxh2+84GrbHTI8Ck7kHQvUPkrcwWH3MIWZRG59I7cuet97g/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieXpRgnh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieXpRgnh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB4C1F00898;
	Thu,  1 Oct 2026 12:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790858581;
	bh=tlM53ucKvyD5/JCwc7/LudijHoJHZCgbWYtlvRDK4Po=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ieXpRgnhw5XRLwNsYh4RPzfk0Z0s2Ss5LR9DagG5BacRCQA0MpWPA/OzF6kXZ/C1Z
	 2gEbag8DqfqBg6w2gwVyOTzF+Kevy+rP1Hl4bFAkXE4kGkd2IYqzaPNpzh6C67X4dK
	 eiIn3AUe2lAPSSoex4Vbg1j7Jf93mi908Wkxywqiw7qf/UN6Gil+x+PvFISKOb/5LO
	 15RzXuDSQiW/w+laTIa34zSOcN7gAvFLJHXvFbTHXyJc6U6qj742TVF2NwQE8OLxbk
	 fHa5cPP1mJud/AzMqqTTgHKK2e86RL9hzVEtWpSzGhnLPDIoYTahNCAx5KVW/nEAfq
	 PMnEtf3cXscHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 05/15] dt-bindings: serial: snps-dw-apb-uart: add
 ambarella,cv75-uart
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-clk@vger.kernel.org, conor+dt@kernel.org, lee@kernel.org, robh@kernel.org, mfd@lists.linux.dev
In-Reply-To: <20261001-cv75-v5-v9-5-486cc289a4b8@ambarella.com>
References: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
 <20261001-cv75-v5-v9-5-486cc289a4b8@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:43:00 +0000
Message-Id: <20261001124300.DBB4C1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Long Zhao <longzhao@ambarella.com>
>=20
> Add the Ambarella CV75 compatible string to the Synopsys DW APB UART
> binding. The block is Ambarella IP with a DW-like register map, so it
> is described as a DW APB UART variant.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-cv75-v5-v9=
-0-486cc289a4b8@ambarella.com?part=3D5

