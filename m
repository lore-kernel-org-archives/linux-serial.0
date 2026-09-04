Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8AC453A41;
	Fri,  4 Sep 2026 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514833; cv=none; b=M8VKxlqptjHKk1vmv8o5zlNc3bAvDn6t/BpQ5Cv5YvyXIRvQj47+26g74MQIJt6Rzwg6vwtYsGU0dqOtLi+3uXe5KHrrmnuwsRQAPc2togPwpEw68VulOiE/K1rEsnErncFtB+cF2VWH4uFZBDwEyaPucGCkrT/K7dFrY3FW8n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514833; c=relaxed/simple;
	bh=br8pqUkcW+UzcOFG3NY6KC7dVNR/5nl+7cAYWXRhRc0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LfUAUUWASzskLRZjz4JGt5yz9hnZ3tcZiWo9t5mKdkjXR1UX21T5aRUzTxJNRCcoEVnhBzDun5BdV+QI03xE//O+aEID+0rJzZ3bNxL0xe1181swBGSsvPmo76Zlv4Gyd3tfV3BQvYg4gU4bw1d3TtSdWqvOEsWlzIvf0lSDWBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNZBE8un; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNZBE8un"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3B11F00A3D;
	Fri,  4 Sep 2026 09:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788514832;
	bh=br8pqUkcW+UzcOFG3NY6KC7dVNR/5nl+7cAYWXRhRc0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oNZBE8unwKPRTsoGe/42I/f6V2rZ2f4g4BOkHfYtrFKF8XeFHSJ9adB/I8eckOEH8
	 GjerQJ17j6Kw5RNXNJr37C9KDaGN1JaoVWH4uH+Hyej2tqRm6LMpOAlRuSvGNg23cl
	 Af2xI/r+YyFUUYYzVeGrolQBEI+BaPQAZmU9AVfP867+p8aY34+1zePXm/Jy4Iv8wy
	 /bCIHK6yKB6Tma/504MSShPmL/dD9HzFoj8cn6yW0XWc7uYVuMV/oakAurOoJCWysS
	 IEV/r1+NSsqDnCdfSQfP193WdWtLCS83nAe3CJfi5O9RsUafKYPwmVRC+ONRoPXkc9
	 HHNkQdRbjILEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: serial: Document WK2xxx SPI UART
 bindings
Reply-To: sashiko-reviews@lists.linux.dev
To: zjzhao@edatec.cn
Cc: robh@kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260904093341.100826-3-zjzhao@edatec.cn>
References: <20260904072027.67473-1-zjzhao@edatec.cn>
 <20260904093341.100826-1-zjzhao@edatec.cn>
 <20260904093341.100826-3-zjzhao@edatec.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 09:40:31 +0000
Message-Id: <20260904094032.1B3B11F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: zjzhao <zjzhao@edatec.cn>
>=20
> Add a DT binding for the WK2xxx SPI to UART bridge ICs (WK2124, WK2132,
> WK2168, WK2202 and WK2204) from WKmic (Chengdu Weikai Microelectronics).
> Each UART channel is described by a serial@N child node that carries its
> own serial and RS-485 properties. Also register the wkmic vendor prefix.
>=20
> Signed-off-by: zjzhao <zjzhao@edatec.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904093341.1008=
26-1-zjzhao@edatec.cn?part=3D2

