Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649979;
	b=wOJJ3SwlnQiLqXmXp5V+y0vSOFgizgoUwIwe8QW86M2v7XlHaIGk9yf/qJrLpQUD+xbM
	 ZN8NZjM/c8HauMmmTKOiYj1RrRN2pK1UNbqkFN8i8+U8Bq0mPForeJQrCiEPGAmTv7uGk
	 7sNb9BmUzmv1N5EuDuceL3jxUZTbpGc2T7mm6dUgjhmlGKPzVItkSZSLL37zrfNObuT/A
	 BxmTpJTTAr43lC0pqDA47TgvHWdxHKKB+0rX7lQ2OzO6b1TKXy+AJkAIOGr0zABewqGVp
	 Y6HtJnv9PfoU1zJfKtFPSYohbdUgRw94GPJ/0oTxfk1Mti5uZWzbic9T9se+sDjNuiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649979;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bNM7NgJxOL2i0ah42e0mtYDd5C/FlHznI+qMxCRs1YA=;
	b=pyK8wdx87DJ7RpnDVXlYcwMinNz65VJG7TtAAqdLUGMm9vhJsNbPsCH7rJ55F8RvOcZu
	 5hFEuUaMhdWm/wax5uKZ6m1HiUYm7KzKb+OVfAH1ep9ZimXm3VimaebpAcm1u9+1CgiNq
	 lQz6qecbXhKOyZdnWQjsCkFG+8fwMZc+CQ/JPCt2JKgDpk9shgDH0x7o8zbWhA/sRLPzG
	 yTgMX5Da2PBA+dmj/+7u7FqEZ1mOJ0wBsmeSNfi9KhKA+1js24ELE7ppAgnVtDfBFkD/8
	 KgRfHN/CKb/ij+z0KODBbUAreHvUsTU+FXhKG0Hu/kd+arx/WRmpfRv4AJJndXmpRVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VkpPiHsj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC48606A339
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 20:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VkpPiHsj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634621F00A16;
	Mon,  2 Nov 2026 20:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793649978;
	bh=bNM7NgJxOL2i0ah42e0mtYDd5C/FlHznI+qMxCRs1YA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VkpPiHsjdrS5PV+8TZZGwcjJmr4E7lrY7w7zMgxDZxdmaw/448f9rlq+ig2M7/2Ue
	 dD87JCX3irNXSwIBBHJgeMRANDzALxo2sW3qosm1GT1yr/pdUF5Ow+gne3RxXV71vU
	 BokXWubeER4s3mxBbxaskVofbVJ7OSgubesOLmtSpvnVOEaDcZpBu9RdL8SuSqM/Do
	 mwJRV/5N4bqZaT8Qwr6I5hie93gpJsESMmEMjKK1vmIoVhrwO1GZEr4s4Htw2cC67t
	 /8ctWuunUfJm8wPqcWcFJ6dsh5k4JUxnyURYJb4odnGhwtikiTbs6m5Ah46byt1q3T
	 rW4h8Q3UyFqew==
Message-ID: <sashiko-outbox-194058@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 13/17] riscv: dts: zhihe: add A210 UARTs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-a210-scmi-v3-13-ee6b31580808@iscas.ac.cn>
References: <20261103-a210-scmi-v3-0-ee6b31580808@iscas.ac.cn>
 <20261103-a210-scmi-v3-13-ee6b31580808@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 20:06:17 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
>=20
> Describe the ten DW APB UARTs with SCMI clocks and their separate APB
> and serial resets.
>=20
> Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-a210-scmi-=
v3-0-ee6b31580808@iscas.ac.cn?part=3D13

