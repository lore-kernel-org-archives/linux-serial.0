Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202388;
	b=YsPAuR+7EzNs8LhOl4kxVl/tlWpNMmNICeEf/0XPzR1jT9STrGcfupEp3uYKdI7jh++8
	 SG/5mgtRlKa6yIv1eWKXr2EJ9JPVdb3UXW+2XbE3/Q8fQmn7sHkms7XldatBJXGbTPYRp
	 mRVaIamDU2rtvSi9uFFZSBy+2ezrFQ7CKsRCm0WMxHrjXS9yPkQJi/5+u9ESaiyNH4w0Y
	 ruKHHcUjUfSEYAPUdgBAD5EJKGqo+9PQGFot7seETj/apy+0IxAkvK2New7sr4DaoVjrx
	 kZMSRsiG80SYSkdXAl/OBojJnHoyi09wPh1c5HnWVNQ3YMpMg6hf3QsB1iuz9oWmNuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202388;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PjXp2rtozpA3KVe2gk/dqm2bA76QmIGMCE2MX12mOLQ=;
	b=w1KsC6VCwu1nsxdcv/FuZ5FPZN7vUhnGHAx2DoaKmzxXycgX9bub9+ckLcKsWlZwBMBg
	 i+RsZrPq0+IbHOZUda63TrV7WT0ROr5UpXW6Ae1IvFKYNWJW1+0R6UNTCv4EfXeEX9Bik
	 EyTYmTLFq7xvziFQyi/a3r6oC8LmdWLMd706zXwWAFeXAP9oaBm7ytkm8spwCw3JxeD9+
	 2HqBEj67vNFohY5EMkk2W6TZvgP9v9/5QWCeVhwKZFbGQmkJYEPLXlQaORx58DRDorX4D
	 N0LUdq8FKJBIJ3hdMGoXGXpVBj9mdQuN9Pqkrg/sd+Cs/OBsP2Wjd4YBuDI8UAmI51Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LJ7Md1mn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB708606A6EC
	for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 19:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LJ7Md1mn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B1B1F000C4;
	Fri, 20 Nov 2026 19:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795202387;
	bh=PjXp2rtozpA3KVe2gk/dqm2bA76QmIGMCE2MX12mOLQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LJ7Md1mn7hnTnRZpXny2JqxMz6Il4mwyqRncc/sLDs7rKBnaMr/iM0gVajh88/prr
	 RXGl8aZ//PdMCQYS0b97SqPeFFqDp+yPcEwnsWi9rIyik0X0e9wwjTJJzcGsghF1Ea
	 mh0NxFxar71kZATy5yfvOaLPFK8dCi5HBAjFFD3GUz+BVPYSytUsP+XjoIqHPJJjO/
	 kGdRsiX23qKDErWRNgQpnYqCz1aT6K9UhUsYV/4oXPJ5dxh8f2vGsYtKTzs6HOcZYN
	 h0BK3A+Uh+u12nQdYO99jk/gfWLeuCb7lMvjUCs/HNBGkMDzxFOUypgW18IPYO+xzP
	 lht30DBe+zdBg==
Message-ID: <sashiko-outbox-225910@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/13] riscv: dts: zhihe: add A210 module memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261121-a210-scmi-v4-10-4a795a0a9fc9@iscas.ac.cn>
References: <20261121-a210-scmi-v4-0-4a795a0a9fc9@iscas.ac.cn>
 <20261121-a210-scmi-v4-10-4a795a0a9fc9@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 19:19:46 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> Add the A210 module memory node with a default 4 GiB range for boot
> firmware to update with the detected capacity.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-a210-scmi-=
v4-0-4a795a0a9fc9@iscas.ac.cn?part=3D10

