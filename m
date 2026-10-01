Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FF5324B20;
	Thu,  1 Oct 2026 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790858999; cv=none; b=CV0MHSf43wnQ1U1HUnsCc3uMb9Jv84sOfB/qCIvU3eKS0HpySKemem6+IyrMAHT+wo2XMG/7Ac0HDzxy/2pmnDM/TQEaRZZteTjz5XrGGC5qY0jVPfHngsp//hp6Z8IDZnlN8US/iVjVVXBFfxtB0Up5AeOZG60hQxnhoWteeN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790858999; c=relaxed/simple;
	bh=dBsrikHVXqpQC6lb8zTxlK76qLlvwNLx+ytoAaDQICo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lIKUpo/Ui73sYXy5YoVVUKteHxQdL1k0j4pj+AsWxAaAnvZ+/o3kkgU7g8A0/g/UiiNoF/VVr9CMi74Ft5K80LVBWlAfd2n1RhzkyOrkIOoiqANkVIEmLSHNw2QcAB2arLHmjP2It78x7nyZNJeVgPBxPRgbO0VA5QkLL6l4bpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qsuilw5F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qsuilw5F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80D91F00898;
	Thu,  1 Oct 2026 12:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790858997;
	bh=dBsrikHVXqpQC6lb8zTxlK76qLlvwNLx+ytoAaDQICo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qsuilw5FiqJk7N4V2Hz+tNRZhBQaEHD5iwfudyUD+gUQiEVxHuA9c0K2Rc1QIoYmz
	 IQ/qaJLaMRkq2d+flMVyU+knrIHdLzfLb0LKqIlmvSutbChSsClYX7GVsHHdoGeUPW
	 Nx6ujF8bW3/R+ZCvMtiqZY1i8tfudw6lXyan1CUtje5/vOiE5RlgC87yWoac93SIeE
	 o3Tlqt+5nU1nCvNs4wFL4+FOgrNKBIbpaQk0WJm33Rh7s9rXNXlU8wrOKueroK8YJN
	 ygoPy0bsTbadWG3jEuWB3KyF2WwaFP90TBLXBoOKgYY1zq4DPrrCRSRYaL5WeUoJjs
	 hNZXPJk61Tiyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 13/15] serial: 8250_dw: add Ambarella CV75 quirks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: mfd@lists.linux.dev, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, lee@kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261001-cv75-v5-v9-13-486cc289a4b8@ambarella.com>
References: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
 <20261001-cv75-v5-v9-13-486cc289a4b8@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:49:56 +0000
Message-Id: <20261001124956.E80D91F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Long Zhao <longzhao@ambarella.com>
>=20
> The Ambarella CV75 UART is Ambarella IP, not a Synopsys DesignWare
> licensed block. At the register level it is close enough to DW APB UART
> that a full custom UART driver is unnecessary: reuse 8250_dw with a
> small platform quirk.
>=20
> Quirks:
> - keep IER ETOI (bit 5) set for RX timeout behaviour
> - skip set_rate; baud clock is managed outside the UART block
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-cv75-v5-v9=
-0-486cc289a4b8@ambarella.com?part=3D13

