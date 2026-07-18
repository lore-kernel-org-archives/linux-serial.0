Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98409335BA
	for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784378872; cv=none; b=Plz/kTTSgWKQJjLPZbvG2HhwTgZwY5BLHHkV62C0zFvlDDS4qaSD5Jkbvc6dwozJCpBvhXcTQmVaWeOBFhMkZhnc9aPPHI0lZAYR6RhoIXdkMeoUOSxQnqw+7LtpfzHeILinDJ2BrVZcZqf2wMOfJvLB5/SJWIgCl4RZ5texowk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784378872; c=relaxed/simple;
	bh=+DglkG3f/oa2ZGnDkZHurCMH7odPQbvwJv1U9ofUel4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cYXJ1OigRN+Dy2/BhibKTAbLOcfsN4FtcoF71U8rM5GSTm3VjIX82fyPXFd8lyOjjCYwtm3ghcir8pNE6DlZlrt7LH5YywXA9DEOq5hgIvfkxUIJZwO3UsyHkQZrWUpkf7lE4tc2kzZp0B/C8gfMBRn7eqmz2csPIQIz7+8Cj0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=kwLNYbGn; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="kwLNYbGn"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id E9B3E240101
	for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 14:47:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1784378868;
	bh=fjzyqMHqJCpWgCPY606AraCobo3dyLkKwD8V5CQfQK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=kwLNYbGnuMqRzmQRRP/l8EKiIwbrpnV1ZtgTUPgdhrrYqv5mprxg1mQ6otz/pLdGX
	 4nUyNPyb1MYBFxu7rRvlBfgB7Gw2cE3gEoPBv3FlPPfw1eHWmdoqubLCpp2+Hw8ptK
	 OSp5eP028SqOf6pB/0LRy4wyo5xED9an/CvHxtyS91oLWsRKgCZt1c00W56AfiWwQt
	 mJvnqkK81qinCqi0XcXRIr1aKzh1SZyJUf0JVl7SuN9S9839L0RkCxFs+Xceu/c6c9
	 68WLxLi3/IaLLMgprhS1/aMtUImPYfypn54ytDbm7UAsaFCUY94fEB9Km/P1z5faJr
	 Zpp7+IN7xd+NQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4h2RQB73cMz6tvs;
	Sat, 18 Jul 2026 14:47:46 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sat, 18 Jul 2026 12:47:47 +0000
Subject: [PATCH v2 1/4] rust: serdev: fix typo in rustdoc
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-rust_serdev_fixes-v2-1-e5214e03de13@posteo.de>
References: <20260718-rust_serdev_fixes-v2-0-e5214e03de13@posteo.de>
In-Reply-To: <20260718-rust_serdev_fixes-v2-0-e5214e03de13@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=+DglkG3f/oa2ZGnDkZHurCMH7odPQbvwJv1U9ofUel4=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqW3XwpDTocvu2ZnGz9Qp6r/9ZZMjjqKAfyC5ul
 wdU7oz0osOJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCalt18BsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9KWPQ/5AXlhQVUYscP5A+P3IyjLyUN2tsgklco
 l4yPdfCkFmz4kha4Bvtp+HoX5lXip1uwDBUMl8IPEpJSEe0Qj1TXlWzmlNcULSlCY4uI84OcT9Z
 BgeHPHO6gGJw6+gA16psZj0WH+tQXxwjo+vMKqkPXF2GMubbTX/lXyYvSl3HArD3F6hToj9OEbb
 sWjX99Wv4qaH3BI9KQbs9zjAqITzukjX4Zw0j+cw1G58XuPDDYIYicBHS/hfd5KUAnwZiCI5jXi
 kPkQZUGL5fpDZod1k3J6wz6VHDbmIQ8WWcnIEnGD0fr4y9nip3ya7qH4qiyBa02CwhWgbmSkWfN
 YC9wOBksXL57p4NHyQ6MGyJJYq2R3MBZ55SCJ/ceEOBrtNdVJTjVwlDXiPwr/RP3GG5le/Q9fQS
 d9wnrTz+fwU244fo1iDW7tcgQcUQkTj4XL2I369M9DxG8EuTqjlhxXK7uTQAPUaQ5BB5uaKKIlU
 oDtv9UGPX42jirhbvlQKjPx98Fz/wRVDaicMYVTFcgbprLnesuu4rvlzxrFN8CF0aVL7t9Bn/Fi
 xR9NbHxeFuznx9gp2pSO+kENxuWuc9xXgX+xtYkVQZGm91qM2iLp7HpKP1G3Sj+msgo2cec3eHK
 F70rbcFjW9NZAyXkOjSdCZ0ahpGXazOFiFn2sSEJhQf3+JecwpLM=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Fix trivial typo

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202607172113.hLDQgD4l-lkp@intel.com/
Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 rust/kernel/serdev.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
index 0ffcef1849d2..47ca57966abf 100644
--- a/rust/kernel/serdev.rs
+++ b/rust/kernel/serdev.rs
@@ -515,7 +515,7 @@ pub fn write_all(&self, data: &[u8], timeout: Timeout) -> Result<usize> {
     /// [`Device::write_all`].
     ///
     /// Note that any accepted data has only been buffered by the controller. Use
-    /// [ Device::wait_until_sent`] to make sure the controller write buffer has actually been
+    /// [`Device::wait_until_sent`] to make sure the controller write buffer has actually been
     /// emptied.
     ///
     /// Returns the number of bytes written (less than `data.len()` if not enough room in the

-- 
2.54.0

