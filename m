Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795762661;
	b=VRAllKbuUFjspWdBJQ7AyGyOygra6rPdqMGwRGcqTo4eXtTH01s/eGeZggN4UyJKI2Qa
	 mUIMWLDR2+T2JDBBiUlQtbuBUqwGxNyjPKcJJ8skhz4Om+kTqinPca4K3fDMdVcZGarPn
	 OtCOOoQJjTCFqn6m8S/HAWt1ZOb7AcJDZ0mLchtaXnJQ5qoZpJIwvxQK6r92UDIWqv8Rd
	 YGrvq4stdopyUK8VjgvGd993HouAOIsQDjgeDDq/7iryKZI4/8YsI2V3bpECa7df5eLQF
	 SwT3WWWB00X5Ah50RtVBSsZfb2lNWXHe9LKfx+WnwDTXdkfE/YyII6/o7KTzyPsxWiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795762661;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2x1EJ8Hay4h6DdJ6zVqdfEjeTRPMO7/DtQG8EaiTMd4=;
	b=wf2HEWJqqrQ05mHrJp3lRYeSbOSi+B3oXCu4DwUlihjfmBFc6vg0wXaL4hxEPvVoe9jY
	 XSc4CiWzpx921QOunMvV4e60+9bEz7n2TKmfbN/BSr41XYsumKxO/+WY/GchxsyKLf8Oo
	 jayRAcnMBncewjL/jAYGp26PSay+JCy5k0L2XjlbzAeLvXYb1FtUthL66jvEY0uWesWN/
	 NTNoST+lfy1ttMOKKmJotj49Dt+Bid1nOp0Tx6AKN2nUV7LdyRG698LGgyhvTdKfJW53k
	 TA7pQ32qMbrN7vWEhjhDvwByvp9gSrDOIQtfVzjvoRm1TFhBCEL5/Q5p9ky7+QheMOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CdRZayBY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E313606A31C
	for <linux-serial@vger.kernel.org>; Fri, 27 Nov 2026 06:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CdRZayBY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68FF1F000C1;
	Fri, 27 Nov 2026 06:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795762660;
	bh=2x1EJ8Hay4h6DdJ6zVqdfEjeTRPMO7/DtQG8EaiTMd4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CdRZayBYBPVTxXhnePX9uD0cEc4IrIsbUr4udZ0dFKuGV4E185DGB4Y5nFmZWmQMW
	 kUMVLIzt+8GsnUXkHRCuMsI9BqQdUHTnAO3wc+fcJ4smveY512Kn57sHDU7Gc754zE
	 yv/AlyXKa8STcm4i3F4JeBf2o5RVi0hyknPVOB3pA/5PqAuW6FmVlXv15wo6t/fyuY
	 1qwpG3SF5qS2FjNKolA1Hwf8SSzuAZdQrFmfbGDOXQ0ixwoG4IFKZkBh7H98m6YRWo
	 D/l7XKWb9dkDfPRXuMimt7L3AWYIuYKwH4NpB/UqU5yygZckpBqZF+kDEAj4XlTuva
	 mvxgF+5mLtL7w==
Message-ID: <sashiko-outbox-236780@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 0/2] serial: 8250: Add Loongson-2K3000 UART support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Zhou" <zhoubinbin@loongson.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <cover.1795761142.git.zhoubinbin@loongson.cn>
References: <cover.1795761142.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 06:57:39 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 2-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795761142.gi=
t.zhoubinbin@loongson.cn
