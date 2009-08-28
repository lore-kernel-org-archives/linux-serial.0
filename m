From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: Persistent problem with wait_until_sent timeout parameter type
 mismatch
Date: Fri, 28 Aug 2009 14:33:48 +0000 (UTC)
Message-ID: <h78psc$9be$1@ger.gmane.org>
References: <h6muja$6ol$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:45499 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751202AbZH1OeM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 28 Aug 2009 10:34:12 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1Mh2Wp-0001mr-Dg
	for linux-serial@vger.kernel.org; Fri, 28 Aug 2009 16:34:11 +0200
Received: from mn-69-34-67-62.sta.embarqhsd.net ([69.34.67.62])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2009 16:34:11 +0200
Received: from grant.b.edwards by mn-69-34-67-62.sta.embarqhsd.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2009 16:34:11 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2009-08-21, Grant Edwards <grant.b.edwards@gmail.com> wrote:

> I seem to have run into a problem which people have been
> pointing out for years, but never gets fixed.
>
> In tty_driver.h, the low-level driver routine wait_until_set()
> function takes an "int" as a timeout value:
[...]
> But, in tty_ioclt.c in the tty_wait_unti_sent() function, the
> timeout is a "long":
[...]
> This is fine on 32-bit systems, where "int" and "long" are
> equivalent, but it results in breakage on 64-bit systems.

Is this not the correct forum in which to report bugs in the
tty layer code?

-- 
Grant Edwards                   grante             Yow! How many retured
                                  at               bricklayers from FLORIDA
                               visi.com            are out purchasing PENCIL
                                                   SHARPENERS right NOW??

