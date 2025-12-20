Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D4530FF2B
	for <linux-serial@vger.kernel.org>; Sat, 20 Dec 2025 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766256253; cv=none; b=S7mXMaTG4NyzC0GnN9hHf/pqREvxiwh4t8WlxLUY/kkPr6C2Gr+DtwigasDNU9jwYUwhGydaSv6/z+hdPfbejfh41PyDKzW9jeucqOhQDuTIC9i3qbX3ecmUkiUBkSCUlfa3Wrsaw0IK4vNKPczDPhGYYgceH6MQBgcML8lTGuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766256253; c=relaxed/simple;
	bh=qxps9LuzVhP3NZF39g3++QSsoAR3m1O2TDzQHDWwPzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gK8Gqpl0CRV6FH0euKMWebhO8ep30YuyDli3JOM2dIeRH58oUF9L00LhiqjGMmQ2QSKZe3MMGoIAfA2l70Ki3mOONCjpgaA/AW5CvqM8YUGDM7St8JYWmaVsI9VOEQRlrvOrk3dM2ggM7i0jq7LhrP8tokte8/dNLZMLp5WNwbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=CbqzRR1Y; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="CbqzRR1Y"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 7A76A24002D
	for <linux-serial@vger.kernel.org>; Sat, 20 Dec 2025 19:44:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1766256249; bh=Mb0ZptlxWRqHBcmO8uHkQKeAT+IaQ7jXYG7pQmabGJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=CbqzRR1YUr8sr6v6Sf4Ne1IZzp3QSnmmdaXWeaMBOUCySNe4xCIQLpXzJ1zwO8fD/
	 d/qq7S6hiMMulGzoBSYuoJE3IeSqAPBU1wh99e728fTL2nsjoTicQwnCxFAw2r6RiI
	 qhIRGu3uKF7UgFo7hKS3cL7pmfntjOWUuoifSJExKUA+caTtOykt84djZVFs4cGc/c
	 6a2qlA1mnPmya57kmyC+xLEFWNkRlvgaz++tAJqUp9axfwH1Al1d5LE0aUTr4URPKJ
	 nyEy0h4mDSsxcPmnk188tBxKSkPqTQdMhyoSHlHzX04j20rTxHhPMA35go8Va7SWjm
	 Ip2lvzp78Qjew==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dYYGH68Hcz9rxB;
	Sat, 20 Dec 2025 19:44:07 +0100 (CET)
From: Markus Probst <markus.probst@posteo.de>
Date: Sat, 20 Dec 2025 18:44:08 +0000
Subject: [PATCH RFC 4/4] rust: Add serdev rust abstractions to MAINTAINERS
 file
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251220-rust_serdev-v1-4-e44645767621@posteo.de>
References: <20251220-rust_serdev-v1-0-e44645767621@posteo.de>
In-Reply-To: <20251220-rust_serdev-v1-0-e44645767621@posteo.de>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Kari Argillander <kari.argillander@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=644;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=qxps9LuzVhP3NZF39g3++QSsoAR3m1O2TDzQHDWwPzU=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBpRu5yYWWsv4r3tm94HeA/rQML2zdP3U9weq9Wp
 B2H9L+l3SGJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaUbuchsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQNHYf+OetQ9JTBw//aBbF+t0bjgpMyeOfm3ho1wXIXVz8v6v
 sHSAnsiZ3Fn+lCdEJjyeTl6E+h0GXHEs3/RGKcdaSeid5WPrhZbzMm/s/Al/SqFigKjxKX3nuJt
 /0M9lEqJ4mimTYFWnEf4Wx4aH7iqYf/1t38emdKXTNEKEU4QdU0YDcJOyCD3EWCxtUVUQkFneEn
 F6r6+ms7SEqAbHloXTg0azMs7W+EIa3mmQifnYy37Bhg46kk+GwzVtDZN/Ebjm6ICVgJRuUoq63
 wKVNHeq8vOhcjMugsoslQoe/utANXJBB6xlEbGCz9bJo/BEamfdj1VnlqTJ2ntvNVnFXlyO/sbX
 kPPLy0aECuMi4CreZi0gP+L89DsTmE78pLARNdGeWcyEIGOQOZErY4S4u0kC2SCWDPGz4ZvGwY5
 /YoPofQajql4tpeu285JGSw0ZHJ31fGEsGbVssa1fU3gIOQ+BfVjQ2wKLIC0laQsquhNYRAyhML
 u144sdxM0j/dJm1b8IMXVrRnufAioa/oUbGPSUmVcNwmXjf33fxKDjf7GR/6jHfuDUgQ1SUSkMW
 g7Y+fDqMlet0Z4Vx4fVShs0OsruaVUu6imxNY4TkobwBd8CJoKx9O18czTOewyS/tnJoa9Oc1DI
 +TSFLvZmhJeUGwr4cR2re4FeaKHVsQVim/Vzpq2GCpmJXunTx4Es=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Adds files related to the serial device bus rust abstractions to the
MAINTAINERS file.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9d..929b1c534173 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23718,6 +23718,9 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/serial/serial.yaml
 F:	drivers/tty/serdev/
 F:	include/linux/serdev.h
+F:	rust/helpers/serdev.c
+F:	rust/kernel/serdev.rs
+F:	samples/rust/rust_driver_serdev.rs
 
 SERIAL IR RECEIVER
 M:	Sean Young <sean@mess.org>

-- 
2.51.2

