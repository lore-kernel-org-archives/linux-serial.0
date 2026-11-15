Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794765774;
	b=m0z85dJMmsNKS6/EdTPY1F+vvWtsV7kH6py65vqHSuFP/9s/7rJLDIFVg+swgELM7v4Y
	 HNgX7GlOk/agfw6SovT9U2CzaNevny8G+K4i5mkloH5gAytpUzsfjtYkNQsZhdwdb1baO
	 6n+OCcPRBFJX82GMbFJuUv1yCUC+y7cpw9Ib8Ttm9XQWfPRrgKMlJzlDod2aj4AeK1I6p
	 /iSGwoSvqPe9dxz17pO8e54dL2gLZh1w+y+b2ALkey9zUQ8H9Kgr2FVSmHqKP1VeWf1yk
	 dW2HBsZi3kXMAitAXh/dWtOyO2mF0aBxXfMHx0Uv9Rg4hoCLZx0pm85qM4na8wxVrIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794765774;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=AZmGU1iiu1xdG+WBJ/cRqP+rT5oUQOovrQFLy+MsMdk=;
	b=374tcRy5r8dkGwliRCGlhVSQ6BzpNeZxu8Mv7mIU7cuD+bC1l3FWnG0WVXytqggMJ8MO
	 tOzL7RLDUI/+4OHp+bI2pO/0esd1bSOVUgyF/gu72rAIVaqHBkSl08EUBZa9HqCtSY9GJ
	 W292mLByGlJxwXPbOd3tnTJmkXAY2rWhYGQCsEG2jEFQz5V5ElT6xgJucW3wRtYkN8Rxs
	 cbQEV54L715N9F1YQzKvCOUEye5E/oPtocVGA6NHe0t3gipIsrgvcbI81gIHRX3DzXH87
	 v/g1G4F3m2mrgGHKC+KHnpdJFVLsVmM1/f2WsnUsGW9OhDJJfsOk+2aysCp43jrYpnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HidNQ0Uz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DA5606A323;
	Sun, 15 Nov 2026 18:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HidNQ0Uz
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794765773;
	b=wS1+JV63fZayvlt+lPa1JvJpdc7Tjcyrl2kVxrobz4loOTXtnWW5e5DCKj1kOsSwN8rw
	 sPOOR/vEz6LW3xkEUi2SPNAepOJKKKgiMZUG+K761B+cgm/rWIyyLyLnjZ020FhCKA/OQ
	 wLhtxGpnReuGbe1JWvh881kh/UC8QjZv9vx8gae3fhMbfrkq5XfmVQMG7pCXdoA0RCcI1
	 /WscMPcZbWhdbsjhpsk0yG+nR82APCMLLJyfOK2W9K8m+Ncn/YsdHxJboCK9SHzqgf6XS
	 2NWwRH4AyRfCGz6pCKzyJBklkmVCmd00JbB/Y4U9Zeab3OoD5HrSNC44DQVMx9jAB9g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794765773;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=AZmGU1iiu1xdG+WBJ/cRqP+rT5oUQOovrQFLy+MsMdk=;
	b=MBHSz5ePOnqG6VDz4b7IzV8CiCORcZonvKkiX57W7dJy0UekZu89jX6ReBVe44b8IkES
	 ctp0S3QhaCUAuzRwWoOOoQOlbKeJWAHBzuByI3CUC4yDUuWAA120KfFo4G423P1QfHGxl
	 I8FW3vUnjcKfk+HNpmzOpLhmn4BYKwzJ4duoOMZLZLgGdw0jlvjKSTJjJ0zFmYMO04mo6
	 YQF4Qtsx0TS5z1Cuwg8/fVnk0cR1HIHMWHecKUxrGXJuPxe8CigzxhJgLFXfNTJWcHdCK
	 sbUhns3PmB5Evo8ELJYX37jCqYSA4kauZVE6kKOn6XX5sDYhN8kO807vLDJDD0dSRww==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 33D361F000C5;
	Sun, 15 Nov 2026 18:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794765773;
	bh=AZmGU1iiu1xdG+WBJ/cRqP+rT5oUQOovrQFLy+MsMdk=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=HidNQ0Uz/G/McY/7hrgm5Lrp3mX6Uq11I+e5XthP/yHx/f7wYd21riZ/ZS1l6SWXI
	 QPE+jEhTL+YX285Kdbpu+L9kGya78U+1MOqe8mQTz2VMhqWOHX41rvHs9B5xU7cRmJ
	 /PebPDSx8/L5U4uXMgfuk5h/FSbud6xL2Z0wRJ/kDEgEWCtggWpHN7eLHGXFRFsaD7
	 F43cuVWSm+1RI5adZuapwRi3epMuu8BYSTIpxDgy2t2H4xdnMD2YW6b0EuvNZYrBFD
	 xwcM1cQ/3TREKag+XXjyvc4rNyXfSn7CUY5i6veUrqW7Qs2pqHDQx6CBvVovGEkg8D
	 K7L4LerKxR2NA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8C0C54A131;
	Sun, 15 Nov 2026 18:02:52 +0000 (UTC)
From: Jonas Juffinger via B4 Relay <devnull+jonas.juffinger.liebherr.com@kernel.org>
Subject: [PATCH 0/2] serial: fsl_lpuart: 8-bit FSL-LPUART driver
 improvements
Date: Sun, 15 Nov 2026 19:01:55 +0100
Message-Id: <20261115-fsl_lpuart_8_bit_break_detection-v1-0-b7ac2307dd55@liebherr.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJPz+WoC/yWNUQqDMBAFryL73UBibJVepUhIzKbdVqxsYimId
 3dtPwfmzVshIxNmuFYrMH4o03sSMKcKhoef7qgoCkOt64sx5qxSHt04L56L61yg4gKjf7mIBYc
 iY9W1uo2NtU2yGiQzMyb6/i5u/Z/zEp5iH13Yth0C9D/RhAAAAA==
X-Change-ID: 20261115-fsl_lpuart_8_bit_break_detection-8707d4334f30
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 michael@walle.cc, sherry.sun@nxp.com, 
 Jonas Juffinger <jonas.juffinger@liebherr.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794765771; l=707;
 i=jonas.juffinger@liebherr.com; s=20260615; h=from:subject:message-id;
 bh=fnQPw0pmRVdCP+5XQzrfDbwdYcVNnwCxka3433C0+4A=;
 b=jEHvDvl+O1IqBZEXiC0TmN3OkceNCHSmhP+tYDhhbzeJslHsniqg5Q4w1XS7UOnAfKvtk1eqe
 8ImrOLrm3RlC8tv5/XNzcFmsARTAL+H4ft6ojerCOBIXZW5EQ2B0flk
X-Developer-Key: i=jonas.juffinger@liebherr.com; a=ed25519;
 pk=57Vzs2aKTP3E7TDrBuZMQibGR+Koattc4oIhiMOs3FI=
X-Endpoint-Received: by B4 Relay for jonas.juffinger@liebherr.com/20260615
 with auth_id=821
X-Original-From: Jonas Juffinger <jonas.juffinger@liebherr.com>
Reply-To: jonas.juffinger@liebherr.com

Add break detection that is currently only working in the 32-bit part of
the driver.
Enable DMA for TX when it is a console for the 8-bit part of the driver.

Signed-off-by: Jonas Juffinger <jonas.juffinger@liebherr.com>
---
Jonas Juffinger (2):
      serial: fsl_lpuart: Enable break detection in 8-bit driver
      serial: fsl_lpuart: Enable DMA for TX in console mode

 drivers/tty/serial/fsl_lpuart.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261115-fsl_lpuart_8_bit_break_detection-8707d4334f30

Best regards,
--  
Jonas Juffinger <jonas.juffinger@liebherr.com>


