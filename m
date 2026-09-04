Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41EC377AB6;
	Fri,  4 Sep 2026 06:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788504343; cv=none; b=uc6GcbL6wHuKTaLpPwqc/FgGTPn2HFaB3fgwAeKHS3i2PcqfEjK0Lg+4vrOW1R+s52OjlJyYEHuhyYURZQJuHobQgGipUacA4OGILlx+XmKHB2prM/P9K5t0npQ2Q3u6m4SWOLDtx1+vC7vPU9GQ9l4u76lCSg2AwNAJyMC6IqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788504343; c=relaxed/simple;
	bh=IhJV+dZNN8M+WFAJ6aET5OPGE4gb+Y1OniOXHGUoH68=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mj8eXksG+R5+zvs7xGPHxBx5tqrDqFiuvXGkewcowOBna75kQ+auO/2yoWJE8s+wNyaUbyQdiPPlumNlrj79jyr9Kz65Pk/VcpflWTQEk26mjMbY2oGUrdNZ6K34uKEEo4PwGUE2YXcdXZkcNMhe5ajRlWNPazScbt3nXIqaHqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4vBO3ms; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4vBO3ms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D011F00A3E;
	Fri,  4 Sep 2026 06:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788504342;
	bh=IhJV+dZNN8M+WFAJ6aET5OPGE4gb+Y1OniOXHGUoH68=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b4vBO3msp4455OJ3A9wuiz0OhF4kK2Nyba04WDEBQdtILEynRJRdA94eExjIA/iXq
	 jhULWN+SuP0CULj05Ar7oU5YmN5lTmi71gwJwEh7bhhuGEmVEWR8HuPJMJqA3XxZSN
	 9V1kznzR8rbCi2W8VZzp1HxAy3wqW/PVlYxhLfX5N6oMvuBOWbTOwM8vyZnXP+5zn8
	 40bwpkoIyctwp3NQ4uEtOQVyhTkGafR1Q3kFTT1NeaUu84gnR1VZ/eVwEAISmFHPkJ
	 hH43jLHPlix56sev1JI3Cok+hdqB8X50Tl8WSPv5qZcLqzfs2f+/scIK8H1e7/hYmQ
	 f2rEnx9Kp30iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/13] dt-bindings: clock: add Ambarella CV75 RCT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: linux-clk@vger.kernel.org, linux-serial@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260904-cv75-v5-v6-3-e918514cb3b1@ambarella.com>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-3-e918514cb3b1@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:45:41 +0000
Message-Id: <20260904064541.86D011F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Long Zhao <longzhao@ambarella.com>
>=20
> Document the CV75 RCT clock controller and the clock ID header used by
> DT consumers.
>=20
> Document #reset-cells for the RCT reset-provider role. Soft-reset line
> IDs and the reset provider driver are deferred; this series has no
> resets=3D consumers.
>=20
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-cv75-v5-v6=
-0-e918514cb3b1@ambarella.com?part=3D3

