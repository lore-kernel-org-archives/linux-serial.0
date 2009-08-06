From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 0/2] ASoC: CX2044: full duplex mode fix
Date: Thu, 6 Aug 2009 11:44:24 +0100
Message-ID: <20090806104424.GB19369@sirena.org.uk>
References: <200908061224.44537.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:37459 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbZHFKoZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Aug 2009 06:44:25 -0400
Content-Disposition: inline
In-Reply-To: <200908061224.44537.jkrzyszt@tis.icnet.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, e3-hacking@earth.li, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Thu, Aug 06, 2009 at 12:24:44PM +0200, Janusz Krzysztofik wrote:
> This series of patches tries to solve the problem of audio mode changes not 
> working correctly while in full duplex mode.
> 
> [PATCH 1/2] ASoC: CX20442: add some debugging
> [PATCH 2/2] ASoC: CX20442: simplify codec controller usage

Applied both, thanks, but I had to manually fix up the patches since
your mailer had word wrapped them.
