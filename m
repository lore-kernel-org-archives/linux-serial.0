Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039E3199EAD
	for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781484030; cv=none; b=uQUOgMUTvbF7NetyyqiUqvZTswd0E8l2JNx2H+VkKDjYE8fU/7DVc/vIxpSb+HrJ9RkpjWW4wm2SObf693SQURwfoH6csHY6CdewurwQvWY5X6JdlhaxLKEWsgIsqcdIyCtVv/jgkTQakWET3SHsIUVl21O2o1+ZZd+LJpT8QKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781484030; c=relaxed/simple;
	bh=ecenD+bbHZd1D7QwIxIhJJWiW1cEKEMuDKlzkTGkejs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ojTzv+Og1+zJJPE3itLnvUHhPBlqrRM3PMqir0bdqOFS1ZM5p/S5O/9heT0+pZtzP2MVRBRxTJysehkgy+rRgnzalQ+GqQdtu5Xkf/alK7mqtXGLl6NCQtqPP3crDWGvsjCrBgORelBZjTj31QFSVuFlDDY/kWFZ5LstvBVxZCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=QUlJBQwj; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="QUlJBQwj"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id EF0E2240104
	for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 02:40:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1781484020; bh=me8kNR5KWFK7zW5n1YHNwt6f8KAeZ/QWlp4X4+QJbB0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Autocrypt:OpenPGP:From;
	b=QUlJBQwjK7gaM7+eCPcGLFRlmUZwGs5/oE9JerF2ytzdv5CLTDg6fM548akUyG+3Y
	 aoX8eUoLB4tJmepCr/2E/OL2CYkj7AWN8ZJQXR9LYQ8iAhurl9zXLahpHumJZOhRV0
	 7pxcvSf5yfWiULRf/WbFXrohYmnjVe7wyabGPt6v5PX6QYfEMhh2wol94Oc39f/z+n
	 lt+NBjD/PxRoGyITHmx7iyg/QiphlBvYRsbYtcKgqvDpBWk45ilwaboEj6+9csDidL
	 aACWLzm2Ewdv9XvDy00ZPcEVnt/COSyN4flpse2A+GgoJIo34BFSJWukM0d21kuMiq
	 Ox3x/p/v5XrNw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gdrr360lyz6tsb;
	Mon, 15 Jun 2026 02:40:19 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Subject: [PATCH v3 0/2] ACPI: SPCR: Support UART clock frequency field
Date: Mon, 15 Jun 2026 00:40:20 +0000
Message-Id: <20260615-acpi_spcr-v3-0-9a59ebad74ea@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WOQQ6CMBREr0K6tqT9BRRW3sMYA+2v1ASKbW00h
 rsL1QUuJ3lvZt7EozPoSZO9icNovLHjEsQuI7JvxytSo5ZMgEHFCsFoKydz8ZN0tOI1A61qEBr
 Iwk8OtXmmrtP5m/2ju6EMa8GPcHh/LCPhi5Gu9UilHQYTmizuc05Wszc+WPdKpyJPYNovWbnZj
 5xyqlXRyUoX2JXiOFkf0OYKU0uEjQl/JlBGJSuAHWq1F7LdmvM8fwBbkF5EFgEAAA==
X-Change-ID: 20260430-acpi_spcr-61902fd923f2
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-acpi@vger.kernel.org, Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=918;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=ecenD+bbHZd1D7QwIxIhJJWiW1cEKEMuDKlzkTGkejs=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqL0nz6/+iH9o3DpA7UygAM7Btze2JysiRg4pHt
 qeHTVwr7NGJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCai9J8xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9ISBw//UnNcW+XyY6FL0BFu0PR/4nkfdXuF6ru
 MhXEnuf1RRwt8Wg26QjRTYyoBzwT4aGa7Z8Kt6zCqyOLGKThVUbOEzQYptuqWD6B9XbsVEOm3tx
 REyqQEGXwC+Tr7yhGSRnoUfqb7G7Xfrm8xBYJmMGTqpxdkfK5WQkuFWA/EbgWApJgcLT7PvvvcA
 oqox/WxYCE2My4hA/bscHiCxZTTZb8Ui5oABR4vPEnaPaQyb3lDjrvGheAl2OqkxEGq0+8OtbOp
 voIKlQ72yPytSJRUK0gOqmsRWzGpcPoF8L+NcmFox4cFx3bQQgSwOLyqu7KHRTe1q7nckA9uXmf
 MK016FxHdhaW0GfzilLkfbczOhvcNVma75SARt3558dz/NccL5Mxh2J30piP1/iJ9nLotFX0T7i
 dBvrBd3lcOq23S+PDlm+X0bn+aqXSLG58CJ7DAb33Z8gxYk9+ZQyTWqN8U2T2KtcbrwpG+FBPYS
 1HovY7PnWoIVCr4tfRMm5ShcfFk+g5Rtd570xjtCT4Vr/wKTAH/4Ihw5EairvRy9/XoChWLzHyx
 VPGlIP1bGp/wU8UauzRkB20T9/kkMBu9ZmXBh4ZA1cWI1Ax2Fd1Wsc/76hMUref5aERBFFn5bgc
 5bCYYtDXGvX5Vo1bG4EQzmROIlGUdCycJbr978AIOuwGFiVA3d2w=
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

Support the uart clock frequency in the SPCR table.
See the commit messages for details.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
Changes in v3:
- add separate function for earlycon with uartclk
- Link to v2: https://patch.msgid.link/20260525-acpi_spcr-v2-0-c042089d73ca@posteo.de

Changes in v2:
- fix uart_clk_freq possibly being interpreted as parity/bits/flow
- Link to v1: https://patch.msgid.link/20260505-acpi_spcr-v1-1-fd4bc6f4eb53@posteo.de

---
Markus Probst (2):
      serial: earlycon: add uart_clk_freq parameter
      ACPI: SPCR: Support UART clock frequency field

 drivers/acpi/spcr.c           |  3 ++-
 drivers/tty/serial/earlycon.c | 17 ++++++++++++-----
 include/linux/serial_core.h   | 11 +++++++++--
 3 files changed, 23 insertions(+), 8 deletions(-)
---
base-commit: b3f94b2b3f3e51ab880a51fc6510e1dafba654ed
change-id: 20260430-acpi_spcr-61902fd923f2

