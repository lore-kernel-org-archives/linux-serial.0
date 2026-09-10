Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F130D485938
	for <linux-serial@vger.kernel.org>; Thu, 10 Sep 2026 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789046174; cv=none; b=tzonZMz2rpHuMlRYf/nSTT0MX5hEpXVTJkLknALg5FK04ulEvS6ylmDm4fpdS+f7CyaQBrYSZDCJ8TLa5bII+MIZ1tw9pBZOHJ5kxdL7IXoN/Avffmg5SPf4xLJSoOhZKKpdAGXTjXr4343HdCR4V99CcpJYhtcU89FSiAEg5Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789046174; c=relaxed/simple;
	bh=VMxo933q7BWmJ69nhh0s3aI4TjWNLe4MH1AcB2kCyaI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=papEJrdWHWjOIwhBS5j+7VSrK/H74lASua9rx015iLSoZ1/u+iwnr8x8DtCMu3Gp/mHtptGh6HsuZYCn4Q+ruzk3xDTomcmJVsWehz1kgGtN8+YdMuElyEqI/BhYevrXslrkrpVaQ94OaQdXNXsc+uWSCy3kkcmCjdY36SBcntk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTKYx6/d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTKYx6/d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB8B1F000FF;
	Thu, 10 Sep 2026 13:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789046172;
	bh=VMxo933q7BWmJ69nhh0s3aI4TjWNLe4MH1AcB2kCyaI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LTKYx6/dlvHwvgrVxUl+MN8BdUReKQcV6bqkmKNizUAYQUIEAKM6RUTLS6Am354Ij
	 xQXvtAxJpzuSetrWFPwoTOT+K45WkD01Ofg3i0S/OdjiG0ct7ubHCOLJYUPeME5OLL
	 shfmGEXBLZlI2zpstQw1lI3HNGZFh1ecFYm86KgOhUmfN4MDGWG756WHSkuYW3fdWR
	 4DGhvmuuEWqKUhLqfNCAlpJPl/1ewp+NlDpywm4zHE+jXh0PDmpQmqsgqEtPYWd7tB
	 P5wyfANtcETbBLf77DgijpuoP0tazTr+MrqdZ293O5Y38Kmv5aE3il2mHhdd7i3cs+
	 fOMYh8PlISG+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] serial: fix TIOCMIWAIT race
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johan Hovold" <johan@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260910130816.642699-4-johan@kernel.org>
References: <20260910130816.642699-1-johan@kernel.org>
 <20260910130816.642699-4-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 13:16:11 +0000
Message-Id: <20260910131612.6CB8B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The task state must be updated before checking the wakeup condition to
> avoid missing a racing modem status update.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: sashiko-bot@kernel.org
> Link: https://lore.kernel.org/r/20260904115542.E20D11F00A3D@smtp.kernel.o=
rg
> Cc: stable@vger.kernel.org
> Signed-off-by: Johan Hovold <johan@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910130816.6426=
99-1-johan@kernel.org?part=3D3

