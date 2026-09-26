Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E93535C684
	for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790444358; cv=none; b=proI6nimQkhwu1Yn5V15y5IX1Y9IUwVljYGVS/oCu4+ytRmGxRP28ilNgCeqZHrcT5UBkSTMpCmIU5tmatyUiP6BjEC2o4dJBds+mTnSfu23gMijVUTGGthMAp1qcu5ShnAsmrLbsDqUyP0Y9HNrkTFSDxIsS6XgwNq44YkFl0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790444358; c=relaxed/simple;
	bh=qmvBuryyQStNQpKGy8zOF30XuzNpkTZze2nW1e1h0J4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YnKIY2MN0p3yd6ceQeP+Pb7tU7gyaVQq0dKyTocHR6N7ImDwJ7KUJibZqk/f+Qw+x4IWhggOQa1osyqELd4m7LyjTcJzYGOWpi1KPBiQn7byAmiwXH861gvWbwhALJ/cSkT6p5X1ph2OFyv6cap9JMuWpqntHPrwAnovSci2fv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCmZ2Abm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCmZ2Abm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAD81F000FF;
	Sat, 26 Sep 2026 17:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790444357;
	bh=qmvBuryyQStNQpKGy8zOF30XuzNpkTZze2nW1e1h0J4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CCmZ2Abm25CSzHHj9iY+400Vqes8ih9pUiATQEU+RnptSMiukafK/vpJvFWMpIg27
	 XEkJ0v2Ra4oT647FBE642I06vzX1xja/W48/bE1Au5DTFes3BZnKfoKYVDgKuOdMSM
	 ZcdQdTgQmh8j/ZL88clI2tsGfp2KBGb7DpwjUTNfFkgKLh0HTmW6/nzNM1yGWBVLu0
	 +Ipqllk2fR7NpFGiyeokxABStPVlq6HK0JkIPLZBEzHD8oRNURZToiRQO5FANSGfFm
	 sD4Ynbs7aupA7APG/LjB6O0W5oiakFvrcS3Dv1VCOOA2j1YaeCnYNi7SP8KJr/8uIz
	 bPjw/eGKdWgxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] rust: add DropGuard KUnit test configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamed Osama" <mohamed.osama189110@gmail.com>
Cc: linux-serial@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20260926173315.56772-2-mohamed.osama189110@gmail.com>
References: <20260926173315.56772-1-mohamed.osama189110@gmail.com>
 <20260926173315.56772-2-mohamed.osama189110@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 17:39:16 +0000
Message-Id: <20260926173916.DDAD81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Add a KUnit configuration option for testing the Rust DropGuard API.
>=20
> The option follows the existing Rust KUnit test configuration pattern and
> defaults to KUNIT_ALL_TESTS.
>=20
> Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926173315.5677=
2-1-mohamed.osama189110@gmail.com?part=3D1

