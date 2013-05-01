From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/7] tty: xuartps: Sort #includes alphabetically
Date: Tue, 30 Apr 2013 17:23:21 -0700
Message-ID: <20130501002321.GB7435@kroah.com>
References: <1367366284-28304-1-git-send-email-soren.brinkmann@xilinx.com>
 <1367366284-28304-2-git-send-email-soren.brinkmann@xilinx.com>
 <20130501000048.GA1840@kroah.com>
 <cbd8c55c-066b-4396-9a4b-97d58a93b573@DB8EHSMHS005.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:52587 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934128Ab3EAAXY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Apr 2013 20:23:24 -0400
Received: by mail-pb0-f52.google.com with SMTP id mc17so512741pbc.25
        for <linux-serial@vger.kernel.org>; Tue, 30 Apr 2013 17:23:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cbd8c55c-066b-4396-9a4b-97d58a93b573@DB8EHSMHS005.ehs.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>
Cc: Michal Simek <michal.simek@xilinx.com>, Josh Cartwright <joshc@eso.teric.us>, Mike Turquette <mturquette@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Stephen Warren <swarren@wwwdotorg.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org

On Tue, Apr 30, 2013 at 05:05:40PM -0700, S=F6ren Brinkmann wrote:
> On Tue, Apr 30, 2013 at 05:00:48PM -0700, Greg Kroah-Hartman wrote:
> > On Tue, Apr 30, 2013 at 04:57:58PM -0700, Soren Brinkmann wrote:
> > > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > > CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > CC: Jiri Slaby <jslaby@suse.cz>
> > > CC: linux-serial@vger.kernel.org
> >=20
> > Why would you need/want to do this?
> I often come across duplicated includes. Having some kind of order he=
lps
> avoiding that, imho.

We have a tool to handle duplicated includes, no need to put them in
sorted order for them to be detected.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
