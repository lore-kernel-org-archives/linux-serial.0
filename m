Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9DD337114;
	Wed, 19 Nov 2025 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546505; cv=none; b=WpeY65LYGnCQI2IbqYC6atAEfDCkUjJGkDN7OaoBUuXkPhFVtR3n91IxjSpO7wP8n5hb8Fz6XNTAVpDSyND/QM5kv9iHR29wYn/mIxN9dzlN4yd2zydU4A0GhDfchsH/y7mWF8H+ZJpRpt9+K1QllFG8T05klaGkMzocpyuadMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546505; c=relaxed/simple;
	bh=vGDtmdPfiCq4OAeLe8htIg4k0syyRGvZnE3YrnH2peA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tGegLaVW3V2y2K879LkRlacYxyCPI4dAnifGoDMjrILViOzeCE3hNNskgo8ZGTJpIcUgbGYXauHDAPEYmKnpqnJlVWxKOKYapKZX6sO73MTvpc5FCx4l6bMsRuoFhVNz1P/THNNW2l8d7db0308Vf7/Kcbfux7urWdx0Qa/l7C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aar0Jyfk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aar0Jyfk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29997C4AF0E;
	Wed, 19 Nov 2025 10:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763546504;
	bh=vGDtmdPfiCq4OAeLe8htIg4k0syyRGvZnE3YrnH2peA=;
	h=From:To:Cc:Subject:Date:From;
	b=Aar0Jyfk/kV2Br5LejKD3LW1d86+G7t6mdf5aaJEi/1tHTTTIcp8aP6EEpzRO7vNE
	 A0Ydho1y9k3tMK+v6CPYCvxLcKXewSwsILPwbtvlsplt5UnoxJleK0E8W3BD4STlyB
	 gHxN1KmEx5C34AGXPzv1OSbKPCd5aMMfSvCnCMpYaRT+hXN6zzdeFlZhj7bHRbpNLH
	 6ex4tLi61PLXqj0OWmuNNbnhRu+LvOLVwWt4WCWe4S9Ffts67GhgqO4ZrqxDHSTDRi
	 TMOMfdLvOwM8X2k4dDLaEcxp5/fpCFYLTwz1+n9JS8oHZXfO+Y8zT7pooJC4flArNj
	 7O+WTvUmy9afQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 00/10] tty: another batch of conversions to guards
Date: Wed, 19 Nov 2025 11:01:30 +0100
Message-ID: <20251119100140.830761-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this is also for 6.19 or later.

This series continues to spread guards more both into the tty core code
and drivers.

Jiri Slaby (SUSE) (10):
  tty: pty: use guard()s
  tty: n_tty: use guard()s
  tty: n_hdlc: simplify return from n_hdlc_tty_ioctl()
  tty: n_hdlc: use guard()s
  tty: moxa: use guard()s
  tty: vt/keyboard: use __free()
  tty: vt/keyboard: simplify returns from vt_do_kbkeycode_ioctl()
  tty: vt/keyboard: use guard()s
  serial: serial_core: simplify uart_ioctl() returns
  serial: serial_core: use guard()s

 drivers/tty/moxa.c               | 169 +++++++---------
 drivers/tty/n_hdlc.c             |  79 +++-----
 drivers/tty/n_tty.c              | 109 +++++------
 drivers/tty/pty.c                | 103 +++++-----
 drivers/tty/serial/serial_core.c | 160 ++++++----------
 drivers/tty/vt/keyboard.c        | 318 ++++++++++++-------------------
 6 files changed, 378 insertions(+), 560 deletions(-)

-- 
2.51.1

