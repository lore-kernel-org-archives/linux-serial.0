Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56D8288529;
	Tue,  7 Oct 2025 13:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759842519; cv=none; b=AeoBxCGjAL7uXlbVVaoETzODvCUOOyhFgAdS1l07DVq8u0EeQ6tspJnQ7lFlUA2wQRW9ZnS3x8BmcJrN3HBWPAGv3j917PDNBdaMYgulep0xVTvj+3oQUoQ1/60EElDFl6VQ2aCksuouy2DrT+Xo02zOTQrd1qCfXOSQ8BwneMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759842519; c=relaxed/simple;
	bh=TcHuqH1KdIrgcCEyXUFKbMB0wj8WIcso01Iu0HH2zTM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=agEeXL13+9hB2wUz+ejkQPGbwomyxDXtsmD49NohKhaMOuIW48zo7uHRTqtR4tkj/COjIXhy8wOez2EBjcbLpMBDu/E3PjFEv/8r1xbaAZ2FaVzA9OwDtjO+jZWQ4p2COgP67xVwYDlmz8MbK/5E/hvj6Os/0s/iEjD1qWmOyxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z+aJZ8Pa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z+aJZ8Pa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAC9C4CEF1;
	Tue,  7 Oct 2025 13:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759842519;
	bh=TcHuqH1KdIrgcCEyXUFKbMB0wj8WIcso01Iu0HH2zTM=;
	h=Date:From:To:Cc:Subject:From;
	b=z+aJZ8PaprOtDY19CIJbjMh48KsaBM8w4POAPVK+j2r04XM+vCNQTqYZZAPeWZ+Sw
	 siqnm2SSK/s8RbqCVu0Pv3520F2G0p9rZdWJjEgour55QtnG+zuPSJdmh3HjZsCvJD
	 ER6cPKL4eBPYHGLYBsIgXgV4fwebCu010LAxnxuM=
Date: Tue, 7 Oct 2025 15:08:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY / Serial driver fix for 6.18-rc1
Message-ID: <aOUQ1CdKRQ2mSN1f@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit f83ec76bf285bea5727f478a68b894f5543ca76e:

  Linux 6.17-rc6 (2025-09-14 14:21:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.18-rc1

for you to fetch changes up to a699213d4e6ef4286348c6439837990f121e0c03:

  serial: qcom-geni: Fix blocked task (2025-09-17 13:12:17 +0200)

----------------------------------------------------------------
TTY driver fix for 6.18-rc1

Here is a single driver fix for the qcom_geni_serial driver for
6.18-rc1.  It has been in my tree for weeks, but missed being sent to
you for 6.17-final due to travel on my side.

This fixes a reported regression for this driver that prevents 6.17 from
working properly on this platform.

It has been in linux-next for many weeks with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      serial: qcom-geni: Fix blocked task

 drivers/tty/serial/qcom_geni_serial.c | 176 ++++------------------------------
 1 file changed, 16 insertions(+), 160 deletions(-)
