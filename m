Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA3216E898;
	Thu, 11 Jul 2024 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714896; cv=none; b=B+vimTWEOxNSApJk1dacs767UTF7TTC1ForFmo7jSiz4lxRFgTlpw7PcNZca7x3cGsxgoBDcKPkzESWglvvpk/g0sdQNhGjxRHUd0DFMWIXtYhGrcX79c6l22ih2figoCOjLl9Pf4L3tgL597dwcCnes1NA0Oh3HNY0vbAx+sXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714896; c=relaxed/simple;
	bh=2lkZDO62KKSLWoCZyINk2tMegh2s5zBoWrcbbgs+qh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLWUYn2gfHHFoml7uzvV/SerNj1ix4ZuISSRGbXQi6mNdThxkCQLZRYvl2Eryzh19142lFQPSBVyhVlJMb3Iy7pt3wD188DzTfdX5sf/+13wnoyFOSnEMvQXtes8ywhYC6IpuOr6ELc2M4TzTI5KDM5yHFkM3Y3cpRPQ/kTZI5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLQvcD8S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLQvcD8S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA722C4AF07;
	Thu, 11 Jul 2024 16:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720714895;
	bh=2lkZDO62KKSLWoCZyINk2tMegh2s5zBoWrcbbgs+qh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SLQvcD8Sff05TBENEvofTjbdmesTqf2NPUlspiQ/Voj+aB6BV1h23XrCpi7qwawMV
	 CifuO2YwsYlm1GHM/RTnoQHcygrdA9Xy4xgB7ORlvIMOQsTJ6KkyruSbqJ16IUMjQ2
	 rx2kbjHGNrODg8kVu52A1Nssnp0LTI6p0bl8Wbu/pteurjOn6vPOyAMbYKUJmnXItQ
	 +fNFHszgzdR/sCkO0MGjg+Wl34904u7cTYpd+mSXUlN0hlHu7ytBa6RY5VpuOU391D
	 e4ZVq9OL9bZSc/eR+mnWtJACTQvzhQhURy17YJonWXwWQxHlijtgYWzLUWEGBc85QI
	 v+L0gImT8LO8w==
From: Jisheng Zhang <jszhang@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 2/2] serial: 8250_early: add xscale earlycon support
Date: Fri, 12 Jul 2024 00:07:20 +0800
Message-ID: <20240711160720.3488-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240711160720.3488-1-jszhang@kernel.org>
References: <20240711160720.3488-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 3a50365d8c79 ("serial: 8250: Add OF support for Xscale
variant"), 8250_of can support the xscale variant. Now, let's add
the earlycon support for xscale too.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/tty/serial/8250/8250_early.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 2ab61d6673d2..6176083d0341 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -178,6 +178,7 @@ static int __init early_serial8250_rs2_setup(struct earlycon_device *device,
 
 	return early_serial8250_setup(device, options);
 }
+OF_EARLYCON_DECLARE(uart, "intel,xscale-uart", early_serial8250_rs2_setup);
 OF_EARLYCON_DECLARE(uart, "mrvl,mmp-uart", early_serial8250_rs2_setup);
 OF_EARLYCON_DECLARE(uart, "mrvl,pxa-uart", early_serial8250_rs2_setup);
 
-- 
2.43.0

