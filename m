From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] pch_uart: Delete modem status interrupt enable code
Date: Wed, 2 Nov 2011 11:00:55 +0000
Message-ID: <20111102110055.153d06c6@lxorguk.ukuu.org.uk>
References: <1319697919-5623-1-git-send-email-tomoya-linux@dsn.lapis-semi.com>
	<1319697919-5623-2-git-send-email-tomoya-linux@dsn.lapis-semi.com>
	<20111101125757.4ef7f883@bob.linux.org.uk>
	<4EB0DAB6.7000106@dsn.lapis-semi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34822 "EHLO
	earthlight.etchedpixels.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756301Ab1KBLAZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 Nov 2011 07:00:25 -0400
In-Reply-To: <4EB0DAB6.7000106@dsn.lapis-semi.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomoya MORINAGA <tomoya-linux@dsn.lapis-semi.com>
Cc: Alan Cox <alan@linux.intel.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com

> Called ".get_mctrl" function, other software can know incoming carrier 
> detection.
> Or you mean a uart driver must detect incoming carrier with interrupt ?

If a user opens a tty port which has no carrier signal then the open is
supposed to block until the carrier is raised unless either clocal
termios or O_NDELAY open flags are set.

That usually means you need to take the carrier raise interrupt in order
to wake out of open in this case.

Alan
