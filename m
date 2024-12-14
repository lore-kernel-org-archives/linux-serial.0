Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9DEDDCD;
	Sat, 14 Dec 2024 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734186953; cv=none; b=JOpNAe3pKXgkXYKPkhXZuYK+acpXD/xmS8gRV0J1HSkELJinIIf/HpJv8K2/nr8LEcxmtMJhTUliVTSeUylFXWCTioBaer9M4VRZ/nLbJFIPLS7pxrXiHIMlqhqavkjZhpsBTJ2L2QjiW03b5Ch6IxGT0yrjeiNe9hQbiXGcCgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734186953; c=relaxed/simple;
	bh=GCemFsEAndIIDDd8VIHsmnrMBKfq1D4UjXgErbA/Kw8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PEiRiDo7conwIZqdgFr12R8eGyaFHAkLVKDs819aelXwJ/+DWuc3KUeyntaSbT3M5aRkUxYoHpOGZQQg9C+9hNHosWIddYnvJds4gHm4rcua4XKDkjuQdDl2uaeRn7WM5wkHqvUS0XANRcZGGQRep2UkOHx87wUEmL6D6+rWnNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CEfZRL5T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CEfZRL5T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B13BC4CED1;
	Sat, 14 Dec 2024 14:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734186952;
	bh=GCemFsEAndIIDDd8VIHsmnrMBKfq1D4UjXgErbA/Kw8=;
	h=Date:From:To:Cc:Subject:From;
	b=CEfZRL5TMbWZyk4CyX97z4Zlam0xCBDL2UQ4PdzJFd2inGVnjIwaYpCu2aOluIYw2
	 SD9zyB/miIQCBVq6hNyh0aM6U85XNTRsBpIN4ToboHnLBaAloIWX0tF+JflTDY2q/z
	 E0PJzSQgKDJ39YJHpTs18Hy9iII3QAZRFVEUE4nk=
Date: Sat, 14 Dec 2024 15:35:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] Serial driver fixes for 6.13-rc3
Message-ID: <Z12XxW821DZlGNfD@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit cdd30ebb1b9f36159d66f088b61aee264e649d7a:

  module: Convert symbol namespace to string literal (2024-12-02 11:34:44 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.13-rc3

for you to fetch changes up to 4e450dfd0f968b79204637bf13280892dff287b1:

  tty: serial: Work around warning backtrace in serial8250_set_defaults (2024-12-06 08:00:01 +0100)

----------------------------------------------------------------
Serial driver fixes for 6.13-rc3

Here are two small serial driver fixes for 6.13-rc3.  They are:
  - ioport build fallout fix for the 8250 port driver that should
    resolve Guenter's runtime problems
  - sh-sci driver bugfix for a reported problem

Both of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Claudiu Beznea (1):
      serial: sh-sci: Check if TX data was written to device in .tx_empty()

Guenter Roeck (1):
      tty: serial: Work around warning backtrace in serial8250_set_defaults

 drivers/tty/serial/8250/8250_port.c |  3 ++-
 drivers/tty/serial/sh-sci.c         | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)
