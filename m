From: Andreas Bombe <aeb@debian.org>
Subject: Re: [PATCH v2 1/6] TTY: serial, remove BTM from wait_until_sent
Date: Wed, 10 Aug 2011 14:25:33 +0200
Message-ID: <20110810122532.GA13832@bombe-desk.opditex>
References: <1310646915-3032-1-git-send-email-jslaby@suse.cz>
 <20110719003503.GA4138@amos.fritz.box>
 <4E3FE2D2.5020801@gmail.com>
 <20110810010933.GA4733@amos.fritz.box>
 <4E425384.3040909@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dd13538.kasserver.com ([85.13.135.107]:42381 "EHLO
	dd13538.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718Ab1HJMdz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 Aug 2011 08:33:55 -0400
Content-Disposition: inline
In-Reply-To: <4E425384.3040909@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Jiri Slaby <jirislaby@gmail.com>, gregkh@suse.de, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>

On Wed, Aug 10, 2011 at 11:46:44AM +0200, Jiri Slaby wrote:
> > [  321.948012] Sched Debug Version: v0.10, 3.1.0-rc1+ser-00011-g37ed45d #87
> 
> What tree is this? I cannot see the path through the code.

In order to identify patched versions, I inserted a commit to add "+ser"
to EXTRAVERSION before applying your patch series. Otherwise it's just
the plain Linux git from Linus. I just rebased onto the latest git
for the new test but I can't say which version exactly because I don't
have that tree with me right now.

-- 
Andreas Bombe
