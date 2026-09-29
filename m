Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DA8350A0F;
	Tue, 29 Sep 2026 06:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664353; cv=none; b=PJ0nS3vTNz+IxoQDs0YFI/k2ldHhsI5+vJLW6mMETyEOyAB1z4ZeltOL0DkNwDjqh/m5QO24U7jVFwtlfO65P6WYW5pMqvWHcbSSIvNh4RTl2eKeeZzYkaztxpuXDdb/A7jBMNMW7H5vd57m4CcOVb2epPFiQYAS0OjUuSBeIfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664353; c=relaxed/simple;
	bh=hC5n30YvWDHYpMAox6B0lu9Vv6kGUiTHZgRFriwOpu4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bnPIFCJ0JE37fmzt5a61EIlMJ5MkBLxAHmdGhWv2Qm2uwNcVAkD5fOKxeVbQnuydWXimC46JMZri8GD4UbPjXOpBkXDdXHftNnIu9kR/oRT7ws4e7AerO/TYpV0xTcZsWcicuuDjIILZNynKnW1x/FCyL0N1yZAQBM572gNX9XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rc/lqLHa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rc/lqLHa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7591F000FF;
	Tue, 29 Sep 2026 06:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790664352;
	bh=AspREdINjSLLrvQ737uEtpGtsblqZXMWOV/IzKwbKcQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rc/lqLHaJzggzwoqMLN4SuQyDuGYHwpSXoSy+VHIfSR5KssvSopv4ZdaXWOB3INg4
	 CpM/LGULJ185lHTjLwdD9QB1UlWszV6m7K6FfQC14todEFFmaKAwUVLz/6IjvHu6Db
	 o3aE2ulnEoe6sirssoKHwaBIsHcl7ZTdfeosDcrw76rvDtKuYqB05Rxmtnw/Bv7AJg
	 t6oQvOttPxVV/poIsnGxhCPUJxGvfTvnR6Fw9mmJ19z5xxJngmmC5kwzDLyejUMA3Y
	 rH6n2UtU3evZh68qWGNd6pnP5EjCuewlpQjhkwLREZsg73L9cU15f1XNO+bsLXmyVK
	 QWWZrB8lPbVgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/20] pinctrl: berlin: enable module build support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jisheng Zhang" <jszhang@kernel.org>
Cc: conor+dt@kernel.org, Frank.Li@kernel.org, lee@kernel.org, devicetree@vger.kernel.org, linux-i3c@lists.infradead.org, linux-serial@vger.kernel.org, robh@kernel.org, mfd@lists.linux.dev, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-clk@vger.kernel.org
In-Reply-To: <20260929061417.20733-12-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-12-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:45:51 +0000
Message-Id: <20260929064552.1D7591F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pinctrl: berlin: missing Kconfig/Makefile changes for module build
--

commit 90017c53ecb9e3f7c921f299ee20085471283f78
Author: Jisheng Zhang <jszhang@kernel.org>

pinctrl: berlin: enable module build support
   =20
This commit updates the berlin pinctrl library to use devres allocation API=
s,
exports necessary symbols, and adds module metadata. This is intended to al=
low
building the drivers as loadable modules for vendor_dlkm deployments.

> For Android GKI + vendor_dlkm deployments, where vendor-specific
> drivers must be kept separate from the GKI vmlinux and loaded as
> modules from the vendor partition, we need to enable module build
> support for berlin pinctrl drivers.

[Severity: High]
Are Kconfig and Makefile updates also needed to fully enable module support?

The commit message states the goal is to enable module builds, but Kconfig
and Makefile changes appear to be missing from the patch.=20

In drivers/pinctrl/berlin/Kconfig, PINCTRL_BERLIN is currently restricted
to bool:

config PINCTRL_BERLIN
	bool

In drivers/pinctrl/berlin/Makefile, berlin.o is unconditionally built-in:

obj-y +=3D berlin.o

Without changing these to use a tristate and obj-$(CONFIG_PINCTRL_BERLIN),
the object is compiled into a built-in archive during a module build. It is
never linked into the loadable module, which causes undefined references to
berlin_pinctrl_probe during driver loading.

Additionally, does builtin_platform_driver() in the SoC drivers prevent them
from being built as modules?

For example, in drivers/pinctrl/berlin/berlin-bg2.c:

builtin_platform_driver(berlin2_pinctrl_driver);

Would this need to be updated to module_platform_driver() to allow existing
SoC drivers to be built as loadable modules alongside the core library?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929061417.2073=
3-1-jszhang@kernel.org?part=3D11
