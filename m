Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC142571A1;
	Fri, 28 Nov 2025 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764347663; cv=none; b=srzqqZ0zqGypgCZiHmT5vCS5YqqPmx/ScwlOVj4SRcNQep7srrukvfUoyUBWMCrYo9BaYmBEpZzTgftimLuKCYgYpTo/GYxGMXoQJ7m/nKSHDQ5NxxPcihEDi8kT1htd/2DCNux42FqpCYPjD3pb4jlhtA0z4m1TjNUy9re284A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764347663; c=relaxed/simple;
	bh=fAyr5BqlBz7/g3ZwBsy8J6Jv3RJnaJghDOHU4AZ8hfU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=teuZP65rQPom+One8izoLGt4Ie07i9tlbBqyOm4gK/5V6CiLRJWjZfAkPKcWBDwQOoOfHbWzw/3uiuF6ugvFxuWKlTPhwyMcJiOZ4jMaPKqEoFHpRmBFD3cF9AzD5T7Gd+xcGM1B7K+dth61ntXZ+Z7M6FpdbZD3z5cMuwyKywE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PcuLILbp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PcuLILbp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3835BC4CEF1;
	Fri, 28 Nov 2025 16:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764347663;
	bh=fAyr5BqlBz7/g3ZwBsy8J6Jv3RJnaJghDOHU4AZ8hfU=;
	h=Date:From:To:Cc:Subject:From;
	b=PcuLILbpZ4JFeE5RDdpLEf/zZPWiNEzTjcOF89Te3pYuqnfI8oUzDP9QRmHolswuo
	 /+iSyIYaKRAnmHmqMjVypV1Towe0HPR2OVd8V5xE/sIB0ywBzuUtdwmnlNsr0kbajk
	 IUw/xta/xBx7h74KAKwMMnnbgCOFo+p0eCz+BS3M=
Date: Fri, 28 Nov 2025 17:34:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] Serial driver fixes for 6.18-rc8
Message-ID: <aSnPDe3bUlz_Xl7e@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa:

  Linux 6.18-rc3 (2025-10-26 15:59:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.18-rc8

for you to fetch changes up to 2bf95a9bcb50002ca9d47403d60aedaeb2e19abe:

  serial: 8250: Fix 8250_rsa symbol loop (2025-11-26 13:16:53 +0100)

----------------------------------------------------------------
Serial driver fixes for 6.18-rc8

Here are 2 serial driver fixes for reported issues for 6.18-rc8.

These are:
  - fix for a much reported symbol build loop that broke the build for
    some kernel configurations.
  - amba-pl011 driver bugfix for a reported issue

Both have been in linux next (the last for weeks, the first for a
shorter amount of time), with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ilpo Järvinen (1):
      serial: 8250: Fix 8250_rsa symbol loop

Miaoqian Lin (1):
      serial: amba-pl011: prefer dma_mapping_error() over explicit address checking

 drivers/tty/serial/8250/8250.h          |  4 ++--
 drivers/tty/serial/8250/8250_platform.c |  2 +-
 drivers/tty/serial/8250/8250_rsa.c      | 26 +++++++++++++++++---------
 drivers/tty/serial/8250/Makefile        |  2 +-
 drivers/tty/serial/amba-pl011.c         |  2 +-
 5 files changed, 22 insertions(+), 14 deletions(-)
