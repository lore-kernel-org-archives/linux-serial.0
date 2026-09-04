Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C348C415F06;
	Fri,  4 Sep 2026 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788504499; cv=none; b=G9Xiz3XHAcH5tYq56C6NUQT7OY5U1yrHwsWiioZZvtM10GCJCjH3TJWjom6ON3uNwnDrbcpDrvlLydxBhcluL/80PBzWG9p+8QTaMNgiklhj3j9Q0Gw9xDKJ/SnSIgmwOn5i0q1ansCiI6TnXmuTmx6jvHjR3lWo8b/Fd7hY3uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788504499; c=relaxed/simple;
	bh=6YHVPHcPX/QZKEftTsIn+QSNdP5FqgYws96eGN4uCkc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S+9E1uZBmkd492dhTOJK8acp0auaLoUsocjJuFTa9vOdCCze20u02N+GEvC/gcDoLvbhhpXLoQBCYDP9WNqaFs41qKc0GJM2PyLw+umne2TEv/2EPWapTWkUlKWVPb2QnVkZ/2vWEB3npCnYRTuurvbZ4CvybzuGNF7dlsbf7io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QylvMCI8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QylvMCI8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC171F00A3D;
	Fri,  4 Sep 2026 06:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788504497;
	bh=6YHVPHcPX/QZKEftTsIn+QSNdP5FqgYws96eGN4uCkc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QylvMCI8K9CKMJUaFFrsuzu+q2wcVIa6kCtUMzuQH4V/xtWQ6gJ07GJxQAaev3nZB
	 PY9q1HqyY1i46MKp2xngl7YP6cEdT43QzYCSV+8gxgyR0qE9IhUmJS/1FcBsd3LQxp
	 DBiczmwv5/xwFgN+fVrfvoTZ3F7wPjquCEuY5ebtSpHdv6YLatXVMzTSeJ+wtVexR5
	 zxZ+LphnxmM69jK9ib74Lg6wukyOyL5mbHziwt+CTMZT+bOY4IuC59fkB831w1FAxq
	 MvzksG4ODxSV6w6pHiNY0RVJ3f93OG6i2T4lZptdiWRBdXJFEu83o4iL3PU9zchVMA
	 8S4/9dBZwBP4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/13] arm64: ambarella: add ARCH_AMBARELLA and CV75
 EVK DT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: lee@kernel.org, mfd@lists.linux.dev, linux-serial@vger.kernel.org, linux-clk@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260904-cv75-v5-v6-12-e918514cb3b1@ambarella.com>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-12-e918514cb3b1@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:48:16 +0000
Message-Id: <20260904064816.DFC171F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Long Zhao <longzhao@ambarella.com>
>=20
> Enable ARCH_AMBARELLA and add a minimal CV75 SoC / EVK device tree for
> console bring-up with the RCT clocks, UART, pinctrl and GPIO banks.
>=20
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-cv75-v5-v6=
-0-e918514cb3b1@ambarella.com?part=3D12

