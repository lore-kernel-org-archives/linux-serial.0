Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E8816E883;
	Thu, 11 Jul 2024 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714893; cv=none; b=meFxs4aVFoAup/3nof7K4QFU0KsOKo9JX5n9duog34LYjQevTDjdkfN5RZjbMp0ksXQqmOVoYiv4plHQLemCg8C86egtN0RNc/8Eaqg5X93OfGmy41oo+i3rQNlNmbG6vOE1wrhYSqw2rIlwJoSXtG0Jth6hzhytwu48xrRhVu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714893; c=relaxed/simple;
	bh=chc1J+KbJgvpNMoeeFyiUqQE98oI304IfhWeTRol57c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mGNeKQe1yBUs48NVnLJBGYPPtA6Nxfw9lZTSywI1CTxhXfYpwkDNNoDBqYZTDVh6Lub8bRy2CtrOrxmmx72l/X2lDGUcgXINCKVQ9t9LucVSqWuQjbKr5oMkGk756WZP+f6NeAlTsNX8wvQrqSRgbcfnUE85+vrksX+gm7W17kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOGyp/v0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOGyp/v0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1425C116B1;
	Thu, 11 Jul 2024 16:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720714892;
	bh=chc1J+KbJgvpNMoeeFyiUqQE98oI304IfhWeTRol57c=;
	h=From:To:Cc:Subject:Date:From;
	b=EOGyp/v0iiEJWVdanyIPDk/IIln4inKUS2BOLkHUo0FYdEiSZGzXxo85SYuWCiucv
	 HZ18yhCOU5nFcS8xdSFbJhY4omblJGyUAZJyUuRmO/6bhJULfyrvpd9zBBAQ+y75Gw
	 hePbPq1lDMpFGC/MM04ODj/lwXh6ga6N5EbWYFpHq2GfUJetg+P5ZqoYwgB9Zyvytu
	 ObgROYNYkD7To2n9uyYp2cQUKSbRR8v41hb2lA94mx/7lT4z8rOCV8fowahPBw5VLx
	 kkOthF825SRh4EOl7qr6zkzVgOLk8wolqsC9n+/PVmeEihIPbBdLL+mwE7WFOKxTzw
	 SCSYVMK1xIsEw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/2] serial: 8250: move mmp|pxa uart earlycon code and add xscale earlycon
Date: Fri, 12 Jul 2024 00:07:18 +0800
Message-ID: <20240711160720.3488-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two other drivers that bind to "mrvl,mmp-uart": the 8250_of
and the 8250_pxa. The previous one is generic and the latter is binded
to ARCH_PXA || ARCH_MMP. Now we may have pxa programming compatible
HW to support, making use of the generic 8250_of seems a good idea.
However, there's no earlycon support if we go with this solution. So
move the mmp|pxa-uart earlycon code to core 8250_early.c.

patch2 adds xscale earlycon support too, only build test since
I have no xscale machine any more.

Since v1:
  - split the patch into two as suggested by Greg

Jisheng Zhang (2):
  serial: 8250: move mmp|pxa uart earlycon code
  serial: 8250_early: add xscale earlycon support

 drivers/tty/serial/8250/8250_early.c | 11 +++++++++++
 drivers/tty/serial/8250/8250_pxa.c   | 16 ----------------
 2 files changed, 11 insertions(+), 16 deletions(-)

-- 
2.43.0

