Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793115667;
	b=iG77+mmimEi3fn9rS9H18wXGYatYhrGyao12zrvuVMASF5gm44J6s1PInF2fFyMqkl6n
	 yB7s18FwaHwTGPqm8El70taS/sfghAexMu74/RS97vI9853fB/di9g7zOfkHQNetKkW9R
	 nNuwH0EB9CV3prwSNidGhV30zdqvp8QZlflv71gM7HIu60B9Es8/2trG8xS9559iW0Jzd
	 4hiGUUOxLaz7ALB5iE32uOpM7Ivc7uJfafkKf5wjH8fkebhvhnQE2I4EP0PpBFTbozDt0
	 JfldqFNINqUkKI/KBA4nGgzfwFLYatXsqkUD7klmr5/xCsIdi1JinXXs3d3JG6AynGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115667;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/AEuSwTlqKeAyXl0+QLkw/nwBLxnwpv7hidmVznBBow=;
	b=RGOY4WE2u1GFe7T0VqSOBNNLs0jxz2BbxAB5fimaug7hIMIIhENj7Q+/07vWdnO+wgV/
	 pvdgwXs93Fry7EZj+anQIADUBH8dURtFrIYVugbmkWgZWIGHd642eHChfon1HiTcTl0rw
	 O4gTBv6YqIegqAVwkwUSWuWSBwlK8DIpy8xmBGFqeDpa7OnxKtSf2268Ij6oC134iHChB
	 b9gi2iv53MwgUauaarbiWlXwb4Qt6WnDpvdB7tcFFtwovt/ykgoSbdJHcgF0y86lmZr1t
	 3UE0OiPRcbf6/bp65a408rB5rAr2jKezaKur94t4QUWp4+wI/qWMu5QQvzhxwF7C6/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JK+39V6b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74679606A31B
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JK+39V6b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B341F01828;
	Tue, 27 Oct 2026 15:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115667;
	bh=/AEuSwTlqKeAyXl0+QLkw/nwBLxnwpv7hidmVznBBow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JK+39V6bPuD+W0fqRm0Ci1gYXDXqJuSopyKYqnMqs71PDNe+rIkZhFcFXB28WCk8F
	 YiQqm8ZROBP47h9e5GD2Iev+kgFuLQHslU51L7wnoK4IOJ68VMh99tMGesOccYSRkL
	 AP2x98h+Y4LPsa+lUeq3FpH4ZLIB8qSZa8DP5IFwQva/7eDmfRvjuHeiWsebQ0Zawo
	 oiD5ep7wrwy6L+wkbzrEl774COysCLln77pW+cla8NNigsOZ7DMlit59FTgX0PIr22
	 AQcwJcmhLxQi8Jo7y15z49nNoTXFb5W5L0VqlTd7QE9o0RlqsQYTw1xU4mQ1fF6tsK
	 /kS7HLkQEcyow==
Message-ID: <sashiko-outbox-186858@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 08/18] dt-bindings: interrupt-controller: add Zhihe
 A210 PLIC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-a210-scmi-v1-8-74d58ce85bd8@iscas.ac.cn>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-8-74d58ce85bd8@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 15:41:06 +0000
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
> Add the A210 PLIC compatible with the thead,c900-plic fallback.
>=20
> Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-a210-scmi-=
v1-0-74d58ce85bd8@iscas.ac.cn?part=3D8

