From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH] atmel_serial: keep the platform_device unchanged
Date: Fri, 15 Apr 2011 21:02:13 +0200
Message-ID: <20110415190213.GA3981@game.jcrosoft.org>
References: <1302724038-26236-1-git-send-email-plagnioj@jcrosoft.com>
 <20110413225818.39ce5104@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 30.mail-out.ovh.net ([213.186.62.213]:59847 "HELO
	30.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751601Ab1DOTKr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Apr 2011 15:10:47 -0400
Content-Disposition: inline
In-Reply-To: <20110413225818.39ce5104@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Patrice Vilchez <patrice.vilchez@atmel.com>, Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>, Greg Kroah-Hartman <gregkh@suse.de>

On 22:58 Wed 13 Apr     , Alan Cox wrote:
> On Wed, 13 Apr 2011 21:47:18 +0200
> Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
> 
> > specify the port num via platform_data this will allow to match the
> > clock with the plaform_dev staticly
> > 
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD
> > <plagnioj@jcrosoft.com> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> > Cc: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
> > Cc: Alan Cox <alan@linux.intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@suse.de>
> 
> Ack for the serial side, its really an arch patch though as far as I
> can see..
applied in at91-l2

Best Regards,
J.
