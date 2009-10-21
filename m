From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Re: [PATCH 1/9] serial_cs: use pcmcia_loop_config() and pre-determined values
Date: Wed, 21 Oct 2009 14:36:54 +0200
Message-ID: <20091021123654.GA17663@isilmar.linta.de>
References: <20091019123739.GA23104@isilmar.linta.de> <1255907255-28297-1-git-send-email-linux@dominikbrodowski.net> <4012584.17381255954017391.komurojun-mbn@nifty.com> <20949843.18491256128220708.komurojun-mbn@nifty.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:39604 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751620AbZJUMgv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Oct 2009 08:36:51 -0400
Content-Disposition: inline
In-Reply-To: <20949843.18491256128220708.komurojun-mbn@nifty.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Komuro <komurojun-mbn@nifty.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, linux-pcmcia@lists.infradead.org, linux-serial@vger.kernel.org

Hey,

On Wed, Oct 21, 2009 at 09:30:20PM +0900, Komuro wrote:
> Hi,
> 
> >On Mon, Oct 19, 2009 at 09:06:57PM +0900, Komuro wrote:
> >> Please don't remove the code below.
> >> This code loades the "2nd" ConfigBase of the multi-function card.
> >
> >isn't this properly handled by the patch 
> >
> >pcmcia: pccard_read tuple and TUPLE_RETURN_COMMON cleanup
> 
> 
> OK.
> works.

Thanks for testing!

	Dominik
