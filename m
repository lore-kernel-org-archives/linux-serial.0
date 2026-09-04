Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D7F351C35;
	Fri,  4 Sep 2026 06:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788504144; cv=none; b=mBFomjlAOeWGqs1j8lIcbh4ZUsWuFu/l36J/OU0RNDiBI3lXS9KS5hlUctfY4VfEKr+djSq9ezCJ6rH29wkplXBMDWrLqgDKvwctPTFOZ6rQrIhAbxhMlY3nCPmshYxbgbucoJsCDiL3O61q1E9lM3Ew3RlYYERVdgkvtH1sQ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788504144; c=relaxed/simple;
	bh=+nGsgIbTAk/WjhtC2Vpj61yk3fJlqabwtjZmx19gOS8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=evKsFRYIApoSOaH8szocRUEWiW6jGs7PRcWQyWW1ohUkPuESLpUXuZnef7p1frf07g9jY9tLIFDu2LtJmQTg3hVN7oJ7Xi2AUdkzO65NDKfD39UYMElOQNOdsjwN1n/CmHOjmXCOKfQiSTCgJzP9EEWiqStNrikJxP+AzIxwb8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2shuH2w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2shuH2w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71741F00A3D;
	Fri,  4 Sep 2026 06:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788504143;
	bh=+nGsgIbTAk/WjhtC2Vpj61yk3fJlqabwtjZmx19gOS8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e2shuH2wbXmA0NNCmymyh23zc36V4IyEXrnolpDkl5SaUC5c9naTlO0DcOOEoiV7C
	 y+j8vZ98WmsPupUIcHfS1Vmsq4yHi73QYNDRt7vB43qzTwMllzxEBhTCHGr4Id/1Dj
	 62BeRyPjoN7GyiZc6R+/fgk+ayup/VoDzXKyGsSK5fMJxglz3aLvk+UTUj2ipcT6k6
	 DmzvRP5ZTrH5EuHMyPKFSjGo7gGZXB505BiTwCn9KPXKMKdWRkZEVr9nPJ4tTJ/QqN
	 QMDk41YoarR3QoZOpsVsRSMbwufSrdv95BWVQGrSumlULCPz2PgIdGtaHfrLOCjNUU
	 PVO4dxDa1N7ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/13] dt-bindings: arm: add Ambarella CV75 platforms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: linux-serial@vger.kernel.org, lee@kernel.org, robh@kernel.org, mfd@lists.linux.dev, linux-clk@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260904-cv75-v5-v6-1-e918514cb3b1@ambarella.com>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-1-e918514cb3b1@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:42:22 +0000
Message-Id: <20260904064222.A71741F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Long Zhao <longzhao@ambarella.com>
>=20
> Add the Ambarella vendor prefix and CV75 EVK board compatible for the
> initial SoC bring-up.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-cv75-v5-v6=
-0-e918514cb3b1@ambarella.com?part=3D1

