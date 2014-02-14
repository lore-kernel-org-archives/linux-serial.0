From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: Is tty->receive_room no longer usable w/ SMP?
Date: Fri, 14 Feb 2014 22:31:52 +0000 (UTC)
Message-ID: <ldm5go$ug5$1@ger.gmane.org>
References: <ldgte5$kp1$1@ger.gmane.org>
 <52FC1A14.5080004@hurleysoftware.com> <ldhaiq$jg$1@ger.gmane.org>
 <52FC427A.8050907@hurleysoftware.com> <ldhlpd$bbr$1@ger.gmane.org>
 <52FCE506.2040801@hurleysoftware.com> <ldj0o5$oq6$1@ger.gmane.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:39782 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752282AbaBNWcS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Feb 2014 17:32:18 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1WERIu-0003U0-GR
	for linux-serial@vger.kernel.org; Fri, 14 Feb 2014 23:32:16 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 14 Feb 2014 23:32:16 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 14 Feb 2014 23:32:16 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2014-02-13, Grant Edwards <grant.b.edwards@gmail.com> wrote:
> On 2014-02-13, Peter Hurley <peter@hurleysoftware.com> wrote:

>> There's no realistic way to single-source a driver across hundreds of
>> kernel versions.
>
> Maybe not hundreds.  Our current drivers only support 2.6.24 and
> later.

It turns out I was wrong on both counts. The oldest supported version
is 2.6.25, not 2.6.24, and yes that is hundreds of versions.  :)

I got curious and counted: we currently have single-source support for
541 official Linux kernel versions. That's not counting current "rc"
versions (which are now supported), or RedHat's backport abominiations
(which occasionally require special support).

Within those 541 versions there are only about five or six distinct
incompatible API subsets to worry about, so it's not as impressive as
it sounds.

-- 
Grant Edwards               grant.b.edwards        Yow! HOORAY, Ronald!!
                                  at               Now YOU can marry LINDA
                              gmail.com            RONSTADT too!!

