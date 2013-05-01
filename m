From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH 1/7] tty: xuartps: Sort #includes alphabetically
Date: Wed, 1 May 2013 08:39:35 -0700
Message-ID: <79ff34b1-0494-4118-a60d-cd5b536d3daa@VA3EHSMHS006.ehs.local>
References: <1367366284-28304-1-git-send-email-soren.brinkmann@xilinx.com>
 <1367366284-28304-2-git-send-email-soren.brinkmann@xilinx.com>
 <20130501000048.GA1840@kroah.com>
 <cbd8c55c-066b-4396-9a4b-97d58a93b573@DB8EHSMHS005.ehs.local>
 <20130501002321.GB7435@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:41077
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755164Ab3EAPkU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 1 May 2013 11:40:20 -0400
Content-Disposition: inline
In-Reply-To: <20130501002321.GB7435@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Simek <michal.simek@xilinx.com>, Josh Cartwright <joshc@eso.teric.us>, Mike Turquette <mturquette@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Stephen Warren <swarren@wwwdotorg.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org

On Tue, Apr 30, 2013 at 05:23:21PM -0700, Greg Kroah-Hartman wrote:
> On Tue, Apr 30, 2013 at 05:05:40PM -0700, S=C3=B6ren Brinkmann wrote:
> > On Tue, Apr 30, 2013 at 05:00:48PM -0700, Greg Kroah-Hartman wrote:
> > > On Tue, Apr 30, 2013 at 04:57:58PM -0700, Soren Brinkmann wrote:
> > > > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > > > CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > CC: Jiri Slaby <jslaby@suse.cz>
> > > > CC: linux-serial@vger.kernel.org
> > >=20
> > > Why would you need/want to do this?
> > I often come across duplicated includes. Having some kind of order =
helps
> > avoiding that, imho.
>=20
> We have a tool to handle duplicated includes, no need to put them in
> sorted order for them to be detected.
During conflict resolution, I find it easier when there is some order.
Anyway, consider it dropped.

	S=C3=B6ren


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
