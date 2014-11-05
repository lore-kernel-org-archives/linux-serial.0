From: Johannes Thumshirn <johannes.thumshirn@men.de>
Subject: Re: [PATCH v4] tty: serial: men_z135_uart: Fix driver for changes in
 hardware
Date: Wed, 5 Nov 2014 17:39:53 +0100
Message-ID: <20141105163952.GA21159@jtlinux>
References: <1415030753-26885-1-git-send-email-johannes.thumshirn@men.de>
 <5457ED0C.3090705@hurleysoftware.com>
 <5457F30F.2030203@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.148]:43349 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755522AbaKEQkP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Nov 2014 11:40:15 -0500
Content-Disposition: inline
In-Reply-To: <5457F30F.2030203@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Johannes Thumshirn <johannes.thumshirn@men.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Nov 03, 2014 at 04:26:39PM -0500, Peter Hurley wrote:
> On 11/03/2014 04:01 PM, Peter Hurley wrote:
> > On 11/03/2014 11:05 AM, Johannes Thumshirn wrote:
> >> * Enable the handling of UART core's automatic flow control feature.
> >>   When AFE is active disable generation of modem status IRQs.
> >
> > So HUPCL doesn't work when CRTSCTS is set?
>
> Sorry, I meant !CLOCAL. IOW,
>
> 'So !CLOCAL doesn't work when CRTSCTS is set?'

Yes, unfortunately

>
> > Is this because there's actually a problem with the IP core that
> > MSIs trash the autoCTS state, or is the problem that the driver
> > just shouldn't be calling uart_handle_cts_change() when autoCTS is
> > on?
>

>From our investigations it looks like it trashes the autoCTS state.

Johannes
