Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649585;
	b=3Z3nNT8Hv/JQGkbWVjqtYOpqVwhc9xUp5dUh5ZHL4Fwq0Xp81SzF5oKK0vF5TLRdB+Dr
	 20TSjy013d/J4H3u9WKb0AlttlaRr48gACdG6Pcqt2WVuXInROlQmOcP0YYmbIpa6hOwj
	 cN2Cxhn3MEmvlZBDQXDkiHTSudES46VAum7/BUrz+Ify0fpNoHmyYJYSMrWTZwtYip7tI
	 vpb2YDGAZjxtx5ARYO/oKWpq1PegQv9GJF8r4WA4sqw0G5qXwu6LgweZ6dEiQpN412LQW
	 ASR12IlPBlqs+VYo8MMp96Fw2+ik2KtgKlVr1PVPzppsb1lqbG4O4Ac3hbmWfCdjY5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649585;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dFqB+yApplsqDPJkhhhMm0Dpn1Zi7N3joJcNblE0T5g=;
	b=aD6VwfupU0Z2DH8Zatt8EXPQ5E6IjKCvTmVxBb0N3u2vIPjBha5wFS3AhNHbAYZQcDqK
	 cse87nTsKiyddG6bwr5finkCeVJDOLEh3JL6aTy/5qhPPT8YjpKb1tH1qyvMcsPH4hFgw
	 fyNMHkDb/10WoL3mF170gR5NsWap7phR3PijZmiA6kgGvBep4SbRQO0MgFjXRlWx+qkxe
	 VpQj4XWL8VSpd1iPxZyZz8tu/8RD8ic/0FQZLSAMDXfy9hJHYEc3yGZDJRcP0Wn7KecAi
	 CtlLdPRWhX8VlJOsRoUnLJrtSyu1sYuvwyId4kZrGxKSBtphToP6iEnNVqRCD4cW41w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ewI1gAEH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DCB606A326
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ewI1gAEH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9481F00A16;
	Mon,  2 Nov 2026 19:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793649584;
	bh=dFqB+yApplsqDPJkhhhMm0Dpn1Zi7N3joJcNblE0T5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ewI1gAEHwYglQUZlrGxdh+YAWROKHbibdsylMoQYYxHTDO1j8oLlvYxbAj4teOLKt
	 2tsibBwFX1K9DerRjm47E3fbwTgygPX8qYvQ4cGkC+gRjtdBQ1Kbc6SB3di6Zhfok0
	 PCSQL6PtlavMswPC/Og0kcBYsNsQ3+OpK8DrMLQ8hmJZmeqVXTg8iNJtqFLs5ImXHA
	 5Mr1oKqbXJw1UMSrAhx4gUYa2fFRr+eyblCMYLD97bVhcL6CCWovGTXBeWGHS5q69d
	 n+dZN4E3ICI9XiJkrfnLd56DZ/ixAEgFTqpPJo4XlWaR9YkpUAQLpzfT7hO3X4YP5N
	 2AfEdkcn5sOPQ==
Message-ID: <sashiko-outbox-194042@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 06/17] dt-bindings: pinctrl: add Zhihe A210 pin
 controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-a210-scmi-v3-6-ee6b31580808@iscas.ac.cn>
References: <20261103-a210-scmi-v3-0-ee6b31580808@iscas.ac.cn>
 <20261103-a210-scmi-v3-6-ee6b31580808@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 19:59:42 +0000
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
> Add a binding for the AON, PERI1 and PERI2 pad controllers of the Zhihe
> A210. Every pad is muxed and configured on its own. Functions of the same
> kind share one name unless a pad can select more than one instance of
> them, as with the UARTs.
>=20
> Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-a210-scmi-=
v3-0-ee6b31580808@iscas.ac.cn?part=3D6

