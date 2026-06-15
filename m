Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5442A1C861D
	for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 00:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781484031; cv=none; b=LbD/iIxcgQBYXMd6PrP6Y8knYU2o6JDoNyV4B9CgY8zhfv3aI88EhdG1ArLj0tk01hujcCrk/X/n8g7ebzFTGoFx9uKGr4FwfPm+B2DgQUqZ6B0hwonVKynjvgYccOD35FxbWBk3Pm8efpU2blVWVBF4oX9QudCWBzbX80qqEjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781484031; c=relaxed/simple;
	bh=D/a7GLwP9RCZ87p4FGNNSBIQmAsgLi2QemlLiAUnZdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SxGRDUbeGXYRF6RdceF9ztntaK8qqgMtWYAW0+Ll5ciu4xtlcNHWvbD+S2KUsvO2wViLWDCi9ZBUbh1LOSpK4lT8FJfHb8GMfErW5R6yj8nnR3G/vMoCxbMV3IL2JaT7lPD1aZd2pA+00zx+hUhX7DGo/psMkWnjoD4Jamx7f9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=HcvW1N39; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="HcvW1N39"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id D2343240101
	for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 02:40:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1781484022; bh=SFw/cV4xrZFmVY2n9Jv3ao6mzSO+0cbe1qwtPHSZl60=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=HcvW1N39AOz9J4Lef18/FP39Wme8T89OkyUhJdHr9jnNw0mh3+fs8qdLijASI3LTo
	 P/CIpSVp4WrP1TWyc7X/PzH8HGUaehzxm1SLKozQxbdBwKoSUsgkVIC3R9j/yo5qx4
	 0Wd29tmcmPDm07+JNS6FMpmgdSlNDroL+pNQUodZwQXq8GSVb1SqK572AbCBCIZThp
	 pYArgUtG3//z67nUiyA5nRSGbT0BSZybs8+daAmEav0kqISwfvUW//OaCyLJgy1Sqv
	 N9ZwSdQcTccVtxfLqpNkLzvW8Q++j5qP0Sf0RQAeBmFNTsQZXL6rtDKwnNLUX92Eno
	 MXsFp0LOMkUmw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gdrr53ffzz6tsb;
	Mon, 15 Jun 2026 02:40:21 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Mon, 15 Jun 2026 00:40:22 +0000
Subject: [PATCH v3 2/2] ACPI: SPCR: Support UART clock frequency field
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-acpi_spcr-v3-2-9a59ebad74ea@posteo.de>
References: <20260615-acpi_spcr-v3-0-9a59ebad74ea@posteo.de>
In-Reply-To: <20260615-acpi_spcr-v3-0-9a59ebad74ea@posteo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-acpi@vger.kernel.org, Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1017;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=D/a7GLwP9RCZ87p4FGNNSBIQmAsgLi2QemlLiAUnZdE=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqL0nz7jORAdHB4SxDPhiz8vbmYF9wiqgK5x+N9
 2bIuCYl9UCJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCai9J8xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9I5+Q//dMx746B8MjxrK0Db30vYOZYJtH/U8Rw
 y1j+kGcAIYrV8JusA98CHLTe6At8Ht9k6pzkpUZqu/dTT86tbz1pB6xYa6gFKM1aNuBNFA5MxWz
 zOE7MDJi2UcKvVnQQ1//ly/JI2vTqel4dIf/ugUTUEtYj9XXuPUGw8k3ku1PsSROX0mMlQrPWc+
 P/Wq+S2t5rOWsykUQNsIgegg76y82/zDdmtEQphV60icwlH2Y/k+YICe4RiC8fJeEcWi9GMaJ1b
 LNyvTTMzTxDOO1MjFm7Pf5b7X4nq/9NPZMieoxGbzW9XyLjjlwkL7FB0mPrm6KVeTdjNbD4ZpSX
 idnoP1O/NR5dwxSSmyoFgbhKmgf14yIzTsVsATbeOZ3spTbBnJIKguXBM2Quf5/E69konidHvZq
 Z2JLPkS5Jww2DzyMzrBNdYHUZVXR7SF5MfDu8sXAt7EtiZHKaQiJNPUwKggdeXzR/GGJsP1qs/z
 PkMT+9rWbAvNPIA+ZTvRdDmbMewxSy1wFnahxG077Q1sKymr/e7Ns9+LPUq5QL6jSZdS3Q8Yb+W
 brQLN1Jp20kWTUkvm1gyj7UiOdmqQgUHxeROhnxQ4H2sODS3AR2RdVWJcEYBSF9MGgvUo91YL6E
 7uoxR5Uy3cRQk0J5Rxs2YyesO/QHcai3Mj02vVoiSvuH+s8bT7Bs=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=xsFNBGiDvXgBEADAXUceKafpl46S35UmDh2wRvvx+UfZbcTjeQOlSwKP7YVJ4JOZrVs93qReNLkO
  WguIqPBxR9blQ4nyYrqSCV+MMw/3ifyXIm6Pw2YRUDg+WTEOjTixRCoWDgUj1nOsvJ9tVAm76Ww+
  /pAnepVRafMID0rqEfD9oGv1YrfpeFJhyE2zUw3SyyNLIKWD6QeLRhKQRbSnsXhGLFBXCqt9k5JA
  RhgQof9zvztcCVlT5KVvuyfC4H+HzeGmu9201BVyihJwKdcKPq+n/aY5FUVxNTgtI9f8wIbmfAja
  oT1pjXSp+dszakA98fhONM98pOq723o/1ZGMZukyXFfsDGtA3BB79HoopHKujLGWAGskzClwTjRQ
  xBqxh/U/lL1pc+0xPWikTNCmtziCOvv0KA0arDOMQlyFvImzX6oGVgE4ksKQYbMZ3Ikw6L1Rv1J+
  FvN0aNwOKgL2ztBRYscUGcQvA0Zo1fGCAn/BLEJvQYShWKeKqjyncVGoXFsz2AcuFKe1pwETSsN6
  OZncjy32e4ktgs07cWBfx0v62b8md36jau+B6RVnnodaA8++oXl3FRwiEW8XfXWIjy4umIv93tb8
  8ekYsfOfWkTSewZYXGoqe4RtK80ulMHb/dh2FZQIFyRdN4HOmB4FYO5sEYFr9YjHLmDkrUgNodJC
  XCeMe4BO4iaxUQARAQABzRdtYXJrdXMucHJvYnN0QHBvc3Rlby5kZcLBkQQTAQgAOxYhBIJ0GMT0
  rFjncjDEczR2H/jnrUPSBQJog714AhsDBQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEDR2
  H/jnrUPSgdkQAISaTk2D345ehXEkn5z2yUEjaVjHIE7ziqRaOgn/QanCgeTUinIv6L6QXUFvvIfH
  1OLPwQ1hfvEg9NnNLyFezWSy6jvoVBTIPqicD/r3FkithnQ1IDkdSjrarPMxJkvuh3l7XZHo49GV
  HQ8i5zh5w4YISrcEtE99lJisvni2Jqx7we5tey9voQFDyM8jxlSWv3pmoUTCtBkX/eKHJXosgsuS
  B4TGDCVPOjla/emI5c9MhMG7O4WEEmoSdPbmraPw66YZD6uLyhV4DPHbiDWRzXWnClHSyjB9rky9
  lausFxogvu4l9H+KDsXIadNDWdLdu1/enS/wDd9zh5S78rY2jeXaG4mnf4seEKamZ7KQ6FIHrcyP
  ezdDzssPQcTQcGRMQzCn6wP3tlGk7rsfmyHMlFqdRoNNv+ZER/OkmZFPW655zRfbMi0vtrqK2Awm
  9ggobb1oktfd9PPNXMUY+DNVlgR2G7jLnenSoQausLUm0pHoNE8TWFv851Y6SOYnvn488sP1Tki5
  F3rKwclawQFHUXTCQw+QSh9ay8xgnNZfH+u9NY7w3gPoeKBOAFcBc2BtzcgekeWS8qgEmm2/oNFV
  G0ivPQbRx8FjRKbuF7g3YhgNZZ0ac8FneuUtJ2PkSIFTZhaAiC0utvxk0ndmWFiW4acEkMZGrLaM
  L2zWNjrqwsD2zsFNBGiDvXgBEADCXQy1n7wjRxG12DOVADawjghKcG+5LtEf31WftHKLFbp/HArj
  BhkT6mj+CCI1ClqY+FYU5CK/s0ScMfLxRGLZ0Ktzawb78vOgBVFT3yB1yWBTewsAXdqNqRooaUNo
  8cG/NNJLjhccH/7PO/FWX5qftOVUJ/AIsAhKQJ18Tc8Ik73v427EDxuKb9mTAnYQFA3Ev3hAiVbO
  6Rv39amVOfJ8sqwiSUGidj2Fctg2aB5JbeMln0KCUbTD1LhEFepeKypfofAXQbGwaCjAhmkWy/q3
  IT1mUrPxOngbxdRoOx1tGUC0HCMUW1sFaJgQPMmDcR0JGPOpgsKnitsSnN7ShcCr1buel7vLnUMD
  +TAZ5opdoF6HjAvAnBQaijtK6minkrM0seNXnCg0KkV8xhMNa6zCs1rq4GgjNLJue2EmuyHooHA4
  7JMoLVHcxVeuNTp6K2+XRx0Pk4e2Lj8IVy9yEYyrywEOC5XRW37KJjsiOAsumi1rkvM7QREWgUDe
  Xs0+RpxI3QrrANh71fLMRo7LKRF3Gvw13NVCCC9ea20P4PwhgWKStkwO2NO+YJsAoS1QycMi/vKu
  0EHhknYXamaSV50oZzHKmX56vEeJHTcngrM8R1SwJCYopCx9gkz90bTVYlitJa5hloWTYeMD7FNj
  Y6jfVSzgM/K4gMgUNDW/PPGeMwARAQABwsF2BBgBCAAgFiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IF
  AmiDvXgCGwwACgkQNHYf+OetQ9LHDBAAhk+ab8+WrbS/b1/gYW3q1KDiXU719nCtfkUVXKidW5Ec
  Idlr5HGt8ilLoxSWT2Zi368iHCXS0WenGgPwlv8ifvB7TOZiiTDZROZkXjEBmU4nYjJ7GymawpWv
  oQwjMsPuq6ysbzWtOZ7eILx7cI0FjQeJ/Q2baRJub0uAZNwBOxCkAS6lpk5Fntd2u8CWmDQo4SYp
  xeuQ+pwkp0yEP30RhN2BO2DXiBEGSZSYh+ioGbCHQPIV3iVj0h6lcCPOqopZqyeCfigeacBI0nvN
  jHWz/spzF3+4OS+3RJvoHtAQmProxyGib8iVsTxgZO3UUi4TSODeEt0i0kHSPY4sCciOyXfAyYoD
  DFqhRjOEwBBxhr+scU4C1T2AflozvDwq3VSONjrKJUkhd8+WsdXxMdPFgBQuiKKwUy11mz6KQfcR
  wmDehF3UaUoxa+YIhWPbKmycxuX/D8SvnqavzAeAL1OcRbEI/HsoroVlEFbBRNBZLJUlnTPs8ZcU
  4+8rq5YX1GUrJL3jf6SAfSgO7UdkEET3PdcKFYtS+ruV1Cp5V0q4kCfI5jk25iiz8grM2wOzVSsc
  l1mEkhiEPH87HP0whhb544iioSnumd3HJKL7dzhRegsMizatupp8D65A2JziW0WKopa1iw9fti3A
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

The Microsoft Serial Port Console Redirection (SPCR) specification
revision 1.08 comprises additional field: UART Clock Frequency [1].

It contains a non-zero value indicating the UART clock frequency in Hz.

Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table [1]
Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 drivers/acpi/spcr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 73cb933fdc89..c79c809f49d4 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -228,7 +228,8 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 	pr_info("console: %s\n", opts);
 
 	if (enable_earlycon)
-		setup_earlycon(opts);
+		setup_earlycon_with_uartclk(opts,
+					    table->header.revision >= 3 ? table->uart_clk_freq : 0);
 
 	if (enable_console)
 		err = add_preferred_console(uart, 0, opts + strlen(uart) + 1);

-- 
2.53.0

