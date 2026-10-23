Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762540;
	b=M0D9zXGiF91BGE5ufZLugmYVQqjc/lM+cjtfPE/7tO0MraP6IjlxcLTTdCdJ8F9YGE1H
	 mqGjMHvpars573FBGmNCV7ijSrOE/KbHpefrp4Xl2zJKA2S0GfGmh1YWTbcTIawKxEnKv
	 yhF+JntAaZsBaUGaa8eZr2KhH28Kbq6O0tK+6VLwfd7kODEnbNbH8fuBhGCNtISEoLIho
	 qENDgz/Tilu53N9Eur0OjQA7Rhm8FTzryoyb4C7LjS5pBmmeqDAXglg24G8pducTJ5bvo
	 mpg2o2ApFMRhOyuHieGmi+jbyVoM9NNdRVkKTWFHraxU8s/0AwtrShA1dAPEeRdx9ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762540;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2LEzXypWWnqQIj+ZCcWUcZRA9IQ3JRJZbnMYS0r01Fw=;
	b=c35gBBgjgrQI58wSgkIWvxZx1233nyhKJ1+qy99A0pQWH0RSXUdLrsgzWj6+1M26ql+4
	 7ZwlRGR8ZTkBIvz4Pj4glBsD3SvcdTNQOPI+dRW49N3XS8ONYb0udg5eOsou0Au7qazJh
	 GT2JmgaWEHWZPb4Kwqqibuhb2iTKKhtgz3peevp/0mFHvYGYA0lEh1+0VkoYEgWncsXxq
	 xtUjx8YQct5Q4XujNPHm5C+WXBZinaqmtcNs9wScKJg5cwWuCF6oI1kmrFO90KsXdeSD1
	 g6OlDwenWoAwu8Hvsa90jQVgGNxjXJPzXjQ8rnNaaSZ2GrHQ1MzOf3ZfSVtWCNqZSZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i1eZrXYZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE12606A31B
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i1eZrXYZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979581F01825;
	Fri, 23 Oct 2026 13:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792762539;
	bh=2LEzXypWWnqQIj+ZCcWUcZRA9IQ3JRJZbnMYS0r01Fw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i1eZrXYZTEIl9FwB1+54XM++EFWlIKfI1cg/gkf9qp5QTdF2eWxcns2BI8xr/x4O3
	 DkWysz9+WwLkYXiT9LFbxb7aAt5b2C8x7NrMs1PbfEKczCMT0sKZMo091cdTXGznnN
	 XhlPfR4IExa+3xA9/Q/hUjGI7x9+7RzRHXmYOBoJYsd/DrKXWzbwAA+7uqbVisDrPn
	 jdUFD7jP9+VRWHi5rmVVVGqzVEVMSV3EGAUmwClF/S7hAgBtcWdkndeSeT+znWS+4E
	 NRShojbLCL1MPd1BDF35AIeqvIYoikUdR6sEgvqyoNx9LKzN2odFTdBV3EKvhiA0i6
	 bN/Kl8lPJI1VA==
Message-ID: <sashiko-outbox-182825@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/7] sticon: Implement struct consw.con_unblank
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261023132448.115747-6-tzimmermann@suse.de>
References: <20261023132448.115747-1-tzimmermann@suse.de>
 <20261023132448.115747-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 13:35:39 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Implement con_unblank from struct consw. The new function is called
> sticon_unblank(). Remove the related code from sticon_blank().
>=20
> There is no display unblanking in sticon: only return true to redraw
> the console.
>=20
> v3:
> - take mode_switch from parameter
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023132448.1157=
47-1-tzimmermann@suse.de?part=3D5

