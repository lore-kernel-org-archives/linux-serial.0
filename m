From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] serial: fix port type conflict between NS16550A &
 U6_16550A
Date: Tue, 31 Aug 2010 06:29:06 -0700
Message-ID: <20100831132906.GA2429@suse.de>
References: <1283257149-3370-1-git-send-email-philippe.langlais@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35501 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753042Ab0HaNcf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 31 Aug 2010 09:32:35 -0400
Content-Disposition: inline
In-Reply-To: <1283257149-3370-1-git-send-email-philippe.langlais@stericsson.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Philippe Langlais <philippe.langlais@stericsson.com>
Cc: linux-serial@vger.kernel.org, linux@treblig.org, STEricsson_nomadik_linux@list.st.com, loic.pallardy@stericsson.com, vincent.guittot@stericsson.com

On Tue, Aug 31, 2010 at 02:19:09PM +0200, Philippe Langlais wrote:
> Bug seen by Dr. David Alan Gilbert with sparse

sparse found this?  nice.

But odds are we should switch this to an enum to try to find it earlier,
right?

I'll go queue this up.

thanks,

greg k-h
