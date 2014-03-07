From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH RFC v2 06/11] tty: xuartps: Change driver name to
 'cdns-uart'
Date: Fri, 7 Mar 2014 14:58:36 -0800
Message-ID: <dc19c026-5a8a-493c-a971-18cc3f26f7e6@CO9EHSMHS012.ehs.local>
References: <1394219614-3197-1-git-send-email-soren.brinkmann@xilinx.com>
 <1394219614-3197-7-git-send-email-soren.brinkmann@xilinx.com>
 <20140307212944.4007c6f1@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:4970 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753049AbaCGW6t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Mar 2014 17:58:49 -0500
Content-Disposition: inline
In-Reply-To: <20140307212944.4007c6f1@alan.etchedpixels.co.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Michal Simek <michal.simek@xilinx.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

On Fri, 2014-03-07 at 09:29PM +0000, One Thousand Gnomes wrote:
> On Fri,  7 Mar 2014 11:13:29 -0800
> Soren Brinkmann <soren.brinkmann@xilinx.com> wrote:
>=20
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > ---
> > I'm not sure about this change. Is this acceptable or already too m=
uch?
> > I think the name is used for some sysfs entries.
>=20
> Its probably not a good idea. You might be ok depending whether anyth=
ing
> ever used the sysfs nodes.

Okay, I'll drop this.

	Thanks,
	S=C3=B6ren


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
