Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65527253950;
	Tue, 24 Jun 2025 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750752405; cv=none; b=DWNhjxPhHmpZlyyXyyvO2L6ypE10klubxz4uLb3njLyTjcyTPrCDbFzdIxJJ7sN1TvtEE3DKIB+uro+3wexAo9rE2PTuPUm6xs/v69oiTvtMApTftjEuzSyjKIc655jz+/lEHfqVECHLkXS+ZxYzDLJT1AhuQr5zERyvM4X0vI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750752405; c=relaxed/simple;
	bh=NKW5h3kHh0oUo7QTNcVMZxhriKcYzprBe2/Zcqsnkjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W9Y9qw+05AyvAksDpoXNsrEKUUad+A4n5f4TPxJYRDop8lF0lcuD2Hv+ZYd3vc5HYIyYknuUxf1UPJdnh8GnhuvNW2XrPu2I6zFhb2II6vqHEUmnDvXprcD7mfDkf9vYbswQ445lytffO0MqWb11RDyf++ZP2G3StQqWd1AAMzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rr+mkyNN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rr+mkyNN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC969C4CEE3;
	Tue, 24 Jun 2025 08:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750752404;
	bh=NKW5h3kHh0oUo7QTNcVMZxhriKcYzprBe2/Zcqsnkjg=;
	h=From:To:Cc:Subject:Date:From;
	b=rr+mkyNNg/oq/yv1zxCndITAG8qIrZzt2HY3nKf2LQGmY/aFEGxA/FxseId2LGtbR
	 GnByK0DZHd8ketQ5fUlFmWNl6wuzs+h7uU543HVAGWP/HH3iZPQqsnZbN6oD8jlXcw
	 9AmRgggGV6ljb7vUysYi4Lyy+tTXriJzVaf0Jjvn+IrdyVYA6TxYoJ3iRD0x3kORt6
	 QTX6ooNDGJPnMI2GRdE9bopRG5mXIhB8h3UZb60zOU/DjlQM1puL8/Xqr0MIjur1+E
	 b4EjQKuZSDRia7dKz9Wg2OnktqcfYEme6O6/sZZCiEfsrP6au1xR+GYp+AmC+oiAhP
	 XcQRERIYO/4wQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 0/5] tty: fixes on top of summer cleanup
Date: Tue, 24 Jun 2025 10:06:36 +0200
Message-ID: <20250624080641.509959-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These are fixes which were suggested or popped out of the summer cleanup
series.

For v1..v2 diff, see the comments in respective patches.

Jiri Slaby (SUSE) (5):
  serial: 8250: extract serial8250_init_mctrl()
  serial: 8250: extract serial8250_iir_txen_test()
  serial: 8250: rename lsr_TEMT, iir_NOINT to lowercase
  serial: 8250: document doubled "type == PORT_8250_CIR" check
  tty: fix tty_port_tty_*hangup() kernel-doc

 Documentation/driver-api/tty/tty_port.rst |  5 +-
 drivers/tty/serial/8250/8250_core.c       |  2 +
 drivers/tty/serial/8250/8250_port.c       | 60 ++++++++++++++---------
 drivers/tty/tty_port.c                    |  5 --
 include/linux/tty_port.h                  |  9 ++++
 5 files changed, 50 insertions(+), 31 deletions(-)

-- 
2.50.0

