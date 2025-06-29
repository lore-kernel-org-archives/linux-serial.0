Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69B51D6AA;
	Sun, 29 Jun 2025 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751200220; cv=none; b=NdfOGbs/JRPkRnc8fkoMRmsF3ZCEqCM6BZZ/B+8D/hwu82b1GcEBblB4dSsZofrm/cU1Qe7xsPJkspHV/kk3/7jlaaOY0F/WE+f+NGq2lBYnRtpKebRf7DI0mcIFHWo2DQ0R/ACBOB9IPLJ18GG2doLNuT3ucnN0V9Y/CIme0RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751200220; c=relaxed/simple;
	bh=UM+OvlejUrRI0VfiNesQkThGz3t5ZeebEYKwPufLmto=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Suk7Q2I/QeT4KiLL2NyKX25MwgoewbO/2cmVGwq/ThVCDQRFHIoaSmdv4zIkxZVvP+ftE2p2yflryF/LTZhSJV+d/ldBoa0oCDPC4MyUiMOyADjdc/Wxoo2aHvjm9q/Fq69iQJq0oZkUgfcp3Sj51pvqkFinFKBpE7nXDOUiWZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X2SltdUb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X2SltdUb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3514C4CEEB;
	Sun, 29 Jun 2025 12:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751200219;
	bh=UM+OvlejUrRI0VfiNesQkThGz3t5ZeebEYKwPufLmto=;
	h=Date:From:To:Cc:Subject:From;
	b=X2SltdUbSa1cvkI1Lbwj8e7o8f0iCVVHrRgNYIozA7sr0w7KsMonMHguA3ylKFRgw
	 +XJILdN7iByaF/vepGi8/vKdiqWoNOGHl1bWWI4eQ/PYErzB0cQNlke2xjT8pOg06O
	 bn0CWZVJrwyzN9q5h0i6NsiQKf0UOKd7dmH6MKDY=
Date: Sun, 29 Jun 2025 14:29:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY / Serial driver fixes for 6.16-rc4
Message-ID: <aGExtgnENnLLFsET@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.16-rc4

for you to fetch changes up to 09812134071b3941fb81def30b61ed36d3a5dfb5:

  dt-bindings: serial: 8250: Make clocks and clock-frequency exclusive (2025-06-24 15:34:37 +0100)

----------------------------------------------------------------
TTY/Serial driver fixes for 6.16-rc4

Here are 5 small serial and tty and vt fixes for 6.16-rc4.  Included in
here are:
  - kerneldoc fixes for vt recent changes
  - imx serial driver fix
  - of_node sysfs fix for a regression
  - vt missing notification fix
  - 8250 dt bindings fix

All of these have been in linux-next for a while with no reported issues

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aidan Stewart (1):
      serial: core: restore of_node information in sysfs

Fabio Estevam (1):
      serial: imx: Restore original RXTL for console to fix data loss

Nicolas Pitre (1):
      vt: add missing notification when switching back to text mode

Randy Dunlap (1):
      vt: fix kernel-doc warnings in ucs_get_fallback()

Yao Zi (1):
      dt-bindings: serial: 8250: Make clocks and clock-frequency exclusive

 Documentation/devicetree/bindings/serial/8250.yaml |  2 +-
 drivers/tty/serial/imx.c                           | 17 ++++++++++++-----
 drivers/tty/serial/serial_base_bus.c               |  1 +
 drivers/tty/vt/ucs.c                               |  2 +-
 drivers/tty/vt/vt.c                                |  1 +
 5 files changed, 16 insertions(+), 7 deletions(-)
