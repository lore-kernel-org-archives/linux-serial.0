From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCHv2] tty: Added a CONFIG_TTY option to allow removal of
 TTY
Date: Mon, 03 Sep 2012 23:45:44 +0200
Message-ID: <50452508.80008@suse.cz>
References: <1346633072-29361-1-git-send-email-jmillenbach@gmail.com> <50451E0E.1050605@suse.cz> <CADwDc1DXb3o0i-7NGZKFGwKU6Ybj703OHhUWgh0he9TcCFpW4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:50267 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692Ab2ICVps (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Sep 2012 17:45:48 -0400
In-Reply-To: <CADwDc1DXb3o0i-7NGZKFGwKU6Ybj703OHhUWgh0he9TcCFpW4g@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Joe Millenbach <jmillenbach@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>, team-fjord@googlegroups.com, Jiri Slaby <jirislaby@gmail.com>

On 09/03/2012 11:24 PM, Joe Millenbach wrote:
> I do not have a Power PC system to test on

Neither do I. But that is no excuse to break it. There are
cross-compilers for instance.

> so during my testing I did
> not notice that option would need TTY also.  Thanks for pointing that
> out.  Before I spin a new patch is there anything else I should add?
> I do not know of a way for me to easily test all the different CPU
> specific configurations on my x86 based machines.

Basically everything that does alloc_tty_driver...

You should minimize the risk of breaking !TTY builds (randconfig for
example) on other arches as much as possible. I'm not trying to force
you to do allmodconfig minus TTY on all arches, but at least do 'git
grep' thoroughly.

thanks,
-- 
js
suse labs
