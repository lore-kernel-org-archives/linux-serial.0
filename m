From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Suspecting kernel timing bug in ppp or tty drivers
Date: Wed, 12 Mar 2014 10:04:10 -0400
Message-ID: <5320695A.2070503@hurleysoftware.com>
References: <ED3E0BCACD909541BA94A34C4A164D4C5B180258@post.tritech.se> <20140310194007.GC3392@kroah.com> <ED3E0BCACD909541BA94A34C4A164D4C5B180A77@post.tritech.se> <20140311185019.GA32618@kroah.com> <Pine.LNX.4.64.1403120452230.17831@yossarian>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:60394 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753029AbaCLOEO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Mar 2014 10:04:14 -0400
In-Reply-To: <Pine.LNX.4.64.1403120452230.17831@yossarian>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: terry white <twhite@aniota.com>
Cc: linux-ppp@vger.kernel.org, linux-serial@vger.kernel.org, =?UTF-8?B?TWF0cyBLw6Rycm1hbg==?= <Mats.Karrman@tritech.se>, Greg KH <gregkh@linuxfoundation.org>

On 03/12/2014 08:14 AM, terry white wrote:
>     my reading of this 'thread' suggests that "pppd" and/or "serial" have
> started "DEMANDING" bleeding edge kernel versions.  if that 'correct', for
> me anyway, it's going to prove problematic.  that aside, it doesn't seem
> like the most elegant solution, to problems it's meant to address ...

There have been _hundreds of changes_ to the tty core since 3.2, many
to specifically fix the type of error reported.

Very few of these changes are trivial; there are at least a dozen patchsets
with 10 or more patches. I doubt these will ever be backported to -stable;
the changes are just too extensive.

It makes sense to establish if these changes have indeed fixed the observed
error already or if more in-depth debugging is necessary to uncover the root
cause.

Regards,
Peter Hurley

