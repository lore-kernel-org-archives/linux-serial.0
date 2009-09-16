From: Grant Edwards <grante@visi.com>
Subject: Re: Persistent problem with wait_until_sent timeout parameter type mismatch
Date: Wed, 16 Sep 2009 05:57:02 +0000 (UTC)
Message-ID: <h8pune$7ak$1@ger.gmane.org>
References: <h6muja$6ol$1@ger.gmane.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:40798 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755445AbZIPF5Z (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Sep 2009 01:57:25 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MnnW8-0000qI-Kb
	for linux-serial@vger.kernel.org; Wed, 16 Sep 2009 07:57:24 +0200
Received: from 67-220-17-45.usiwireless.com ([67.220.17.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 16 Sep 2009 07:57:24 +0200
Received: from grante by 67-220-17-45.usiwireless.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 16 Sep 2009 07:57:24 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2009-08-21, Grant Edwards <grant.b.edwards@gmail.com> wrote:

> I seem to have run into a problem which people have been
> pointing out for years, but never gets fixed.
>
> In tty_driver.h, the low-level driver routine wait_until_set()
> function takes an "int" as a timeout value:

Since this apparently isn't the place to discuss problems with
the tty layer, can somebody suggest the proper forum?

-- 
Grant


