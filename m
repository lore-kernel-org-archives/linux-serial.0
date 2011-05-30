From: "Tomoya MORINAGA" <tomoya-linux@dsn.okisemi.com>
Subject: RE: [PATCH] 8250_pci: add -ENODEV code for Intel EG20T PCH
Date: Mon, 30 May 2011 20:19:40 +0900
Message-ID: <EC1A82FC0A474852B4C14B0946198E85@hacdom.okisemi.com>
References: <1306741324-4562-1-git-send-email-tomoya-linux@dsn.okisemi.com><20110530074722.GA7947@suse.de> <20110530105633.596ab8ab@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sm-d311v.smileserver.ne.jp ([203.211.202.206]:39254 "EHLO
	sm-d311v.smileserver.ne.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753137Ab1E3LTn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 30 May 2011 07:19:43 -0400
In-Reply-To: <20110530105633.596ab8ab@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Alan Cox' <alan@linux.intel.com>, 'Greg KH' <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com, toshiharu-linux@dsn.okisemi.com

Hi Greg

> Because if the PCH driver is not available you want to bind 
> it to the 8250 driver, which also works with it but less efficiently.
> 
> The giant if probably should be a pci match table however
 
Which opinions should I select ?

Though Alan's comment has a point,
IMHO, in probe processing, the efficiently is not so important.
Adding the "#ifdef", I think, readability of 8250_pci.c goes down.

Thanks,
-----------------------------------------
Tomoya MORINAGA
OKI SEMICONDUCTOR CO., LTD.

