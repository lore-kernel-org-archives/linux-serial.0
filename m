From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH 1/3] tty: xuartps: Fix "may be used uninitialized" build
 warning
Date: Tue, 29 Oct 2013 09:39:13 -0700
Message-ID: <49d5e652-87b6-4e4c-8812-398bd2076d76@VA3EHSMHS008.ehs.local>
References: <1382398861-21542-1-git-send-email-soren.brinkmann@xilinx.com>
 <1382398861-21542-2-git-send-email-soren.brinkmann@xilinx.com>
 <20131029162252.GA21986@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:16873
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751732Ab3J2QjW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Oct 2013 12:39:22 -0400
Content-Disposition: inline
In-Reply-To: <20131029162252.GA21986@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Tue, Oct 29, 2013 at 09:22:52AM -0700, Greg Kroah-Hartman wrote:
> On Mon, Oct 21, 2013 at 04:40:59PM -0700, Soren Brinkmann wrote:
> > Initialize varibles for which a 'may be used uninitalized' warning =
is
> > issued.
> >=20
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > ---
> > The warning is actually a false positive. The variables are passed =
to a
> > function per reference. That function uses those variables to retur=
n
> > values, which then are used by the caller. Is there a way to
> > avoid the initialization and the build warning alltogether?
> > ---
> >  drivers/tty/serial/xilinx_uartps.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Please properly credit the kbuild robot who found these issues the ne=
xt
> time...

Sorry for that. I'll do that next time.

	Thanks,
	S=C3=B6ren


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
