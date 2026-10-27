Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793115674;
	b=k5N/4z9COgVJRUzKZ7sfKvoJTYy4aCPQMEEiCygxjZkW14JDcQzoO640rrxQPFfB5lXG
	 +53RPCrzrKbDlFv5VXbQeuDlfITyp9F0FFl1Is99whjHcKda+ATFxbAP/Y8CnREnss9s5
	 0v9QoQya4FcTtAuY0bsUZrM0/BlZ6avdOpwzCKE39yPGfzh+vkEbij+0EBWPIago1dhGD
	 0op5L6IjvX+pWpqapof8pwnefhZRwzNLWTymCm5ujhOnO+dfdTlWrOzDyLEo/mIi64AoI
	 AfaJdD27zFd6MYAOz20juCReE4vpNryRfItP7nZ42dqWjnmcr3i4RRgIbFsblWgW5EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115674;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WT0+zVDltIZK9upczhkcZtuh/1op6LuoDN8yJVLy6wg=;
	b=eYjO80hrb7MOimt+7eoNkN42kNHSHMgnTN61qBGc6dNHlKJfsSy9kExsip7uM5mhN8Ok
	 RmnJOqrdMANlaWGvuy5ytNGnbloT3P6hPO1xFTIsChNdIFewJb/ElWVPy30QNZJuhBTZ9
	 IaTO1mMWWan8Z7kX92vUgA/6elfjbM0hqO9xuM2IO+Or099Alz5YMVmvMpEN404UqS2ds
	 MFAc9MyzedxDuofZnGPoQ3wxdX9HCRP7vtTFbutljMBrY9+XKvXuZW7HYR5rO9uaP9jD4
	 xDjpQIkoOoKmnCVBE1lJkv/9L6apDiwOim3aeT4XIE65bG51VwHhoFpI7BLa5zER9sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PrU5Y+hV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7A4606A31E
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PrU5Y+hV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896A91F01828;
	Tue, 27 Oct 2026 15:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115673;
	bh=WT0+zVDltIZK9upczhkcZtuh/1op6LuoDN8yJVLy6wg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PrU5Y+hVwM8F3htVIEZIgZBxGFklpCBXLmTMcqz1GsmyDR9g7Hi9CC3qMGbKG2sn2
	 KjKtUtXug4cuxqGt4ZCPSOBmPjf5kF77jWr2ENF25FHMh4VjYcaXBYSiPM519XjglH
	 6YP5HaqlVD6fHM4qMIey0t45s6E6oaSrzHMv8zKBbL35WgrpnicXwRfRigNrQRHK6C
	 9d2Exh5cc7VtLCd12OocSi9sKEmOdyjKgsuNBlT8AaXzkYm/8vGmevHVvbk1hyo+Lc
	 6UAOy0B8wF+j/WMUSYKedEuJxSk3cW4TTtUknkv7lH0L/5E663lZVvn2RoqMgzGT0b
	 NAbVcGClkrPUA==
Message-ID: <sashiko-outbox-186859@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 06/18] dt-bindings: pinctrl: add Zhihe A210 pin
 controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-a210-scmi-v1-6-74d58ce85bd8@iscas.ac.cn>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-6-74d58ce85bd8@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 15:41:13 +0000
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
> Add bindings for the four A210 pad controllers. Describe the shared
> PERI3 SDIO mux, the per-pad bias controls and the optional pad
> controller reset.
>=20
> Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-a210-scmi-=
v1-0-74d58ce85bd8@iscas.ac.cn?part=3D6

