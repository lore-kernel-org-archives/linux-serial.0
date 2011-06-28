From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 6/7] serial/8250: sanitize fourport handling
Date: Tue, 28 Jun 2011 11:10:35 +0100
Message-ID: <20110628111035.7bd69c0d@lxorguk.ukuu.org.uk>
References: <1309211120-2803-1-git-send-email-arnd@arndb.de>
	<1309211120-2803-7-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39535 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754475Ab1F1KIH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Jun 2011 06:08:07 -0400
In-Reply-To: <1309211120-2803-7-git-send-email-arnd@arndb.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Mon, 27 Jun 2011 23:45:19 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> Support for AST fourport cards is always built into
> the 8250 driver, even if CONFIG_SERIAL_8250_FOURPORT
> is disabled. This introduces a set of macros for
> accessing the special interrupt control register on
> the fourport card, so that support is left out
> when the option is disabled, without adding more #ifdef
> lines to the driver itself.

Why not just leave it in - it seems to take almost no code and your
changes mean people setting the fourport flag are going to get strange
behaviour when it isn't compiled in.

