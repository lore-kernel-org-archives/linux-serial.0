Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142485;
	b=VxubWqUxcURJGt4qNy7pF28WUgZ8V+5kTLnXPomWnfgH+NhfY4CRmOUEbOtjCLyBUgcF
	 weg0NsZgzaepwiPxmJuyymmmHqCbuVFnzwBolWwqfbogID1ylrSFXUkanezzfOgq6MFQ8
	 7Wa3pftekC7gq1Sj1fOZOepvUgmoL+G3h1MM0kIvpodiGMsoPagZh8qWdstpVvt/whBLp
	 pPd8DAUAXqeu+/G4hL/H6QOK5Mzl+dT9EuntVe9ecssSBbkQMYSjaEj7d+fLMIKJ4hGiY
	 SOU6eSo9FU8p4PbkIlXImUc7PuT92OSeeT4YHc625Z79Da+O4A0uPHKffmaf6d+NDNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142485;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EGVsund9v98NtwB6q4ISMIttpAxfNO1iyvgNFH7luiI=;
	b=DQCJVwqEji/e0qpSJrCFsQUCjl8X+K/C0qiafvjEcZfcFLmcohae/ONaZMIEN1Dsr6eS
	 O6PNRtOW7rMuS7JDpUUGP9HSsKgPWfaK9eeTD0stB7VMvrPb3ixtQCK04D4u36zfS5rGf
	 to8C40JoBDvxljhxK/qrlGeqS04jsToSzZIpdqaF0M6oc63tQ5B5krT8zL3Hwm30S7mRS
	 RjSV4AGnnB/kfJdfq9P7SoPJ9PemLqfWxD8l6rUmSpsHe/yGTFuRHiMAo0nX7BANsE/vC
	 vmwjmuBa7Uinz9RYb/WJu3uHVPy3b1W/FUQ6gRii9dNLQ41MG4Db5MOp0SWU55/rZJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R89zF5+i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224CE606A321
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 23:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R89zF5+i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1B31F031E0;
	Tue, 27 Oct 2026 23:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793142484;
	bh=EGVsund9v98NtwB6q4ISMIttpAxfNO1iyvgNFH7luiI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R89zF5+iJr9uH3DmkkVFJYARjPfebCRcJNxtRG/qvcF5zoRCiafMo7vGNb3r1TWwP
	 BfxgH3edtFsBbi2yR2I3E9W1X1PxTDdMvN7mkPUu7EiVlXf1aJPcT+EGk/Q2fVbs+5
	 MPU44ptUB4h+jkrORIIh/vrpuDIRxJprfdajNt3YwT0i0ljHdKQd70Qnz+mDz2EQtn
	 lzkp4IhVzLiwCUqXEC0Ng1/e74dSSsIPDkbx02BZUGnKbczkdU/0BPmDlXAfeA5kzs
	 xXTjr7uYhMVnPu0d0eezbi38K8uj6N5kWULPFfcfLrPwFehKF3fxM6DlZpjreNSHph
	 EwIWq1bKv/OsA==
Message-ID: <sashiko-outbox-187191@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] serial: 8250_dw: select port setup through
 platform data
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-submit-h616-uart-fifo-v1-v4-1-d37e018fd0a6@gmail.com>
References: <20261027-submit-h616-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com>
 <20261027-submit-h616-uart-fifo-v1-v4-1-d37e018fd0a6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 23:08:04 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Select feature discovery and DMA attachment through a platform-data setup
> callback. The generic callback probes the optional registers and attaches
> DMA when a FIFO size is available. Integrations with a fixed configuration
> can supply their own setup before the port is registered.
>=20
> Replace skip_autocfg with the Octeon setup selection. On 64-bit builds,
> Octeon continues to skip optional-register probing while retaining its DMA
> setup; on 32-bit builds it retains the generic setup. Keep generic setup
> for devices without matched platform data as well.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-submit-h61=
6-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com?part=3D1

