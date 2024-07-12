Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B08AD512;
	Fri, 12 Jul 2024 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720780865; cv=none; b=XebR9K/1QwP5p3SEHslhd/hGDZnSb4H7oKWLnehDRuNHO/AOMHoOhKGJ9ndTSQ7zsl9mhBNsff4asbpuRUr0q9Yv7tNWYt5nMNVehZeEMlEsDmTKBj3ohlKr1QKIcTrbk+OAPRQH5XEHocd3cipv7MQt7Zi1fP0TaeYSFPlfaZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720780865; c=relaxed/simple;
	bh=TDEL5hC57yul95B5udSlmhCRtwcFbbCO8GwyqgY7/7M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R0n8oM1wIZs4JDxCzCpF10JnIslIbF34KTGP4hlr3ABFLXeAaZDiwlV8VOp4+Z/d+25xrET+tTZqyy49F6d5MwFPU2kSWwKAN1Z77+dlTUc8h5XPRDffaPAkF5qkwpd0jCvSQiOh8d54Onil+4mdW4kfwh45UdXBfMQG41QZTo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cazfjA0I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cazfjA0I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535ABC32782;
	Fri, 12 Jul 2024 10:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720780864;
	bh=TDEL5hC57yul95B5udSlmhCRtwcFbbCO8GwyqgY7/7M=;
	h=Date:From:To:Cc:Subject:From;
	b=cazfjA0ISbn5KKssDGxfuwBkzP9tCB/BkOmWBwgqMtdI/VcIZgCCtdDoSljQ51onZ
	 8vfPEBmyEzx9LCRyYQBRxJLyrNNpuIGN8A1rTswXiSuxRWxMkS997YTq/j+kGdnzQX
	 mOIsU2CbztUr0Fw1LBIsc4tifkgqNpWBiyPbxK6M=
Date: Fri, 12 Jul 2024 12:41:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY / Serial driver fixes for 6.10-final
Message-ID: <ZpEIPXujV_586zPp@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 22a40d14b572deb80c0648557f4bd502d7e83826:

  Linux 6.10-rc6 (2024-06-30 14:40:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.10-final

for you to fetch changes up to 2ac33975abda6921896e52372aec2be2cf51ab37:

  serial: qcom-geni: do not kill the machine on fifo underrun (2024-07-04 12:30:30 +0200)

----------------------------------------------------------------
TTY/Serial fixes for 6.10-final

Here are some small serial driver fixes for 6.10-final.  Included in
here are:
  - qcom-geni fixes for a much much much discussed issue and everyone
    now seems to be agreed that this is the proper way forward to
    resolve the reported lockups
  - imx serial driver bugfixes
  - 8250_omap errata fix
  - ma35d1 serial driver bugfix

All of these have been in linux-next for over a week with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Jacky Huang (1):
      tty: serial: ma35d1: Add a NULL check for of_node

Johan Hovold (3):
      serial: qcom-geni: fix soft lockup on sw flow control and suspend
      serial: qcom-geni: fix hard lockup on buffer flush
      serial: qcom-geni: do not kill the machine on fifo underrun

Rasmus Villemoes (1):
      serial: imx: ensure RTS signal is not left active after shutdown

Stefan Eichenberger (1):
      serial: imx: only set receiver level if it is zero

Udit Kumar (1):
      serial: 8250_omap: Fix Errata i2310 with RX FIFO level check

 drivers/tty/serial/8250/8250_omap.c   |  3 +-
 drivers/tty/serial/imx.c              | 59 +++++++++++++++++++++++++++++++++--
 drivers/tty/serial/ma35d1_serial.c    | 13 ++++----
 drivers/tty/serial/qcom_geni_serial.c | 51 ++++++++++++++++++++++--------
 4 files changed, 104 insertions(+), 22 deletions(-)
