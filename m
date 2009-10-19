From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 1/9] serial_cs: use pcmcia_loop_config() and pre-determined values
Date: Mon, 19 Oct 2009 14:37:40 +0200
Message-ID: <20091019123739.GA23104@isilmar.linta.de>
References: <1255907255-28297-1-git-send-email-linux@dominikbrodowski.net> <4012584.17381255954017391.komurojun-mbn@nifty.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:53804 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751248AbZJSMhh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Oct 2009 08:37:37 -0400
Content-Disposition: inline
In-Reply-To: <4012584.17381255954017391.komurojun-mbn@nifty.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Komuro <komurojun-mbn@nifty.com>
Cc: linux-pcmcia@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>, linux-serial@vger.kernel.org

Hey,

On Mon, Oct 19, 2009 at 09:06:57PM +0900, Komuro wrote:
> Please don't remove the code below.
> This code loades the "2nd" ConfigBase of the multi-function card.

isn't this properly handled by the patch 

pcmcia: pccard_read tuple and TUPLE_RETURN_COMMON cleanup

http://git.kernel.org/?p=linux/kernel/git/brodo/pcmcia-2.6.git;a=commitdiff;h=84897fc0524d7cbfc81d0bdf9f92ade6e3c3816b
?

Best,
	Dominik
