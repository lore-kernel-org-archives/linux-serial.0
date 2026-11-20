Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202352;
	b=xRqMmednq4jwzjOyZ1LWSBGxY0eDRPPq4anyQwBI6QhlxTLdJBabwmv70hmSCyx5oHfX
	 4PZ2ohWhCw5g59/Kqp+CcaBDav3PYvfFIH5CvYPDNffAjkzvKTveqYLoCkCVhEklXAFuz
	 6wt7+AQ6VH1pOGqpcGh000I671G1dqC9XAgq1g9Yrf6kURooWVfKiI195dbzYtSXrVyL6
	 hGHysSwJdWK7TEYjkOscoLlsxSO+W4HiwNYUvzrPdJyLJ+W+A0Fd+cXt8rGsspxroz3p4
	 HHpwhRlTzGEE+5rhQff48iW5hqcpRDuRw5LTtKQDOqJD/JIqJh4TXujoOaAW2OB5fGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202352;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tPnlmzk18B99VlCU8BuBkpse5l//seCIy+RnFiHIbtM=;
	b=RE6ZS75PSkdQM2Yrto5ashHH3Vyozq18mpjEBme4NbnpA+DXRRyK35d7L6LoLJGG4NYF
	 7LNx37KCWWSoTO469rnfv6yFT1QbewbqKoxiMm1mdjUQn3eDnfwHa0Spdcd5gFTySmgsH
	 YGj3V0HC8SnVe1wiOUCzkns3je1QxQj5QtQLM4Qh1UZEw3wLt6SDIgcqFPoaFlQxmvH43
	 WNVG78a7TBjri9GDJhKAduZNFlK9BRmZBodkoPbARzw2gsIrFrz/aWI08anQNnNqaGUXC
	 YgoBidAGwrcaSzElE4r+D0wHHCdm2cOIUZvQjf/tFEgDIUorCv60cydGzg+GsrOgPQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b73XDzO9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C525606A33A
	for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 19:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b73XDzO9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215A01F000CA;
	Fri, 20 Nov 2026 19:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795202351;
	bh=tPnlmzk18B99VlCU8BuBkpse5l//seCIy+RnFiHIbtM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b73XDzO9bjpPFU1pp1v9EeAsln0jSX5x9AgFFvblo/821tTsCxn7amY/Dtp096qm8
	 +aT103r2j4s+IYp3rzFJTsvYL70lMn/2Cny8WE7VKkOvm4Id8w61QYAdmx8eY8r200
	 0r6h/XEWfs9s9F70fkvgLyoXNqNdBwVn5C4pbfapKOCxVPClk9Uh6ro7mkinkMIP22
	 nPLDCbrx/spwMRblGvYKtPhJzd3ILkiE2/57f/bdDn5vFpvQxSBjCzAavEERcyx7hJ
	 qXWEzWwibFs9JFk4GBrLeLDlzyyMUj4dS99e5IUB7gY9y98TK2dy33KAdzrT8QBpxD
	 yjJjAM9+k2E+A==
Message-ID: <sashiko-outbox-225909@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/13] riscv: dts: zhihe: add A210 UARTs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261121-a210-scmi-v4-9-4a795a0a9fc9@iscas.ac.cn>
References: <20261121-a210-scmi-v4-0-4a795a0a9fc9@iscas.ac.cn>
 <20261121-a210-scmi-v4-9-4a795a0a9fc9@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 19:19:10 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-a210-scmi-=
v4-0-4a795a0a9fc9@iscas.ac.cn?part=3D9

