Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B9733B966;
	Fri,  4 Sep 2026 06:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788504332; cv=none; b=ubLBHgd764AakTs33uToXP9L26ialNZvK9bg+hdiH6ldrSINJT4RSYUeBuknbL1XdZlK56URsxHaJ9oRC10OnEjDhdkS4LF+z4eyVboA50py4NwUvi1mvF/5VwhB7Q1bBZDmg7dZ1BAeCQpcrXQd6RRVsWohPa6BBISEpVcDyQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788504332; c=relaxed/simple;
	bh=bzNbo3twuXIM7t9gov8IaQAgAJxMN17nSW37XiiT5gE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qCYnmsd6M6bvn6gilB6goApmfbEEy/eQ8w7I+8WRpcIZZlg10ctsvTn9x58JKGeMwwFus1a6Zb+0rPctSdbtWftk2CFEXYXYtJnuusyAhhiBggDhB2sP9QeMRzUrSB5NdeUvhKlf66r2q8mIFNqOEGkUdO1ZXC+EKuOkrQBgLjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQgntWsN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQgntWsN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FA11F00A3D;
	Fri,  4 Sep 2026 06:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788504331;
	bh=bzNbo3twuXIM7t9gov8IaQAgAJxMN17nSW37XiiT5gE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eQgntWsNrvVEqMzFinqVgvqdDRorsASSQgL+f8OiLCUCI4LAdY3wT8p8mPtnMX0fy
	 d6eiq45dPKKaQc3cvizvhiP5t3pKuPCVVxLWATSc8KqZ0LRCyP1aE9fjc0NU6WbDEz
	 EMtjfdZyuz5JGHwJWPs7V1JTfaVL+7OSh/45cpA7gycgER7LUa09jiR05GPHAhRqDU
	 fL/xyYYNyboUeWLhfDeK+YQeXctgN0id2/yGfhzjSvYc13zU4KcJz39RRfNMn8NrEe
	 DY2BToD1nl8NqKpl7GY+sZF/x52dcZixBWb8rMHP6hUsxv5VAIDNZS4qCasecY6uJ5
	 Ic+bOGMBbvNAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/13] dt-bindings: pinctrl: add Ambarella CV75
 pinctrl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: linux-clk@vger.kernel.org, robh@kernel.org, linux-serial@vger.kernel.org, mfd@lists.linux.dev, conor+dt@kernel.org, lee@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260904-cv75-v5-v6-4-e918514cb3b1@ambarella.com>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-4-e918514cb3b1@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:45:29 +0000
Message-Id: <20260904064530.10FA11F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Long Zhao <longzhao@ambarella.com>
>=20
> Document the CV75 pin controller binding using generic function and
> groups properties for pinmux configuration.
>=20
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-cv75-v5-v6=
-0-e918514cb3b1@ambarella.com?part=3D4

