Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301112;
	b=OCAIDy/Lk0nonotwbj0q4S6Mkb5M+TRbcGqcjcKMtpLwk9q00H6qcESb31kM+HtMJRMQ
	 L3h8xs8M8xt06JoZfC8qWIiOmDuE7uDT7cY9063iHhklLAWYAkcTVV+qq0PEfAx38DMaU
	 S1BH9rG2wKziwsSiwREf1Tn0vvjMimYv+m6GdWp1CH7dbJbdRvCuHiDuDxlli8p6l/kIZ
	 j7NwwrUUB7dYR7tpj08KIe0qFOZHDEo7C/gM5Z+nM0Or5nwIGna36sUghDh/kVlWB4142
	 g7sD8kLnQzSDhr8H+oQIOFemI1yZcHsCdVXRLfouAkl5tZJUHHk4oyQqi5j76yB9XTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301112;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=23XxXEOoN91oSzeyZVq34L0FddNyJS4mLkfKW/IiXfA=;
	b=QbUhvtU+k08CvIRohL1Ws/X2SnO4lR3/ewxG3vYlUk00LVDrGFZoqHd/cvNLTEZo7lvi
	 VfujRDdjUp4+V/mllcm0q9zrU+MPwBxNfezYA94WQnu2tzswL19Lb6kmMR4ZUKENZKPyE
	 HgjgC02lC95PWfn5Lz1yN0FA6oyEy/dCgMltLXDYHL+7fREIDsIFNGXBFPmQDXgY49Nhh
	 iMFZI1tssL7shdC0YBuXV+xY0yq/mzd1snt8+Ex+uA1eSqAQFM5VM01GOBsUZe3tFzvAK
	 L6uVqeH+5CILWK0Om6CMqS7vywCNtbgRotFR2d+enha//9R1lCOCC98ZbOCztxXOwUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ISOyaxbY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A509C606A31A
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ISOyaxbY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2732B1F01816;
	Thu, 29 Oct 2026 19:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793301111;
	bh=23XxXEOoN91oSzeyZVq34L0FddNyJS4mLkfKW/IiXfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ISOyaxbYwZPGjL1XJ8i+39SQgOUQEZPHjYBom70SmOuL6yNErsqrZm1HYIvVFxgnP
	 5IBeghjU9gdlShUyF3eyPG0kUq3tf2HkfXrEgQWi/QmcPPdgEvJg0cbV4ItCHyLyq+
	 REzERoysb/8WRxHzKmvfz+Y+SPwU1hueRkMjSRkVElVqNWqkPk4r8bl6SOsGXXmu2H
	 4m4TCN5ztL8hIUCpi9c95UlS6aLUKzqsPzGncBpv3zSqSLPnpHsUwycIkmOuxYAWGT
	 mlgL/zZJIn+d+g7YOjeytAj7PTe5m0XCKMnuKlRB0nRct280MBWDlkx4qqNsx5wllV
	 +cJz5e9hKeAqQ==
Message-ID: <sashiko-outbox-189851@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/8] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner H616
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-submit-h616-uart-fifo-v1-v5-3-53b433aebbf8@gmail.com>
References: <20261029-submit-h616-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com>
 <20261029-submit-h616-uart-fifo-v1-v5-3-53b433aebbf8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 19:11:50 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The H616 UART has 256-byte transmit and receive FIFOs, but its DesignWare
> component parameter register does not report the FIFO depth. Its optional
> register layout also differs from the generic DesignWare integration.
>=20
> Add a specific compatible to identify this fixed configuration, retaining
> snps,dw-apb-uart as a fallback.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-submit-h61=
6-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com?part=3D3

