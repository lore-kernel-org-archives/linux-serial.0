From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Inter-Character Delay
Date: Tue, 26 Feb 2008 17:11:56 +0000
Message-ID: <20080226171156.GA11561@flint.arm.linux.org.uk>
References: <200802181336.26328.rgetz@blackfin.uclinux.org> <200802261111.58448.rgetz@blackfin.uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41137 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062AbYBZRMS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Feb 2008 12:12:18 -0500
Content-Disposition: inline
In-Reply-To: <200802261111.58448.rgetz@blackfin.uclinux.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Robin Getz <rgetz@blackfin.uclinux.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-serial@vger.kernel.org

On Tue, Feb 26, 2008 at 11:11:58AM -0500, Robin Getz wrote:
> ping.
> 
> Comments appreciated.

ascii-xfr does inter-line and inter-character delays without requiring any
kernel modifications - used it with some dumb boot loaders which required
'mem deposit <address> <word>' to be sent slowly to the target.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
