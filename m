Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EFF387345;
	Sat,  3 Oct 2026 01:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991234; cv=none; b=P0+33VW/kUhs7XeeWrmYFkccFYuoxCc8dv+/oBQYy1MpO+r2FTXF66z9Vd4n1AXVHCX961B8y0wfZzwgmifZJK5HnSptQdkYd2L/M/Ho2wedU9EcNv+Wef8WdhHCjUE5M8EIEWNqKnvMa4Uug4AMvk9xqNyGHWM5XApynfCYTPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991234; c=relaxed/simple;
	bh=cUz0mZU1sRsREh02G+T1nLcmEoE4wca5SLdkUvPXJbQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iCFdLrwd/20kQJkqaveodBVde1/Ykn0UcoMBxtCDIFJz5DjJJehogs0UmLFa/r9dP9hiToiV1P8jruSJfunPzgLzMuIu2zFwD8oPXWXTuZwHXi1B+aWqLnXf7fsEJmKWmAQJQPOoiDS7YMPOs0rKsR1Gb1BueD+fYHvJD/WEubw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIRCiJFk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIRCiJFk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F8E1F000FF;
	Sat,  3 Oct 2026 01:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991233;
	bh=cUz0mZU1sRsREh02G+T1nLcmEoE4wca5SLdkUvPXJbQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LIRCiJFk0fs6G0WAzbha2upJvaajF88N7CcFAUZpNNk6kVrBFMy6I4765YFXeWIrt
	 +zHMxiFq9PvoJx3e8AMZakkaKZYfZ2uBvCJteApv1ErOUcvhKzE2Ac7PepLctodDxy
	 VV9f+fqL/qbEYeeAE1X7E395byXjgvT9xr3bMFUfw5ZMSB2ohYBFU4Ku/vM2fHf+BY
	 vrkwtg8DasYq1v/qFnNAmNJLcdx/AIYtMp1w1nTOh/iFjLZ5t3+9pIsJpU5ORrgW9D
	 t115UQsOJwOsL8p8KjnyWAkbIAisewlEQCB0YePSPJAdibfXQ/vn72Y2xvHyJMMhR+
	 PDiOWs6VKK5HQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] tty: serial: pch_uart: use dmaengine_submit()
 instead of ->tx_submit()
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: linux-serial@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20261002200927.236033-1-Frank.Li@oss.nxp.com>
References: <20261002200927.236033-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:52 +0000
Message-Id: <20261003013353.50F8E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Replace direct dma_async_tx_descriptor->tx_submit() calls with the
> proper dmaengine_submit() API wrapper.
>=20
> Assisted-by: LLM
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002200927.2360=
33-1-Frank.Li@oss.nxp.com?part=3D1

