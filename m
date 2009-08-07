From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/2] Give the N_AMSDELTA line discipline more generic
 name
Date: Fri, 7 Aug 2009 11:47:53 +0100
Message-ID: <20090807104753.GA9002@rakim.wolfsonmicro.main>
References: <200908061306.27639.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:47303 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757322AbZHGKry (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Aug 2009 06:47:54 -0400
Content-Disposition: inline
In-Reply-To: <200908061306.27639.jkrzyszt@tis.icnet.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, e3-hacking@earth.li, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Aug 06, 2009 at 01:06:26PM +0200, Janusz Krzysztofik wrote:

> As the line discipline is conceived to be registered from a machine driver, 
> there should be no conflicts, even if used by several different drivers that 
> happen to be be built-in side-by-side.

I've applied the patches but squashed them down into one to avoid broken
builds when doing bisection.
