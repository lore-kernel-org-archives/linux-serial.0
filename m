Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F3643F0A0
	for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784374625; cv=none; b=GEOGhUvEdfwKSuUCuuVRo6Ddv+UJEj1hkBM7RZjDv6i4yoxPQstx/eR7c70wyTpmOdSJFd4eDmHh2RjYboyXLhlTyNyqUPI/vXf5/5iuZ9DKPp2sSDP9rPLLvIID23jUU0pihE2LQbp+JE5q5PNIn8DMo5kCz7Nk9r8CB0hV5AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784374625; c=relaxed/simple;
	bh=nQbxhuRSlQe+fmVcdHGPONres2HAjhXC2agmBNO5b8k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jUV6pjF1lwQcRmlPGTzOMCrtf5oOlnaexGtMsK/TCI+NWiqd5RYlkg3/a1i3rz+w9C1BFFKpRlKBOlL82ar0toyTHeyHpI9DPfdTvL6bZ1kOGaTyitVLaiCiLmSD+S1drSA6vlzzYDe3FefLDfk2cjkshC0/Tgu/xaO6r+I8fzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=cEvBJ9ra; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="cEvBJ9ra"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id C549A24002B
	for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 13:36:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1784374613;
	bh=LhpxnpbEO7DfeUBYJpJtwpHPn02MA2RmcTccr+dAujA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Autocrypt:OpenPGP:From;
	b=cEvBJ9raGcYG6Sr3Js8VxNBpfM7YBIoKfWZYyegmjc11ITnUyJutNp0nwdtzGxivl
	 RjYJ+NY4dRMfc6qsIqZynOayD9cO+ZfuSQWGPRzOuRjCWiBK+kuQ4XfOS+UzGshIlr
	 SMMRQmkjR8dfyx2xJCa5dtutarWb6pxNVoRVJQkJnBlEWN8TuGkpfTl5LVsQHRFebj
	 CxmtPeQG+zws0bNblFswalpEq4ROTd21wViUn8jJdg2krICDFue0HVXTcPpYaj+XVd
	 U9IZZ4OK9hm7tGJ9PoMVnzS7nGF9YwjyThkGGvpxwx8KTGhV7AmOrhQtFItb08ksID
	 5MvaD2o8CsXKQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4h2PrM0NYDz6tvk;
	Sat, 18 Jul 2026 13:36:51 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Subject: [PATCH 0/4] rust: serdev: trivial fixes
Date: Sat, 18 Jul 2026 11:36:53 +0000
Message-Id: <20260718-rust_serdev_fixes-v1-0-35433b6dce0f@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02NUQ6CMAxAr7L020WYUZSrGELYKFgThraDmBDub
 hU//OtL32sXEGRCgdIswDiT0BgV8p2BcGtij5ZaZXCZO2VFXlieJNUatTjXHb1Q7MU33bE75Jk
 rzqDdg/G70OxabSyTv2NIn0M/g/E56bO0aeAbQRvGYaBUmpZpRlZk3P/NVuVEsYdqXd8keCyGu
 AAAAA==
X-Change-ID: 20260717-rust_serdev_fixes-9baf5f310278
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-serial@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Markus Probst <markus.probst@posteo.de>, 
 kernel test robot <lkp@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=829;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=nQbxhuRSlQe+fmVcdHGPONres2HAjhXC2agmBNO5b8k=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqW2VS/C20oMZIweUErk2nnqDeYYGmuAf1vOB/3
 e21GkLXLtCJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaltlUhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9LbYw/8DoYEs5SpqtiLVraev8uRGG+E8fUw0lW
 iyPloIJrHsPDziePdwknsBkC6Kh6xhE1Mf6LRwVz5P+88Rw8ty2l3ORMltJhI6s5UEkJSUcQwAr
 WrVLfiWUNxhmgb88gNsBhIci7UjlF3ITtTDQS1Sa6L4og9Tkyy/NBg3nntnaUcPulMKkyQ0UWGw
 q6WczLstTlbO6ig/wn9SpQn6A+QIHjecs2LD6TxevY8qhy9sSy/3TQwCzwGY5FAW9ZfFwU+bWLd
 GbCjudqqlLgbRMqKSlQXUEOmSRK0ZXUh0yByX/z+ZbvIVFaghHbf9iOp8E/kRyfI98zeipgaO+6
 bflBgF8QueoZS3mDLHEEJxVwMACND1J8V4/jEtmauWs8iisvHdUuJ1sjlXyAKpmyBUNxGsUxKdH
 3LBKIHXHFQQqBajLKADnQo3jb5KYx1PZU76qJNwBQ3XQcMzx+SVfZcJCDTndzW4NzOtA+/UMxc1
 QHiHBZAxZIAy74MQioW3Bdg4bUrnuMUz05UllNJXcw7hfwcB6wJYGsLyHgIg6mlvaQ080/3R//w
 zXG5P69DSo+ClsvOZpDsotRC7eqGgTTbI/Y6Ff66CReF/U2Am18jGdYl017IAdSrApw2EyMIBst
 34iRodLbg/AmduQZ5Tfdn+D+HbDqItOIVTYvXVHulIvPDMGZhJhk=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Those are small fixes discovered by the kernel test robot and Gary Guo
after the serdev rust abstraction have already been merged.

This includes
- a fix for a documentation typo
- adding missing `#[inline]` attributes
- a small structual change for timeout

There is no urgency to merge this.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
Markus Probst (4):
      rust: serdev: fix typo in rustdoc
      rust: serdev: mark small functions as `#[inline]`
      rust: serdev: document `PrivateData::active`
      rust: serdev: remove `serdev::Timeout`

 rust/kernel/serdev.rs | 80 +++++++++++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 37 deletions(-)
---
base-commit: 25acf039a5dbb40b6865d9392e05be8e713a39f3
change-id: 20260717-rust_serdev_fixes-9baf5f310278

