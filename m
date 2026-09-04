Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C48B480DF0;
	Fri,  4 Sep 2026 11:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520352; cv=none; b=H08eEEs0/yWyc4XzzZtL+6WjmAi4xBGVkiC7EdNgZRCbmSZaa+OhM7E45h/UgbMYHNFsbpo4Twtd8ByQBJf1DESVo67fsILc2NH5dCTpUhyWbZj33K87dh0RX1bto9uMoVvelEpbXUZXDh23r4fg4LN6Tlowt9PPNpAcaF4SR2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520352; c=relaxed/simple;
	bh=vg1tybtiV0+/9Ky5C37tEQkOqbrqxm4UeZGr3wrvBDU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CctpDj6mg4fijIuD596kpAmc5SiaD0XjyX6hiu1yUVJm0G4uaMpif//+wb8SFhr7gd1awaDhM9nR5dL16Svz2J7tk4aLYKFTde4CllTWW1JRHHjMoIVRMSwV6tS3//3V0bZoD7TIDPegLmv+tjDC1RgRYxVo6xYn0GQFN6FYb7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iID6hRkB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iID6hRkB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68E31F00A3E;
	Fri,  4 Sep 2026 11:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788520351;
	bh=vg1tybtiV0+/9Ky5C37tEQkOqbrqxm4UeZGr3wrvBDU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iID6hRkBVSW79jvQD9EPRA7+cBXR4KPFooUX5nxk51YbGVqjWKJHrfP4TfCKh0jYe
	 F50AXzyoSkZaQtCDSG5ShGNZemoPrtsiz5Iw8SodoBDzpQfYNv3LgfHG9LppGx3iHh
	 KENY6xHC1SdUzeQGCWi+F1A+Eoqqu//VtMQo27I7I7voqMnolA5M9pj2C7rj5LGvqx
	 h8lOzMYOkjBGhGvu1HiAg34SzKLleV0xLjpFtsHqVI/kXZERDJYtby8cPZNbCzzF+W
	 W+QJVpBS1efhetuAARLFaO0LMhm6qRXUGcd358EkVnqQ68MDYXzF+E7AREA72GK+ZQ
	 ojELVo3DyoJfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: serial: Document WK2xxx SPI UART
 bindings
Reply-To: sashiko-reviews@lists.linux.dev
To: zjzhao <zjzhao@edatec.cn>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260904105243.120769-3-zjzhao@edatec.cn>
References: <20260904093341.100826-1-zjzhao@edatec.cn>
 <20260904105243.120769-1-zjzhao@edatec.cn>
 <20260904105243.120769-3-zjzhao@edatec.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 11:12:30 +0000
Message-Id: <20260904111230.E68E31F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Add a DT binding for the WK2xxx SPI to UART bridge ICs (WK2124, WK2132,
> WK2168, WK2202 and WK2204) from WKmic (Chengdu Weikai Microelectronics).
> Each UART channel is described by a serial@N child node that carries its
> own serial and RS-485 properties. Also register the wkmic vendor prefix.
>=20
> Signed-off-by: zjzhao <zjzhao@edatec.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904105243.1207=
69-1-zjzhao@edatec.cn?part=3D2

