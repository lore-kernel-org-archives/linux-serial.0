Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649112;
	b=kPxoqycXZqFB0ByPer0KmFff8BoHGzl6Mcv7IHCAZPiDMB5+TAjcH6M+xk0G68bFNE6G
	 CeN3OgHsVQ1Wl6wNVCznhhcliiI8G4dhagH7cy/KIp28vyNUNoMj2ilT3MnzxGYjwv51D
	 ku+Zk75ITs8rMRHlGthoonsxT8I4w8DzMF7QnQYSfN62A1CqWdUdn0gRg7gbM+O3vZGHA
	 R8ZfpajbpQyukP74KKV3rYjf0hpWshQsA3KalYYKUvNJ9enPzUr4MSyxdJS4IWPrlDELf
	 EL/CmKfL43oU728sbT5ZeOfNtXKs0Dc+DlGqa1BbcDoHW8CBU4jPLp1IettuNe1OOCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649112;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uFYFEYunEH7ogRztWAlBHTE6PELYqaCujszRLeCGDyo=;
	b=xVhdBJ3dJVRn8qscgmBJTRspINoXXptmuFpKAMq/9cbIwnhKJMFS+iKvh/TFChvuo5nT
	 Q8BLg17xgOQJKIu3DRkfNejsAWn9ZKnysf9dY3iQn5Vb0eGyDgMLVVv5nuzDQmu18Bdiw
	 Fq/hFMOa3uJDpLnXfi4CVao748QnwoJuticiJHhyYC3OOEBol6+5NO0Df44mOP9Y/9App
	 JPd68gV3s/6mrJRWWArr51qUl1dXJ3aD6AqHUOgb6nJyMMiJ/mrYnVj959A9HbI5BL3dF
	 GJlw6+s8XRXg+LDu7oRzHmx8RCnNbNfRYghloPRfPXDdCNikwagdT6p42dTaaJzdryQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l6Vs1tJm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C29606A324
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l6Vs1tJm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9025F1F00A16;
	Mon,  2 Nov 2026 19:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793649111;
	bh=uFYFEYunEH7ogRztWAlBHTE6PELYqaCujszRLeCGDyo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l6Vs1tJmNA0nXg2/EQ1oLVjcoLE73aD/m3hJbjGygLveq6n0jKhTm5bWMtKd3obM3
	 HyOT7ASzALOJEM0V95R/70dWo2j/28QU4L91OO85QcyvEMRDci2rW3iGET6ErBsQDT
	 P0Dlz1rUlRAzRpDdZW9v9gZ5PHS3avmgHNdtu9lv+yAsy/tqBGmy0vGYR5sQrQ4Zmn
	 QBtF9odNwLweP4e6iF5IFI6/ceFT2eyVP/hs2ztDGV94CdfsDSUU/ONPhxMm5IPzyt
	 7hsZK9ISLpY57as8S0d6hgkIVKy9a02tO1qJ3ZjVVek/aiqhLH7SNBg9zOFrScP0mu
	 X/obPD5RUFvWw==
Message-ID: <sashiko-outbox-194031@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 04/17] dt-bindings: mailbox: add Zhihe A210 AP to
 E902 mailbox
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-a210-scmi-v3-4-ee6b31580808@iscas.ac.cn>
References: <20261103-a210-scmi-v3-0-ee6b31580808@iscas.ac.cn>
 <20261103-a210-scmi-v3-4-ee6b31580808@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 19:51:50 +0000
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
> The Zhihe A210 has an E902 management core next to its application
> processors. Each side owns a mailbox block and rings the other side by
> writing to its slice of the other side's mailbox.
>=20
> The application processors ring E902 through their slice of the E902
> mailbox. E902 rings back through the application processor mailbox and
> writes INFO0 or INFO1 there to say which of its two doorbells it rang.
> The doorbells carry no data, and clients such as SCMI keep their
> messages in shared memory.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-a210-scmi-=
v3-0-ee6b31580808@iscas.ac.cn?part=3D4

