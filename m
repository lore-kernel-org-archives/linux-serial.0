Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8DD1E1C22;
	Sun, 26 Oct 2025 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761487182; cv=none; b=duPB5X07VbQAEe/jRwujwhDuIIGRs7UrX224t/OXjJUBZmqKa0eyOX9Vskp0UdbgqkEe5r8rd82oUj4MA6SQROuva1ZhBXLginfLeZY6k4sOjdzeho1D2WFTdKhsiYIZWy4B+dSwaK8AhRsfbXkDHk2hryB2DkN7uFBXd75M0uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761487182; c=relaxed/simple;
	bh=z9ENmQBPXDOYZ9BsEZqtw/UhsDZN8tdZ+6KB5WgXGGk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YuUVW9EcNZ2nXZ1Pt81FJJ/Ja1luS/gwUWFQUHH+AJX11s9Nzd6v6NsA21wzOwU1KsD0oWLigVDJVwNq3/lg6PGyyl8oY4h7TINBFCsmQjOwESLXjwIejCPFGryUBSEKPhFNrVlGxmhj5r1PjyKZtOcosPolrjpZFdVY5h5Zw44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dmqDnQwL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dmqDnQwL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64B8C4CEE7;
	Sun, 26 Oct 2025 13:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761487182;
	bh=z9ENmQBPXDOYZ9BsEZqtw/UhsDZN8tdZ+6KB5WgXGGk=;
	h=Date:From:To:Cc:Subject:From;
	b=dmqDnQwL7xDoug18z/PdGh8ZXghzZrf4ngH7vYm0eAF7KlncZPULdyIe2NYU5kKgX
	 YWh+wLXfjV863OtLhWXnizrLYKZh2hn9G6iPapNNxZrMqFKO3lzNj67ZOIFLvQr3YC
	 RsmVgefJuih0Rv9ijtoR5InOyuRbVG1wI+VJxl4I=
Date: Sun, 26 Oct 2025 14:59:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY / Serial driver fixes for 6.18-rc3
Message-ID: <aP4pS45wz11Lcggf@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.18-rc3

for you to fetch changes up to d518314a1fa4e980a227d1b2bda1badf433cb932:

  serial: 8250_mtk: Enable baud clock and manage in runtime PM (2025-10-22 12:13:54 +0200)

----------------------------------------------------------------
tty/serial driver bugfixes for 6.18-rc3

Here are some small tty and serial driver fixes for reported issues.
Included in here are:
  - sh-sci serial driver fixes
  - 8250_dw and _mtk driver fixes
  - sc16is7xx driver bugfix
  - new 8250_exar device ids added

All of these have been in linux-next this past week with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Artem Shimko (1):
      serial: 8250_dw: handle reset control deassert error

Cosmin Tanislav (1):
      tty: serial: sh-sci: fix RSCI FIFO overrun handling

Daniel Golle (1):
      serial: 8250_mtk: Enable baud clock and manage in runtime PM

Florian Eckert (1):
      serial: 8250_exar: add support for Advantech 2 port card with Device ID 0x0018

Geert Uytterhoeven (1):
      dt-bindings: serial: sh-sci: Fix r8a78000 interrupts

Hugo Villeneuve (1):
      serial: sc16is7xx: remove useless enable of enhanced features

 Documentation/devicetree/bindings/serial/renesas,scif.yaml |  1 +
 drivers/tty/serial/8250/8250_dw.c                          |  4 +++-
 drivers/tty/serial/8250/8250_exar.c                        | 11 +++++++++++
 drivers/tty/serial/8250/8250_mtk.c                         |  6 ++++--
 drivers/tty/serial/sc16is7xx.c                             |  7 -------
 drivers/tty/serial/sh-sci.c                                | 14 ++++++++------
 6 files changed, 27 insertions(+), 16 deletions(-)
